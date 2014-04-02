<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file paymentplugin.php
 * @brief 支付插件基类
 * @author kane
 * @date 2011-01-19
 * @version 0.6
 * @note
 */

 /**
 * @class PaymentPlugin
 * @brief 支付插件基类
 */
class paymentPlugin
{
	public $method      = "post";//form提交模式
	public $charset     = "utf8";//字符集
	public $name        = null;//支付插件名称
	public $version     = 0.6;//版本
	public $callbackUrl = null;//支付完成后，回调地址
	public $_config     = array();//支付插件配置信息

	/**
	* @brief 构造函数
	*/
	public function __construct()
	{
		$payName = str_replace('pay_','',get_class($this));

		//获取域名地址
		$sUrl = IUrl::getHost().IUrl::creatUrl();
		$sUrl = str_replace( 'plugins/', '', $sUrl);

		//回调函数地址
		$this->callbackUrl = str_replace('plugins/','',IUrl::getHost().IUrl::creatUrl("/block/callback/payment_name/{$payName}"));

		//回调业务处理地址
		$this->serverCallbackUrl = str_replace('plugins/','',IUrl::getHost().IUrl::creatUrl("/block/server_callback/payment_name/{$payName}"));
	}

	/**
	* @brief 获取支付插件配置详细信息
	* @param $paymentId int    支付方式id值
	* @param $key       string 插件配置项
	*/
	public function getConf($paymentId,$key = '')
	{
		if(empty($this->_config))
		{
			$payment       = new Payment();
			$payment_cfg   = $payment->getPaymentById($paymentId);
			$this->_config = unserialize($payment_cfg['config']);
		}

		if($key != '' && isset($this->_config[$key]))
		{
			return $this->_config[$key];
		}
		else
		{
			return $this->_config;
		}
	}

	//同步支付回调
	public function callback($in,&$paymentId,&$money,&$message,&$tradeno)
	{

	}

	//异步支付回调
	public function serverCallback($in,&$paymentId,&$money,&$message,&$tradeno)
	{
		$this->callback($in,$paymentId,$money,$message,$tradeno);
	}
}
?>