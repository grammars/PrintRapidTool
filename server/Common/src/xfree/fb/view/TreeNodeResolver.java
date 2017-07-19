package xfree.fb.view;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

public class TreeNodeResolver
{
	private List<TreeNodeResolvable> tnrList;
	private List<TreeNode> nodeList;
	
	private TreeNode rootNode;
	
	public TreeNodeResolver(List<TreeNodeResolvable> tnrList)
	{
		this.tnrList = tnrList;
		nodeList = new ArrayList<TreeNode>();
		for(TreeNodeResolvable tnr : this.tnrList)
		{
			TreeNode node = new TreeNode();
			node.learn(tnr);
			nodeList.add(node);
		}
		for(TreeNode node : nodeList)
		{
			TreeNode pnode = getParentNode(node.getPid());
			if(pnode != null)
			{
				pnode.add(node);
			}
			else
			{
				//没有父节点，则是根节点
				rootNode = node;
			}
		}
	}
	
	private TreeNode getParentNode(String pid)
	{
		for(TreeNode node : nodeList)
		{
			if(StringUtils.equals(node.getId(), pid))
			{
				return node;
			}
		}
		return null;
	}
	
	public TreeNode getTreeNode(String id)
	{
		if(StringUtils.isBlank(id))
		{
			return rootNode;
		}
		for(TreeNode node : nodeList)
		{
			if(StringUtils.equals(node.getId(), id))
			{
				return node;
			}
		}
		return null;
	}
}
