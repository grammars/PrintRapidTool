package xfree.fb.view;

import java.util.ArrayList;
import java.util.List;

public class TreeNode
{	
	private String id;
	private String pid;
	private String text;
	private List<TreeNode> children;
	
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public String getPid()
	{
		return pid;
	}
	public void setPid(String pid)
	{
		this.pid = pid;
	}
	public String getText()
	{
		return text;
	}
	public void setText(String text)
	{
		this.text = text;
	}
	public List<TreeNode> getChildren()
	{
		return children;
	}
	public void setChildren(List<TreeNode> children)
	{
		this.children = children;
	}
	
	public TreeNode add(TreeNode child)
	{
		if(children == null) 
		{
			children = new ArrayList<TreeNode>();
		}
		children.add(child);
		return this;
	}
	
	public void learn(TreeNodeResolvable tnr)
	{
		this.id = tnr.toTreeNodeId();
		this.pid = tnr.toTreeNodeParentId();
		this.text = tnr.toTreeNodeText();
	}
}
