<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file paypal.php
 * @brief 贝宝(外卡)接口
 * @author chendeshan
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

 /**
 * @class paypal
 * @brief 贝宝(外卡)接口
 */
class pay_paypal extends paymentPlugin
{
	//插件名称
    var $name    = '贝宝在线支付';
    //插件logo
    var $logo    = 'paypal';
    //版本号
    var $version = 0.6;
    //插件字符集
    var $charset = 'utf8';
	//提交的地址
    var $submitUrl = "https://www.paypal.com/cgi-bin/webscr";
	//html头部的字符集
    var $head_charset='utf-8';
    //支持的地区
    var $supportArea     =  array("AREA_CNY");
    var $supportCurrency = array("USD"=>"01");

    /**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    public function toSubmit($payment)
    {
    	$return = array();

		$UserName = $this->getConf($payment['M_Paymentid'], 'UserName');
		$IDcode   = $this->getConf($payment['M_Paymentid'], 'IDcode');

		$return['business']    = $UserName;
		$return['item_number'] = $payment['M_OrderNO'];
		$return['amount']      = $payment['M_Amount'];
		$return['return']      = $this->callbackUrl;
		$return['notify_url']  = $this->serverCallbackUrl;
		$return['custom']      = $this->createMD5($return,$IDcode);
		$return['item_name']   = $payment['R_Name'];
		$return['cmd']         = '_xclick';
		$return['charset']     = 'utf-8';

        return $return;
    }

	//回调处理
    public function callback($in,&$paymentId,&$money,&$message,&$tradeno)
    {
		$UserName = $this->getConf($paymentId, 'UserName');
		$IDcode   = $this->getConf($paymentId, 'IDcode');

		$return                = array();
		$return['business']    = urldecode($UserName);
		$return['item_number'] = urldecode($in['item_number']);
		$return['amount']      = urldecode($in['amt']);
		$return['return']      = urldecode($this->callbackUrl);
		$return['notify_url']  = urldecode($this->serverCallbackUrl);
		$md5Code               = $this->createMD5($return,$IDcode);

		//校验md5码 防止篡改数据
		if(urldecode($in['cm']) == $md5Code)
		{
            switch($in['st'])
            {
                case 'Completed':
                {
					$tradeno  = $in['item_number'];
					$money    = $in['amt'];
                	return PAY_SUCCESS;
                    break;
                }
                default:
                {
                	return PAY_FAILED;
                	break;
                }
            }
		}
		else
		{
			$message = '校验码不正确';
			return PAY_INVALID;
		}
    }

    //异步回调处理
    public function serverCallback($in,&$paymentId,&$money,&$message,&$tradeno)
    {
    	//通过soket检查回值是否合法
    	$req = 'cmd=_notify-validate';
		foreach ($_POST as $key => $value)
		{
			$value = urlencode(stripslashes($value));
			$req  .= "&$key=$value";
		}
		$header .= "POST /cgi-bin/webscr HTTP/1.0\r\n";
		$header .= "Content-Type:application/x-www-form-urlencoded\r\n";
		$header .= "Content-Length:" . strlen($req) ."\r\n\r\n";
		$fp      = fsockopen ('www.paypal.com', 80, $errno, $errstr, 30);
		if(!$fp)
		{
			return PAY_INVALID;
		}
		else
		{
			fputs ($fp, $header .$req);
			while (!feof($fp))
			{
				$res = fgets ($fp, 1024);
				if (strcmp ($res, "VERIFIED") == 0)
				{
					return $this->callback($in,&$paymentId,&$money,&$message,&$tradeno);
				}
				else if (strcmp ($res, "INVALID") == 0)
				{
					return PAY_INVALID;
				}
			}
			fclose ($fp);
		}
    }

    /**
    * @brief 生成md5防篡改码
	* @param array  要加密的原数据
	* @param string id密钥
	× @return string md5码
    */
    private function createMD5($rdata,$idCode)
    {
    	$rdataMD5   = '';
    	$rdataArray = array();

    	//让数组以键值进行排序
        ksort($rdata);
        reset($rdata);

    	foreach($rdata as $key => $val)
    	{
    		$rdataArray[] = $val;
    	}

    	$rdataMD5 = join('&',$rdataArray);
    	return md5($rdataMD5.$idCode);
    }

	//必要的数据
    function getfields(){
		return array(
			'UserName' => array(
				'label' => '签约商家Email',
				'type'  => 'string'
			),
			'IDcode' => array(
				'label' => '密钥',
				'type'   => 'string'
			),
		);
    }
}