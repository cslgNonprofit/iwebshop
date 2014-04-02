<?php
/**
 * @brief 订单模块
 * @class Order
 * @note  后台
 */
class Order extends IController
{
	protected $checkRight  = 'all';
	public $layout='admin';
	function init()
	{
		$checkObj = new CheckRights($this);
		$checkObj->checkAdminRights();
	}
	/*
	 * @brief查看订单
	 **/
	 public function order_show()
	 {
	 	//获得post传来的值
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$tab = IReq::get('tab');
	 	$data = array();
	 	if(!empty($order_id))
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->get_order_show($order_id);
	 		if(count($data)>0)
	 		{
	 			//获得折扣前的价格
			 	$rule = new ProRule($data['real_amount']);
			 	$this->result = $rule->getInfo();

			 	$data['tab'] = $tab;
			 	$this->setRenderData($data);
				$this->redirect('order_show',false);
	 		}
	 	}
		if(count($data)==0)
		{
			$this->redirect('order_list');
		}
	 }
	 /*
	  * @brief查看收款单
	  * */
	 public function collection_show()
	 {
	 	//获得post传来的收款单id值
	 	$collection_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($collection_id)
	 	{
	 		$tb_collection = new IQuery('collection_doc as c ');
	 		$tb_collection->join=' left join order as o on c.order_id=o.id left join payment as p on c.payment_id = p.id left join user as u on u.id = c.user_id';
	 		$tb_collection->fields = 'o.order_no,p.name as pname,o.create_time,p.type,c.collection_account,u.username,c.amount,o.pay_time ';
	 		$tb_collection->where = 'c.id='.$collection_id;
	 		$collection_info = $tb_collection->find();
	 		if(count($collection_info)>0)
	 		{
	 			$data = $collection_info[0];

	 			$this->setRenderData($data);
	 			$this->redirect('collection_show',false);
	 		}
	 	}
	 	if(count($data)==0)
		{
			$this->redirect('order_collection_list');
		}
	 }
	/*
	  * @brief查看退款单
	  * */
	 public function refundment_show()
	 {
	 	//获得post传来的退款单id值
	 	$refundment_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($refundment_id)
	 	{
	 		$tb_refundment = new IQuery('refundment_doc as c ');
	 		$tb_refundment->join=' left join order as o on c.order_id=o.id left join payment as p on c.bank_name = p.id left join user as u on u.id = c.user_id';
	 		$tb_refundment->fields = 'o.order_no,p.name as pname,o.create_time,p.type,c.bank_account,u.username,c.amount,c.bank_time,c.content ';
	 		$tb_refundment->where = 'c.id='.$refundment_id;
	 		$refundment_info = $tb_refundment->find();
	 		if(count($refundment_info)>0)
	 		{
	 			$data = $refundment_info[0];

	 			$this->setRenderData($data);
	 			$this->redirect('refundment_show',false);
	 		}
	 	}
	 	if(count($data)==0)
		{
			$this->redirect('order_refundment_list');
		}
	 }
	/*
	  * @brief查看申请退款单
	  * */
	 public function refundment_doc_show()
	 {
	 	//获得post传来的申请退款单id值
	 	$refundment_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($refundment_id)
	 	{
	 		$tb_refundment = new IQuery('refundment_doc as c ');
	 		$tb_refundment->fields = '* ';
	 		$tb_refundment->where = 'c.id='.$refundment_id;
	 		$refundment_info = $tb_refundment->find();
	 		if(count($refundment_info)>0)
	 		{
	 			$data = $refundment_info[0];

	 			$this->setRenderData($data);
	 			$this->redirect('refundment_doc_show',false);
	 		}
	 	}
	 	if(count($data)==0)
		{
			$this->redirect('refundment_list');
		}
	 }
	//删除申请退款单
	public function refundment_doc_del()
	{
		//获得post传来的申请退款单id值
		$refundment_id = IFilter::act(IReq::get('id'),'int');
		if(is_array($refundment_id))
		{
			$refundment_id = implode(",",$refundment_id);
		}
		if($refundment_id)
		{
			$tb_refundment_doc = new IModel('refundment_doc');
			$tb_refundment_doc->setData(array('if_del' => 1));
			$tb_refundment_doc->update("id IN ($refundment_id)");
		}

		$logObj = new log('db');
		$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"退款单移除到回收站",'移除的ID：'.$refundment_id));

		$this->redirect('refundment_list');
	}

	 /*
	  * @brief更新申请退款单
	  */
	 public function refundment_doc_show_save()
	 {
	 	//获得post传来的收款单id值
	 	$refundment_id = IFilter::act(IReq::get('rid'),'int');
	 	$pay_status = IFilter::act(IReq::get('pay_status'),'int');
	 	$dispose_idea = IFilter::act(IReq::get('dispose_idea'));
	 	//获得refundment_doc对象
	 	$tb_refundment_doc = new IModel('refundment_doc');
	 	$tb_refundment_doc->setData(array(
	 		'pay_status'=>$pay_status,
	 		'dispose_idea'=>$dispose_idea,
	 		'dispose_time'=>date('Y-m-d H:i:s')
	 	));
	 	if($refundment_id)
	 	{
	 		$tb_refundment_doc->update('id='.$refundment_id);

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"修改了退款单",'修改的ID：'.$refundment_id));
	 	}
	 	$this->redirect('refundment_list');
	 }
	/*
	  * @brief查看发货单
	  * */
	 public function delivery_show()
	 {
	 	//获得post传来的发货单id值
	 	$delivery_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($delivery_id)
	 	{
	 		$tb_delivery = new IQuery('delivery_doc as c ');
	 		$tb_delivery->join=' left join order as o on c.order_id=o.id left join delivery as p on c.delivery_type = p.id left join user as u on u.id = c.user_id';
	 		$tb_delivery->fields = 'o.order_no,c.order_id,p.name as pname,o.create_time,u.username,c.name,c.province,c.city,c.area,c.address,c.mobile,c.telphone,c.postcode,c.freight,c.delivery_code,c.time,c.note ';
	 		$tb_delivery->where = 'c.id='.$delivery_id;
	 		$delivery_info = $tb_delivery->find();
	 		if(count($delivery_info)>0)
	 		{
	 			$data = $delivery_info[0];

	 			$data['country'] = '';
	 			$tb_area = new IModel('areas');
	 			$area_info = $tb_area->query('area_id in ('.$data['province'].','.$data['city'].','.$data['area'].')');
	 			if(count($area_info)>0)
	 			{
	 				$data['country'] .= $area_info[0]['area_name'].'-';
	 				$data['country'] .= $area_info[1]['area_name'].'-';
	 				$data['country'] .= $area_info[2]['area_name'];
	 			}
	 			$this->setRenderData($data);
	 			$this->redirect('delivery_show',false);
	 		}
	 	}
	 	if(count($data)==0)
		{
			$this->redirect('order_delivery_list');
		}

	 }
	/*
	  * @brief查看退货单
	  * */
	 public function returns_show()
	 {
	 	//获得post传来的收款单id值
	 	$returns_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($returns_id)
	 	{
	 		$tb_returns = new IQuery('returns_doc as c ');
	 		$tb_returns->join=' left join order as o on c.order_id=o.id left join delivery as p on c.delivery_type = p.id left join user as u on u.id = c.user_id';
	 		$tb_returns->fields = 'o.order_no,c.order_id,p.name as pname,u.username,c.name,c.province,c.city,c.area,c.address,c.mobile,c.telphone,c.postcode,c.freight,c.delivery_code,c.time ';
	 		$tb_returns->where = 'c.id='.$returns_id;
	 		$returns_info = $tb_returns->find();
	 		if(count($returns_info)>0)
	 		{
	 			$data = $returns_info[0];

		 		$data['country'] = '';
		 		if(count($data)>0)
		 		{
		 			$tb_area = new IModel('areas');
		 			$area_info = $tb_area->query('area_id in ('.$data['province'].','.$data['city'].','.$data['area'].')');
		 			if(count($area_info)>0)
		 			{
		 				$data['country'] .= $area_info[0]['area_name'].'-';
		 				$data['country'] .= $area_info[1]['area_name'].'-';
		 				$data['country'] .= $area_info[2]['area_name'];
		 			}
		 		}

		 		$this->setRenderData($data);
	 			$this->redirect('returns_show',false);
	 		}
	 	}
	 	if(count($data)==0)
	 	{
	 		$this->redirect('order_returns_list');
	 	}
	 }
	 /*
	  * @brief 支付订单页面collection_doc
	  * */
	 public function order_collection()
	 {
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($order_id)
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->get_order_show($order_id);
	 	}
	 	$this->setRenderData($data);
	 	$this->redirect('order_collection');
	 }
	/*
	 * @brief 保存支付订单页面collection_doc
	 * */
	 public function order_collection_doc()
	 {
	 	//获得订单号
	 	$order_no = IFilter::act(IReq::get('order_no'));
	 	$text = "<br /><div align='center'>付款已完成</div>";
	 	if(payment::updateOrder($order_no))
	 	{
		 	//获得collection_doc表的对象
		 	$tb_collection_doc = new IModel('collection_doc');
		 	$tb_collection_doc->setData(array(
		 		'order_id' =>IFilter::act(IReq::get('id'),'int'),
		 		'user_id' =>IFilter::act(IReq::get('user_id'),'int'),
		 		'payment_id' => IFilter::act(IReq::get('payment_id'),'int'),
		 		'collection_account' => IFilter::act(IReq::get('collection_account')),
		 		'time' =>date('Y-m-d H:i:s'),
		 		'amount' =>IFilter::act(IReq::get('amount'),'float'),
		 		'note' =>IFilter::act(IReq::get('note'),'text'),
		 		'pay_status' =>1,
		 		'if_del' =>0
		 	));
		 	$tb_collection_doc->add();

		 	//生成订单日志
	    	$tb_order_log = new IModel('order_log');
	    	$tb_order_log->setData(array(
	    		'order_id' =>IFilter::act(IReq::get('id'),'int'),
	    		'user' =>$this->admin['admin_id'],
	    		'action' =>'付款',
	    		'result' =>'成功',
	    		'note' =>'订单【'.$order_no.'】付款'.IFilter::act(IReq::get('amount'),'float'),
	    		'addtime'=>date('Y-m-d H:i:s')
	    	));
	    	$tb_order_log->add();

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为已付款","订单号：".$order_no.'，已经确定付款'));
	 	}
	 	else
	 	{
	 		$text = "<br /><div align='center'>付款失败</div>";
	 	}

	 	echo $text;
	 	exit;
	 }
	/*
	  * @brief 退款单页面
	  * */
	 public function order_refundment()
	 {
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($order_id)
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->get_order_show($order_id);
	 	}
	 	$this->setRenderData($data);
	 	$this->redirect('order_refundment');
	 }
	/*
	 * @brief 退款单页面
	 * */
	 public function order_refundment_form()
	 {
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$rid = IFilter::act(IReq::get('rid'),'int');
	 	$data = array();
	 	if($order_id)
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->get_order_show($order_id);
	 	}
	 	$data['rid'] = $rid;
	 	//退款单
 		$tb_refundment_doc = new IModel('refundment_doc');
 		$refundment_doc_info = $tb_refundment_doc->query('order_id='.$order_id);
 		$data['refundment_context'] = '';
 		if(count($refundment_doc_info))
 		{
 			$data['refundment_context'] = $refundment_doc_info[0]['content'];
 		}
	 	//税率
	 	$config = new Config("site_config");
		$config_info = $config->getInfo();
     	$data['tax'] = isset($config_info['tax'])  ? $config_info['tax']/100  : 0;
	 	$this->setRenderData($data);
	 	$this->redirect('order_refundment_form');
	 }
	/*
	  * @brief 保存退款单页面
	  * */
	 public function order_refundment_doc()
	 {
	 	//获得post变量参数
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$rid = IFilter::act(IReq::get('rid'),'int');

	 	$tb_refundment_doc = new IModel('refundment_doc');
	 	$arr = array(
	 		'order_id'=>$order_id,
	 		'order_no'=>IFilter::act(IReq::get('order_no')),
	 		'user_id'=>IFilter::act(IReq::get('user_id'),'int'),
	 		'bank_name'=>IFilter::act(IReq::get('refundment_name')),
	 		'bank_account'=>IFilter::act(IReq::get('refundment_account')),
	 		'amount'=>IFilter::act(IReq::get('amount'),'float'),
	 		'content'=>IFilter::act(IReq::get('content'),'text'),
	 		'bank_time'=>date('Y-m-d H:i:s'),
	 		'if_del' =>0,
	 		'admin_id' =>$this->admin['admin_id']
	 	);

	 	if(!empty($rid))
	 	{
	 		$tb_refundment_doc ->setData($arr);
	 		$tb_refundment_doc->update('id='.$rid);
	 	}
	 	else
	 	{
	 		$arr['pay_status'] = '2';
	 		$arr['dispose_time'] = date('Y-m-d H:i:s');
	 		$arr['dispose_idea'] = '';
	 		$tb_refundment_doc ->setData($arr);
	 		$tb_refundment_doc->add();
	 	}

	 	//更新发货状态
	 	$tb_order = new IModel('order');
	 	$tb_order -> setData(array(
	 		'pay_status' =>2,
	 		'pay_time' =>''
	 	));
	 	$tb_order->update('id='.$order_id);
	 	//生成订单日志
    	$tb_order_log = new IModel('order_log');
    	$tb_order_log->setData(array(
    		'order_id' =>$order_id,
    		'user' =>$this->admin['admin_id'],
    		'action' =>'退款',
    		'result' =>'成功',
    		'note' =>'订单【'.IFilter::act(IReq::get('order_no')).'】退款'.IFilter::act(IReq::get('amount'),'float'),
    		'addtime'=>date('Y-m-d H:i:s')
    	));
    	$tb_order_log->add();

		//作废订单-还原红包
    	$prop = 'id = '.$order_id.' and pay_status =0 and prop is not null';
    	$order_info = $tb_order->query($prop);
    	if(count($order_info)>0)
		{
			$tb_prop = new IModel('prop');
			foreach ($order_info as $value)
			{
				$tb_prop->setData(array('is_close'=>0));
				if($value['prop'])
				{
					$tb_prop->update('id='.$value['prop']);
				}
			}
		}

		$logObj = new log('db');
		$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为退款",'订单号：'.$arr['order_no']));

	 	echo "<br /><div align='center'>退款已完成</div>";
	 	exit;
	 }
	/*
	  * @brief 保存订单备注
	  * */
	 public function order_note()
	 {
	 	//获得post数据
	 	$order_id = IFilter::act(IReq::get('order_id'),'int');
	 	$note = IFilter::act(IReq::get('note'),'text');
	 	$tab = IReq::get('tab');

	 	//获得order的表对象
	 	$tb_order =  new IModel('order');
	 	$tb_order->setData(array(
	 		'note'=>$note
	 	));
	 	$tb_order->update('id='.$order_id);
	 	IReq::set('tab',$tab);
	 	IReq::set('id',$order_id);
	 	$this->order_show();

	 }
	 /*
	  * @brief 保存顾客留言
	  * */
	 public function order_message()
	 {
	 	//获得post数据
	 	$order_id = IFilter::act(IReq::get('order_id'),'int');
	 	$user_id = IFilter::act(IReq::get('user_id'),'int');
	 	$title = IFilter::act(IReq::get('title'));
	 	$content = IFilter::act(IReq::get('content'),'text');

	 	//获得message的表对象
	 	$tb_message =  new IModel('message');
	 	$tb_message->setData(array(
	 		'title'=>$title,
	 		'content' =>$content,
	 		'time'=>date('Y-m-d H:i:s')
	 	));
	 	$message_id = $tb_message->add();
	 	//获的mess类
	 	$message = new Mess($user_id);
	 	$message->writeMessage($message_id);
	 	IReq::set('id',$order_id);
	 	$this->order_show();

	 }
	/*
	  * @brief 完成或作废订单页面
	  * */
	 public function order_complete()
	 {
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$type = IFilter::act(IReq::get('type'),'int');
	 	$order_no = IFilter::act(IReq::get('order_no'));

	 	//oerder表的对象
	 	$tb_order = new IModel('order');
	 	$tb_order->setData(array(
	 		'status'=>$type,
	 		'completion_time'=>date('Y-m-d H:i:s')
	 	));
	 	$tb_order->update('id='.$order_id);

	 	//生成订单日志
    	$tb_order_log = new IModel('order_log');
    	$action = '作废';
    	$note = '订单【'.$order_no.'】作废成功';
    	if($type=='5')
    	{
    		$action = '完成';
    		$note = '订单【'.$order_no.'】完成成功';

	    	//comment表中插入数据
	    	//获得user_id和order_no
	    	$order_info = $tb_order->query('id='.$order_id);
	    	$user_id = $order_info[0]['user_id'];
	    	$tb_comment = new IModel('comment');
	    	//获得goods_id
	    	$tb_order_goods = new IModel('order_goods');
		    $order_goods_info = $tb_order_goods->query('order_id='.$order_id);
	    	 if(count($order_goods_info)>0)
	    	 {
	    	 	foreach ($order_goods_info as $value)
		    	{
		    		$tb_comment->setData(array(
			    		'goods_id' =>$value['goods_id'],
		    			'time'=>date('Y-m-d H:i:s'),
		    			'order_no' =>$order_no,
		    			'user_id' =>$user_id
			    	));
			    	$tb_comment->add();
		    	}
	    	 }

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为完成",'订单号：'.$order_no));
    	}
    	else
    	{
    		//作废订单-还原红包
    		$prop = 'id = '.$order_id.' and pay_status =0 and prop is not null';
    		$order_info = $tb_order->query($prop);
    		if(count($order_info)>0)
			{
				$tb_prop = new IModel('prop');
				foreach ($order_info as $value)
				{
					$tb_prop->setData(array('is_close'=>0));
					if($value['prop'])
					{
						$tb_prop->update('id='.$value['prop']);
					}
				}
			}

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单更新为作废",'订单号：'.$order_no));

    		//作废订单的时候，将订单中的商品数量，加回到原商品中
    		Block::updateStore($order_id ,$type = 'add');
    	}

    	$tb_order_log->setData(array(
    		'order_id' =>$order_id,
    		'user' =>$this->admin['admin_id'],
    		'action' =>$action,
    		'result' =>'成功',
    		'note' =>$note,
    		'addtime'=>date('Y-m-d H:i:s')
    	));
    	$tb_order_log->add();
	 	echo 1;
	 }
	/*
	 * @brief 发货订单页面
	 */
	 public function order_deliver()
	 {
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($order_id)
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->get_order_show($order_id);
	 	}
	 	$this->setRenderData($data);
	 	$this->redirect('order_deliver');
	 }
	 /*
	  * @brief 保存发货信息
	  * */
	 public function order_delivery_doc()
	 {
	 	//获得post变量参数
	 	$order_id = IFilter::act(IReq::get('id'),'int');

	 	//获得delivery_doc表的对象
	 	$tb_delivery_doc = new IModel('delivery_doc');
	 	$tb_delivery_doc->setData(array(
	 		'order_id' =>$order_id,
	 		'user_id' =>IFilter::act(IReq::get('user_id'),'int'),
	 		'name' =>IFilter::string(IReq::get('name')),
	 		'postcode' =>IFilter::act(IReq::get('postcode'),'int'),
	 		'telphone' =>IFilter::act(IReq::get('telphone')),
	 		'province' =>IFilter::act(IReq::get('province'),'int'),
	 		'city' =>IFilter::act(IReq::get('city'),'int'),
	 		'area' =>IFilter::act(IReq::get('area'),'int'),
	 		'address' =>IFilter::act(IReq::get('address')),
	 		'mobile' =>IFilter::string(IReq::get('mobile')),
	 		'time' => date('Y-m-d H:i:s'),
	 		'freight' =>IFilter::act(IReq::get('freight'),'float'),
	 		'delivery_code' =>IFilter::act(IReq::get('delivery_code')),
	 		'delivery_type' =>IFilter::act(IReq::get('delivery_type')),
	 		'note' =>IFilter::string(IReq::get('note'),'text'),
	 		'if_del'=>0
	 	));
	 	$tb_delivery_doc->add();

	 	//更新发货状态
	 	$tb_order = new IModel('order');
	 	$tb_order -> setData(array(
	 		'distribution_status' =>1,
	 		'status' =>2,
	 		'send_time' =>date('Y-m-d H:i:s')
	 	));
	 	$tb_order->update('id='.$order_id);

	 	//生成订单日志
    	$tb_order_log = new IModel('order_log');
    	$tb_order_log->setData(array(
    		'order_id' =>$order_id,
    		'user' =>$this->admin['admin_id'],
    		'action' =>'发货',
    		'result' =>'成功',
    		'note' =>'订单【'.IFilter::act(IReq::get('order_no')).'】发货成功',
    		'addtime'=>date('Y-m-d H:i:s')
    	));
    	$tb_order_log->add();

	 	echo "<br /><div align='center'>发货已完成</div>";
	 	exit;
	 }
	/*
	  * @brief 退货订单页面
	  * */
	 public function order_return()
	 {
	 	//去掉左侧菜单和上部导航
	 	$this->layout='';
	 	$order_id = IFilter::act(IReq::get('id'),'int');
	 	$data = array();
	 	if($order_id)
	 	{
	 		$order_show = new Order_Class();
	 		$data = $order_show->get_order_show($order_id);
	 	}
	 	$this->setRenderData($data);
	 	$this->redirect('order_return');
	 }
	 /*
	  * @brief 保存退货信息
	  * */
	 public function order_return_doc()
	 {
	 	$order_id = IFilter::act(IReq::get('id'),'int');

	 	//获得returns_doc表的对象
	 	$tb_returns_doc = new IModel('returns_doc');
	 	$tb_returns_doc->setData(array(
	 		'order_id' =>$order_id,
	 		'user_id' =>IFilter::act(IReq::get('user_id'),'int'),
	 		'reason' =>IFilter::act(IReq::get('reason')),
	 		'name' =>IFilter::string(IReq::get('name')),
	 		'postcode' =>IFilter::act(IReq::get('postcode'),'int'),
	 		'telphone' =>IFilter::act(IReq::get('telphone')),
	 		'province' =>IFilter::act(IReq::get('province'),'int'),
	 		'city' =>IFilter::act(IReq::get('city'),'int'),
	 		'area' =>IFilter::act(IReq::get('area'),'int'),
	 		'address' =>IFilter::act(IReq::get('address')),
	 		'mobile' =>IFilter::string(IReq::get('mobile')),
	 		'time' => date('Y-m-d H:i:s'),
	 		'freight' =>IFilter::act(IReq::get('freight'),'float'),
	 		'delivery_code' =>IFilter::act(IReq::get('delivery_code')),
	 		'delivery_type' =>IFilter::act(IReq::get('delivery_type')),
	 		'note' =>IFilter::act(IReq::get('note'),'text'),
	 		'if_del'=>0
	 	));
	 	$tb_returns_doc->add();

	 	//更新发货状态
	 	$tb_order = new IModel('order');
	 	$tb_order -> setData(array(
	 		'distribution_status' =>0,
	 		'send_time' =>''
	 	));
	 	$tb_order->update('id='.$order_id);

	 	//生成订单日志
    	$tb_order_log = new IModel('order_log');
    	$tb_order_log->setData(array(
    		'order_id' =>$order_id,
    		'user' =>$this->admin['admin_id'],
    		'action' =>'退货',
    		'result' =>'成功',
    		'note' =>'订单【'.IFilter::act(IReq::get('order_no')).'】退货成功',
    		'addtime'=>date('Y-m-d H:i:s')
    	));
    	$tb_order_log->add();

	 	echo "<br /><div align='center'>退货已完成</div>";
	 	exit;
	 }
	 /*
	  * @brief添加订单
	  * */
	 public function order_add()
	 {
	 	//读取configuration配置文件
	 	$config = new Config("site_config");
		$config_info = $config->getInfo();
     	$this->tax = isset($config_info['tax'])  ? $config_info['tax']/100  : 0;
	 	//支付方式
		//初始化支付插件类
     	$payment = new IModel('payment');
     	//获取已配置支付列表
     	$list = $payment->query();
     	$this->setRenderData(array("payment_list"=>$list));
		$this->redirect('order_add');
	 }
	 /**
	 * @brief 获得订单的实际金额和商品的实际价格
	 */
	 public function getAmount()
	 {
	 	//获得ajax中post传来的数据
	 	$uid = IFilter::act(IReq::get('uid'));
	 	$price = IFilter::act(IReq::get('price'));
	 	$gid = IFilter::act(IReq::get('gid'));
	 	$number = IFilter::act(IReq::get('number'));
	 	$pid = IFilter::act(IReq::get('pid'));
	 	//将price和gid转换为数组
	 	$price_arr = array();
	 	$gid_arr = array();
	 	$num_arr = array();
	 	$pid_arr = array();
	 	$price_arr = explode(',',$price);
	 	$gid_arr = explode(',',$gid);
	 	$num_arr = explode(',',$number);
	 	$pid_arr = explode(',',$pid);
	 	//获得order_class的对象
	 	$ord_class = new Order_Class();
	 	//实际价格
	 	$real_price = '';
	 	//执行折扣前的总金额
	 	$real_amount = 0;
	 	//循环获得商品的实际价格和实际总金额
	 	foreach ($price_arr as $key => $value)
	 	{
	 		$real = $ord_class->get_real_price($uid,$gid_arr[$key],$pid_arr[$key],$price_arr[$key]);
	 		$real_price .= $real.',';
	 		$real_amount = $real_amount + $real*$num_arr[$key];
	 	}
	 	$real_price = substr($real_price,0,-1);
	 	//获得group_id
	 	$tb_member = new IModel('member');
	 	$member_info = $tb_member->query('user_id='.$uid);
	 	//获得规则函数的对象
	 	$rule = new ProRule($real_amount);
	 	$rule->setUserGroup($member_info[0]['group_id']);
	 	//获得规则折扣后的实际总金额
	 	$real_amount = $rule->getSum();
	 	//判断是否免运费,true免，false不免
	 	$isBolg = $rule->isFreeFreight();
	 	$relieve = '0';
	 	if($isBolg)
	 	{
	 		$relieve = '1';
	 	}
	 	//返回页面数据实际商品价格和实际总金额
	 	echo $relieve.';'.$real_price.';'.$real_amount;

	 }
	 /**
	 * @brief 支付费用
	 */
	 public function gePay_fee()
	 {
	 	$payment_id = IFilter::act(IReq::get('pid'),'int');
	 	$total = IFilter::act(IReq::get('total'));
	 	//获得order_class的对象
	 	$ord_class = new Order_Class();
	 	$pay_fee = $ord_class->get_payment($payment_id,$total);
	 	//返回支付费用
	 	echo $pay_fee;
	}
	 /**
	 * @brief 修改订单
	 */
	public function order_edit()
    {
    	$data = array();
    	//获得order_id的值
		$order_id = IFilter::act(IReq::get('id'),'int');
		if(!empty($order_id))
		{
			$ord_class = new Order_Class();
	 		$data = $ord_class->get_order_edit_value($order_id);
	 		if(count($data)>0)
	 		{
		 		//税率
		 		$config = new Config("site_config");
				$config_info = $config->getInfo();
		     	$data['tax'] = isset($config_info['tax'])  ? $config_info['tax']/100  : 0;
	 			$this->setRenderData($data);
				$this->redirect('order_edit');
	 		}
		}
		if(count($data)==0)
		{
			$this->redirect('order_list');
		}
    }
    /**
     * @brief ajax更新订单中商品的数据
     * */
    public function order_pri_num()
    {
    	$type = IFilter::act(IReq::get('type'));
    	$va = IFilter::act(IReq::get('va'));
    	$ogid = IFilter::act(IReq::get('ogid'),'int');

    	$ord_class = new Order_Class();
	 	$ord_class->get_order_pri_num($type,$va,$ogid);

    	echo 1;

    }
	/**
     * @brief ajax删除订单中商品的数据
     * */
    public function order_pri_num_del()
    {
    	$ogid = IFilter::act(IReq::get('ogid'),'int');

    	$ord_class = new Order_Class();
    	echo $ord_class->get_order_pri_num_del($ogid);
    }
    /**
     * @brief 订单列表
     * */
    public function order_list()
    {
    	$data = array();
    	//获得-快搜-post
    	$name = IFilter::act(IReq::get('name'));
    	$order_no = IFilter::act(IReq::get('order_no'));
    	$where = '';
    	if($name)
    	{
    		$where .= " and u.username like '%{$name}%'";
    	}
    	if($order_no)
    	{
    		$where .= " and o.order_no like '%{$order_no}%'";
    	}
    	$data['name'] = $name;
    	$data['order_no'] = $order_no;
    	//获得筛选post
    	$pay_status = IFilter::act(IReq::get('pay_status'));
    	$distribution_status = IFilter::act(IReq::get('distribution_status'));
    	$status = IFilter::act(IReq::get('status'));
    	if($pay_status!='')
    	{
    		$where .= ' and o.pay_status = '.$pay_status;
    	}
    	if($distribution_status!='')
    	{
    		$where .= ' and o.distribution_status = '.$distribution_status;
    	}
    	if($status)
    	{
    		$where .= ' and o.status = '.$status;
    	}
    	$data['pay_status'] = $pay_status;
    	$data['distribution_status'] = $distribution_status;
    	$data['status'] = $status;
    	$data['where'] = $where;
    	//向前台渲染
    	$this->setRenderData($data);
		$this->redirect("order_list");
    }
    /**
     * @brief 保存修改订单
     */
    public function order_save()
    {
    	$order_id = IFilter::act(IReq::get('order_id'),'int');
    	//post获得数据
    	$real_amount = IFilter::act(IReq::get('goods_total'),'float');
    	$real_freight = IFilter::act(IReq::get('real_freight'),'float');
    	$taxes = IFilter::act(IReq::get('taxes'),'float');
    	$pay_fee = IFilter::act(IReq::get('pay_fee'),'float');
    	$total_price =IFilter::act(IReq::get('total_price'),'float');
		$discount = IFilter::act(IReq::get('discount'),'float');

    	//获得order表对象
    	$tb_order = new IModel('order');
    	$tb_order ->setData(array(
    		'payable_amount' =>IFilter::act(IReq::get('total'),'int'),
    		'accept_name' => IFilter::act(IReq::get('accept_name')),
    		'pay_code' =>IFilter::act(IReq::get('pay_code')),
    		'pay_type' => IFilter::act(IReq::get('pay_type'),'int'),
    		'distribution' =>IFilter::act(IReq::get('distribution'),'int'),
    		'mobile' => IFilter::act(IReq::get('mobile')),
    		'telphone' => IFilter::act(IReq::get('telphone')),
    		'postcode' => IFilter::act(IReq::get('postcode')),
    		'postscript' => IFilter::act(IReq::get('postscript')),
    		'province' => IFilter::act(IReq::get('province'),'int'),
    		'city' => IFilter::act(IReq::get('city'),'int'),
    		'area' => IFilter::act(IReq::get('area'),'int'),
    		'address' => IFilter::act(IReq::get('address')),
    		'real_amount' => $real_amount,
    		'real_freight' =>$real_freight,
    		'invoice' =>IFilter::act(IReq::get('invoice'),'int'),
    		'invoice_title' =>IFilter::act(IReq::get('invoice_title')),
    		'taxes' =>$taxes,
    		'insured'=>IFilter::act(IReq::get('insured'),'float'),
    		'if_insured' =>IFilter::act(IReq::get('if_insured'),'int'),
    		'pay_fee' =>$pay_fee,
    		'promotions'=>IFilter::act(IReq::get('promotions'),'float'),
    		'discount'=>$discount,
    		'order_amount' =>$real_amount+$real_freight+$taxes+$pay_fee+$discount
    	));
    	$arr = array('order_amount');
    	$tb_order->update('id='.$order_id,$arr);

    	//根据order_id,先删除order_goods表中的数据
    	$ogid = IFilter::act(IReq::get('ogid'));
		$tb_goods = new IModel('goods');
    	$tb_order_goods = new IModel('order_goods');
    	$tb_products = new IModel('products');
    	if($ogid)
    	{
	    	//恢复商品库存数量
	    	Block::updateStore($order_id ,$type = 'add');
	    	if($ogid!='')
	    	{
	    		$tb_order_goods->del('id in ('.$ogid.')');
	    	}
	    	//循环保存order_goods中的数据
	    	$goods_id = IFilter::act(IReq::get('goods_id'));
	    	$product_id = IFilter::act(IReq::get('p_id'));
	    	$goods_price = IFilter::act(IReq::get('price'));
	    	$real_price = IFilter::act(IReq::get('real_price'));
	    	$goods_nums = IFilter::act(IReq::get('number'));
	    	$goods_weight = IFilter::act(IReq::get('weight'));
	    	$g_id_arr = explode(',',$goods_id);
	    	$p_id_arr = explode(',',$product_id);
	    	$g_pr_arr = explode(',',$goods_price);
	    	$r_pr_arr = explode(',',$real_price);
	    	$g_nu_arr = explode(',',$goods_nums);
	    	$g_we_arr = explode(',',$goods_weight);
	    	$point = 0;
	    	$exp = 0;
	    	//循环保存order_goods表中数据
	    	foreach ($g_id_arr as $key => $value)
	    	{
	    		//根据会员组获得产品的实际价格
	    		$tb_order_goods ->setData(array(
		    		'order_id' => $order_id,
		    		'goods_id' =>$g_id_arr[$key],
		    		'product_id' => $p_id_arr[$key],
		    		'goods_price' =>$g_pr_arr[$key],
	    			'real_price' =>$r_pr_arr[$key],
		    		'goods_nums' =>$g_nu_arr[$key],
	    			'goods_weight' =>$g_we_arr[$key]
	    		));
	    		$order_goods_id = $tb_order_goods ->add();

	    		$ids = array();
				$ids['name'] = '';
				$info = $tb_goods->query('id='.$g_id_arr[$key]);
				if(count($info)>0)
				{
					$ids['name'] = $info[0]['name'];
					//计算积分
	    			$point += $g_nu_arr[$key]*$info[0]['point'];
	    			$exp += $g_nu_arr[$key]*$info[0]['exp'];
				}
				$ids['value'] = '';
				$p_info = $tb_products->query('id='.$p_id_arr[$key]);
				if(count($p_info)>0)
				{
					$spec_array=Block::show_spec($p_info[0]['spec_array']);
					foreach ($spec_array as $ky => $vaa)
					{
						$ids['value'] .= $ky.':'.$vaa.',';
					}
				}
				$tb_order_goods ->setData(array('goods_array' =>serialize($ids)));
				$tb_order_goods->update('id='.$order_goods_id);
	    		//减少商品的库存
	    		Block::updateStore($order_id ,$type = 'reduce');
	    		//计算实付总金额
	    		$real_amount = $real_amount+$real_price*$g_nu_arr[$key];

	    		$orderRow = $tb_order->getObj('id = '.$order_id,'order_no');

				$logObj = new log('db');
				$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"修改了订单信息",'订单号：'.$orderRow['order_no']));
	    	}
	    	if($point)
	    	{
	    		//更新积分
		    	$tb_order->setData(array('point'=>$point,'exp'=>$exp));
		    	$tb_order->update('id='.$order_id);
	    	}
    	}
    	$this->redirect('order_list');
    }
    /**
     * @brief 保存添加订单
     * */
    public function order_update()
    {
    	//获取post参数-----order表中
    	$user_id = IFilter::act(IReq::get('user_id'),'int');
 		$payment = IFilter::act(IReq::get('payment'),'int');
    	$payable_amount = IFilter::act(IReq::get('total'),'float');
    	$real_amount = IFilter::act(IReq::get('real_total'),'float');
    	$payable_freight = IFilter::act(IReq::get('delivery_price'),'float');
    	$real_freight = IFilter::act(IReq::get('real_freight'),'float');
    	$taxes = IFilter::act(IReq::get('taxes'),'float');
    	$pay_fee = IFilter::act(IReq::get('pay_fee'),'float');
    	$order_no = block::createOrderNum();
    	//获得货到付款
    	$pay_type = IFilter::act(IReq::get('pay_type'));
    	if($pay_type==1)
    	{
    		$payment = IFilter::act(IReq::get('paymen'),'int');
    	}
    	//获得order表对象
    	$tb_order = new IModel('order');
    	$tb_order ->setData(array(
    		'user_id' => $user_id,
    		'accept_name' => IFilter::act(IReq::get('accept_name')),
    		'pay_code' =>IFilter::act(IReq::get('pay_code')),
    		'distribution' =>IFilter::act(IReq::get('delivery'),'int'),
    		'pay_type' => $payment,
    		'status' => 1,
    		'pay_status' => 0,
    		'distribution_status' => 0,
    		'postcode' => IFilter::act(IReq::get('postcode')),
    		'telphone' => IFilter::act(IReq::get('telphone')),
    		'province' => IFilter::act(IReq::get('province'),'int'),
    		'city' => IFilter::act(IReq::get('city'),'int'),
    		'area' => IFilter::act(IReq::get('area'),'int'),
    		'mobile' => IFilter::act(IReq::get('mobile')),
    		'address' => IFilter::act(IReq::get('address')),
    		'postscript' =>IFilter::act(IReq::get('postscript')),
    		'create_time' =>date('Y-m-d H:i:s'),
    		'payable_amount' => $payable_amount,
    		'real_amount' => $real_amount,
    		'payable_freight' =>$payable_freight,
    		'real_freight' =>$real_freight,
    		'order_no' =>  $order_no,
    		'invoice' =>IFilter::act(IReq::get('invoice'),'int'),
    		'invoice_title' =>IFilter::act(IReq::get('invoice_title')),
    		'promotions' =>$payable_amount - $real_amount,
    		'taxes' =>$taxes,
    		'pay_fee' =>$pay_fee,
    		'order_amount' =>$real_amount+$real_freight+$taxes+$pay_fee,
    		'accept_time' =>'任意'
    	));
    	//保存order数据，并且获得order_id
    	$order_id = $tb_order->add();
    	//实付总金额
    	$real_amount = 0;
    	//第二步获得order_goods表的内容，包括order_id，goods_id，products_id等主要项目
    	$goods_id = IFilter::act(IReq::get('goods_id'));
    	$product_id = IFilter::act(IReq::get('p_id'));
    	$goods_price = IFilter::act(IReq::get('price'));
    	$real_price = IFilter::act(IReq::get('real_price'));
    	$goods_nums = IFilter::act(IReq::get('number'));
    	$goods_weight = IFilter::act(IReq::get('weight'));
    	$g_id_arr = explode(',',$goods_id);
    	$p_id_arr = explode(',',$product_id);
    	$g_pr_arr = explode(',',$goods_price);
    	$r_pr_arr = explode(',',$real_price);
    	$g_nu_arr = explode(',',$goods_nums);
    	$g_we_arr = explode(',',$goods_weight);
    	$point = 0;
    	$exp = 0;
    	//循环保存order_goods表中数据
    	$tb_goods = new IModel('goods');
    	$tb_order_goods = new IModel('order_goods');
    	$tb_products = new IModel('products');

    	foreach ($g_id_arr as $key => $value)
    	{
    		//根据会员组获得产品的实际价格
    		$tb_order_goods ->setData(array(
	    		'order_id' => $order_id,
	    		'goods_id' =>$g_id_arr[$key],
	    		'product_id' => $p_id_arr[$key],
	    		'goods_price' =>$g_pr_arr[$key],
    			'real_price' =>$r_pr_arr[$key],
	    		'goods_nums' =>$g_nu_arr[$key],
    			'goods_weight' =>$g_we_arr[$key]
    		));
    		$og_id = $tb_order_goods ->add();
			$ids = array();
			$ids['name'] = '';
			$info = $tb_goods->query('id='.$g_id_arr[$key]);
			if(count($info)>0)
			{
				$ids['name'] = $info[0]['name'];
				//计算积分
    			$point += $g_nu_arr[$key]*$info[0]['point'];
    			$exp += $g_nu_arr[$key]*$info[0]['exp'];
			}
			$ids['value'] = '';
			$p_info = $tb_products->query('id='.$p_id_arr[$key]);
			if(count($p_info)>0)
			{
				$spec_array=Block::show_spec($p_info[0]['spec_array']);
				foreach ($spec_array as $ky => $vaa)
				{
					$ids['value'] .= $ky.':'.$vaa.',';
				}
			}
			$tb_order_goods ->setData(array('goods_array' =>serialize($ids)));
			$tb_order_goods->update('id='.$og_id);

    		//减goods表中以及products中的库存
    		Block::updateStore($order_id ,$type = 'reduce');
    		//计算实付总金额
    		$real_amount = $real_amount+$real_price*$g_nu_arr[$key];
    	}
    	if($point)
    	{
    		//更新积分
	    	$tb_order->setData(array('point'=>$point,'exp'=>$exp));
	    	$tb_order->update('id='.$order_id);
    	}
    	//获取post值，看用户是否要保存收货地址
    	$if_save = IReq::get('if_save');
    	if($if_save)
    	{
    		$tb_address = new IModel('address');
    		$tb_address->setData(array(
    			'user_id' =>$user_id,
    			'accept_name' =>IFilter::act(IReq::get('accept_name')),
    			'zip' =>IFilter::act(IReq::get('postcode')),
    			'telphone' =>IFilter::act(IReq::get('telphone')),
    			'province' =>IFilter::act(IReq::get('province'),'int'),
    			'city' =>IFilter::act(IReq::get('city'),'int'),
    			'area' =>IFilter::act(IReq::get('area'),'int'),
    			'address' =>IFilter::act(IReq::get('address')),
    			'mobile' =>IFilter::act(IReq::get('mobile')),
    			'default' =>0
    		));
    		$tb_address->add();
    	}
    	//生成订单日志
    	$tb_order_log = new IModel('order_log');
    	$tb_order_log->setData(array(
    		'order_id' =>$order_id,
    		'user' =>$this->admin['admin_id'],
    		'action' =>'添加',
    		'result' =>'成功',
    		'note' =>'订单【'.$order_no.'】创建',
    		'addtime'=>date('Y-m-d H:i:s')
    	));
    	$tb_order_log->add();

		$logObj = new log('db');
		$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"生成了新订单",'订单号：'.$order_no));

    	$this->redirect('order_list');
    }
    /*
     * @brief 订单删除功能_删除到回收站
     *
     * */
    public function order_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('order');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$id = $tb_order->update(Order_Class::getWhere($id));

			//获取订单编号
			$orderRs   = $tb_order->query('id in ('.$id.')','order_no');
			$orderData = array();
			foreach($orderRs as $val)
			{
				$orderData[] = $val['order_no'];
			}

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"订单移除到回收站内",'订单号：'.join(',',$orderData)));

			$this->redirect('order_list');
		}
		else
		{
			$this->redirect('order_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/*
     * @brief 收款单删除功能_删除到回收站
     *
     * */
    public function collection_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('collection_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"收款单移除到回收站内",'收款单ID：'.$id));

			$this->redirect('order_collection_list');
		}
		else
		{
			$this->redirect('order_collection_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/*
     * @brief 收款单删除功能_删除回收站中的数据，彻底删除
     *
     * */
    public function collection_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('collection_doc');
    	if(!empty($id))
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除回收站内的收款单",'收款单ID：'.$id));

			$this->redirect('collection_recycle_list');
		}
		else
		{
			$this->redirect('collection_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原还款单列表
	 */
    public function collection_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('collection_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"恢复了回收站内的收款单",'收款单ID：'.$id));

			$this->redirect('collection_recycle_list');
		}
		else
		{
			$this->redirect('collection_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }

	/*
     * @brief 退款单删除功能_删除到回收站
     */
    public function refundment_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('refundment_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"退款单移除到回收站内",'退款单ID：'.$id));

			$this->redirect('order_refundment_list');
		}
		else
		{
			$this->redirect('order_refundment_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/*
     * @brief 退款单删除功能_删除回收站中的数据，彻底删除
     *
     * */
    public function refundment_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('refundment_doc');
    	if(!empty($id))
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除了回收站内的退款单",'退款单ID：'.$id));

			$this->redirect('refundment_recycle_list');
		}
		else
		{
			$this->redirect('refundment_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原还款单列表
	 */
    public function refundment_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('refundment_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"还原了回收站内的还款单",'还款单ID：'.$id));

			$this->redirect('refundment_recycle_list');
		}
		else
		{
			$this->redirect('refundment_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
    /*
     * @brief 发货单删除功能_删除到回收站
     *
     * */
    public function delivery_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('delivery_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"发货单移除到回收站内",'发货单ID：'.$id));

			$this->redirect('order_delivery_list');
		}
		else
		{
			$this->redirect('order_delivery_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/*
     * @brief 发货单删除功能_删除回收站中的数据，彻底删除
     *
     * */
    public function delivery_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('delivery_doc');
    	if(!empty($id))
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除了回收站中的发货单",'发货单ID：'.$id));

			$this->redirect('delivery_recycle_list');
		}
		else
		{
			$this->redirect('delivery_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原发货单列表
	 */
    public function delivery_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('delivery_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"还原了回收站中的发货单",'发货单ID：'.$id_str));

			$this->redirect('delivery_recycle_list');
		}
		else
		{
			$this->redirect('delivery_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
	/*
	 * @brief 退货单删除功能_删除到回收站
	 * */
    public function returns_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('returns_doc');
    	$tb_order->setData(array('if_del'=>1));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"退货单移除到回收站中",'退货单ID：'.$id));

			$this->redirect('order_returns_list');
		}
		else
		{
			$this->redirect('order_returns_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/*
     * @brief 退货单删除功能_删除回收站中的数据，彻底删除
     *
     * */
    public function returns_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('returns_doc');
    	if(!empty($id))
		{
			$tb_order->del(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"退货单移除到回收站中",'退货单ID：'.$id));

			$this->redirect('returns_recycle_list');
		}
		else
		{
			$this->redirect('returns_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
	/**
	 * @brief 还原退货单列表
	 */
    public function returns_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('returns_doc');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"还原回收站中退货单",'退货单ID：'.$id));

			$this->redirect('returns_recycle_list');
		}
		else
		{
			$this->redirect('returns_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
    /*
     * @brief 订单删除功能_删除回收站中的数据，彻底删除
     *
     * */
    public function order_recycle_del()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	$id_str = $id;
    	//生成order对象
    	$tb_order = new IModel('order');
    	if(!empty($id))
		{
			$where = '';
			$prop = '';
			$order_id = '';
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				$where = ' id in ('.$id_str.')';
				$prop = ' id in ('.$id_str.') and pay_status =0 and prop is not null';
				$order_id = ' order_id in ('.$id_str.')';
			}
			else
			{
				$where = 'id = '.$id;
				$prop = 'id = '.$id.' and pay_status =0 and prop is not null';
				$order_id = 'id = '.$id;
			}
			//先修改红包
			$order_info = $tb_order->query($prop);
			if(count($order_info)>0)
			{
				$tb_prop = new IModel('prop');
				foreach ($order_info as $value)
				{
					$tb_prop->setData(array('is_close'=>0));
					if($value['prop'])
					{
						$tb_prop->update('id='.$value['prop']);
					}
				}
			}
			//删除订单商品
			$tb_order_goods = new IQuery('order_goods');
			$tb_order_goods->fields = 'id';
			$tb_order_goods->where = $order_id;
			$order_info = $tb_order_goods->find();

			if(count($order_info)>0)
			{
				$tb_order_go = new IModel('order_goods');
				foreach ($order_info as $value)
				{
					if($value['id'])
					{
						$tb_order_go->del('id='.$value['id']);
					}
				}
			}
			//删除订单
			$tb_order->del($where);

			$logObj = new log('db');
			$logObj->write('operation',array("管理员:".ISafe::get('admin_name'),"删除回收站中退货单",'退货单ID：'.$id_str));

			$this->redirect('order_recycle_list');
		}
		else
		{
			$this->redirect('order_recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
    }
    /**
	 * @brief 还原订单列表
	 */
    public function order_recycle_restore()
    {
    	//post数据
    	$id = IFilter::act(IReq::get('id'),'int');
    	//生成order对象
    	$tb_order = new IModel('order');
    	$tb_order->setData(array('if_del'=>0));
    	if(!empty($id))
		{
			$tb_order->update(Order_Class::getWhere($id));
			$this->redirect('order_recycle_list');
		}
		else
		{
			$this->redirect('order_recycle_list',false);
			Util::showMessage('请选择要还原的数据');
		}
    }
	/**
	 * @brief 获取添加订单时，用户名检索的结果
	 */
	public function search_user()
	{
		$data = array();
		//去掉页面的左侧菜单和导航
		$this->layout = '';
		// 获取POST数据
		$user = IFilter::act(IReq::get("user"));
		$name = IFilter::act(IReq::get("name"));
		$user_where = IFilter::act(IReq::get("user_where"));
		$name_where = IFilter::act(IReq::get("name_where"));
		$province_where = IFilter::act(IReq::get("province_where"));
		$province = IFilter::act(IReq::get("province"),'int');
		$city = IFilter::act(IReq::get("city"),'int');
		$area = IFilter::act(IReq::get("area"),'int');
		$mobile_where = IFilter::act(IReq::get("mobile_where"));
		$mobile = IFilter::act(IReq::get("mobile"));
		$where = '1=1';
		//判断post数据
		if ($user)
		{
			if($user_where == 'like')
			{
				$where .= ' and u.username like "%'.$user.'%"';
			}
			else
			{
				$where .= ' and u.username = "'.$user.'"';
			}
		}
		if ($name)
		{
			if($name_where == 'like')
			{
				$where .= ' and m.true_name like "%'.$name.'%"';
			}
			else
			{
				$where .= ' and m.true_name = "'.$name.'"';
			}
		}
		if ($province && $city && $area)
		{
			$addr = ','.$province.','.$city.','.$area.',';
			if($province_where == 'like')
			{
				$where .= ' and m.area like "%,'.$province.',%" or m.area like "%,'.$city.',%" or m.area like "%,'.$area.',%"';
			}
			else
			{
				$where .= ' and m.area = "'.$addr.'"';
			}
		}
		if ($mobile)
		{
			if($mobile_where == 'like')
			{
				$where .= ' and m.mobile like "%'.$mobile.'%"';
			}
			else
			{
				$where .= ' and m.mobile = "'.$mobile.'"';
			}
		}
		//定义data数组的值，将值传回页面
		$data['user'] = $user;
		$data['name'] = $name;
		$data['user_where'] = $user_where;
		$data['name_where'] = $name_where;
		$data['province_where'] = $province_where;
		$data['province'] = $province;
		$data['city'] = $city;
		$data['area'] = $area;
		$data['mobile_where'] = $mobile_where;
		$data['mobile'] = $mobile;
		//向前台渲染值
		$this->where = $where;
		$this->setRenderData($data);

		$this->redirect('search_user');
	}
	 /**
	 * @brief 获取添加订单时，商品检索的结果
	 */
	public function search_goods()
	{
		//去掉页面的左侧菜单和导航
		$this->layout = '';
		//获取POST数据
		$goods_name = IFilter::act(IReq::get('goods_name'));
		$name_where = IFilter::act(IReq::get('name_where'));
		$goods_code = IFilter::act(IReq::get('goods_code'));
		$code_where = IFilter::act(IReq::get('code_where'));
		$price = IFilter::act(IReq::get('price'));
		$price_where = IFilter::act(IReq::get('price_where'));
		//查询条件
		$where = ' where 1=1 ';
		$where1 = '';
		$where2 = '';
		$where3 = '';
		$where4 = '';
		if($goods_name)
		{
			if($name_where == 'like')
			{
				$where1 = " and g.name like '%".$goods_name."%'";
			}
			else
			{
				$where1 = " and g.name = '".$goods_name."'";
			}
		}
		if($goods_code)
		{
			if($code_where == 'like')
			{
				$where2 = " and p.goods_code like '%".$goods_code."%'";
			}
			else
			{
				$where2 = " and p.goods_code = '".$goods_code."'";
			}
		}
		if($price)
		{
			if($price_where == 'like')
			{
				$where3 = " and p.market_price like '%".$price."%'";
				$where4 = " and g.sell_price like '%".$price."%'";
			}
			else
			{
				$where3 = " and p.market_price = '".$price."'";
				$where4 = " and g.sell_price = '".$price."'";
			}
		}
		//获得表前缀
		$tablePre = isset(IWeb::$app->config['DB']['tablePre'])?IWeb::$app->config['DB']['tablePre']:'';
		//查询商品名称
		$sql = "select distinct * from (select p.goods_id,g.name,p.spec_array,p.id,p.sell_price,p.weight from {$tablePre}goods as g join {$tablePre}products as p on p.goods_id = g.id {$where} {$where1}{$where2}{$where3}
				union all
				select g.id,g.name,g.name='' as aa,g.id='',g.sell_price,g.weight from {$tablePre}goods as g where id not in (select DISTINCT goods_id from {$tablePre}products ) {$where1}{$where4}) b ";
		//获得表链接对象
		$dbo=IDBFactory::getDB();
		//查询结果

		//分页方法
		$page = isset($_GET['page'])?$_GET['page']:1;
		$this->paging = new IPaging($sql);
		$this->arr = $this->paging->getPage($page);
		//查询条件
		$data = array();
		$data['goods_name'] = $goods_name;
		$data['name_where'] = $name_where;
		$data['goods_code'] = $goods_code;
		$data['code_where'] = $code_where;
		$data['price'] = $price;
		$data['price_where'] = $price_where;
		//向前台渲染数据
		$this->setRenderData($data);
		$this->redirect('search_goods');
	}
	 /**
	 * @brief 订单打印模板修改
	 */
    public function print_template()
    {
		//获取根目录路径
		$path = IWeb::$app->getBasePath().'views/'.$this->theme.'/order';
    	//获取 购物清单模板
		$ifile_shop = new IFile($path.'/shop_template.html');
		$arr['ifile_shop']=$ifile_shop->read();
		//获取 配货单模板
		$ifile_pick = new IFile($path."/pick_template.html");
		$arr['ifile_pick']=$ifile_pick->read();

		$this->setRenderData($arr);
		$this->redirect('print_template');
    }
    function template()
    {
    	$this->layout='';
    	$this->redirect('template');
    }
	 /**
	 * @brief 订单打印模板修改保存
	 */
    public function print_template_update()
    {
		// 获取POST数据
    	$con_shop = IReq::get("con_shop");
		$con_pick = IReq::get("con_pick");

    	//获取根目录路径
		$path = IWeb::$app->getBasePath().'views/'.$this->theme.'/order';
    	//保存 购物清单模板
		$ifile_shop = new IFile($path.'/shop_template.html','w');
		if(!($ifile_shop->write($con_shop)))
		{
			$this->redirect('print_template',false);
			Util::showMessage('保存购物清单模板失败！');
		}
		//保存 配货单模板
		$ifile_pick = new IFile($path."/pick_template.html",'w');
		if(!($ifile_pick->write($con_pick)))
		{
			$this->redirect('print_template',false);
			Util::showMessage('保存配货单模板失败！');
		}
		//保存 合并单模板
    	$ifile_merge = new IFile($path."/merge_template.html",'w');
		if(!($ifile_merge->write($con_shop.$con_pick)))
		{
			$this->redirect('print_template',false);
			Util::showMessage('购物清单和配货单模板合并失败！');
		}

		$this->setRenderData(array('where'=>''));
		$this->redirect('order_list');
	}

	//购物单
	function shop_template()
	{
		$this->layout='print';
		$order_id = IFilter::string( IReq::get('id') );
		$tb_order = new IModel('order');
		$order_info = $tb_order->query('id='.$order_id);
		$this->setRenderData($order_info[0]);
		//获得配置文件内容
		$data = array();

		$config = new Config("site_config");
		$config_info = $config->getInfo();
     	$data['set']['name'] = isset($config_info['name'])  ? $config_info['name']  : '';
     	$data['set']['mobile'] = isset($config_info['mobile'])  ? $config_info['mobile']  : '';
     	$data['set']['email'] = isset($config_info['email'])  ? $config_info['email']  : '';
     	$data['set']['url'] = isset($config_info['url'])  ? $config_info['url']  : '';
		$this->setRenderData($data);
		$this->redirect("shop_template");
	}
	//发货单
	function pick_template()
	{
		$data = array();
		$this->layout='print';
		$order_id = IFilter::string( IReq::get('id') );
		$tb_order = new IModel('order');
		$order_info = $tb_order->query('id='.$order_id);
		$data = $order_info[0];
		$tb_deliver_doc = new IQuery('delivery_doc as dd');
		$tb_deliver_doc->join = 'left join delivery_goods as dg on dd.id = dg.delivery_id';
		$tb_deliver_doc->fields = 'dd.name,dd.mobile,dd.telphone,dd.address,dd.postcode,dd.delivery_type';
		$tb_deliver_doc->where = 'dd.order_id='.$order_id;
		$deliver_doc_info = $tb_deliver_doc->find();
		if(count($deliver_doc_info)>0)
		{
			$data['deliver'] = $deliver_doc_info[0];
		}
		$this->setRenderData($data);
		$this->redirect('pick_template');
	}
	//合并购物单和发货单
	function merge_template()
	{
		$this->layout='print';
		$order_id = IFilter::string(IReq::get('id'));
		$tb_order = new IModel('order');
		$order_info = $tb_order->query('id='.$order_id);
		$this->setRenderData($order_info[0]);
		//获得配置文件内容
		$data = array();
		$config = new Config("site_config");
		$config_info = $config->getInfo();
     	$data['set']['name'] = isset($config_info['name'])  ? $config_info['name']  : '';
     	$data['set']['mobile'] = isset($config_info['mobile'])  ? $config_info['mobile']  : '';
     	$data['set']['email'] = isset($config_info['email'])  ? $config_info['email']  : '';
     	$data['set']['url'] = isset($config_info['url'])  ? $config_info['url']  : '';
		$tb_deliver_doc = new IQuery('delivery_doc as dd');
		$tb_deliver_doc->join = 'left join delivery_goods as dg on dd.id = dg.delivery_id';
		$tb_deliver_doc->fields = 'dd.name,dd.mobile,dd.telphone,dd.address,dd.postcode,dd.delivery_type';
		$tb_deliver_doc->where = 'dd.order_id='.$order_id;
		$deliver_doc_info = $tb_deliver_doc->find();
		if(count($deliver_doc_info)>0)
		{
			$data['deliver'] = $deliver_doc_info[0];
		}
		$this->setRenderData($data);

		$this->redirect("merge_template");
	}
	/**
	 * @brief 发货信息管理
	 * */
	public function ship_info_list()
	{
		$this->redirect('ship_info_list');
	}
	/**
	 * @brief 添加/修改发货信息
	 * */
	public function ship_info_edit()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get("sid"),'int');
    	if($id)
    	{
    		$tb_ship = new IModel("merch_ship_info");
    		$ship_info = $tb_ship->query("id=".$id);
    		if(count($ship_info)>0)
    		{
    			$this->data = $ship_info[0];
    		}
    		else
    		{
    			$this->ship_info_list();
				return;
    		}
    	}
    	$this->setRenderData($this->data);
		$this->redirect('ship_info_edit');
	}
	/**
	 * @brief 设置发货信息的默认值
	 * */
	public function ship_info_default()
	{
		$id = IFilter::act( IReq::get('id'),'int' );
        $default = IFilter::string(IReq::get('default'));
        $tb_merch_ship_info = new IModel('merch_ship_info');
        if($default == 1)
        {
            $tb_merch_ship_info->setData(array('is_default'=>0));
            $tb_merch_ship_info->update("all");
        }
        $tb_merch_ship_info->setData(array('is_default'=>$default));
        $tb_merch_ship_info->update("id = ".$id);
        $this->redirect('ship_info_list');
	}
	/**
	 * @brief 保存添加/修改发货信息
	 * */
	public function ship_info_update()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('sid'),'int');
    	$ship_name = IFilter::act(IReq::get('ship_name'));
    	$ship_user_name = IFilter::act(IReq::get('ship_user_name'));
    	$sex = IFilter::act(IReq::get('sex'),'int');
    	$province =IFilter::act(IReq::get('province'),'int');
    	$city = IFilter::act(IReq::get('city'),'int');
    	$area = IFilter::act(IReq::get('area'),'int');
    	$address = IFilter::act(IReq::get('address'));
    	$postcode = IFilter::act(IReq::get('postcode'),'int');
    	$mobile = IFilter::act(IReq::get('mobile'));
    	$telphone = IFilter::act(IReq::get('telphone'));
    	$is_default = IFilter::act(IReq::get('is_default'),'int');
    	//过滤string
    	$ship_name = IFilter::string($ship_name,true);
    	$ship_user_name = IFilter::string($ship_user_name,true);
    	$address = IFilter::string($address,true);
    	if($telphone)
    	{
    		$telphone = IFilter::string($telphone,true);
    	}
    	$tb_merch_ship_info = new IModel('merch_ship_info');
    	//判断是否已经有了一个默认地址
    	if(isset($is_default) && $is_default==1)
    	{
    		$tb_ship_info = new IQuery('merch_ship_info');
    		$tb_ship_info->fields = 'id,is_default';
    		$tb_ship_info->where = 'is_default=1';
    		$merch_ship_info = $tb_ship_info->find();
    		if(count($merch_ship_info)>0)
    		{
    			foreach ($merch_ship_info as $value)
    			{
    				$sid = $value['id'];
    				$tb_merch_ship_info->setData(array('is_default'=>0));
    				$tb_merch_ship_info->update('id='.$sid);
    			}

    		}
    	}
    	//设置存储数据
    	$arr['ship_name'] = $ship_name;
	    $arr['ship_user_name'] = $ship_user_name;
	    $arr['sex'] = $sex;
    	$arr['province'] = $province;
    	$arr['city'] =$city;
    	$arr['area'] =$area;
    	$arr['address'] = $address;
    	$arr['postcode'] = $postcode;
    	$arr['mobile'] = $mobile;
    	$arr['telphone'] =$telphone;
    	$arr['is_default'] = $is_default;
    	$arr['is_del'] =1;

    	$tb_merch_ship_info->setData($arr);
    	//判断是添加还是修改
    	if($id)
    	{
    		$tb_merch_ship_info->update('id='.$id);
    	}
    	else
    	{
    		$tb_merch_ship_info->add();
    	}
		$this->redirect('ship_info_list');
	}
	/**
	 * @brief 删除发货信息到回收站中
	 * */
	public function ship_info_del()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('id'),'int');
		//加载 商家发货点信息
    	$tb_merch_ship_info = new IModel('merch_ship_info');
    	$tb_merch_ship_info->setData(array('is_del' => 0));
		if(!empty($id))
		{
			$tb_merch_ship_info->update(Order_Class::getWhere($id));
			$this->redirect('ship_info_list');
		}
		else
		{
			$this->redirect('ship_info_list',false);
			Util::showMessage('请选择要删除的数据');
		}
	}
	/**
	 * @brief 还原回收站的信息到列表
	 * */
	public function recycle_restore()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('id'),'int');
		//加载 商家发货点信息
    	$tb_merch_ship_info = new IModel('merch_ship_info');
    	$tb_merch_ship_info->setData(array('is_del' => 1));
		if(!empty($id))
		{
			$tb_merch_ship_info->update(Order_Class::getWhere($id));
			$this->redirect('recycle_list');
		}
		else
		{
			$this->redirect('recycle_list',false);
		}
	}
	/**
	 * @brief 发货信息回收站列表
	 * */
	public function recycle_list()
	{
		$this->redirect('recycle_list',false);
	}
	/**
	 * @brief 删除回收站中的信息
	 * */
	public function recycle_del()
	{
		// 获取POST数据
    	$id = IFilter::act(IReq::get('id'),'int');
		//加载 商家发货点信息
    	$tb_merch_ship_info = new IModel('merch_ship_info');
		if(!empty($id))
		{
			$tb_merch_ship_info->del(Order_Class::getWhere($id));
			$this->redirect('recycle_list');
		}
		else
		{
			$this->redirect('recycle_list',false);
			Util::showMessage('请选择要删除的数据');
		}
	}

	//快递单背景图片上传
	public function expresswaybill_upload()
	{
		$result = array(
			'isError' => true,
		);

		if(isset($_FILES['attach']['name']) && $_FILES['attach']['name'] != '')
		{
			$photoObj = new PhotoUpload();
			$photo    = $photoObj->run();

			$result['isError'] = false;
			$result['data']    = $photo['attach']['img'];
		}
		else
		{
			$result['message'] = '请选择图片';
		}

		echo '<script type="text/javascript">parent.photoUpload_callback('.JSON::encode($result).');</script>';
	}

	//快递单添加修改
	public function expresswaybill_edit()
	{
		$id = intval(IReq::get('id'));

		$this->expressRow = array();

		//修改模式
		if($id)
		{
			$expressObj       = new IModel('expresswaybill');
			$this->expressRow = $expressObj->getObj('id = '.$id);
		}

		$this->redirect('expresswaybill_edit');
	}

	//快递单添加修改动作
	public function expresswaybill_edit_act()
	{
		$id           = intval(IReq::get('id'));
		$printExpress = IReq::get('printExpress');
		$name         = IFilter::act(IReq::get('express_name'));
		$width        = intval(IReq::get('width'));
		$height       = intval(IReq::get('height'));
		$background   = IFilter::act(IReq::get('printBackground'));
		$background   = ltrim($background,IUrl::creatUrl(''));

		if(!$printExpress)
		{
			$printExpress = array();
		}

		if(!$name)
		{
			die('快递单的名称不能为空');
		}

		$expressObj     = new IModel('expresswaybill');

		$data = array(
			'config'     => serialize($printExpress),
			'name'       => $name,
			'width'      => $width,
			'height'     => $height,
			'background' => $background,
		);

		$expressObj->setData($data);

		//修改模式
		if($id)
		{
			$is_result = $expressObj->update('id = '.$id);
		}
		else
		{
			$is_result = $expressObj->add();
		}
		echo $is_result === false ? '操作失败' : 'success';
	}

	//快递单删除
	public function expresswaybill_del()
	{
		$id = intval(IReq::get('id'));
		$expressObj = new IModel('expresswaybill');
		$expressObj->del('id = '.$id);
		$this->redirect('print_template/tab_index/3');
	}

	//选择快递单打印类型
	public function expresswaybill_template()
	{
		$this->layout = 'print';
    	$data = array();

    	//获得order_id的值
		$order_id = IFilter::act(IReq::get('id'));
		$order_id = is_array($order_id) ? join(',',$order_id) : $order_id;

		if(!$order_id)
		{
			$this->redirect('order_list');
			exit;
		}

		$ord_class       = new Order_Class();
 		$this->orderInfo = $ord_class->getOrderInfo($order_id);

		$this->redirect('expresswaybill_template');
	}

	//打印快递单
	public function expresswaybill_print()
	{
		$config_conver = array();
		$this->layout  = 'print';

		$order_id     = IFilter::act(IReq::get('order_id'));
		$express_id   = intval(IReq::get('express_id'));
		$expressObj   = new IModel('expresswaybill');
		$expressRow   = $expressObj->getObj('id = '.$express_id);

		if(empty($expressRow))
		{
			die('不存在此快递单信息');
		}

		$expressConfig     = unserialize($expressRow['config']);
		$expresswaybillObj = new Expresswaybill();

		$config_conver       = $expresswaybillObj->conver($expressConfig,$order_id);
		$this->config_conver = str_replace('trackingLeft','letterSpacing',$config_conver);

		$this->order_id      = $order_id;
		$this->expressRow    = $expressRow;
		$this->redirect('expresswaybill_print');
	}

	//更新打印状态
	public function update_print_status()
	{
		$order_id   = IFilter::act(IReq::get('order_id'),'int');
		$order_id   = is_array($order_id) ? join(',',$order_id) : $order_id;
		$print_type = IFilter::act(IReq::get('print_type'));

		$orderObj   = new IModel('order');
		$orderList  = $orderObj->query('id in ('.$order_id.')','if_print');

		foreach($orderList as $orderRow)
		{
			if(isset($orderRow['if_print']) && strpos($orderRow['if_print'],$print_type) === false)
			{
				if($orderRow['if_print'] == '')
				{
					$if_print = $print_type;
				}
				else
				{
					$if_print = $orderRow['if_print'].','.$print_type;
				}
				$orderObj->setData(array('if_print' => $if_print));
				$orderObj->update("id = ".$orderRow['id']);
			}
		}
	}
}
?>
