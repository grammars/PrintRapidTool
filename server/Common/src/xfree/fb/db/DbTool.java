package xfree.fb.db;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javakit.string.StrUtil;
import javakit.utils.ClassUtil;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.sql.DataSource;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapperResultSetExtractor;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

//【C】create 【U】update 【R】read(single) query(some) 【D】delete
public class DbTool 
{
	private static DbTool _me;
	public static DbTool me() { return _me; }
	public DbTool()
	{
		_me = this;
	}
	
	public DbTool(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	private Log log = LogFactory.getLog(this.getClass());
	
	private DataSource dataSource;
	public DataSource getDataSource() 
	{
		return dataSource;
	}
	public void setDataSource(DataSource dataSource) 
	{
		this.dataSource = dataSource;
	}
	
	private JdbcTemplate _jt;
	private JdbcTemplate jt()
	{
		if(_jt == null) { _jt = new JdbcTemplate(dataSource); }
		return _jt;
	}
	
	private NamedParameterJdbcTemplate _npjt;
	private NamedParameterJdbcTemplate npjt()
	{
		if(_npjt == null) { _npjt = new NamedParameterJdbcTemplate(dataSource); }
		return _npjt;
	}
	
	private static class AttCol
	{
		//entity属性名 Attribute Name
		public String attname;
		//table字段列名Column Name
		public String colname;
		
		public AttCol(String attname, String colname)
		{
			this.attname = attname;
			this.colname = colname;
		}
	}
	
	/** 获取主键信息 */
	protected AttCol getPK(Class<?> clazz)
	{
		Field[] fields = ClassUtil.getUserDefinedField(clazz);//clazz.getDeclaredFields();
		for(Field f : fields)
		{
			Id idAnno = f.getAnnotation(Id.class);
			if(idAnno != null)
			{
				Column colAnno = f.getAnnotation(Column.class);
				if(colAnno == null)
				{
					log.warn("" + clazz.getName() + "具有Id注释却没有Column注释，这不应该！");
					continue;
				}
				AttCol ac = new AttCol(f.getName(), colAnno.name());
				return ac;
			}
		}
		return null;
	}
	
	/** 获取表名 */
	protected String getTableName(Class<?> clazz)
	{
		Table table = clazz.getAnnotation(Table.class);
		if(table == null)
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return null;
		}
		return table.name();
	}
	
	/** 是否是自动设置，不需要手动干预 */
	private boolean isAutoSet(Field f)
	{
		//【GenerationType.IDENTITY】
		//	多数数据库支持IDENTITY列，数据库会在新行插入时自动给ID赋值，这也叫做ID自增长列，比如MySQL中可以在创建表时声明“AUTO_INCREMENT”, 就是一个ID子增长列
		//	由于主键由数据库自动插入，因此不需要额外的配置信息。
		//	多数数据库支持IDENTITY策略：MySQL, SQL Server, DB2, Derby, Sybase, PostgreSQL。
		//【GenerationType.SEQUENCE】
		//	Oracle不支持ID子增长列而是使用序列的机制生成主键ID，对此，可以选用序列作为主键生成策略
		//	如果不指定序列生成器的名称，则使用厂商提供的默认序列生成器，比如Hibernate默认提供的序列名称为hibernate_sequence。
		//	支持的数据库： Oracle、PostgreSQL、DB2
		//【GenerationType.TABLE】
		//	有时候为了不依赖于数据库的具体实现，在不同数据库之间更好的移植，可以在数据库中新建序列表来生成主键，
		//	序列表一般包含两个字段：第一个字段引用不同的关系表，第二个字段是该关系表的最大序号。这样，只需要一张序列就可以用于多张表的主键生成。 
		//	如果不指定表生成器，JPA厂商会使用默认的表，比如Hibernate在Oracle数据库上会默认使用表hibernate_sequence。
		//	这种方式虽然通用性最好，所有的关系型数据库都支持，但是由于不能充分利用具体数据库的特性，建议不要优先使用。
		//【GenerationType.Auto】
		//	把主键生成策略交给JPA厂商(Persistence Provider)，由它根据具体的数据库选择合适的策略，可以是Table/Sequence/Identity中的一种。
		//	假如数据库是Oracle，则选择Sequence。
		//	如果不特别指定，这是默认的主键生成策略。
		GeneratedValue gv = f.getAnnotation(GeneratedValue.class);
		//gv.strategy()  GenerationType.AUTO
		return gv != null;
	}
	
	/** 直接运行SQL */
	public void execute(String sql)
	{
		jt().execute(sql);
	}
	
	/** 创建一个新的entity */
	public <T> T create(T entity)
	{
		String tableName = getTableName(entity.getClass());
		if(tableName == null) 
		{
			log.error("请在" + entity.getClass().getName() + "上加上Table注解");
			return null;
		}
		
		boolean ok = false;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Field[] fields = ClassUtil.getUserDefinedField(entity.getClass());//entity.getClass().getDeclaredFields();
		String cols = "";
		String args = "";
		String aiKeyName = null;
		for(Field f : fields)
		{
			Column column = f.getAnnotation(Column.class);
			if(column != null)
			{
				if( isAutoSet(f) )
				{
					aiKeyName = f.getName();
				}
				else
				{
					try
					{
						//System.out.println("PropertyUtils.getProperty("+entity+","+f.getName()+")");
						Object value = PropertyUtils.getProperty(entity, f.getName());
						paramMap.put(column.name(), value);
						cols += column.name() + ",";
						args += ":" + column.name() + ",";
						
						ok = true;
					} 
					catch (IllegalAccessException e) { e.printStackTrace(); } 
					catch (InvocationTargetException e) { e.printStackTrace(); } 
					catch (NoSuchMethodException e) { e.printStackTrace(); }
				}
			}
		}
		if(!ok)
		{
			log.error("至少需要一项数据库字段");
			return null;
		}
		cols = cols.substring(0, cols.length()-1);
		args = args.substring(0, args.length()-1);
		String springSql = "insert into "+ tableName +"("+cols+") values("+args+")";
		
		KeyHolder keyHolder = new GeneratedKeyHolder();
		
		SqlParameterSource  paramSource = new MapSqlParameterSource(paramMap);
		npjt().update(springSql, paramSource, keyHolder);
	
		if(null != aiKeyName)
		{
			try
			{
				PropertyUtils.setProperty(entity, aiKeyName, keyHolder.getKey().intValue());
			} 
			catch (InvalidDataAccessApiUsageException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e)
			{
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	
	/** 更新一个已存在的entity
	 * @return true:更新成功 / false:更新失败 */
	public <T> boolean update(T entity)
	{
		String tableName = getTableName(entity.getClass());
		if(tableName == null) 
		{
			log.error("请在" + entity.getClass().getName() + "上加上Table注解");
			return false;
		}
		String springSql = "UPDATE "+tableName+" SET ";
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		Field[] fields = ClassUtil.getUserDefinedField(entity.getClass());//entity.getClass().getDeclaredFields();
		String setContent = "";
		boolean ok = false;
		for(Field f : fields)
		{
			Column column = f.getAnnotation(Column.class);
			if(column != null)
			{
				if( !isAutoSet(f) )
				{
					try
					{
						Object value = PropertyUtils.getProperty(entity, f.getName());
						paramMap.put(column.name(), value);
						setContent += column.name() + "=:" + column.name() + ",";
						ok = true;
					} 
					catch (IllegalAccessException e) { e.printStackTrace(); } 
					catch (InvocationTargetException e) { e.printStackTrace(); } 
					catch (NoSuchMethodException e) { e.printStackTrace(); }
				}
			}
		}
		if(!ok)
		{
			log.error("至少需要一项数据库字段");
			return false;
		}
		setContent = setContent.substring(0, setContent.length()-1);
		
		AttCol ac = getPK(entity.getClass());
		if(ac == null)
		{
			log.error("必须有主键且用@ID注释");
			return false;
		}
		springSql += setContent + " WHERE " + ac.colname + "=:" + ac.colname;
		Object pkVal = null;
		try
		{
			pkVal = PropertyUtils.getProperty(entity, ac.attname);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			return false;
		} 
		paramMap.put(ac.colname, pkVal);
		
		int r = npjt().update(springSql, paramMap);
		return r > 0;
	}
	
	
	/** 根据主键id读取entity */
	public <T> T read(Class<T> clazz, Object id)
	{
		AttCol ac = getPK(clazz);
		if(ac == null) 
		{
			log.error("" + clazz.getName() + "找不到主键");
			return null;
		}
		return read(clazz, ac.colname, id);
	}
	
	/** 读取一个符合某列等于某值的entity */
	public <T> T read(Class<T> clazz, String colName, Object colVal)
	{
		String conditionSql = " " + colName + "=:" + colName + " ";
		List<T> list = querySome(clazz, conditionSql, new String[]{colName}, new Object[]{colVal}, null).getRows();
		if(list.size() > 0) { return list.get(0); }
		return null;
	}
	
	/** 根据主键id读取entity,以map形式返回 */
	public Map<String, Object> readToMap(Class<?> clazz, Object id)
	{
		AttCol ac = getPK(clazz);
		if(ac == null) 
		{
			log.error("" + clazz.getName() + "找不到主键,请用@Id注解对应主键");
			return null;
		}
		return readToMap(clazz, ac.colname, id);
	}
	
	/** 读取一个符合某列等于某值的entity,以map形式返回 */
	public Map<String, Object> readToMap(Class<?> clazz, String colName, Object colVal)
	{
		String conditionSql = " " + colName + "=:" + colName + " ";
		List<Map<String, Object>> list = querySomeToMap(clazz, conditionSql, new String[]{colName}, new Object[]{colVal});
		if(list.size() > 0) { return list.get(0); }
		return null;
	}
	
	/** 根据唯一主键id删除entity */
	public boolean delete(Object entity)
	{
		Class<?> clazz = entity.getClass();
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return false;
		}
		AttCol ac = getPK(clazz);
		if(ac == null) 
		{
			log.error("" + clazz.getName() + "找不到主键,请用@Id注解对应主键");
			return false;
		}
		try
		{
			Object id = PropertyUtils.getProperty(entity, ac.attname);
			String springSql = "DELETE FROM "+tableName+" WHERE "+ac.colname+"=:"+ac.colname;
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put(ac.colname, id);
			int r = npjt().update(springSql, paramMap);
			return r > 0;
		}
		catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e)
		{
			e.printStackTrace();
		}
		return false;
	}
	
	/** 根据主键id删除对应条目 */
	public boolean deleteById(Class<?> clazz, Object id)
	{
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return false;
		}
		AttCol ac = getPK(clazz);
		if(ac == null) 
		{
			log.error("" + clazz.getName() + "找不到主键,请用@Id注解对应主键");
			return false;
		}
		String springSql = "DELETE FROM "+tableName+" WHERE "+ac.colname+"=:"+ac.colname;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put(ac.colname, id);
		int r = npjt().update(springSql, paramMap);
		return r > 0;
	}
	
	/** 根据条件语句删除 */
	public boolean deleteWhere(Class<?> clazz, String conditionSql)
	{
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return false;
		}
		String springSql = "DELETE FROM "+tableName+" WHERE "+conditionSql;
		int r = jt().update(springSql);
		return r > 0;
	}
	
	/** 根据主键id删除entity */
	public boolean delete(Class<?> clazz, String conditionSql, String[] paramCols, Object[] paramVals)
	{
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return false;
		}
		String springSql = "DELETE FROM "+tableName+" WHERE " + conditionSql;
		Map<String, Object> paramMap = new LinkedHashMap<String, Object>();
		for(int i = 0; i < paramCols.length; i++)
		{
			paramMap.put(paramCols[i], paramVals[i]);
		}
		int r = npjt().update(springSql, paramMap);
		return r > 0;
	}
	
	
	/** 查询[所有] */
	public <T> List<T> queryAll(final Class<T> clazz)
	{
		return querySome(clazz, null, null).getRows();
	}
	
	/** 查询[指定页] */
	public <T> DbResult<T> querySome(final Class<T> clazz, DbPage dp)
	{
		return querySome(clazz, null, dp);
	}
	
	/** 查询[自定义条件] */
	public <T> DbResult<T> querySome(final Class<T> clazz, String conditionSql, String[] paramCols, Object[] paramVals, DbPage dp)
	{
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return null;
		}
		Map<String, Object> paramMap = new LinkedHashMap<String, Object>();
		for(int i = 0; i < paramCols.length; i++)
		{
			paramMap.put(paramCols[i], paramVals[i]);
		}
		String springSql = "SELECT * FROM " + tableName + " WHERE " + conditionSql;
		return querySome(clazz, springSql, paramMap, dp);
	}
	
	/** 查询[自定义条件] */
	public <T> DbResult<T> querySome(final Class<T> clazz, String springSql, DbPage dp)
	{
		return querySome(clazz, springSql, null, dp);
	}
	
	/** 查询[自定义条件] */
	public <T> DbResult<T> querySome(final Class<T> clazz, String springSql, Map<String, ?> paramMap, DbPage dp)
	{
		if( springSql == null )
		{
			String tableName = getTableName(clazz);
			if(tableName == null) 
			{
				log.error("请在" + clazz.getName() + "上加上Table注解");
				return null;
			}
			springSql = "SELECT * FROM " + tableName;
		}
		String totalSql = springSql;
		if(dp != null && dp.available())
		{
			springSql += dp.toLimitSql();
		}
		if( paramMap == null )
		{
			paramMap = new HashMap<String, Object>();
		}
		
		final Map<String, String> att2col = new LinkedHashMap<String, String>();
		final Map<String, String> col2att = new LinkedHashMap<String, String>();
		Field[] fields = ClassUtil.getUserDefinedField(clazz);//clazz.getDeclaredFields();
		for(Field f : fields)
		{
			Column column = f.getAnnotation(Column.class);
			if(column != null)
			{
				att2col.put(f.getName(), column.name());
				col2att.put(column.name(), f.getName());
			}
		}
		ResultSetExtractor<List<T>> rse = new RowMapperResultSetExtractor<T>(new RowMapper<T>() {
			public T mapRow(ResultSet rs, int index) throws SQLException {
				T bean = BeanUtils.instantiate(clazz);
				Iterator<Entry<String, String>> iter = att2col.entrySet().iterator();
				while(iter.hasNext()){
					Entry<String, String> e = iter.next();
					String attName = e.getKey();
					String colName = e.getValue();
					fillBeanWithResult(bean, rs, attName, colName);
				}
				return bean;
			}
		});
		List<T> list = npjt().query(springSql, paramMap, rse);
		DbResult<T> result = new DbResult<>();
		result.setRows(list);
		if(dp != null)
		{
			result.setTotal(count(totalSql, paramMap));
		}
		else
		{
			result.setTotal(-1);
		}
		return result;
	}
	
	/** 查询[所有],以map形式返回 */
	public List<Map<String, Object>> queryAllToMap(final Class<?> clazz)
	{
		return querySomeToMap(clazz, null).getRows();
	}
	
	/** 查询[指定页],以map形式返回 */
	public DbResult<Map<String, Object>> querySomeToMap(final Class<?> clazz, DbPage dp)
	{
		Table table = clazz.getAnnotation(Table.class);
		if(table == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return null;
		}
		String springSql = "SELECT * FROM " + table.name();
		String totalSql = springSql;
		if(dp != null && dp.available())
		{
			springSql += dp.toLimitSql();
		}
		Map<String, Object> paramMap = new LinkedHashMap<String, Object>();
		DbResult<Map<String, Object>> result = new DbResult<>();
		result.setRows(querySomeToMap(clazz, springSql, paramMap));
		result.setTotal(count(totalSql, paramMap));
		return result;
	}
	
	/** 查询[自定义条件&指定页],以map形式返回 */
	public DbResult<Map<String, Object>> querySomeToMap(Class<?> clazz, String springSql, Map<String, ?> paramMap, DbPage dp)
	{
		if(dp != null && dp.available())
		{
			springSql += dp.toLimitSql();
		}
		DbResult<Map<String, Object>> result = new DbResult<>();
		result.setRows(querySomeToMap(clazz, springSql, paramMap));
		result.setTotal(count(springSql, paramMap));
		return result;
	}
	
	/** 查询[自定义条件] */
	public List<Map<String, Object>> querySomeToMap(Class<?> clazz, String conditionSql, String[] paramCols, Object[] paramVals)
	{
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return null;
		}
		Map<String, Object> paramMap = new LinkedHashMap<String, Object>();
		for(int i = 0; i < paramCols.length; i++)
		{
			paramMap.put(paramCols[i], paramVals[i]);
		}
		String springSql = "SELECT * FROM " + tableName + " WHERE " + conditionSql;
		List<Map<String, Object>> list = querySomeToMap(clazz, springSql, paramMap);
		return list;
	}
	
	/** 查询[自定义条件],以map形式返回 */
	public List<Map<String, Object>> querySomeToMap(Class<?> clazz, String springSql, Map<String, ?> paramMap)
	{
		final Map<String, String> att2col = new LinkedHashMap<String, String>();
		final Map<String, String> col2att = new LinkedHashMap<String, String>();
		Field[] fields = ClassUtil.getUserDefinedField(clazz);//clazz.getDeclaredFields();
		for(Field f : fields)
		{
			Column column = f.getAnnotation(Column.class);
			if(column != null)
			{
				att2col.put(f.getName(), column.name());
				col2att.put(column.name(), f.getName());
			}
		}
		ResultSetExtractor<List<Map<String, Object>>> rse = new RowMapperResultSetExtractor<Map<String, Object>>(new RowMapper<Map<String, Object>>() {
			public Map<String, Object> mapRow(ResultSet rs, int index) throws SQLException {
				Map<String, Object> map = new HashMap<String, Object>();
				Iterator<Entry<String, String>> iter = att2col.entrySet().iterator();
				while(iter.hasNext()){
					Entry<String, String> e = iter.next();
					String attName = e.getKey();
					String colName = e.getValue();
					fillMapWithResult(map, rs, attName, colName);
				}
				return map;
			}
		});
		List<Map<String, Object>> list = npjt().query(springSql, paramMap, rse);
		return list;
	}
	
	private void fillBeanWithResult(Object bean, ResultSet rs, String attName, String colname)
	{
		try 
		{
			ResultSetMetaData rsmd = rs.getMetaData();
			Object value = rs.getObject(colname);
			try 
			{
				///进行MySql的TINYINT => Java的Boolean的转换
				///转换开始
				String colType = null;
				for(int i = 1; i <= rsmd.getColumnCount(); i++)
				{
					if(StringUtils.equals(rsmd.getColumnName(i), colname))
					{
						colType = rsmd.getColumnTypeName(i);
						break;
					}
				}
				if("TINYINT".equals(colType))
				{
					PropertyDescriptor propDes = PropertyUtils.getPropertyDescriptor(bean, attName);
					if(Boolean.class.equals(propDes.getPropertyType()))
					{
						///至此，适用 TINYINT => Boolean 的情况
						Integer intVal = rs.getInt(colname);
						value = intVal != 0 ? true : false;
					}
				}
				///换换结束
				
				PropertyUtils.setSimpleProperty(bean, attName, value);
			} 
			catch (IllegalAccessException e) { e.printStackTrace(); } 
			catch (InvocationTargetException e) { e.printStackTrace(); }
			catch (NoSuchMethodException e) { e.printStackTrace(); }
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
	}
	
	private void fillMapWithResult(Map<String, Object> map, ResultSet rs, String attName, String colname)
	{
		try 
		{
			Object value = rs.getObject(colname);
			if(value instanceof Timestamp)
			{
				map.put(attName, StrUtil.toDateTimeStr( (Timestamp)value ));
			}
			else if(value instanceof Time)
			{
				map.put(attName, StrUtil.toTimeStr( (Time)value ));
			}
			else if(value instanceof java.sql.Date)
			{
				map.put(attName, StrUtil.toDateStr( (java.sql.Date)value ));
			}
			else
			{
				map.put(attName, value);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
	}

	public int count(Class<?> clazz)
	{
		return count(clazz, null, null, null);
	}
	
	public int count(Class<?> clazz, String conditionSql, String[] paramCols, Object[] paramVals)
	{
		String tableName = getTableName(clazz);
		if(tableName == null) 
		{
			log.error("请在" + clazz.getName() + "上加上Table注解");
			return -1;
		}
		Map<String, Object> paramMap = new LinkedHashMap<String, Object>();
		String springSql = "SELECT * FROM " + tableName + " ";
		if(conditionSql != null)
		{
			for(int i = 0; i < paramCols.length; i++)
			{
				paramMap.put(paramCols[i], paramVals[i]);
			}
			springSql += " WHERE " + conditionSql;
		}
		return count(springSql, paramMap);
	}
	
	public int count(String springSql, Map<String, ?> paramMap)
	{
		String sql = "SELECT COUNT(0) FROM (" + springSql + ") A";
		return npjt().queryForObject(sql, paramMap, Integer.class);
	}
}
