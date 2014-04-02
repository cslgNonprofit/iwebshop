<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file pay_alipaytrad.php
 * @brief 支付宝插件类
 * @author kane
 * @date 2011-01-27
 * @version 0.6
 * @note
 */

 /**
 * @class pay_alipaytrad
 * @brief 支付宝插件类
 */
class pay_alipaytrad extends paymentPlugin
{
	//支付插件名称
    var $name = '支付宝[担保交易]';
	//支付插件logo
    var $logo = 'ALIPAYTRAD';
	//支付宝[担保交易]的版本号
    var $version = 0.6;
	//支付插件字符集
    var $charset = 'utf8';
	//支付宝提交的地址
    var $submitUrl = 'https://www.alipay.com/cooperate/gateway.do?_input_charset=utf-8';
	//支付宝提交按钮的图片
    var $submitButton = 'http://img.alipay.com/pimg/button_alipaybutton_o_a.gif';
	//支付宝插件所支持的货币单位
    var $supportCurrency = array("CNY"=>"01");
	//支付宝支持的地区
    var $supportArea =  array("AREA_CNY");
	//支付宝插件排序
    var $orderby = 4;
	//支付宝html头部的字符集
    var $head_charset = "utf-8";

	/**
    * @brief 初始化支付宝类
    */
    function pay_alipaytrad()
	{
		//初始化父类
        parent::__construct();
		//获取IP地址
        $regIp=isset($_SERVER['SERVER_ADDR'])?$_SERVER['SERVER_ADDR']:$_SERVER['HTTP_HOST'];
		//设置支付宝详细信息
        $this->intro='<div style="padding:10px 0 0 388px"><a  href="javascript:void(0)" onclick="document.ALIPAYFORM.submit();"><img src="../plugins/payment/images/alipaysq.png"></a></div><div>如果您已经和支付宝签约了其他套餐，同样可以点击上面申请按钮重新签约，即可享受新的套餐。<br>如果不需要更换套餐，请将签约合作者身份ID等信息在下面填写即可</div>';
    }

	/**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    function toSubmit($payment)
	{
		//合作者身份(parterID)
        $member_id = $this->getConf($payment['M_Paymentid'], 'member_id');

		//交易安全校验码(key)
        $PrivateKey = $this->getConf($payment['M_Paymentid'], 'PrivateKey');
		//签约支付宝账号
		$seller_email = $this->getConf($payment['M_Paymentid'], 'seller_email');

		//处理交易安全校验码(key)
        $PrivateKey = $PrivateKey==''?'afsvq2mqwc7j0i69uzvukqexrzd0jq6h':$PrivateKey;

		//付完款后跳转的页面 要用 http://格式的完整路径，不允许加?id=123这类自定义参数
        $return_url = $this->callbackUrl;
		//交易过程中服务器通知的页面 要用 http://格式的完整路径，不允许加?id=123这类自定义参数
        $server_url = $this->serverCallbackUrl;

		//订单总价
        $amount = number_format($payment['M_Amount'],2,".","");
		//商品名称
        $shopName = IFilter::act($payment['R_Name']);

        $subject = $shopName."订单";

        $return = array();
		/** 以下是支付宝配置必填信息 **/
		//合作者身份(parterID)
        $return['partner'] = $this->getConf($payment['M_Paymentid'], 'PrivateKey')==''?'2088002003028751':$member_id;

		//交易接口名称
        $real_method = $this->getConf($payment['M_Paymentid'], 'real_method');

		//付完款后跳转的页面
        $return['return_url'] = $return_url;

		//交易过程中服务器通知的页面
        $return['notify_url'] = $server_url;

		//签约支付宝账号或卖家支付宝帐户
		$return['seller_email'] = $seller_email;
        switch ($real_method)
		{
			//使用标准双接口
            case '0':
                $return['service'] = 'trade_create_by_buyer';
                break;
			//使用即时到帐交易接口
            case '1':
                $return['service'] = 'create_direct_pay_by_user';
                break;
			//使用担保交易接口
            case '2':
                $return['service'] = 'create_partner_trade_by_buyer';
                break;
        }

		//交易类型
        $return['payment_type'] = 1;

		//字符编码格式 目前支持 GBK 或 utf-8
        $return['_input_charset'] = "utf-8";

		/** 以下是物流配置信息 **/
		//物流费用，即运费。
		$return['logistics_fee'] = '0.00';

		//物流类型，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）
        $return['logistics_type'] = "EXPRESS";

		//物流支付方式，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）
        $return['logistics_payment'] = "BUYER_PAY";


		/** 以下是订单详细信息 **/
		//订单编号
        $return['out_trade_no'] = $payment['M_OrderNO'];

		//订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
        $return['subject'] = $subject;

		//订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
        $return['body'] = '网店订单';

		//订单总金额，显示在支付宝收银台里的“应付总额”里
        $return['price'] = $amount;

		//商品数量，建议默认为1，不改变值，把一次交易看成是一次下订单而非购买一件商品。
        $return['quantity'] = 1;

		//对数组按照键名排序，保留键名到数据的关联。
        ksort($return);
		//将数组的内部指针指向第一个单元
        reset($return);

        $mac= "";
        foreach($return as $k=>$v)
        {
            $mac .= "&{$k}={$v}";
        }
        $mac = substr($mac,1);
		//对提交信息进行md5加密
        $return['sign'] = md5($mac.$PrivateKey);
		//加密类型为md5
        $return['sign_type'] = 'MD5';
        unset($return['_input_charset']);
		//返回需要提交的数据
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
    function callback($return,&$orderid,&$money,&$message,&$tradeno)
	{
		//交易安全校验码(key)
        $PrivateKey = $this->getConf($orderid, 'PrivateKey');
		//签约支付宝账号
		$seller_email = $this->getConf($orderid, 'seller_email');
		//处理交易安全校验码(key)
        $PrivateKey = $PrivateKey==''?'afsvq2mqwc7j0i69uzvukqexrzd0jq6h':$PrivateKey;

		unset($return['controller']);
		unset($return['action']);
		unset($return['payment_name']);

		//对数组按照键名排序，保留键名到数据的关联。
        ksort($return);

        //检测参数合法性
        $temp = array();
        foreach($return as $k=>$v)
		{
            if($k!='sign'&&$k!='sign_type')
			{
                $temp[] = $k.'='.$v;
            }
        }
        $testStr = implode('&',$temp).$PrivateKey;

		//验证返回数据是否正确
        if($return['sign']==md5($testStr))
		{
			//订单总价
            $money = $return['total_fee'];
			//订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
            $message = $return['body'];
			//订单编号
            $tradeno = $return['out_trade_no'];
            switch($return['trade_status'])
			{
				//该判断表示买家已经确认收货，这笔交易完成
                case 'TRADE_FINISHED':
                case 'TRADE_SUCCESS':
                case 'WAIT_SELLER_SEND_GOODS':
                {
                	return PAY_SUCCESS;
                	break;
                }
                default:
                	return PAY_FAILED;
                	break;
            }
        }
		else
		{
            $message = 'Invalid Sign';
            return PAY_ERROR;
        }
    }

	/**
    * @brief 支付宝配置字段
	× @return array 返回支付宝配置字段
    */
    function getfields()
	{
        return array(
            'member_id'=>array(
                'label'=>'合作者身份(parterID)',
                'type'=>'string'
            ),
            'PrivateKey'=>array(
                'label'=>'交易安全校验码(key)',
                'type'=>'string'
            ),
			'seller_email'=>array(
                'label'=>'签约支付宝账号',
                'type'=>'string'
            ),
            'real_method'=>array(
                    'label'=>'选择接口类型',
                    'type'=>'select',
                    'options'=>array('0'=>'使用标准双接口','2'=>'使用担保交易接口',)
            )
        );
    }
}
?>
