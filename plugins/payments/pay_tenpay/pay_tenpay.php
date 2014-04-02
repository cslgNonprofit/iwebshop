<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file pay_tenpay.php
 * @brief 腾讯财付通插件类
 * @author kane
 * @date 2011-02-12
 * @version 20070902
 * @note
 */
/**
 * @class pay_tenpay
 * @brief 腾讯财付通[即时到账]
 */
class pay_tenpay extends paymentPlugin
{
	//支付插件名称
    var $name = '腾讯财付通[即时到账]';
	//支付插件logo
    var $logo = 'TENPAY';
	//支付插件版本号
    var $version = 20070902;
	//支付插件字符集
    var $charset = 'utf8';
	//腾讯财付通提交的地址
    var $submitUrl = 'https://www.tenpay.com/cgi-bin/v1.0/pay_gate.cgi';
    
	//腾讯财付通提交按钮的图片
    var $submitButton = 'http://img.alipay.com/pimg/button_alipaybutton_o_a.gif'; ##需要完善的地方
	//腾讯财付通插件所支持的货币单位
    var $supportCurrency =  array("CNY"=>"1");
	//腾讯财付通支持的地区
    var $supportArea =  array("AREA_CNY");
    var $desc = '财付通是腾讯公司为促进中国电子商务的发展需要，满足互联网用户价值需求，针对网上交易安全而精心推出的一系列服务。';
	//腾讯财付通的详细介绍
    var $intro = '财付通是腾讯公司于2005年9月正式推出专业在线支付平台，致力于为互联网用户和企业提供安全、便捷、专业的在线支付服务。<br>财付通构建全新的综合支付平台，业务覆盖B2B、B2C和C2C各领域，提供卓越的网上支付及清算服务。<br>财付通先后荣膺2006年电子支付平台十佳奖、2006年最佳便捷支付奖、2006年中国电子支付最具增长潜力平台奖和2007年最具竞争力电子支付企业奖等奖项，并于2007年首创获得“国家电子商务专项基金”资金支持。<!--<br><br><font color="red">本接口需点击以下链接(二选一)进行在线签约后方可使用。</font>-->';
    var $applyProp = array("postmethod"=>"get","sp_suggestuser"=>"2289480");//代理注册参数组
	//腾讯财付通插件排序
    var $orderby = 2;
	//腾讯财付通html头部的字符集
    var $head_charset='utf-8';

	/**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    function toSubmit($payment)
	{
        $merId = $this->getConf($payment['M_Paymentid'], 'member_id');        
        $ikey = $this->getConf($payment['M_Paymentid'], 'PrivateKey');

        $spbill_create_ip = $_SERVER['REMOTE_ADDR'];

		$bank_type = isset($payment['payExtend']['bankId'])?$payment['payExtend']['bankId']:0;        
        
        $return['cmdno'] = 1;
        $return['date']  = date('Ymd');
        $return["bank_type"] = $bank_type;
        $return['desc']  = $payment['M_OrderNO'];
        $return['purchaser_id'] = '';
        $return['bargainor_id'] = $merId;
        $return['transaction_id'] = $merId.$return['date'].substr($payment['M_OrderNO'],-10);
        $return['sp_billno'] = $payment['M_OrderNO'];
        $return["total_fee"] = intval($payment['M_Amount'] * 100);
        $return["fee_type"]  = 1;
        $return['return_url'] = $this->callbackUrl;
        $return["attach"]    = $payment['M_OrderId'];
        $return["spbill_create_ip"] = $spbill_create_ip;
        $return['cs'] = 'utf-8';
        
        $signPars = "cmdno=".$return['cmdno']."&date=".$return['date']."&bargainor_id=".$return['bargainor_id']."&transaction_id=".$return['transaction_id']."&sp_billno=".$return['sp_billno']."&total_fee=".$return['total_fee']."&fee_type=".$return['fee_type']."&return_url=".$return['return_url']."&attach=".$return['attach']."&";        
		if($spbill_create_ip != "") {
			$signPars .= "spbill_create_ip=" . $spbill_create_ip . "&";
		}
		$signPars .= "key=" . $ikey;
		
        $return["sign"] = strtoupper(md5($signPars));
        
        ksort($return);
        return $return;
    }

    function callback($in,&$paymentId,&$money,&$message,&$tradeno)
    {
        $cmdno=$in["cmdno"];
        $pay_result=$in["pay_result"];
        $pay_info=$in["pay_info"];
        $date=$in["date"];
        $bargainor_id=$in["bargainor_id"];
        $transaction_id=$in["transaction_id"];
        $sp_billno=$in["sp_billno"];
        $total_fee=$in["total_fee"];
        $fee_type=$in["fee_type"];
        $attach=$in["attach"];
        $sign=$in["sign"];
        $mac ="";
        $v_orderid = substr($tradeno,-6);
        $ikey = $this->getConf($paymentId, 'PrivateKey');
        $str = "cmdno=1&pay_result=".$in['pay_result']."&date=".$date."&transaction_id=".$transaction_id."&sp_billno=".$sp_billno."&total_fee=".$total_fee."&fee_type=".$fee_type."&attach=".$attach."&key=".$ikey;
        $md5mac=strtoupper(md5($str));
        $paymentId=$in['attach'];
        $money=$total_fee/100;
        $tradeno = $in['sp_billno'];

        if($md5mac!=$sign){
           $message = '签名认证失败,请立即与商店管理员联系';
            return PAY_ERROR;
        }else{
            if($pay_result==0){
                return PAY_SUCCESS;
            }else{
                $message = '支付失败,请立即与商店管理员联系'.$pay_info;
                return PAY_FAILED;
            }
        }
    }

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
            ),
           'ConnectType' => array(
                'label'=>'顾客付款类型',
                'type'=>'radio',
                'options'=>array('0'=>'财付通'),
                'extendcontent'=>array(
                    array(
                        "property"=>array(
                            "type"=>"checkbox",//后台显示方式
                            "name"=>"bankId",
                            "size"=>6,
                            "extconId"=>"bankShow",
                            "display"=>1,
                            "fronttype"=>"radio", //前台显示方式
                            "frontsize"=>6,
                            "frontname"=>"showbank"
                        ),
                        "value"=>array(
                            array("value"=>"0","imgname"=>"bank_tenpay.gif","name"=>"财付通账户支付"),
                            array("value"=>"1001","imgname"=>"bank_cmb.gif","name"=>"招商银行借记卡"),
                            array("value"=>"1002","imgname"=>"bank_icbc.gif","name"=>"中国工商银行"),
                            array("value"=>"1003","imgname"=>"bank_ccb.gif","name"=>"中国建设银行"),
                            array("value"=>"1004","imgname"=>"bank_spdb.gif","name"=>"上海浦东发展银行"),
                            array("value"=>"1005","imgname"=>"bank_abc.gif","name"=>"中国农业银行"),
                            array("value"=>"1006","imgname"=>"bank_cmbc.gif","name"=>"中国民生银行"),
                            array("value"=>"1008","imgname"=>"bank_sdb.gif","name"=>"深圳发展银行"),
                            array("value"=>"1009","imgname"=>"bank_cib.gif","name"=>"兴业银行"),
                            array("value"=>"1010","imgname"=>"bank_pab.gif","name"=>"平安银行"),
                            array("value"=>"1020","imgname"=>"bank_bcom.gif","name"=>"交通银行"),
                            array("value"=>"1021","imgname"=>"bank_citic.gif","name"=>"中信银行"),
                            array("value"=>"1022","imgname"=>"bank_ceb.gif","name"=>"中国光大银行"),
                            array("value"=>"1024","imgname"=>"bank_shanghai.gif","name"=>"上海银行"),
                            array("value"=>"1025","imgname"=>"bank_hxb.gif","name"=>"华夏银行"),
                            array("value"=>"1027","imgname"=>"bank_gdb.gif","name"=>"广东发展银行"),
                            array("value"=>"1028","imgname"=>"bank_post.gif","name"=>"中国邮政储蓄银行"),
                            array("value"=>"1038","imgname"=>"bank_cmb.gif","name"=>"招商银行信用卡"),
                            array("value"=>"1032","imgname"=>"bank_bob.gif","name"=>"北京银行"),
                            array("value"=>"1033","imgname"=>"bank_unpay.gif","name"=>"网汇通"),
                            array("value"=>"1052","imgname"=>"bank_boc.gif","name"=>"中国银行")
                        )
                    )
                )
			)
            );
        }
    function applyForm($agentfield){
      return $tmp_form;
   }
}
?>
