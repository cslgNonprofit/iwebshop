<?PHP
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file pay_tenpaytrad.php
 * @brief 腾讯财付通插件类
 * @author kane
 * @date 2011-01-29
 * @version 0.6
 * @note
 */

 /**
 * @class pay_tenpaytrad
 * @brief 腾讯财付通插件类
 */
class pay_tenpaytrad extends paymentPlugin
{
	//支付插件名称
    var $name = "腾讯财付通[担保交易]";
	//支付插件logo
    var $logo = 'TENPAYTRAD';
	//腾讯财付通[担保交易] 版本号
    var $version = 0.6;
	//支付插件字符集
    var $charset = 'utf8';
	//腾讯财付通提交的地址
    var $submitUrl = 'https://www.tenpay.com/cgi-bin/med/show_opentrans.cgi';
	//腾讯财付通提交按钮的图片
    var $submitButton = 'http://img.alipay.com/pimg/button_alipaybutton_o_a.gif';
	//腾讯财付通插件所支持的货币单位
    var $supportCurrency =  array("CNY"=>"1");
	//腾讯财付通支持的地区
    var $supportArea =  array("AREA_CNY");
    var $desc = '财付通是腾讯公司为促进中国电子商务的发展需要，满足互联网用户价值需求，针对网上交易安全而精心推出的一系列服务。';
	//腾讯财付通的详细介绍
    var $intro = '财付通是腾讯公司于2005年9月正式推出专业在线支付平台，致力于为互联网用户和企业提供安全、便捷、专业的在线支付服务。<br>财付通构建全新的综合支付平台，业务覆盖B2B、B2C和C2C各领域，提供卓越的网上支付及清算服务。<br>财付通先后荣膺2006年电子支付平台十佳奖、2006年最佳便捷支付奖、2006年中国电子支付最具增长潜力平台奖和2007年最具竞争力电子支付企业奖等奖项，并于2007年首创获得“国家电子商务专项基金”资金支持。<br><br><font color="red">本接口需点击【立即申请财付通担保账户】链接进行在线签约和付费后方可使用。</font>';
	//腾讯财付通插件排序
    var $orderby = 13;
	//腾讯财付通html头部的字符集
    var $head_charset='utf-8';

	/**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    function toSubmit($payment)
	{
		//客户号
        $merId = $this->getConf($payment['M_Paymentid'],'member_id');
		//私钥
        $PrivateKey = $this->getConf($payment['M_Paymentid'], 'PrivateKey');
		//商家支付模式
        $authtype = $this->getConf($payment['M_Paymentid'],'authtype');
		//订单号
        $mchname = $payment['M_OrderNO'];

        $return['attach'] = '';

		// 商家的财付通商户号
		$return['seller'] = $merId;
		//平台提供者,代理商的财付通账号
		$return['chnid']  = $merId;
		//业务代码, 财付通支付支付接口填 12
		$return['cmdno'] = "12";
		//编码标准
        $return['encode_type'] = "2";
		//版本号 2
		$return['version'] = "2";
		//接收财付通返回结果的URL
		$return['mch_returl'] = $this->serverCallbackUrl;
		//返回的路径
        $return['show_url'] = $this->callbackUrl;
		//交易类型  1、实物交易 ；2、虚拟交易
		$return['mch_type'] = "1";

		//商品名称
        $return['mch_name'] = $mchname;
		//交易说明
        $return['mch_desc'] = "";
		// 订单金额
		$return['mch_price'] = $payment['M_Amount']*100;

        // 交易号(订单号)
        $return['mch_vno'] = $payment['M_OrderNO'];
		//是否需要在财付通填定物流信息
        $return['need_buyerinfo'] = "2";
		//物流配送说明
        $return['transport_desc'] = "";
		//物流费用
        $return['transport_fee'] = 0;

		//对数组按照键名排序，保留键名到数据的关联。
        ksort($return);
		//将数组的内部指针指向第一个单元
        reset($return);
		//进行数字加密
		$signPars = "";

		/*
		 * sign值计算法则：要提交的数据按照ksort排序，去除值恒等于空的情况，通过 '&' 链接，在链接最后拼接上 &key=私钥
		 */
		foreach($return as $k => $v) {
			if("" !== $v && "sign" != $k) {
				$signPars .= $k . "=" . $v . "&";
			}
		}

		$signPars .= "key=" . $PrivateKey;
		$sign = strtolower(md5($signPars));
		$return['sign'] = $sign;
        return $return;
    }

	/**
    * @brief 支付回调函数
	* @param array		return		支付完返回的数据
	* @param string 	orderid		订单编号
	* @param decimal	money		订单总价
	* @param string		message 	订单商品的详细信息
	* @param string		tradeno 	订单编号
	× @return int 					支付状态
    */
    function callback($backdata,&$paymentId,&$money,&$message,&$tradeno)
	{
		//私钥
        $PrivateKey = $this->getConf($paymentId, 'PrivateKey');
		$tradeno = $backdata['mch_vno'];

		$signParameterArray = array(
			'attach',
			'buyer_id',
			'cft_tid',
			'chnid',
			'cmdno',
			'mch_vno',
			'retcode',
			'seller',
			'status',
			'total_fee',
			'trade_price',
			'transport_fee',
			'version'
		);

        //对数组按照键名排序，保留键名到数据的关联。
        ksort($backdata);
		//将数组的内部指针指向第一个单元
        reset($backdata);

        $signPars = '';
		//进行数字加密
		foreach($signParameterArray as $k )
		{
			$v = isset($backdata[$k]) ? $backdata[$k] : '';
			if($v !== '')
			{
				$signPars .= $k . "=" . urldecode($v) . "&";
			}
		}

		$signPars  .= "key=" . $PrivateKey;
		$sign       = strtolower(md5($signPars));
		$tenpaySign = strtolower($backdata['sign']);

        if ($strLocalSign  == $sign)
		{
            if ($backdata['retcode'] == "0")
			{
	            $message="支付成功";
	            return PAY_SUCCESS;
	        }
	        else
	        {
	            $message="支付失败";
	            return PAY_FAILED;
	        }
        }
        else
		{
            $message = '签名认证失败,请立即与商店管理员联系';
            return PAY_ERROR;
        }
    }

	/**
    * @brief 腾讯财付通配置字段
	× @return array 返回腾讯财付通配置字段
    */
    function getfields()
	{
        return array(
            'member_id'=>array(
                'label'=>'客户号',
                'type'=>'string'
            ),
            'PrivateKey'=>array(
                'label'=>'私钥',
                'type'=>'string'
            ),
            'authtype'=>array(
                'label'=>'商家支付模式',
                'type'=>'select',
                'options'=>array('0'=>'套餐包量商家','1'=>'单笔支付商家')
            )
        );
    }
}
?>
