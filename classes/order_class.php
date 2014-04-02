<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file Order_Class.php
 * @brief 订单中相关的
 * @author relay
 * @date 2011-02-24
 * @version 0.6
 */
class Order_Class
{
	/**
	 * @param $order_id string 订单的id
	 * @return array()
	 * @brief 配送方式计算管理模块
	 */
	static function get_order_show($order_id)
	{
		$data = array();
		//获得对象
		$tb_order = new IModel('order');
 		$order_info = $tb_order->query('id='.$order_id);
 		if(count($order_info)>0)
 		{
 			$data = $order_info[0];

	 		$data['order_id'] = $order_id;
	 		//配送方式
	 		$tb_delivery = new IModel('delivery');
	 		$delivery_info = $tb_delivery->query('id='.$data['distribution']);
	 		if(count($delivery_info)>0)
	 		{
	 			$data['delivery'] = $delivery_info[0]['name'];
	 		}
	 		//支付方式
	 		$tb_payment = new IModel('payment');
	 		$payment_info = $tb_payment->query('id='.$data['pay_type']);
	 		if(count($payment_info)>0)
	 		{
	 			$data['payment'] = $payment_info[0]['name'];
	 		}
	 		//总重量
	 		$tb_order_goods = new IModel('order_goods');
	 		$order_goods_info = $tb_order_goods->query('order_id='.$order_id);
	 		$data['amount'] = 0;
	 		if(count($order_goods_info)>0)
	 		{
	 			$data['goods_weight'] = 0;
	 			foreach ($order_goods_info as $value) {
	 				$data['goods_weight'] = $data['goods_weight']+$value['goods_weight'];
	 				$data['amount'] = $data['amount'] + $value['real_price']*$value['goods_nums'];
	 			}
	 		}
	 		//用户名
	 		$query = new IQuery('user as u ');
	 		$query->join = ' left join member as m on u.id=m.user_id ';
	 		$query->fields = 'u.username,u.email,m.mobile,m.contact_addr,m.true_name ';
	 		$query->where = 'u.id='.$data['user_id'];
	 		$user_info = $query->find();
	 		if(count($user_info)>0)
	 		{
	 			$data['username'] = $user_info[0]['username'];
	 			$data['email'] = $user_info[0]['email'];
	 			$data['u_mobile'] = $user_info[0]['mobile'];
	 			$data['contact_addr'] = $user_info[0]['contact_addr'];
	 			$data['true_name'] = $user_info[0]['true_name'];
	 		}
	 		//地区
	 		$areas_id = $data['province'].','.$data['city'].','.$data['area'];
	 		$tb_area = new IModel('areas');
	 		$area_info = $tb_area->query('area_id in ('.$areas_id.')');
	 		if(count($area_info)>0)
	 		{
	 			$data['area_addr'] = $area_info[0]['area_name'].$area_info[1]['area_name'].$area_info[2]['area_name'];
	 		}
 		}

 		return $data;
	}
	/**
	 * @param $user_id int 用户的id
	 * @param $goods_id int 商品的id
	 * @param $products_id int 规格的id
	 * @param $goods_price int 商品的原始价格
	 * @return int $price
	 * @brief 根据会员组计算出每件商品的实际价格
	 */
	static function get_real_price($user_id,$goods_id,$products_id,$goods_price)
	{
		$price =$goods_price;
		//判断在group_price中有相关的值
		$query = new IQuery('group_price as g ');
		$query->join = 'left join member as m on m.group_id=g.group_id ';
		$query->where = 'g.goods_id='.$goods_id.' and m.user_id='.$user_id.' and g.products_id='.$products_id;
		$price_info = $query->find();
		if(count($price_info)>0)
		{
			$price=$price_info[0]['price'];
		}
		else
		{
			$u_query = new IQuery('user_group as u');
			$u_query->join = 'left join member as m on m.group_id=u.id ';
			$u_query->where= 'm.user_id='.$user_id;
			$user_info = $u_query->find();
			if(count($user_info)>0)
			{
				$price = $price*($user_info[0]['discount']/100);
			}
		}

		return $price;
	}
	/*
	 * @param $pay_type int 支付类型id
	 * @param $real_amount int 商品的实际价格
	 * @return int $pay_fee
	 * @brief 计算出支付费用
	 * */
	static function get_payment($pay_type,$real_amount)
	{
		$pay_fee = 0;
		$tb_payment = new IModel('payment');
		$payment_info = $tb_payment->query('id='.$pay_type);
		if(count($payment_info)>0)
		{
			if($payment_info[0]['poundage_type']==1)
			{
				$pay_fee = $real_amount*($payment_info[0]['poundage']/100);
			}
			else
			{
				$pay_fee = $payment_info[0]['poundage'];
			}
		}
		return $pay_fee;
	}
	/*
	 * @param $order_id int 订单id
	 * @return array $data
	 * @brief 获得单个订单信息表单回写
	 * */
	static function get_order_edit_value($order_id)
	{
		$data = array();
		$obj_order = new IModel("order");
		$order_info = $obj_order -> query('id='.$order_id);
		if(count($order_info)>0)
		{
			$data = $order_info[0];

			//取出order_goods中的数据
			$query = new IQuery('order_goods as og ');
			$query->join=' left join goods as g on og.goods_id = g.id ';
			$query->fields=' g.id as gid,g.name,og.product_id,og.goods_price,og.goods_nums,og.goods_weight,og.id as ogid,og.real_price ';
			$query->where = 'og.order_id = '.$order_id;
			$order_goods_info = $query->find();
			//定义goods_id和p_id参数
			$goods_id ='';
			$p_id ='';
			$price = '';
			$real_price = '';
			$weight = '';
			$weight_total =0;
			$num = '';
			$number = '';
			$name = '';
			$ogid = '';
			//判断order_goods表中是否有相关的值，如有则循环取出
			if(count($order_goods_info)>0)
			{
				$i=0;
				foreach ($order_goods_info as $value)
				{
					$goods_id .= $value['gid'].',';
					$p_id .= $value['product_id'].',';
					$price .=$value['goods_price'].',';
					$real_price .=$value['real_price'].',';
					$weight .=$value['goods_weight'].',';
					$weight_total = $weight_total+$value['goods_nums']*$value['goods_weight'];
					$num .= $i.',';
					$number .= $value['goods_nums'].',';
					$name .= $value['name'].',';
					$ogid .= $value['ogid'].',';
					$i++;
				}
				$data['goods_id'] = substr($goods_id,0,-1);
				$data['p_id'] = substr($p_id,0,-1);
				$data['price'] = substr($price,0,-1);
				$data['real_price'] = substr($real_price,0,-1);
				$data['weight'] = substr($weight,0,-1);
				$data['weight_total'] = $weight_total;
				$data['num'] = substr($num,0,-1);
				$data['number'] = substr($number,0,-1);
				$data['name'] = substr($name,0,-1);
				$data['ogid'] = substr($ogid,0,-1);
			}

			//获得收货地区的名称
			$query_area = new IQuery('areas');
			$query_area->where = 'area_id in ('.$data['province'].','.$data['city'].','.$data['area'].')';
			$area_info = $query_area->find();
			$data['province_na'] = $area_info[0]['area_name'];
			$data['city_na'] = $area_info[1]['area_name'];
			$data['area_na'] = $area_info[2]['area_name'];
		}
		return $data;
	}
	/*
	 * @param $type string 商品数量，实际价格
	 * @param $va string 商品数量，实际价格 相关的值
	 * @param $ogid string 订单商品id
	 * @brief 修改订单中商品时的相关数据
	 * */
	static function get_order_pri_num($type,$va,$ogid)
	{
		$total = 0;
    	$number = 0;
    	$goods_id = '';
    	$p_id = '';
    	$order_amount = 0;
    	$payable_amount = 0;
    	//先根据ogid查询出order_goods单价和数量，然后从order表总价格中删除
    	$query = new IQuery('order_goods');
    	$query->where='id = '.$ogid;
    	$order_goods_info = $query->find();
    	if(count($order_goods_info)>0)
    	{
    		$order_id = $order_goods_info[0]['order_id'];
    		$real_price = $order_goods_info[0]['real_price'];
    		$goods_price = $order_goods_info[0]['goods_price'];
    		$goods_nums = $order_goods_info[0]['goods_nums'];
    		$goods_id = $order_goods_info[0]['goods_id'];
    		$p_id = $order_goods_info[0]['product_id'];
    		$number = $goods_nums;

    		$query_order = new IQuery('order');
    		$query_order->where = 'id='.$order_id;
    		$order_info = $query_order->find();
    		$total = $order_info[0]['real_amount']-$real_price*$goods_nums;
    		$payable_amount = $order_info[0]['payable_amount']-$goods_price*$goods_nums;
    		$order_amount = $order_info[0]['real_freight']+$order_info[0]['taxes']+$order_info[0]['pay_fee']+$order_info[0]['insured'];
    		//$payable_amount = $order_info[0]['payable_amount'];
    	}
    	//二更新order_goods的数据
    	$tb_order_goods = new IModel('order_goods');
    	$tb_order_goods->setData(array(
    		$type => $va
    	));
    	$tb_order_goods->update('id='.$ogid);
    	//三
    	$query_2 = new IQuery('order_goods');
    	$query_2->where='id = '.$ogid;
    	$info = $query_2->find();
    	if(count($info)>0)
    	{
    		$real_price_2 = $info[0]['real_price'];
    		$goods_nums_2 = $info[0]['goods_nums'];
    		$goods_price_2 = $info[0]['goods_price'];
    		$total = $total + $real_price_2 * $goods_nums_2;
    		$payable_amount = $payable_amount+$goods_price_2*$goods_nums_2;
    	}
    	//四更新order表
    	$tb_order = new IModel('order');
    	$tb_order->setData(array(
    		'real_amount' =>$total,
    		'order_amount' =>$total+$order_amount,
    		'payable_amount' =>$payable_amount,
    		'promotions' =>$payable_amount-$total
    	));
    	$tb_order->update('id='.$order_id);
    	//判断修改是否是goods_nums（数量）如果是则修改goods表中数量
    	if($type=='goods_nums')
    	{
    		//获得goods表的对象
    		$tb_goods = new IModel('goods');
    		$tb_goods->setData(array(
    			'store_nums'=>'store_nums+'.$number.'-'.$va
    		));
    		$go_arr = array('store_nums');
    		$tb_goods->update('id='.$goods_id,$go_arr);
    		//判断p_id是否有值如果有则修改products中的数量
    		if($p_id!=0)
    		{
    			$tb_products = new IModel('products');
    			$tb_products->setData(array(
    				'store_nums'=>'store_nums+'.$number.'-'.$va
    			));
    			$tb_products->update('id='.$p_id,$go_arr);
    		}
    	}
	}
	/*
	 * @param $ogid string 订单商品id
	 * @brief 删除订单中商品时的相关数据
	 * */
	static function get_order_pri_num_del($ogid)
	{
		$total = 0;
    	$goods_id = '';
    	$p_id ='';
    	$number ='';
    	//先根据ogid查询出order_goods单价和数量，然后从order表总价格中删除
    	$query = new IQuery('order_goods');
    	$query->where='id = '.$ogid;
    	$order_goods_info = $query->find();
    	if(count($order_goods_info)>0)
    	{
    		$order_id = $order_goods_info[0]['order_id'];
    		$goods_price = $order_goods_info[0]['goods_price'];
    		$real_price = $order_goods_info[0]['real_price'];
    		$goods_nums = $order_goods_info[0]['goods_nums'];
    		$number = $goods_nums;
    		$goods_id = $order_goods_info[0]['goods_id'];
    		$p_id = $order_goods_info[0]['product_id'];

    		$tb_order = new IModel('order');
	    	$tb_order->setData(array(
	    		'payable_amount' =>'payable_amount-'.$goods_price*$goods_nums,
	    		'real_amount' => 'real_amount-'.$real_price*$goods_nums,
	    		'order_amount' =>'order_amount-'.$real_price*$goods_nums
	    	));
	    	$arr = array('payable_amount','real_amount','order_amount');
	    	$tb_order->update('id='.$order_id,$arr);
    	}
    	$islog = 0;
    	$tb_order_goods = new IModel('order_goods');
    	if($tb_order_goods->del('id='.$ogid))
    	{
    		 $islog = 1;
    	}
    	//修改goods表中数量,获得goods表的对象
    	$tb_goods = new IModel('goods');
    	$tb_goods->setData(array(
    		'store_nums'=>'store_nums+'.$number
    	));
    	$grr = array('store_nums');
    	$tb_goods->update('id='.$goods_id,$grr);
    	//判断p_id是否有值如果有则修改products中的数量
    	if($p_id!=0)
    	{
    		$tb_products = new IModel('products');
    		$tb_products->setData(array(
    			'store_nums'=>'store_nums+'.$number
    		));
    		$prr = array('store_nums');
    		$tb_products->update('id='.$p_id,$prr);
    	}
    	return $islog;
	}

	//获取订单信息
	public function getOrderInfo($order)
	{
		$orderObj    = new IModel('order');
		$areaIdArray = array();
		$orderList   = $orderObj->query('id in ('.$order.')');
		foreach($orderList as $val)
		{
			$areaIdArray[] = $val['province'];
			$areaIdArray[] = $val['city'];
			$areaIdArray[] = $val['area'];
		}
		$areaIdArray = array_unique($areaIdArray);

		$areaObj  = new IModel('areas');
		$areaList = $areaObj->query('area_id in ('.join(",",$areaIdArray).')');
		$areaData = array();

		foreach($areaList as $val)
		{
			$areaData[$val['area_id']] = $val['area_name'];
		}

		foreach($orderList as $key => $val)
		{
			$orderList[$key]['province_str'] = $areaData[$val['province']];
			$orderList[$key]['city_str']     = $areaData[$val['city']];
			$orderList[$key]['area_str']     = $areaData[$val['area']];
		}

		return $orderList;
	}
	
	//判断变量是数组还是单个变量
	static function getWhere($id)
	{
		if(is_array($id) && isset($id[0]) && $id[0]!='')
		{
			$id = join(',',$id);
			$where = ' id in ('.$id.')';
		}
		else
		{
			$where = 'id = '.$id;
		}
		return $where;
	}
	
}
?>