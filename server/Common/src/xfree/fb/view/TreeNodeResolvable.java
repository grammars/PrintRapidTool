package xfree.fb.view;

/** 可被解析成树节点的 */
public interface TreeNodeResolvable
{
	/** 变成树节点id */
	String toTreeNodeId();
	/** 变成树节点父id */
	String toTreeNodeParentId();
	/** 变成树节点文本 */
	String toTreeNodeText();
}
