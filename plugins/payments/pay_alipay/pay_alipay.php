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
class pay_alipay extends paymentPlugin{

	//支付插件名称
    var $name = '支付宝[即时到帐]';//支付宝（特别推荐！）
    //支付插件logo
    var $logo = 'ALIPAY';
    //版本号
    var $version = 20070902;
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
    var $orderby = 3;
	//支付宝html头部的字符集
    var $head_charset='utf-8';

    /**
    * @brief 初始化支付宝类
    */
    function __construct(){
    	//初始化父类
        parent::__construct();
        //获取IP地址
        $regIp=isset($_SERVER['SERVER_ADDR'])?$_SERVER['SERVER_ADDR']:$_SERVER['HTTP_HOST'];
        //设置支付宝详细信息
        $this->intro='<b style="font-family:verdana;font-size:13px;padding:3px;color:#000"><br>ShopEx联合支付宝推出优惠套餐：无预付/年费，单笔费率1.5%，无流量限制。</b><div style="padding:10px 0 0 388px"><a  href="javascript:void(0)" onclick="document.ALIPAYFORM.submit();"><img src="../plugins/payment/images/alipaysq.png"></a></div><div>如果您已经和支付宝签约了其他套餐，同样可以点击上面申请按钮重新签约，即可享受新的套餐。<br>如果不需要更换套餐，请将签约合作者身份ID等信息在下面填写即可，<a href="http://www.shopex.cn/help/ShopEx48/help_shopex48-1235733634-11323.html" target="_blank">点击这里查看使用帮助</a><form name="ALIPAYFORM" method="GET" action="http://top.shopex.cn/recordpayagent.php" target="_blank"><input type="hidden" name="postmethod" value="GET"><input type="hidden" name="payagentname" value="支付宝"><input type="hidden" name="payagentkey" value="ALIPAY"><input type="hidden" name="market_type" value="from_agent_contract"><input type="hidden" name="customer_external_id" value="C433530444855584111X"><input type="hidden" name="pro_codes" value="6AECD60F4D75A7FB"><input type="hidden" name="regIp" value="'.$regIp.'"><input type="hidden" name="domain" value=""></form></div>';
    }

    /**
    * @brief form提交事件
	* @param array 订单的详细信息
	× @return array 返回支付需提交的详细信息
    */
    function toSubmit($payment)
    {
    	//合作者身份(parterID)-帐号
        $merId = $this->getConf($payment['M_Paymentid'], 'member_id');

        //交易安全校验码(key)
        $pKey = $this->getConf($payment['M_Paymentid'], 'PrivateKey');
        $key = $pKey==''?'afsvq2mqwc7j0i69uzvukqexrzd0jq6h':$pKey;

		//订单总价
        $amount = number_format($payment['M_Amount'],2,".","");

        //商店名称
        $shopName = IFilter::act($payment['R_Name']);

		//标题
        $subject = $shopName.'订单';

		//初始化返回值
        $return = array();

        //交易接口名称
        $real_method = $this->getConf($payment['M_Paymentid'], 'real_method');

        switch ($real_method){
            case '0':
                $return['service'] = 'trade_create_by_buyer';
                break;
            case '1':
                $return['service'] = 'create_direct_pay_by_user';
                break;
            case '2':
                $return['service'] = 'create_partner_trade_by_buyer';
                break;
        }

		//付完款后跳转的页面 要用 http://格式的完整路径，不允许加?id=123这类自定义参数
        $return['return_url'] = $this->callbackUrl;

		//交易过程中服务器通知的页面 要用 http://格式的完整路径，不允许加?id=123这类自定义参数
        $return['notify_url'] = $this->serverCallbackUrl;

        $return['payment_type'] = 1;
        $return['partner'] = $merId;
        $return['subject'] = $subject;
        $return['body'] = '网店订单';
        $return['out_trade_no'] = $payment['M_OrderNO'];
        $return['total_fee'] = $amount;
        $return['seller_id'] = $merId;
		$return['_input_charset'] = 'utf-8';

        ksort($return);
        reset($return);

        $mac= "";
        foreach($return as $k => $v)
        {
        	$mac .= '&'.$k.'='.$v;
        }

        $mac = substr($mac,1);

        $return['sign'] = md5($mac.$key);//验证信息
        $return['sign_type'] = 'MD5';//验证信息

		unset($return['_input_charset']);
        return $return;
    }

    function callback($in,&$paymentId,&$money,&$message,&$tradeno)
    {
        //比对md5码
        $tradeno  = $in['out_trade_no'];
        $pKey     = $this->getConf($paymentId,'PrivateKey');
        $pri_key  = $pKey=='' ? 'afsvq2mqwc7j0i69uzvukqexrzd0jq6h':$pKey;//私钥值

		ksort($in);

		unset($in['controller']);
		unset($in['action']);
		unset($in['payment_name']);

		$temp = array();
        foreach($in as $k => $v)
        {
            if($k!='sign' && $k!='sign_type')
            {
                $temp[] = $k.'='.$v;
            }
        }
        $testStr = implode('&',$temp).$pri_key;

        if($in['sign'] == md5($testStr))
        {
            //支付单号
            $money   = $in['total_fee'];
            $message = $in['body'];
            switch($in['trade_status'])
            {
                case 'TRADE_FINISHED':
                case 'TRADE_SUCCESS':
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

    function applyForm($agentfield){
      $tmp_form='<a href="javascript:void(0)" onclick="document.applyForm.submit();">立即申请支付宝</a>';
      $tmp_form.="<form name='applyForm' method='".$agentfield['postmethod']."' action='http://top.shopex.cn/recordpayagent.php' target='_blank'>";
      foreach($agentfield as $key => $val){
            $tmp_form.="<input type='hidden' name='".$key."' value='".$val."'>";
      }
      $tmp_form.="</form>";
      return $tmp_form;
    }

    function getfields(){
        return array(
                'member_id'=>array(
                        'label'=>'合作者身份(parterID)',
                        'type'=>'string'
                    ),
                'PrivateKey'=>array(
                        'label'=>'交易安全校验码(key)',
                        'type'=>'string'
                ),
                'real_method'=>array(
                        'label'=>'选择接口类型',
                        'type'=>'select',
                        'options'=>array('1'=>'使用即时到帐交易接口')
                ),

            );
    }
}
?>
