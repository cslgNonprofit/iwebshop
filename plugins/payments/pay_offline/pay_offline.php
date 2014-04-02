<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file pay_offline.php
 * @brief 线下支付插件类
 * @author kane
 * @date 2011-01-30
 * @version 0.6
 * @note
 */

 /**
 * @class pay_offline
 * @brief 线下支付插件类
 */
class pay_offline extends paymentPlugin
{
	//插件名称
    var $name    = '线下支付';
    //插件logo
    var $logo    = '';
    //版本号
    var $version = 0.6;
    //插件字符集
    var $charset = 'utf8';
	//提交的地址
    var $submitUrl = '';
	//html头部的字符集
    var $head_charset='utf-8';
    //支持的地区
    var $supportArea     =  array("AREA_CNY");
    var $supportCurrency = array("CNY"=>"01");

    function getfields()
	{
        return array();
    }
}
?>
