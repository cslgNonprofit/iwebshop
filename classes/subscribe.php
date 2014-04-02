<?php
/**
 * @author walu 
 * @package iwebshop
 */

/**
 * 电子订阅退订
 * 
 * @todu 应该先向用户邮箱发信，然后用户通过信件里的链接实现退订，防止被恶意退订
 */
class Subscribe
{
	/**
	 * 退订，并记录退订理由
	 * @param string $email 
	 * @param string $content 退订理由
	 * @static
	 */
	public static function unsubscribe($email,$content)
	{
		$email = addslashes($email);
		$tb = new IModel("email_registry");
		$re = $tb->query("email = '{$email}' AND flag=1");
		if(!$re)
		{
			return array('flag'=>false,'data'=>'你还没有订阅');
		}
		$re = end($re);
		
		/*
		$re['content'] = htmlspecialchars($content,ENT_QUOTES);
		$re['flag'] = 0;
		$tb->setData($re);
		$tb->update("id={$re['id']}");
		*/

		$tb->del("id={$re['id']}");
		return array('flag'=>true,'data'=>'success') ;
	}
}
?>
