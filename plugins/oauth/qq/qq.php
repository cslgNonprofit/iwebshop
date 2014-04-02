<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file qq.php
 * @brief qq的oauth协议登录接口
 * @author chendeshan
 * @date 2011-7-18 9:34:18
 * @version 0.6
 */

/**
 * @class QQ
 * @brief QQ的oauth协议接口
 */
class Qq extends OauthBase
{
	private $apiId  = '';
	private $apiKey = '';

	public function __construct($config)
	{
		$this->apiId  = $config['apiId'];
		$this->apiKey = $config['apiKey'];
	}

	public function getFields()
	{
		return array(
			'apiId' => array(
				'label' => 'apiId',
				'type'  => 'string',
			),
			'apiKey'=> array(
				'label' => 'apiKey',
				'type'  => 'string',
			),
		);
	}

	//获取登录url地址
	public function getLoginUrl()
	{
		$redirect = "http://openapi.qzone.qq.com/oauth/qzoneoauth_authorize?oauth_consumer_key=".$this->apiId."&";

	    $result = array();
	    $request_token = $this->get_request_token();
	    parse_str($request_token, $result);

	    if(isset($result["oauth_token"]) && isset($result["oauth_token_secret"]))
	    {
		    ISession::set('token',$result["oauth_token"]);
		    ISession::set('secret',$result["oauth_token_secret"]);
	    }
	    else
	    {
	    	die($request_token);
	    }

	    //构造请求URL
	    $redirect .= "oauth_token=".$result["oauth_token"]."&oauth_callback=".rawurlencode(parent::getReturnUrl());
	    return $redirect;
	}

	//获取进入令牌
	public function getAccessToken($parms)
	{
		$url    = "http://openapi.qzone.qq.com/oauth/qzoneoauth_access_token?";

		$sigstr = "GET"."&".rawurlencode("http://openapi.qzone.qq.com/oauth/qzoneoauth_access_token")."&";

		$params = array();
		$params["oauth_version"]          = "1.0";
		$params["oauth_signature_method"] = "HMAC-SHA1";
		$params["oauth_timestamp"]        = time();
		$params["oauth_nonce"]            = mt_rand();
		$params["oauth_consumer_key"]     = $this->apiId;
		$params["oauth_token"]            = $parms['oauth_token'];
		$params["oauth_vericode"]         = $parms['oauth_vericode'];

		//对参数按照字母升序做序列化
		$normalized_str = $this->get_normalized_string($params);
		$sigstr        .= rawurlencode($normalized_str);

		//（2）构造密钥
		$key = $this->apiKey."&".ISession::get('secret');

		//（3）生成oauth_signature签名值。这里需要确保PHP版本支持hash_hmac函数
		$signature = $this->get_signature($sigstr, $key);

		//构造请求url
		$url      .= $normalized_str."&"."oauth_signature=".rawurlencode($signature);

		$result = array();
		$access_str = file_get_contents($url);

		parse_str($access_str, $result);
		if(isset($result["oauth_token"]) && isset($result["oauth_token_secret"]) && isset($result["openid"]))
		{
			ISession::set('token',$result["oauth_token"]);
			ISession::set('secret',$result["oauth_token_secret"]);
			ISession::set('openid',$result["openid"]);
		}
		else
		{
			die($access_str);
		}
	}

	//获取用户数据
	public function getUserInfo()
	{
		//获取用户信息的接口地址, 不要更改!!
	    $url  = "http://openapi.qzone.qq.com/user/get_user_info";
	    $info = $this->do_get($url, $this->apiId, $this->apiKey, ISession::get('token'), ISession::get('secret'), ISession::get('openid'));
	    $arr  = JSON::decode($info);
	    $userInfo = array();

	    $userInfo['id']   = ISession::get('openid');
	    $userInfo['name'] = isset($arr['nickname']) ? $arr['nickname'] : '';
	    return $userInfo;
	}

	public function checkStatus($parms)
	{
		return true;
	}

	//get通用方法
	private function do_get($url, $appid, $appkey, $access_token, $access_token_secret, $openid)
	{
	    $sigstr = "GET"."&".rawurlencode("$url")."&";

	    //必要参数, 不要随便更改!!
	    $params = $_GET;
	    $params["oauth_version"]          = "1.0";
	    $params["oauth_signature_method"] = "HMAC-SHA1";
	    $params["oauth_timestamp"]        = time();
	    $params["oauth_nonce"]            = mt_rand();
	    $params["oauth_consumer_key"]     = $appid;
	    $params["oauth_token"]            = $access_token;
	    $params["openid"]                 = $openid;
	    unset($params["oauth_signature"]);

	    //参数按照字母升序做序列化
	    $normalized_str = $this->get_normalized_string($params);
	    $sigstr        .= rawurlencode($normalized_str);

	    //签名,确保php版本支持hash_hmac函数
	    $key = $appkey."&".$access_token_secret;
	    $signature = $this->get_signature($sigstr, $key);
	    $url      .= "?".$normalized_str."&"."oauth_signature=".rawurlencode($signature);

	    return file_get_contents($url);
	}

	//获取临时令牌
	private function get_request_token()
	{
	    $url = "http://openapi.qzone.qq.com/oauth/qzoneoauth_request_token?";

	    //生成oauth_signature签名值。签名值生成方法详见（http://wiki.opensns.qq.com/wiki/【QQ登录】签名参数oauth_signature的说明）
	    //（1） 构造生成签名值的源串（HTTP请求方式 & urlencode(uri) & urlencode(a=x&b=y&...)）
		$sigstr = "GET"."&".rawurlencode("http://openapi.qzone.qq.com/oauth/qzoneoauth_request_token")."&";

		//必要参数
	    $params = array();
	    $params["oauth_version"]          = "1.0";
	    $params["oauth_signature_method"] = "HMAC-SHA1";
	    $params["oauth_timestamp"]        = time();
	    $params["oauth_nonce"]            = mt_rand();
	    $params["oauth_consumer_key"]     = $this->apiId;

	    //对参数按照字母升序做序列化
	    $normalized_str = $this->get_normalized_string($params);
	    $sigstr        .= rawurlencode($normalized_str);

		//（2）构造密钥
	    $key = $this->apiKey."&";

	 	//（3）生成oauth_signature签名值。这里需要确保PHP版本支持hash_hmac函数
	    $signature = $this->get_signature($sigstr, $key);

		//构造请求url
	    $url      .= $normalized_str."&"."oauth_signature=".rawurlencode($signature);

	    return file_get_contents($url);
	}

	//sign计算方法
	private function get_signature($str, $key)
	{
	    $signature = "";
	    if (function_exists('hash_hmac'))
	    {
	        $signature = base64_encode(hash_hmac("sha1", $str, $key, true));
	    }
	    else
	    {
	        $blocksize	= 64;
	        $hashfunc	= 'sha1';
	        if (strlen($key) > $blocksize)
	        {
	            $key = pack('H*', $hashfunc($key));
	        }
	        $key	= str_pad($key,$blocksize,chr(0x00));
	        $ipad	= str_repeat(chr(0x36),$blocksize);
	        $opad	= str_repeat(chr(0x5c),$blocksize);
	        $hmac 	= pack(
	            'H*',$hashfunc(
	                ($key^$opad).pack(
	                    'H*',$hashfunc(
	                        ($key^$ipad).$str
	                    )
	                )
	            )
	        );
	        $signature = base64_encode($hmac);
	    }
	    return $signature;
	}

	//整理数组
	private function get_normalized_string($params)
	{
	    ksort($params);
	    $normalized = array();
	    foreach($params as $key => $val)
	    {
	        $normalized[] = $key."=".$val;
	    }

	    return join("&", $normalized);
	}
}