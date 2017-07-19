package xfree.fb.weixin;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;

public class WxUtil
{

	private static final String TOKEN = "asdfzxcvli123";

	/**
	 * 验证消息真实性
	 * 
	 * @param request
	 *            - 微信服务器发送的GET请求，包含signature、timestamp、nonce、echostr4个参数
	 * @return true-消息请求来自微信服务器，原样返回echostr参数<br>
	 *         false-消息验证失败
	 */
	public static boolean checkSignature(HttpServletRequest request)
	{
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");

		if (signature != null)
		{
			// ConfigUtil.TOKEN指服务器配置中用于生成签名的Token
			String[] tmpArr = { TOKEN, timestamp, nonce };
			Arrays.sort(tmpArr);

			StringBuilder buf = new StringBuilder();
			for (int i = 0; i < tmpArr.length; i++)
			{
				buf.append(tmpArr[i]);
			}

			if (signature.equals(encrypt(buf.toString())))
			{
				return true;
			}
		}

		return false;
	}

	/**
	 * 对字符串进行sha1加密
	 * 
	 * @param strSrc
	 *            - 要加密的字符串
	 * @return 加密后的字符串
	 */
	public static String encrypt(String strSrc)
	{
		MessageDigest md = null;
		String strDes = null;

		byte[] bt = strSrc.getBytes();
		try
		{
			md = MessageDigest.getInstance("SHA-1");
			md.update(bt);
			strDes = bytes2Hex(md.digest()); // to HexString
		} catch (NoSuchAlgorithmException e)
		{
			System.out.println("Invalid algorithm.");
			return null;
		}
		return strDes;
	}

	private static String bytes2Hex(byte[] bts)
	{
		String des = "";
		String tmp = null;
		for (int i = 0; i < bts.length; i++)
		{
			tmp = (Integer.toHexString(bts[i] & 0xFF));
			if (tmp.length() == 1)
			{
				des += "0";
			}
			des += tmp;
		}
		return des;
	}
}