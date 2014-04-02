<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file Simple.php
 * @brief
 * @author webning
 * @date 2011-03-22
 * @version 0.6
 * @note
 */
/**
 * @brief Simple
 * @class Simple
 * @note
 */
class Simple extends IController
{
    public $layout='site_mini';

	function init()
	{
		$user = array();
		$user['user_id']  = ISafe::get('user_id');
		$user['username'] = ISafe::get('username');
		$user['head_ico'] = ISafe::get('head_ico');
		$this->user = $user;
	}

	function login()
	{
		//如果已经登录，就跳到ucenter页面
		if( ISafe::get('user_id') != null  )
		{
			$this->redirect("/ucenter/index");
		}
		else
		{
			$this->redirect('login');
		}
	}

	//退出登录
    function logout()
    {
    	ISafe::clearAll();
    	$this->redirect('login');
    }

    //用户注册
    function reg_act()
    {
    	$email      = IFilter::act(IReq::get('email','post'));
    	$username   = IFilter::act(IReq::get('username','post'));
    	$password   = IFilter::act(IReq::get('password','post'));
    	$repassword = IFilter::act(IReq::get('repassword','post'));
    	$captcha    = IReq::get('captcha','post');
    	$message    = '';

		/*注册信息校验*/
    	if(IValidate::email($email) == false)
    	{
    		$message = '邮箱格式不正确';
    	}
    	else if(!Util::is_username($username))
    	{
    		$message = '用户名必须是由2-20个字符，可以为字数，数字下划线和中文';
    	}
    	else if(!preg_match('|\S{6,32}|',$password))
    	{
    		$message = '密码必须是字母，数字，下划线组成的6-32个字符';
    	}
    	else if($password != $repassword)
    	{
    		$message = '2次密码输入不一致';
    	}
    	else if($captcha != ISafe::get('Captcha'))
    	{
    		$message = '验证码输入不正确';
    	}
    	else
    	{
    		$userObj = new IModel('user');
    		$where   = 'email = "'.$email.'" or username = "'.$email.'" or username = "'.$username.'"';
    		$userRow = $userObj->getObj($where);

    		if(!empty($userRow))
    		{
    			if($email == $userRow['email'])
    			{
    				$message = '此邮箱已经被注册过，请重新更换';
    			}
    			else
    			{
    				$message = "此用户名已经被注册过，请重新更换";
    			}
    		}
    	}

		//校验通过
    	if($message == '')
    	{
    		//user表
    		$userArray = array(
    			'username' => $username,
    			'password' => md5($password),
    			'email'    => $email,
    		);
    		$userObj->setData($userArray);
    		$user_id = $userObj->add();

    		if($user_id)
    		{
				//member表
	    		$memberArray = array(
	    			'user_id' => $user_id,
	    			'time'    => ITime::getDateTime(),
	    		);
	    		$memberObj = new IModel('member');
	    		$memberObj->setData($memberArray);
	    		$memberObj->add();

	    		//用户私密数据
	    		ISafe::set('username',$username);
	    		ISafe::set('user_id',$user_id);
	    		ISafe::set('user_pwd',$userArray['password']);

				//自定义跳转页面
				$callback = IReq::get('callback') ? urlencode(IReq::get('callback')) : '';
				$this->redirect('/simple/success_info?callback='.$callback);
    		}
    		else
    		{
    			$message = '注册失败';
    		}
    	}

		//出错信息展示
    	if($message != '')
    	{
    		$this->email    = $email;
    		$this->username = $username;

    		$this->redirect('reg',false);
    		Util::showMessage($message);
    	}
    }

    //用户登录
    function login_act()
    {
    	$login_info = IFilter::act(IReq::get('login_info','post'));
    	$password   = IReq::get('password','post');
    	$remember   = IFilter::act(IReq::get('remember','post'));
    	$autoLogin  = IFilter::act(IReq::get('autoLogin','post'));
    	$callback   = IReq::get('callback');
		$message    = '';

    	if($login_info == '')
    	{
    		$message = '请填写用户名或者邮箱';
    	}
		else if(!preg_match('|\S{6,32}|',$password))
    	{
    		$message = '密码格式不正确,请输入6-32个字符';
    	}
    	else
    	{
    		if($userRow = CheckRights::isValidUser($login_info,md5($password)))
    		{
				$this->loginAfter($userRow);

				//记住帐号
				if($remember == 1)
				{
					ICookie::set('loginName',$login_info);
				}

				//自动登录
				if($autoLogin == 1)
				{
					ICookie::set('autoLogin',$autoLogin);
				}

				//自定义跳转页面
				if($callback != null && $callback != '' && $callback!="/simple/reg" && $callback!="/simple/login")
				{
					$this->redirect($callback);
				}
				else
				{
					$this->redirect('/ucenter/index');
				}
    		}
    		else
    		{
    			$message = '用户名和密码不匹配';
    		}
    	}

    	//错误信息
    	if($message != '')
    	{
    		$this->message = $message;
    		$_GET['callback'] = $callback;
    		$this->redirect('login',false);
    	}
    }

	//登录后的处理
    function loginAfter($userRow)
    {
		//用户私密数据
		ISafe::set('user_id',$userRow['id']);
		ISafe::set('username',$userRow['username']);
		ISafe::set('head_ico',$userRow['head_ico']);
		ISafe::set('user_pwd',$userRow['password']);

		//更新最后一次登录时间
		$memberObj = new IModel('member');
		$dataArray = array(
			'last_login' => ITime::getDateTime(),
		);
		$memberObj->setData($dataArray);
		$where     = 'user_id = '.$userRow["id"];
		$memberObj->update($where);
		$memberRow = $memberObj->getObj($where,'exp');

		//根据经验值分会员组
		$groupObj = new IModel('user_group');
		$groupRow = $groupObj->getObj($memberRow['exp'].' between minexp and maxexp ','id','discount','desc');
		if(!empty($groupRow))
		{
			$dataArray = array('group_id' => $groupRow['id']);
			$memberObj->setData($dataArray);
			$memberObj->update('user_id = '.$userRow["id"]);
		}
    }

    //商品加入购物车[ajax]
    function joinCart()
    {
    	$link       = IReq::get('link');
    	$goods_id   = intval(IReq::get('goods_id'));
    	$goods_num  = IReq::get('goods_num') === null ? 1 : intval(IReq::get('goods_num'));
    	$type       = IFilter::act(IReq::get('type'));

		//加入购物车
    	$cartObj   = new Cart();
    	$addResult = $cartObj->add($goods_id,$goods_num,$type);

    	if($link != '')
    	{
    		if($addResult === false)
    		{
    			$this->cart(false);
    			Util::showMessage($cartObj->getError());
    		}
    		else
    		{
    			$this->redirect($link);
    		}
    	}
    	else
    	{
	    	if($addResult === false)
	    	{
		    	$result = array(
		    		'isError' => true,
		    		'message' => $cartObj->getError(),
		    	);
	    	}
	    	else
	    	{
		    	$cartInfo = $cartObj->getMyCart();
		    	$result = array(
		    		'isError' => false,
		    		'data'    => $cartInfo,
		    		'message' => '添加成功',
		    	);
	    	}
	    	echo JSON::encode($result);
    	}
    }

    //根据goods_id获取货品
    function getProducts()
    {
    	$id = intval(IReq::get('id'));
    	$productObj   = new IModel('products');
    	$productsList = $productObj->query('goods_id = '.$id,'sell_price,id,spec_array,goods_id','store_nums','desc',7);
		if(!empty($productsList))
		{
			$data = array('mod' => 'selectProduct','productList' => $productsList);
			$this->redirect('/block/site',false,$data);
		}
		else
		{
			echo '';
		}
    }

    //删除购物车
    function removeCart()
    {
    	$link      = IReq::get('link');
    	$goods_id  = intval(IReq::get('goods_id'));
    	$type      = IReq::get('type');

    	$cartObj   = new Cart();
    	$cartInfo  = $cartObj->getMyCart();
    	$delResult = $cartObj->del($goods_id,$type);

    	if($link != '')
    	{
    		if($delResult === false)
    		{
    			$this->cart(false);
    			Util::showMessage($cartObj->getError());
    		}
    		else
    		{
    			$this->redirect($link);
    		}
    	}
    	else
    	{
	    	if($delResult === false)
	    	{
	    		$result = array(
		    		'isError' => true,
		    		'message' => $cartObj->getError(),
	    		);
	    	}
	    	else
	    	{
		    	$goodsRow = $cartInfo[$type]['data'][$goods_id];
		    	$cartInfo['sum']   -= $goodsRow['sell_price'] * $goodsRow['count'];
		    	$cartInfo['count'] -= $goodsRow['count'];

		    	$result = array(
		    		'isError' => false,
		    		'data'    => $cartInfo,
		    	);
	    	}

	    	echo JSON::encode($result);
    	}
    }

    //清空购物车
    function clearCart()
    {
    	$cartObj = new Cart();
    	$cartObj->clear();
    	$this->redirect('cart');
    }

    //购物车div展示
    function showCart()
    {
    	$cartObj  = new Cart();
    	$cartList = $cartObj->getMyCart();
		$data['mod']  = 'mycart';
    	$data['data'] = array_merge($cartList['goods']['data'],$cartList['product']['data']);
    	$data['count']= $cartList['count'];
    	$data['sum']  = $cartList['sum'];
    	$this->redirect('/block/site',false,$data);
    }

    //购物车页面及商品价格计算[复杂]
    function cart($redirect = false)
    {
    	//防止页面刷新
    	header("Cache-Control: no-store, no-cache, must-revalidate");
		header("Cache-Control: post-check=0, pre-check=0", false);

		//开始计算购物车中的商品价格
    	$countObj = new CountSum();
    	$result   = $countObj->cart_count();

    	//返回值
    	$this->final_sum = $result['final_sum'];
    	$this->promotion = $result['promotion'];
    	$this->proReduce = $result['proReduce'];
    	$this->sum       = $result['sum'];
    	$this->goodsList = $result['goodsList'];
    	$this->productList = $result['productList'];
    	$this->count       = $result['count'];
    	$this->reduce      = $result['reduce'];
    	$this->weight      = $result['weight'];

		//渲染视图
    	$this->redirect('cart',$redirect);
    }

    //计算促销规则[ajax]
    function promotionRuleAjax()
    {
    	$promotion = array();
    	$proReduce = 0;

    	//总金额满足的促销规则
    	if($this->user['user_id'])
    	{
    		$final_sum = intval(IReq::get('final_sum'));

    		//获取 user_group
	    	$groupObj = new IModel('member as m,user_group as g');
			$groupRow = $groupObj->getObj('m.user_id = '.$this->user['user_id'].' and m.group_id = g.id','g.*');
			$groupRow['id'] = empty($groupRow) ? 0 : $groupRow['id'];

	    	$proObj = new ProRule($final_sum);
	    	$proObj->setUserGroup($groupRow['id']);

	    	$promotion = $proObj->getInfo();
	    	$proReduce = $final_sum - $proObj->getSum();
    	}

		$result = array(
    		'promotion' => $promotion,
    		'proReduce' => $proReduce,
		);

    	echo JSON::encode($result);
    }

    //购物车寄存功能[写入]
    function deposit_cart_set()
    {
    	$is_ajax = IReq::get('is_ajax');

    	//必须为登录用户
    	if($this->user['user_id'] == null)
    	{
			$callback = "/simple/cart";
    		$this->redirect('/simple/login?callback={$callback}');
    	}

    	//获取购物车中的信息
    	$cartObj    = new Cart();
    	$myCartInfo = $cartObj->getMyCart();

		/*寄存的数据
		格式：goods => array (id => count);
		*/
    	$depositArray = array();

    	if(isset($myCartInfo['goods']['id']) && !empty($myCartInfo['goods']['id']))
    	{
    		foreach($myCartInfo['goods']['id'] as $id)
    		{
    			$depositArray['goods'][$id]   = $myCartInfo['goods']['data'][$id]['count'];
    		}
    	}

    	if(isset($myCartInfo['product']['id']) && !empty($myCartInfo['product']['id']))
    	{
    		foreach($myCartInfo['product']['id'] as $id)
    		{
    			$depositArray['product'][$id] = $myCartInfo['product']['data'][$id]['count'];
    		}
    	}

    	if(empty($depositArray))
    	{
    		$isError = true;
    		$message = '您的购物车中没有商品';
    	}
    	else
    	{
    		$isError = false;
	    	$dataArray   = array(
	    		'user_id'     => $this->user['user_id'],
	    		'content'     => serialize($depositArray),
	    		'create_time' => ITime::getDateTime(),
	    	);

	    	$goodsCarObj = new IModel('goods_car');
	    	$goodsCarRow = $goodsCarObj->getObj('user_id = '.$this->user['user_id']);
	    	$goodsCarObj->setData($dataArray);

	    	if(empty($goodsCarRow))
	    	{
	    		$goodsCarObj->add();
	    	}
	    	else
	    	{
	    		$goodsCarObj->update('user_id = '.$this->user['user_id']);
	    	}
	    	$message = '寄存成功';
    	}

		//ajax方式
    	if($is_ajax == 1)
    	{
    		$result = array(
    			'isError' => $isError,
    			'message' => $message,
    		);

    		echo JSON::encode($result);
    	}

    	//传统跳转方式
    	else
    	{
			//页面跳转
			$this->cart();
	    	if(isset($message))
	    	{
	    		Util::showMessage($message);
	    	}
    	}
    }

    //购物车寄存功能[读取]
    function deposit_cart_get()
    {
    	//必须为登录用户
    	if($this->user['user_id'] == null)
    	{
    		$this->redirect('/simple/login?callback=/simple/cart');
    	}

    	$goodsCatObj = new IModel('goods_car');
    	$goodsCarRow = $goodsCatObj->getObj('user_id = '.$this->user['user_id']);

    	if(isset($goodsCarRow['content']))
    	{
    		$depositContent = unserialize($goodsCarRow['content']);

	    	//获取购物车中的信息
	    	$cartObj    = new Cart();
	    	$myCartInfo = $cartObj->getMyCart();

	    	if(isset($depositContent['goods']))
	    	{
		    	foreach($depositContent['goods'] as $id => $count)
		    	{
		    		if(!in_array($id,$myCartInfo['goods']['id']) && ($depositGoods = $cartObj->getUpdateCartData($myCartInfo,$id,$count,'goods')))
		    		{
		    			$myCartInfo = $depositGoods;
		    		}
		    	}
	    	}

	    	if(isset($depositContent['product']))
	    	{
		    	foreach($depositContent['product'] as $id => $count)
		    	{
		    		if(!in_array($id,$myCartInfo['product']['id']) && ($depositProducts = $cartObj->getUpdateCartData($myCartInfo,$id,$count,'product')))
		    		{
		    			$myCartInfo = $depositProducts;
		    		}
		    	}
	    	}
    	}
    	else
    	{
    		$message = '您没有寄存任何商品';
    	}

		//页面跳转
    	if(isset($message))
    	{
    		$this->cart(false);
    		Util::showMessage($message);
    	}
    	else
    	{
    		$cartObj->setMyCart($myCartInfo);
    		$this->cart(true);
    	}
    }

    //清空寄存购物车
    function deposit_cart_clear()
    {
    	//必须为登录用户
    	if($this->user['user_id'] == null)
    	{
    		$this->redirect('/simple/login?callback=/simple/cart');
    	}

    	$goodsCarObj = new IModel('goods_car');
    	$goodsCarObj->del('user_id = '.$this->user['user_id']);
    	$this->cart();
    	Util::showMessage('操作成功');
    }

    //根据商品总额计算税金 ajax
    function count_tax()
    {
    	$goods_sum = IFilter::act(IReq::get('goods_sum'),'float');
    	$tax       = 0;

    	if($goods_sum > 0)
    	{
			$siteConfigObj = new Config("site_config");
			$site_config   = $siteConfigObj->getInfo();
			$tax_per       = isset($site_config['tax']) ? $site_config['tax'] : 0;
			$tax           = $goods_sum * ($tax_per/100);
			$tax           = round($tax,2);
    	}
    	echo $tax;
    }

    //填写订单信息cart2
    function cart2()
    {
		$id        = intval(IReq::get('id'));
		$type      = IFilter::act(IReq::get('type'));
		$buy_num   = IReq::get('num') ? intval(IReq::get('num')) : 1;
		$promo     = IFilter::act(IReq::get('promo'));
		$active_id = intval(IReq::get('active_id'));
		$tourist   = IReq::get('tourist');//游客方式购物

		//活动购买方式
		if($promo == 'groupon' && $active_id != '')
		{
			$hashId = $this->user['user_id'] ? $this->user['user_id'] : ICookie::get("regiment_{$active_id}");

			//此团购还存在已经报名但是未付款的情况
			if(regiment::hasJoined($active_id,$hashId) == true)
			{
				IError::show(403,'您已经参加过此次团购，请先完成支付');
				exit;
			}

			//团购已经达到限定的人数
			if(regiment::isFull($active_id) == true)
			{
				IError::show(403,'此团购的参加人数已满');
				exit;
			}
		}

    	//必须为登录用户
    	if($tourist === null && $this->user['user_id'] == null)
    	{
    		if($id == 0 || $type == '')
    		{
    			$this->redirect('/simple/login?tourist&callback=/simple/cart2');
    		}
    		else
    		{
    			$url  = '/simple/login?tourist&callback=/simple/cart2/id/'.$id.'/type/'.$type.'/num/'.$buy_num;
    			$url .= $promo     ? '/promo/'.$promo         : '';
    			$url .= $active_id ? '/active_id/'.$active_id : '';
    			$this->redirect($url);
    		}
    	}

		//游客的user_id默认为0
    	$user_id = ($this->user['user_id'] == null) ? 0 : $this->user['user_id'];

    	//获取收货地址
    	$addressObj  = new IModel('address');
    	$addressList = $addressObj->query('user_id = '.$user_id);

		$addressRow  = array();
		$areaArray   = array();
    	foreach($addressList as $val)
    	{
    		$areaArray[$val['province']] = $val['province'];
    		$areaArray[$val['city']]     = $val['city'];
    		$areaArray[$val['area']]     = $val['area'];
    	}

		if(!empty($areaArray))
		{
			//拼接area_id对应的名字
	    	$areaIdStr = join(',',$areaArray);
	    	$areaObj   = new IModel('areas');
	    	$areaList  = $areaObj->query('area_id in ('.$areaIdStr.')','area_name,area_id');
	    	foreach($areaList as $val)
	    	{
	    		$areaArray[$val['area_id']] = $val['area_name'];
	    	}

			//更新$addressList数据
	    	foreach($addressList as $key => $val)
	    	{
	    		$addressList[$key]['province_val'] = $areaArray[$val['province']];
	    		$addressList[$key]['city_val']     = $areaArray[$val['city']];
	    		$addressList[$key]['area_val']     = $areaArray[$val['area']];
	    		if($val['default'] == 1)
	    		{
	    			$addressRow = $addressList[$key];
	    		}
	    	}
		}

		//获取用户的道具红包和用户的习惯方式
		$this->prop = array();
		$memberObj = new IModel('member');
		$memberRow = $memberObj->getObj('user_id = '.$user_id,'prop,custom');

		if(isset($memberRow['prop']) && ($propId = trim($memberRow['prop'],',')))
		{
			$porpObj = new IModel('prop');
			$this->prop = $porpObj->query('id in ('.$propId.') and NOW() between start_time and end_time and type = 0 and is_close = 0 and is_userd = 0 and is_send = 1','id,name,value,card_name');
		}

		if(isset($memberRow['custom']) && $memberRow['custom'] != '')
		{
			$this->custom = unserialize($memberRow['custom']);
		}
		else
		{
			$this->custom = array(
				'payment'     => '',
				'delivery'    => '',
			);
		}

		//计算商品
		$countSumObj = new CountSum();

		//判断是特定活动还是购物车
		if($id != 0 && $type != '')
		{
			$result = $countSumObj->direct_count($id,$type,$buy_num,$promo,$active_id);
			$this->gid       = $id;
			$this->type      = $type;
			$this->num       = $buy_num;
			$this->promo     = $promo;
			$this->active_id = $active_id;
		}
		else
		{
			//计算购物车中的商品价格
			$result = $countSumObj->cart_count();
		}

		if($result['count'] == 0)
		{
			$this->redirect('/simple/cart');
			exit;
		}

    	//返回值
    	$this->final_sum = $result['final_sum'];
    	$this->promotion = $result['promotion'];
    	$this->proReduce = $result['proReduce'];
    	$this->sum       = $result['sum'];
    	$this->goodsList = $result['goodsList'];
    	$this->productList = $result['productList'];
    	$this->count       = $result['count'];
    	$this->reduce      = $result['reduce'];
    	$this->weight      = $result['weight'];
    	$this->freeFreight = $result['freeFreight'];

		//收货地址列表
		$this->addressList = $addressList;

		//默认收货地址
		$this->addressRow = $addressRow;

    	//获取税率
		$siteConfigObj = new Config("site_config");
		$site_config   = $siteConfigObj->getInfo();
		$this->tax_per = isset($site_config['tax']) ? $site_config['tax'] : 0;

    	//渲染页面
    	$this->redirect('cart2');
    }

    function cart3()
    {
    	$accept_name       = IFilter::act(IReq::get('accept_name'));
    	$province          = IFilter::act(IReq::get('province'),'int');
    	$city              = IFilter::act(IReq::get('city'),'int');
    	$area              = IFilter::act(IReq::get('area'),'int');
    	$address           = IFilter::act(IReq::get('address'));
    	$mobile            = IFilter::act(IReq::get('mobile'));
    	$telphone          = IFilter::act(IReq::get('telphone'));
    	$zip               = IFilter::act(IReq::get('zip'));
    	$delivery_id       = IFilter::act(IReq::get('delivery_id'),'int');
    	$accept_time_radio = IFilter::act(IReq::get('accept_time_radio'),'int');
    	$accept_time       = IFilter::act(IReq::get('accept_time'));
    	$payment           = IFilter::act(IReq::get('payment'),'int');
    	$order_message     = IFilter::act(IReq::get('message'));
    	$ticket_id         = IFilter::act(IReq::get('ticket_id'),'int');
    	$is_tax            = IFilter::act(IReq::get('is_tax'),'int');
    	$tax_title         = IFilter::act(IReq::get('tax_title'),'text');
    	$gid               = intval(IReq::get('direct_gid'));
    	$num               = intval(IReq::get('direct_num'));
    	$type              = IFilter::act(IReq::get('direct_type'));//商品或者货品
    	$promo             = IFilter::act(IReq::get('direct_promo'));
    	$active_id         = intval(IReq::get('direct_active_id'));
    	$tourist           = IReq::get('tourist');//游客方式购物
    	$order_no          = block::createOrderNum();
    	$order_type        = 0;
    	$is_protectPrice   = IFilter::act(IReq::get('protect_price'));

    	$dataArray         = array();

		//防止表单重复提交
    	if(IReq::get('timeKey') != null)
    	{
    		if(ISafe::get('timeKey') == IReq::get('timeKey'))
    		{
	    		IError::show(403,'订单数据不能被重复提交');
	    		exit;
    		}
    		else
    		{
    			ISafe::set('timeKey',IReq::get('timeKey'));
    		}
    	}

    	if($province == 0 || $city == 0 || $area == 0)
    	{
    		IError::show(403,'请填写收货地址的省市地区');
    	}

    	if($delivery_id == 0)
    	{
    		IError::show(403,'请选择配送方式');
    	}

    	$user_id = ($this->user['user_id'] == null) ? 0 : $this->user['user_id'];

		//活动特殊处理
		if($promo != '' && $active_id != '')
		{
			//团购
			if($promo == 'groupon')
			{
				$hashId = $user_id ? $user_id : ICookie::get("regiment_{$active_id}");

				//此团购还存在已经报名但是未付款的情况
				if(regiment::hasJoined($active_id,$hashId) == true)
				{
					IError::show(403,'您已经参加过此次团购，请先完成支付');
					exit;
				}

				//团购已经达到限定的人数
				if(regiment::isFull($active_id) == true)
				{
					IError::show(403,'此团购的参加人数已满');
					exit;
				}

				$order_type = 1;

				//团购开始报名
				$joinUserId = $user_id ? $user_id : null;
				$resultData = regiment::join($active_id,$joinUserId);
				$is_success = '';

				if($resultData['flag'] == true)
				{
					$regimentRelationObj = new IModel('regiment_user_relation');
					$regimentRelationObj->setData(array('order_no' => $order_no));
					$is_success          = $regimentRelationObj->update('id = '.$resultData['relation_id']);
				}

				if($is_success == '' || $resultData['flag'] == false)
				{
					$errorMsg = ( isset($resultData['data']) && $resultData['data'] != '' ) ? $resultData['data'] : '团购报名失败';
					IError::show(403,$errorMsg);
					exit;
				}
			}
			//限时抢购
			else if($promo == 'time')
			{
				$order_type = 2;
			}
		}

		//付款方式,判断是否为货到付款
		$deliveryObj = new IModel('delivery');
		$deliveryRow = $deliveryObj->getObj('id = '.$delivery_id,'type');

		if($deliveryRow['type'] == 0 && $payment == 0)
		{
			IError::show(403,'请选择支付方式');
		}
		else if($deliveryRow['type'] == 1)
		{
			$payment = 0;
		}

    	$countSumObj = new CountSum();

    	//直接购买商品方式
    	if($type !='' && $gid != 0)
    	{
    		//计算$gid商品
    		$goodsResult = $countSumObj->direct_count($gid,$type,$num,$promo,$active_id);
    	}
    	else
    	{
			//计算购物车中的商品价格$goodsResult
			$goodsResult = $countSumObj->cart_count();

			//清空购物车
	    	$cartObj = new Cart();
	    	$cartObj->clear();
    	}

    	//判断商品商品是否存在
    	if(empty($goodsResult['goodsList']) && empty($goodsResult['productList']))
    	{
    		IError::show(403,'商品数据不存在');
    		exit;
    	}

		$sum_r         = $goodsResult['sum'];
		$proReduce_r   = $goodsResult['proReduce'];
		$reduce_r      = $goodsResult['reduce'];
		$final_sum_r   = $goodsResult['final_sum'];
		$freeFreight_r = $goodsResult['freeFreight'];
		$point_r       = $goodsResult['point'];
		$exp_r         = $goodsResult['exp'];

		//计算运费$deliveryPrice和保价$protect_price
    	$deliveryList  = Delivery::getDelivery($province,$goodsResult['weight'],$final_sum_r);
    	$deliveryPrice = $deliveryList[$delivery_id]['price'];

    	if($is_protectPrice == null)
    	{
    		$protect_price = 0;
    		$if_insured    = 0;
    	}
    	else
    	{
    		$protect_price = $deliveryList[$delivery_id]['protect_price'];
    		$if_insured    = 1;
    	}

		if($freeFreight_r == true)
		{
			$deliveryPrice_r = 0;
		}
		else
		{
			$deliveryPrice_r = $deliveryPrice;
		}

		//获取红包减免金额
		if($ticket_id != '')
		{
			$memberObj = new IModel('member');
			$memberRow = $memberObj->getObj('user_id = '.$user_id,'prop,custom');

			if(ISafe::get('ticket_'.$ticket_id) == $ticket_id || stripos(','.trim($memberRow['prop'],',').',',','.$ticket_id.',') !== false)
			{
				$propObj   = new IModel('prop');
				$ticketRow = $propObj->getObj('id = '.$ticket_id.' and NOW() between start_time and end_time and type = 0 and is_close = 0 and is_userd = 0 and is_send = 1');
				if(!empty($ticketRow))
				{
					$ticket_value = $ticketRow['value'];
					$reduce_r    += $ticket_value;
					$final_sum_r -= $ticket_value;
					$dataArray['prop'] = $ticket_id;
				}

				//锁定红包状态
				$propObj->setData(array('is_close' => 2));
				$propObj->update('id = '.$ticket_id);
			}
		}

    	//获取税率$tax
    	if($is_tax == 1)
    	{
			$siteConfigObj = new Config("site_config");
			$site_config   = $siteConfigObj->getInfo();
			$tax_per       = isset($site_config['tax']) ? $site_config['tax'] : 0;
			$tax           = $final_sum_r * ($tax_per/100);
    	}
    	else
    	{
    		$tax = 0;
    	}

		//货到付款的方式
		if($payment == 0)
		{
			$paymentName = '货到付款';
			$payment_fee = 0;
			$paymentType = 0;
			$paymentNote = '';
		}
		else
		{
			//计算支付手续费
			$paymentObj = new IModel('payment');
			$paymentRow = $paymentObj->getObj('id = '.$payment,'type,poundage,poundage_type,name,note');
			$paymentName= $paymentRow['name'];
			$paymentType= $paymentRow['type'];
			$paymentNote= $paymentRow['note'];

			if($paymentRow['poundage_type'] == 1)
			{
				$payment_fee = ($final_sum_r + $tax + $deliveryPrice_r + $protect_price) * ($paymentRow['poundage']/100);
			}
			else
			{
				$payment_fee = $paymentRow['poundage'];
			}
		}

		//最终订单金额计算
		$order_amount = $final_sum_r + $deliveryPrice_r + $payment_fee + $tax + $protect_price;
		$order_amount = $order_amount <= 0 ? 0 : round($order_amount,2);

		//生成的订单数据
		$dataArray = array(
			'order_no'            => $order_no,
			'user_id'             => $user_id,
			'accept_name'         => $accept_name,
			'pay_type'            => $payment,
			'distribution'        => $delivery_id,
			'status'              => 1,
			'pay_status'          => 0,
			'distribution_status' => 0,
			'postcode'            => $zip,
			'telphone'            => $telphone,
			'province'            => $province,
			'city'                => $city,
			'area'                => $area,
			'address'             => $address,
			'mobile'              => $mobile,
			'create_time'         => ITime::getDateTime(),
			'invoice'             => $is_tax,
			'postscript'          => $order_message,
			'invoice_title'       => $tax_title,
			'accept_time'         => $accept_time,
			'exp'                 => $exp_r,
			'point'               => $point_r,
			'type'                => $order_type,

			//红包道具
			'prop'                => isset($dataArray['prop']) ? $dataArray['prop'] : null,

			//商品价格
			'payable_amount'      => $goodsResult['sum'],
			'real_amount'         => $goodsResult['final_sum'],

			//运费价格
			'payable_freight'     => $deliveryPrice,
			'real_freight'        => $deliveryPrice_r,

			//手续费
			'pay_fee'             => $payment_fee,

			//税金
			'taxes'               => $tax,

			//优惠价格
			'promotions'          => $proReduce_r + $reduce_r,

			//订单应付总额
			'order_amount'        => $order_amount,

			//订单保价
			'if_insured'          => $if_insured,
			'insured'             => $protect_price,
		);

		$orderObj  = new IModel('order');
		$orderObj->setData($dataArray);

		$this->order_id = $orderObj->add();

		if($this->order_id == false)
		{
			IError::show(403,'订单生成错误');
		}

		/*将订单中的商品插入到order_goods表*/
		$orderGoodsObj = new IModel('order_goods');
		$goodsArray = array(
			'order_id' => $this->order_id
		);

		$findType = array('goods'=>'goodsList','product'=>'productList');

		foreach($findType as $key => $list)
		{
			if(isset($goodsResult[$list]) && count($goodsResult[$list]) > 0)
			{
				foreach($goodsResult[$list] as $k => $val)
				{
					//拼接商品名称和规格数据
					$specArray = array('name' => $val['name'],'value' => '');
					if($key == 'product')
					{
						$goodsArray['product_id']  = $val['id'];
						$goodsArray['goods_id']    = $val['goods_id'];

						$spec = block::show_spec($val['spec_array']);
						foreach($spec as $skey => $svalue)
						{
							$specArray['value'] .= $skey.':'.$svalue.' , ';
						}
					}
					else
					{
						$goodsArray['goods_id']  = $val['id'];
						$goodsArray['product_id']= 0;
					}
					$specArray = serialize($specArray);
					$goodsArray['goods_price'] = $val['sell_price'];
					$goodsArray['real_price']  = $val['sell_price'] - $val['reduce'];
					$goodsArray['goods_nums']  = $val['count'];
					$goodsArray['goods_weight']= $val['weight'];
					$goodsArray['goods_array'] = $specArray;
					$orderGoodsObj->setData($goodsArray);
					$orderGoodsObj->add();
				}
			}
		}

		//更改购买商品的库存数量
		Block::updateStore($this->order_id , 'reduce');

		//记录用户默认习惯的数据
		if(!isset($memberRow['custom']))
		{
			$memberObj = new IModel('member');
			$memberRow = $memberObj->getObj('user_id = '.$user_id,'custom');
		}

		$memberData = array(
			'custom' => serialize(
				array(
					'payment'  => $payment,
					'delivery' => $delivery_id,
				)
			),
		);
		$memberObj->setData($memberData);
		$memberObj->update('user_id = '.$user_id);

		//收货地址的处理
		if($user_id)
		{
			$addressObj = new IModel('address');

			//如果用户之前没有收货地址,那么会自动记录此次的地址信息并且为默认
			$addressRow = $addressObj->getObj('user_id = '.$user_id);
			if(empty($addressRow))
			{
				$addressData = array('default'=>'1','user_id'=>$user_id,'accept_name'=>$accept_name,'province'=>$province,'city'=>$city,'area'=>$area,'address'=>$address,'zip'=>$zip,'telphone'=>$telphone,'mobile'=>$mobile);
				$addressObj->setData($addressData);
				$addressObj->add();
			}
			else
			{
				//如果用户有收货地址,但是没有设置默认项,那么会自动设置此次地址信息为默认
				$radio_address = intval(IReq::get('radio_address'));
				if($radio_address != 0)
				{
					$addressDefRow = $addressObj->getObj('user_id = '.$user_id.' and `default` = 1');
					if(empty($addressDefRow))
					{
						$addressData = array('default' => 1);
						$addressObj->setData($addressData);
						$addressObj->update('user_id = '.$user_id.' and id = '.$radio_address);
					}
				}
			}
		}

		//获取备货时间
		$siteConfigObj = new Config("site_config");
		$site_config   = $siteConfigObj->getInfo();
		$this->stockup_time = isset($site_config['stockup_time'])?$site_config['stockup_time']:2;

		//数据渲染
		$this->order_num   = $dataArray['order_no'];
		$this->final_sum   = $dataArray['order_amount'];
		$this->payment_fee = $payment_fee;
		$this->payment     = $paymentName;
		$this->delivery    = $deliveryList[$delivery_id]['name'];
		$this->tax_title   = $tax_title;
		$this->deliveryType= $deliveryRow['type'];
		$this->paymentType = $paymentType;
		$this->paymentNote = $paymentNote;

		//订单金额为0时，订单自动完成
		if($this->final_sum <= 0)
		{
			$order_id = payment::updateOrder($dataArray['order_no']);
			if($order_id != '')
			{
				if($user_id)
				{
					$this->redirect('/site/success/message/'.urlencode("订单确认成功，等待发货").'/?callback=ucenter/order_detail/id/'.$order_id);
				}
				else
				{
					$this->redirect('/site/success/message/'.urlencode("订单确认成功，等待发货"));
				}
			}
			else
			{
				IError::show(403,'订单修改失败');
			}
		}
		else
		{
			$this->redirect('cart3');
		}
    }

    //cart3支付按钮操作
    function do_pay()
    {
    	$id       = intval(IReq::get('order_id'));
    	$payment  = intval(IReq::get('payment'));//更新的支付方式

    	$orderObj = new IModel('order');
    	$orderRow = $orderObj->getObj('id = '.$id);
    	if(empty($orderRow))
    	{
    		IError::show(403,'订单不存在');
    	}

		//更换了支付方式，更新手续费
    	if($payment != 0 && $orderRow['pay_type'] != $payment)
    	{
    		$paymentObj = new IModel('payment');
    		$payRow     = $paymentObj->getObj('id = '.$payment,'poundage_type,poundage');

    		if($payRow['poundage_type'] == 1)
    		{
    			$pay_fee = ($orderRow['order_amount'] - $orderRow['pay_fee']) * ($payRow['poundage']/100);
    		}
    		else
    		{
    			$pay_fee = $payRow['poundage'];
    		}

    		$dataArray = array(
    			'pay_type'     => $payment,
    			'order_amount' => $orderRow['order_amount'] - $orderRow['pay_fee'] + $pay_fee,
    			'pay_fee'      => $pay_fee,
    		);
    		$orderObj->setData($dataArray);
    		$orderObj->update('id = '.$id);
    	}
    	else
    	{
    		$payment = $orderRow['pay_type'];
    	}

		//拼接query字符串
		$query_str = '?order_id='.$id.'&id='.$payment;

    	$this->redirect('/block/doPay/'.$query_str);
    }

    //到货通知处理动作
	function arrival_notice()
	{
		$user_id = ISafe::get('user_id');
		if(!$user_id)
		{
			$user_id = 0;
		}
		/*
		未登录的时候也能弄到货通知
		if($user_id == '')
		{
			$this->redirect('/simple/login?callback='.urlencode('/simple/arrival'));
		}
		*/
		$email = IFilter::act( IReq::get('email') );
		$mobile = IFilter::act( IReq::get('mobile'));
		$goods_id = IFilter::act( IReq::get('goods_id'),'int' );
		$register_time = date('Y-m-d H:i:s');
		$model = new IModel('notify_registry');

		$obj = $model->getObj("email = '{$email}' and user_id = '{$user_id}' and goods_id = '$goods_id'");
		if(empty($obj))
		{
			$model->setData(array('email'=>$email,'user_id'=>$user_id,'mobile'=>$mobile,'goods_id'=>$goods_id,'register_time'=>$register_time));
			$model->add();
		}
		else
		{
			$model->setData(array('email'=>$email,'user_id'=>$user_id,'mobile'=>$mobile,'goods_id'=>$goods_id,'register_time'=>$register_time,'notify_status'=>0));
			$model->update('id = '.$obj['id']);
		}
		$this->redirect('arrival_result');
	}
    //到货通知登记页面
    function arrival()
    {
    	/*
        $user_id = ISafe::get('user_id');
		if($user_id == '')
		{
			$this->redirect('/simple/login?callback='.urlencode('/simple/arrival'));
		}
		*/
        $this->redirect('arrival');
    }

    function do_find_password()
	{
		$username = IReq::get('username');
		if($username === null || !Util::is_username($username)  )
		{
			die("请输入正确的用户名");
		}

		$useremail = IReq::get("useremail");
		if($useremail ===null || !IValidate::email($useremail ))
		{
			die("请输入正确的邮箱地址");
		}

		$captcha = IReq::get("captcha");
		if($captcha != ISafe::get('Captcha'))
		{
			die('验证码输入不正确');
		}

		$tb_user = new IModel("user");
		$username = IFilter::act($username);
		$useremail = IFilter::act($useremail);
		$user = $tb_user->query("username='{$username}' AND email='{$useremail}'");
		if(!$user)
		{
			die("没有这个用户");
		}
		$user=end($user);
		$hash = IHash::md5( microtime(true) .mt_rand());
		$tb_find_password = new IModel("find_password"); //重新生成
		$tb_find_password->setData( array( 'hash'=>$hash ,'user_id'=>$user['id'] , 'addtime'=>time()  ) );

		$sendMail = true;

		if( $tb_find_password->query("`hash` = '{$hash}'") || $tb_find_password->add()  )
		{
			$smtp = new SendMail();

			$url = IUrl::creatUrl("/simple/restore_password/hash/{$hash}");
			$url = IUrl::getHost().$url;
			$content = "请你点击下面这个链接修改密码：<a href='{$url}'>{$url}</a>。<br />如果不能点击，请您把它复制到地址栏中打开。<br />本链接在3天后将自动失效。";

			$re = $smtp->send($user['email'],"您的密码找回",$content );

			if($re===false )
			{
				die("发信失败");
			}
			die("success");
		}
		die("找回密码失败");
	}

	function restore_password()
	{
		$hash = IReq::get("hash");
		if(!$hash)
		{
			throw new IHttpException("参数不完整",0);
			exit;
		}
		$hash = IFilter::act($hash,'string');
		$tb = new IModel("find_password");
		$addtime = time() - 3600*72;
		$row = $tb->getObj("`hash`='$hash' AND addtime>$addtime ");
		if(!$row)
		{
			throw new IHttpException("本链接已失效，请重新申请密码找回链接",0);
			exit;
		}
		$formAction = IUrl::creatUrl("/simple/do_restore_password/hash/$hash");
		$this->formAction = $formAction;
		$this->redirect("restore_password");
	}

	function do_restore_password()
	{
		$hash = IReq::get("hash");
		if(!$hash)
		{
			throw new IHttpException("参数不完整",404);
			exit;
		}
		$hash = IFilter::act($hash,'string');
		$tb = new IModel("find_password");
		$addtime = time() - 3600*72;
		$row = $tb->getObj("`hash`='$hash' AND addtime>$addtime ");
		if(!$row)
		{
			throw new IHttpException("本链接已失效，请重新申请密码找回链接",403);
			exit;
		}

		$pwd = IReq::get("password");
		$repwd = IReq::get("repassword");
		if($pwd == null || strlen($pwd) < 6 || $repwd!=$pwd)
		{
			throw new IHttpException("新密码至少六位，且两次输入的密码应该一致。",403);
			exit;
		}
		$pwd = md5($pwd);
		$tb_user = new IModel("user");
		$tb_user->setData(array("password"=>$pwd));
		$re = $tb_user->update("id='{$row['user_id']}'");
		if($re !== false)
		{
			$message = "修改密码成功";
			$tb->del("`hash`='{$hash}'");
			$this->redirect("/site/success/message/$message");
			exit;
		}
		else
		{
			//throw new IHttpException("修改密码失败",403);
			exit;
		}
	}

    //添加收藏夹
    function favorite_add()
    {
    	$goods_id = intval(IReq::get('goods_id'));
    	$message  = '';

    	if($goods_id == 0)
    	{
    		$message = '商品id值不能为空';
    	}
    	else if(ISafe::get('user_id') == null)
    	{
    		$message = '请先登录';
    	}
    	else
    	{
    		$favoriteObj = new IModel('favorite');
    		$goodsRow    = $favoriteObj->getObj('user_id = '.$this->user['user_id'].' and rid = '.$goods_id);
    		if(!empty($goodsRow))
    		{
    			$message = '您已经收藏过次商品';
    		}
    		else
    		{
    			$catObj = new IModel('category_extend');
    			$catRow = $catObj->getObj('goods_id = '.$goods_id);
    			$cat_id = $catRow ? $catRow['category_id'] : 0;

	    		$dataArray   = array(
	    			'user_id' => $this->user['user_id'],
	    			'rid'     => $goods_id,
	    			'time'    => ITime::getDateTime(),
	    			'cat_id'  => $cat_id,
	    		);
	    		$favoriteObj->setData($dataArray);
	    		$favoriteObj->add();
    		}
    	}

    	if($message == '')
    	{
    		$result = array(
    			'isError' => false,
    			'message' => '收藏成功',
    		);
    	}
    	else
    	{
    		$result = array(
    			'isError' => true,
    			'message' => $message,
    		);
    	}

    	echo JSON::encode($result);
    }

    //获取oauth登录地址
    public function oauth_login()
    {
    	$id = intval(IReq::get('id'));
    	ISafe::set('callback',IReq::get('callback')); //记录回调地址
    	if($id)
    	{
    		$oauthObj = new Oauth($id);
			$result   = array(
				'isError' => false,
				'url'     => $oauthObj->getLoginUrl(),
			);
    		ISession::set('oauth',$id);
    	}
    	else
    	{
			$result   = array(
				'isError' => true,
				'message' => '请选择要登录的平台',
			);
    	}
    	echo JSON::encode($result);
    }

    //获取令牌
    public function oauth_callback()
    {
    	$id = intval(ISession::get('oauth'));
    	if(!$id)
    	{
    		$this->redirect('login');
    		exit;
    	}
    	$oauthObj = new Oauth($id);
    	$result   = $oauthObj->checkStatus($_GET);

    	if($result === true)
    	{
    		$oauthObj->getAccessToken($_GET);
	    	$userInfo = $oauthObj->getUserInfo();

	    	if(isset($userInfo['id']) && isset($userInfo['name']) && $userInfo['id'] != '' &&  $userInfo['name'] != '')
	    	{
	    		$this->bindUser($userInfo,$id);
	    	}
	    	else
	    	{
	    		$this->redirect('login');
	    	}
    	}
    	else
    	{
    		$this->redirect('login');
    	}
    }

    //同步绑定用户数据
    public function bindUser($userInfo,$oauthId)
    {
    	$oauthUserObj = new IModel('oauth_user');
    	$oauthUserRow = $oauthUserObj->getObj("oauth_user_id = '{$userInfo['id']}' and oauth_id = '{$oauthId}' ",'user_id');

    	//没有绑定账号
    	if(empty($oauthUserRow))
    	{
	    	$userObj   = new IModel('user');
	    	$userCount = $userObj->getObj("username = '{$userInfo['name']}'",'count(*) as num');

	    	//没有重复的用户名
	    	if($userCount['num'] == 0)
	    	{
	    		$username = $userInfo['name'];
	    	}
	    	else
	    	{
	    		//随即分配一个用户名
	    		$username = $userInfo['name'].$userCount['num'];
	    	}

	    	ISafe::set('oauth_username',$username);
	    	ISession::set('oauth_id',$oauthId);
	    	ISession::set('oauth_userInfo',$userInfo);

	    	$this->redirect('bind_user');
    	}

    	//存在绑定账号
    	else
    	{
    		$userObj = new IModel('user');
    		$userRow = $userObj->getObj("id = '{$oauthUserRow['user_id']}'");
    		$this->loginAfter($userRow);

			//自定义跳转页面
			$callback = ISafe::get('callback');

			if($callback != null && $callback != '' && $callback!="/simple/reg" && $callback!="/simple/login")
			{
				$this->redirect($callback);
			}
			else
			{
				$this->redirect('/ucenter/index');
			}
    	}
    }

	//绑定已存在用户
    public function bind_exists_user()
    {
    	$login_info     = IReq::get('login_info');
    	$password       = IReq::get('password');
    	$oauth_id       = IFilter::act(ISession::get('oauth_id'));
    	$oauth_userInfo = IFilter::act(ISession::get('oauth_userInfo'));

    	if(!$oauth_id || !isset($oauth_userInfo['id']))
    	{
    		$this->redirect('login');
    		exit;
    	}

    	if($userRow = CheckRights::isValidUser($login_info,md5($password)))
    	{
    		$oauthUserObj = new IModel('oauth_user');

    		//插入关系表
    		$oauthUserData = array(
    			'oauth_user_id' => $oauth_userInfo['id'],
    			'oauth_id'      => $oauth_id,
    			'user_id'       => $userRow['user_id'],
    			'datetime'      => ITime::getDateTime(),
    		);
    		$oauthUserObj->setData($oauthUserData);
    		$oauthUserObj->add();

    		$this->loginAfter($userRow);

			//自定义跳转页面
			$callback = ISafe::get('callback');
			$this->redirect('/simple/success_info/?callback='.$callback);
    	}
    	else
    	{
    		$this->login_info = $login_info;
    		$this->message    = '用户名和密码不匹配';
    		$_GET['bind_type']= 'exists';
    		$this->redirect('bind_user',false);
    	}
    }

	//绑定不存在用户
    public function bind_nexists_user()
    {
    	$username       = IFilter::act(IReq::get('username'));
    	$email          = IFilter::act(IReq::get('email'));
    	$oauth_id       = IFilter::act(ISession::get('oauth_id'));
    	$oauth_userInfo = IFilter::act(ISession::get('oauth_userInfo'));

		/*注册信息校验*/
    	if(IValidate::email($email) == false)
    	{
    		$message = '邮箱格式不正确';
    	}
    	else if(!Util::is_username($username))
    	{
    		$message = '用户名必须是由2-20个字符，可以为字数，数字下划线和中文';
    	}
    	else
    	{
    		$userObj = new IModel('user');
    		$where   = 'email = "'.$email.'" or username = "'.$email.'" or username = "'.$username.'"';
    		$userRow = $userObj->getObj($where);

    		if(!empty($userRow))
    		{
    			if($email == $userRow['email'])
    			{
    				$message = '此邮箱已经被注册过，请重新更换';
    			}
    			else
    			{
    				$message = "此用户名已经被注册过，请重新更换";
    			}
    		}
    		else
    		{
				$userData = array(
					'email'    => $email,
					'username' => $username,
					'password' => md5(ITime::getDateTime()),
				);
				$userObj->setData($userData);
				$user_id = $userObj->add();

				$memberObj  = new IModel('member');
				$memberData = array(
					'user_id'   => $user_id,
					'true_name' => $oauth_userInfo['name'],
					'last_login'=> ITime::getDateTime(),
					'sex'       => isset($oauth_userInfo['sex']) ? $oauth_userInfo['sex'] : 1,
					'time'      => ITime::getDateTime(),
				);
				$memberObj->setData($memberData);
				$memberObj->add();

				$oauthUserObj = new IModel('oauth_user');

				//插入关系表
				$oauthUserData = array(
					'oauth_user_id' => $oauth_userInfo['id'],
					'oauth_id'      => $oauth_id,
					'user_id'       => $user_id,
					'datetime'      => ITime::getDateTime(),
				);
				$oauthUserObj->setData($oauthUserData);
				$oauthUserObj->add();

				$userRow = $userObj->getObj('id = '.$user_id);
				$this->loginAfter($userRow);

				//自定义跳转页面
				$callback = ISafe::get('callback');
				$this->redirect('/simple/success_info/?callback='.$callback);
    		}
    	}

    	if($message != '')
    	{
    		$this->message = $message;
    		$this->redirect('bind_user',false);
    	}
    }
}
