package xfree.fb.view;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.view.AbstractView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class JsonView extends AbstractView 
{
	public static final String DEFAULT_CONTENT_TYPE = "application/json";
	public static final String HTML_CONTENT_TYPE = "text/html";
	public static final String DEFAULT_CHAR_ENCODING = "UTF-8";
	private String encodeing = DEFAULT_CHAR_ENCODING;

	private Object jsonData = null;
	private Map<String, Object> _jsonDataMap = new HashMap<String, Object>();

	public void setEncodeing(String encodeing) {
		this.encodeing = encodeing;
	}

	private Set<String> renderedAttributes;

	public JsonView() {
		setContentType(DEFAULT_CONTENT_TYPE);
	}

	public JsonView(Object data) {
		setContentType(DEFAULT_CONTENT_TYPE);
		this.jsonData = data;
	}
	
	/** 默认的日期格式 */
	public static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

	private String dateFormat = DEFAULT_DATE_FORMAT;
	
	public String getDateFormat()
	{
		return dateFormat;
	}

	public void setDateFormat(String dateFormat)
	{
		this.dateFormat = dateFormat;
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding(encodeing);
		response.setContentType(getContentType());

		Gson gson = new GsonBuilder().setDateFormat(dateFormat).create();
		
		PrintWriter out = response.getWriter();
		if (jsonData != null) {
			out.print(gson.toJson(jsonData));
		} else if (!_jsonDataMap.isEmpty()) {
			out.print(gson.toJson(_jsonDataMap));
		} else {
			model = filterModel(model);
			out.print(gson.toJson(model));
		}
	}

	/**
	 * Filters out undesired attributes from the given model.
	 * <p>
	 * Default implementation removes {@link BindingResult} instances and
	 * entries not included in the {@link #setRenderedAttributes(Set)
	 * renderedAttributes} property.
	 */
	protected Map<String, Object> filterModel(Map<String, Object> model) {
		Map<String, Object> result = new HashMap<String, Object>(model.size());
		Set<String> renderedAttributes = !CollectionUtils.isEmpty(this.renderedAttributes) ? this.renderedAttributes : model.keySet();
		for (Map.Entry<String, Object> entry : model.entrySet()) {
			if (!(entry.getValue() instanceof BindingResult) && renderedAttributes.contains(entry.getKey())) {
				result.put(entry.getKey(), entry.getValue());
			}
		}

		return result;

	}

	public void setJsonData(Object jsonData) {
		this.jsonData = jsonData;
	}

	public static JsonView returnJson(Object jsonData) {
		JsonView jsonView = new JsonView();
		jsonView.setJsonData(jsonData);
		return jsonView;
	}

	public JsonView put(String key, Object value) {
		_jsonDataMap.put(key, value);
		return this;
	}
}