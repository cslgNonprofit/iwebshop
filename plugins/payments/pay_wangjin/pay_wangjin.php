<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file pay_wangjin.php
 * @brief 网银在线支付(内卡)接口
 * @author chendeshan
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

 /**
 * @class pay_wangjin
 * @brief 网银在线(内卡)支付接口
 */
class pay_wangjin extends paymentPlugin
{
	//插件名称
    var $name = '网银在线支付(内卡)';
    //插件logo
    var $logo = 'WANGYIN';
    //版本号
    var $version = 0.6;
    //插件字符集
    var $charset = 'utf8';
	//提交的地址
    var $submitUrl = 'https://Pay3.chinabank.com.cn/PayGate';
	//html头部的字符集
    var $head_charset='utf-8';
    //支持的地区
    var $supportArea     =  array("AREA_CNY");
    var $supportCurrency = array("CNY"=>"01");

    /**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    public function toSubmit($payment)
    {
    	$return                = array();
    	$key                   = $this->getConf($payment['M_Paymentid'], 'key');

    	$return['v_mid']       = $this->getConf($payment['M_Paymentid'], 'v_mid');
    	$return['v_oid']       = $payment['M_OrderNO'];
    	$return['v_amount']    = $payment['M_Amount'];
    	$return['v_moneytype'] = "CNY";
    	$return['v_url']       = $this->callbackUrl;
    	$text                  = $return['v_amount'].$return['v_moneytype'].$return['v_oid'].$return['v_mid'].$return['v_url'].$key;
		$return['v_md5info']   = strtoupper(md5($text));

        return $return;
    }

	//回调处理
    function callback($in,&$paymentId,&$money,&$message,&$tradeno)
    {
        $key         = $this->getConf($paymentId, 'key');

		$v_oid       = trim($_POST['v_oid']);      // 商户发送的v_oid定单编号
		$v_pmode     = trim($_POST['v_pmode']);    // 支付方式（字符串）
		$v_pstatus   = trim($_POST['v_pstatus']);  // 支付状态 ：20（支付成功）；30（支付失败）
		$v_pstring   = trim($_POST['v_pstring']);  // 支付结果信息 ： 支付完成（当v_pstatus=20时）；失败原因（当v_pstatus=30时,字符串）；
		$v_amount    = trim($_POST['v_amount']);   // 订单实际支付金额
		$v_moneytype = trim($_POST['v_moneytype']);// 订单实际支付币种
		$v_md5str    = trim($_POST['v_md5str' ]);  // 拼凑后的MD5校验值

		$md5string   = strtoupper(md5($v_oid.$v_pstatus.$v_amount.$v_moneytype.$key));

        if($v_md5str == $md5string)
        {
			$money       = $v_amount;
			$tradeno     = $v_oid;
			$message     = $v_pstring;

            //支付单号
            switch($v_pstatus)
            {
                case '20':
                {
                	return PAY_SUCCESS;
                    break;
                }

                case '30':
                {
                	return PAY_FAILED;
                	break;
                }
            }
        }
        else
        {
        	IError::show(403,'校验码不正确');
        }
    }

    function getfields(){
        return array(
                'v_mid'=>array(
                        'label'=>'签约商户ID',
                        'type'=>'string'
                ),
                'key'=>array(
                        'label'=>'密钥',
                        'type'=>'string'
                ),
            );
    }
}
?>
