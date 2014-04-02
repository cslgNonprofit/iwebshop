<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file pay_balance.php
 * @brief 账户余额支付接口
 * @author chendeshan
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

 /**
 * @class pay_balance
 * @brief 账户余额支付接口
 */
class pay_balance extends paymentPlugin
{
	//插件名称
    var $name = '账户余额支付';
    //插件logo
    var $logo = 'JOOYEA';
    //版本号
    var $version = 0.6;
    //插件字符集
    var $charset = 'utf8';
	//html头部的字符集
    var $head_charset='utf-8';
    //插件所支持的货币单位
    var $supportCurrency = array("CNY"=>"01");
    //支持的地区
    var $supportArea  =  array("AREA_CNY");

    public function __get($parms)
    {
    	if($parms == 'submitUrl')
    	{
    		return IUrl::getHost().IUrl::creatUrl('/ucenter/payment_balance');
    	}
    }

    /**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    public function toSubmit($payment)
    {
    	$pkey      = $this->getConf($payment['M_Paymentid'], 'PrivateKey');
		$user_id   = ISafe::get('user_id');
		$urlStr    = '';

		$return['attach']     = $payment['M_Paymentid'];
		$return['total_fee']  = $payment['M_Amount'];
		$return['order_no']   = $payment['M_OrderNO'];
		$return['return_url'] = $this->callbackUrl;

		ksort($return);
		foreach($return as $key => $val)
		{
			$urlStr .= $key.'='.urlencode($val).'&';
		}
		$urlStr .= $user_id.$pkey;
		$return['sign'] = md5($urlStr);

        return $return;
    }

	//回调处理
    function callback($in,&$paymentId,&$money,&$message,&$tradeno)
    {
        //比对md5码
        $pKey    = $this->getConf($paymentId, 'PrivateKey');
        $user_id = ISafe::get('user_id');

		ksort($in);
		unset($in['controller']);
		unset($in['action']);
		unset($in['payment_name']);

		$temp = array();
        foreach($in as $k => $v)
        {
            if($k!='sign')
            {
                $temp[] = $k.'='.urlencode($v);
            }
        }
        $testStr = join('&',$temp).'&'.$user_id.$pKey;

        $tradeno = $in['order_no'];
        $money   = $in['total_fee'];

        if($in['sign'] == md5($testStr))
        {
            //支付单号
            switch($in['is_success'])
            {
                case 'T':
                {
					$log    = new AccountLog();
					$config = array(
						'user_id'  => ISafe::get('user_id'),
						'event'    => 'pay',
						'note'     => '通过余额支付方式进行商品购买',
						'num'      => '-'.$money,
						'order_id' => $tradeno,
					);
					$log->write($config);
                	return PAY_SUCCESS;
                    break;
                }

                case 'F':
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
			'PrivateKey'=>array
			(
				'label'=>'交易安全校验码(key)',
				'type'=>'string'
			),
			'real_method'=>array
			(
				'label'=>'选择接口类型',
				'type'=>'select',
				'options'=>array('1'=>'使用即时到帐交易接口')
			),
		);
    }
}
?>
