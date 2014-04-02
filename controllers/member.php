<?php
/**
 * @brief 会员模块
 * @class Member
 * @note  后台
 */
class Member extends IController
{
	protected $checkRight  = 'all';
    public $layout='admin';
	private $data = array();

	function init()
	{
		$checkObj = new CheckRights($this);
		$checkObj->checkAdminRights();
	}

	/**
	 * @brief 添加会员
	 */
	function member_edit()
	{
		$data = array();
		$uid = intval(IReq::get('uid'));
		$tb_user_group = new IModel('user_group');
		$group_info = $tb_user_group->query();
		$data['group'] = $group_info;
		$data['province'] = '';
		$data['city'] = '';
		$data['area'] = '';
		//编辑会员信息 读取会员信息
		if($uid)
		{
			$tb_user = new IModel('user');
			$tb_member = new IModel('member');

			$user_info = $tb_user->query("id=".$uid);
			$member_info = $tb_member->query("user_id=".$uid);

			if(is_array($user_info) && ($uinfo=$user_info[0]) && is_array($member_info) && ($minfo=$member_info[0]))
			{
				$data['member'] = array(
					'user_id'		=>	$uinfo['id'],
					'user_name'		=>	$uinfo['username'],
					'email'			=>	$uinfo['email'],
					'user_group'	=>	$minfo['group_id'],
					'truename'		=>	$minfo['true_name'],
					'sex'			=>	$minfo['sex'],
					'telephone'		=>	$minfo['telephone'],
					'mobile'		=>	$minfo['mobile'],
					'address'		=>	$minfo['contact_addr'],
					'zip'			=>	$minfo['zip'],
					'exp'			=>	$minfo['exp'],
					'point'			=>	$minfo['point'],
					'qq'			=>	$minfo['qq'],
					'msn'			=>	$minfo['msn']
				);
				if($minfo['area'])
				{
					$area = substr($minfo['area'],1,-1);
					$arr = explode(',',$area);
					$data['province'] = $arr[0];
					$data['city'] = $arr[1];
					$data['area'] = $arr[2];
				}
			}
			else
			{
				$this->member_list();
				Util::showMessage("没有找到相关记录！");
				return;
			}
		}
		$this->setRenderData($data);
		$this->redirect('member_edit');
	}

	//保存会员信息
	function member_save()
	{
		$user_id = IFilter::act(IReq::get('user_id'),'int');
		$email = IFilter::act(IReq::get('email'));
		$password = IFilter::act(IReq::get('password'));
		$repassword = IFilter::act(IReq::get('repassword'));

		$user_group = IFilter::act(IReq::get('user_group'),'int');
		$truename = IFilter::act(IReq::get('truename'));
		$sex = IFilter::act(IReq::get('sex'),'int');
		$telephone = IFilter::act(IReq::get('telephone'));
		$mobile = IFilter::act(IReq::get('mobile'));
		$province = IFilter::act(IReq::get('province'),'int');

		$city = IFilter::act(IReq::get('city'),'int');
		$area = IFilter::act(IReq::get('area'),'int');
		$address = IFilter::act(IReq::get('address'));
		$zip = IFilter::act(IReq::get('zip'));
		$qq = IFilter::act(IReq::get('qq'));
		$msn = IFilter::act(IReq::get('msn'));
		$exp = IFilter::act(IReq::get('exp'),'int');
		$point = IFilter::act(IReq::get('point'),'int');
		$data['member'] = array(
				'email'			=>	$email,
				'user_group'	=>	$user_group,
				'truename'		=>	$truename,
				'sex'			=>	$sex,
				'telephone'		=>	$telephone,
				'mobile'		=>	$mobile,
				'address'		=>	$address,
				'zip'			=>	$zip,
				'exp'			=>	$exp,
				'point'			=>	$point,
				'qq'			=>	$qq,
				'msn'			=>	$msn
			);
		$count = '';
		if($province)
		{
			$count = ','.$province.','.$city.','.$area.',';
		}
		$data['province'] = $province;
		$data['city'] = $city;
		$data['area'] = $area;
		if(empty($user_id))		//添加新会员
		{
			$user_name = IFilter::act( IReq::get('user_name') );
			$email = IFilter::act( IReq::get('email') );
			$data['member']['user_name'] = $user_name;
			$data['member']['email'] = $email;
			if($password=='')
			{
				$errorMsg = '请输入密码！';
				$tb_user_group = new IModel('user_group');
				$group_info = $tb_user_group->query();
				$data['group'] = $group_info;
				$this->setRenderData($data);
				$this->redirect('member_edit',false);
				Util::showMessage($errorMsg);
			}
			if($password != $repassword)
			{
				$errorMsg = '两次输入的密码不一致！';
				$tb_user_group = new IModel('user_group');
				$group_info = $tb_user_group->query();
				$data['group'] = $group_info;
				$this->setRenderData($data);
				$this->redirect('member_edit',false);
				Util::showMessage($errorMsg);
			}

			$tb_user = new IModel("user");
			$user = array(
				'username'=>$user_name,
				'password'=>md5($password),
				'email'=>$email
			);
			$tb_user->setData($user);
			$uid = $tb_user->add();

			if($uid)
			{
				$tb_member = new IModel("member");
				$member = array(
					'user_id'=>$uid,
					'true_name' =>$truename,
					'telephone' =>$telephone,
					'mobile' => $mobile,
					'area' => $count,
					'contact_addr' =>$address,
					'qq' =>$qq,
					'msn'=>$msn,
					'sex'=>$sex,
					'zip'=>$zip,
					'exp' =>$exp,
					'point'=>$point,
					'group_id'=>$user_group,
					'time'=>date('Y-m-d H:i:s')
				);
				$tb_member->setData($member);
				$tb_member->add();
				$this->redirect('member_list');
				Util::showMessage('添加用户成功！');
			}
			else
			{
				$this->redirect('member_list');
				Util::showMessage('添加用户失败！');
			}
		}
		else		//编辑会员
		{
				$tb_user = new IModel("user");
				$user = array('id'=>$user_id);
				if($password!='')
				{
					if($password != $repassword)
					{
						$errorMsg = '两次输入的密码不一致！';
						$tb_user_group = new IModel('user_group');
						$group_info = $tb_user_group->query();
						$data['group'] = $group_info;
						$this->setRenderData($data);
						$this->redirect('member_edit',false);
						Util::showMessage($errorMsg);
					}
					$user['password'] = md5($password);
				}
				$tb_user->setData($user);
				$tb_user->update("id=".$user_id);

				$tb_member = new IModel("member");
				$member_info = $tb_member->getObj('user_id='.$user_id);
				//修改积分
				
				if($point!=$member_info['point'])
				{
					$pointObj = new Point;
					$pointConfig = array(
						'user_id' => $user_id,
						'point'   => $point,
						'log'     => '管理员'.$this->admin['admin_name'].'将您的积分重置为'.$point.'积分',
					);
					$pointObj->update($pointConfig);
				}
				
				$member = array(
					'true_name' =>$truename,
					'telephone' =>$telephone,
					'mobile' => $mobile,
					'area' => $count,
					'contact_addr' =>$address,
					'qq' =>$qq,
					'msn'=>$msn,
					'sex'=>$sex,
					'zip'=>$zip,
					'exp' =>$exp,
					'point'=>$point,
					'group_id'=>$user_group,
					'time'=>date('Y-m-d H:i:s')
				);
				$tb_member->setData($member);
				$affected_rows = $tb_member->update("user_id=".$user_id);
				if($affected_rows)
				{
					$this->redirect('member_list');
					Util::showMessage('更新用户成功！');
				}
				else
				{
					$this->redirect('member_list');
					Util::showMessage('更新用户失败！');
				}

		}
	}

	/**
	 * @brief 会员列表
	 */
	function member_list()
	{
		$search = IFilter::string(IReq::get('search'));
		$keywords = IFilter::string(IReq::get('keywords'));
		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search like '%{$keywords}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;
		$tb_user_group = new IModel('user_group');
		$data_group = $tb_user_group->query();
		$data_group = is_array($data_group) ? $data_group : array();
		$group      = array();
		foreach($data_group as $value)
		{
			$group[$value['id']] = $value['group_name'];
		}
		$this->data['group'] = $group;
		$this->setRenderData($this->data);
		$this->redirect('member_list');
	}
	/**
	 * @brief 用户筛选
	 */
	function member_filter()
	{
		$search = IFilter::string(IReq::get('search'));
		$keywords = IFilter::string(IReq::get('keywords'));
		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search like '%{$keywords}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;
		$tb_user_group = new IModel('user_group');
		$data_group = $tb_user_group->query();
		$data_group = is_array($data_group) ? $data_group : array();
		$group      = array();
		foreach($data_group as $value)
		{
			$group[$value['id']] = $value['group_name'];
		}
		$this->data['group'] = $group;

		$page = IReq::get('page');
		$page = intval($page) ? intval($page) : 1;
		$and = ' and ';
		$where = 'm.status="1"'.$and;
		$group_key = IFilter::string(IReq::get('group_key'));
		$group_v = IFilter::act((IReq::get('group_value')),'int') ;
		if($group_key && $group_v)
		{
			if($group_key=='eq')
			{
				$where .= "m.group_id='{$group_v}' {$and}";
			}else
			{
				$where .= "m.group_id!='{$group_v}' {$and} ";
			}
		}
		$username_key = IFilter::string(IReq::get('username_key'));
		$username_v = IFilter::act(IReq::get('username_value'),'string');
		if($username_key && $username_v)
		{
			if($username_key=='eq')
			{
				$where .= "u.username='{$username_v}' {$and}";
			}else
			{
				$where .= 'u.username like "%'.$username_v.'%"'.$and;
			}
		}
		$truename_key = IFilter::string(IReq::get('truename_key'));
		$truename_v = IFilter::act(IReq::get('truename_value'),'string');
		if($truename_key && $truename_v)
		{
			if($truename_key=='eq')
			{
				$where .= "m.true_name='{$truename_v}' {$and}";
			}else
			{
				$where .= 'm.true_name like "%'.$truename_v.'%"'.$and;
			}
		}
		$mobile_key = IFilter::string(IReq::get('mobile_key'));
		$mobile_v = IFilter::act(IReq::get('mobile_value'),'string');
		if($mobile_key && $mobile_v)
		{
			if($mobile_key=='eq')
			{
				$where .= "m.mobile='{$mobile_v}' {$and} ";
			}else
			{
				$where .= 'm.mobile like "%'.$mobile_v.'%"'.$and;
			}
		}
		$telephone_key = IFilter::string(IReq::get('telephone_key'));
		$telephone_v = IFilter::act(IReq::get('telephone_value'),'string');
		if($telephone_key && $telephone_v)
		{
			if($telephone_key=='eq')
			{
				$where .= "m.telephone='{$telephone_v}' {$and} ";
			}else
			{
				$where .= 'm.telephone like "%'.$telephone_v.'%"'.$and;
			}
		}
		$email_key = IFilter::string(IReq::get('email_key'));
		$email_v = IFilter::act(IReq::get('email_value'),'string');
		if($email_key && $email_v)
		{
			if($email_key=='eq')
			{
				$where .= "u.email='{$email_v}' {$and} ";
			}else
			{
				$where .= 'u.email like "%'.$email_v.'%"'.$and;
			}
		}
		$zip_key = IFilter::string(IReq::get('zip_key'));
		$zip_v = IFilter::act((IReq::get('zip_value')),'string');
		if($zip_key && $zip_v)
		{
			if($zip_key=='eq')
			{
				$where .= "m.zip='{$zip_v}' {$and} ";
			}else
			{
				$where .= 'm.zip like "%'.$zip_v.'%"'.$and;
			}
		}
		$sex = intval(IReq::get('sex'));
		if($sex && $sex!='-1')
		{
			$where .= 'm.sex='.$sex.$and;
		}
		$point_key = IFilter::string(IReq::get('point_key'));
		$point_v = intval(IReq::get('point_value'));
		if($point_key && $point_v)
		{
			if($point_key=='eq')
			{
				$where .= 'm.point= "'.$point_v.'"'.$and;
			}
			elseif($point_key=='gt')
			{
				$where .= 'm.point > "'.$point_v.'"'.$and;
			}
			else
			{
				$where .= 'm.point < "'.$point_v.'"'.$and;
			}
		}
		$regtimeBegin = IFilter::string(IReq::get('regtimeBegin'));
		if($regtimeBegin)
		{
			$where .= 'm.time > "'.$regtimeBegin.'"'.$and;
		}
		$regtimeEnd = IFilter::string(IReq::get('regtimeEnd'));
		if($regtimeEnd)
		{
			$where .= 'm.time < "'.$regtimeEnd.'"'.$and;
		}
		$where .= ' 1 ';

		$query = new IQuery("member as m");
		$query->join = "left join user as u on m.user_id = u.id left join user_group as gp on m.group_id = gp.id";
		$query->fields = "m.*,u.username,u.email,gp.group_name";
		$query->where = $where;
		$query->page = $page;
		$query->pagesize = "20";
		$this->data['member_list'] = $query->find();
		$this->data['pageBar'] = $query->getPageBar('/member/member_filter/');
		$this->setRenderData($this->data);
		$this->redirect('member_filter');
	}

	/**
	 * @brief 删除至回收站
	 */
	function member_reclaim()
	{
		$user_ids = IReq::get('check');
		$user_ids = is_array($user_ids) ? $user_ids : array($user_ids);
		$user_ids = IFilter::act($user_ids,'int');
		if($user_ids)
		{
			$ids = implode(',',$user_ids);
			if($ids)
			{
				$tb_member = new IModel('member');
				$tb_member->setData(array('status'=>'2'));
				$where = "user_id in (".$ids.")";
				$tb_member->update($where);
			}
		}
		$this->member_list();
	}

	/**
	 * @brief 移动会员，修改会员等级
	 */
	function member_remove()
	{
		$user_ids = IFilter::act(IReq::get('check','post'),'int');
		$group_id = IFilter::act(IReq::get('move_group','post'),'int');
		$point    = IFilter::act(IReq::get('move_point','post'),'int');
		if($user_ids && is_array($user_ids))
		{
			$ids = implode(',',$user_ids);
			if($ids)
			{
				$tb_member = new IModel('member');
				$updatearray = array();

				//积分改动
				if($point)
				{
					$pointObj = new Point;
					$userList = $tb_member->query('user_id in('.$ids.')','user_id,point');

					foreach($userList as $val)
					{
						$c_point = intval($point - $val['point']);
						if($c_point != 0)
						{
							$tip = $c_point > 0 ? '奖励' : '扣除';
							$pointConfig = array(
								'user_id' => $val['user_id'],
								'point'   => $c_point,
								'log'     => '管理员'.$this->admin['admin_name'].'修改了积分，'.$tip.$c_point.'积分',
							);
							$pointObj->update($pointConfig);
						}
					}
				}
				$updatearray['group_id'] = $group_id;
				$tb_member->setData($updatearray);
				$where = "user_id in (".$ids.")";
				$tb_member->update($where);
			}
		}
		$this->member_list();
	}
	//批量用户充值
    function member_recharge()
    {
    	$id = IReq::get('check');
    	$balance = IReq::get('balance');
    	$type = IReq::get('type');
    	$order_no = IFilter::act( IReq::get('order_no') );
    	$even = '';
    	if($type=='3')
    	{
    		$balance = '-'.abs($balance);
    		$even = 'withdraw';
    	}
    	else
    	{
    		$balance = abs($balance);
    		if($type=='1')
    		{
    			$even = 'recharge';
    		}else
    		{
    			$even = 'drawback';
    			if(is_array($id) && count($id)>1)
    			{
    				$this->setRenderData(array('where'=>1,'search'=>'','group'=>array()));
    				$this->redirect('member_list',false);
					Util::showMessage('订单退款功能不能批量处理');
					return;
    			}
    			if(is_array($id))
    			{
    				$id = end($id);
    			}
    			$id = intval($id);
    			//检测这个订单是不是这个用户的，且是否申请退款了
    			$obj = new IModel("order");
    			$row = $obj->query("user_id={$id} AND order_no = '{$order_no}' and (pay_status = 1 or pay_status = 3)");
    			if(!$row)
    			{
    				$this->setRenderData(array('where'=>1,'search'=>'','group'=>array()));
    				$this->redirect('member_list',false);
					Util::showMessage('不存在这个订单或付款状态不正确');
					return;
    			}
    		}
    	}
		if(!empty($id))
		{
			$obj = new IModel('member');
			if(is_array($id) && isset($id[0]) && $id[0]!='')
			{
				$id_str = join(',',$id);
				//按用户id数组查询出用户余额，然后进行充值
				$member_info = $obj->query(' user_id in ('.$id_str.')');
				if(count($member_info)>0)
				{
					foreach ($member_info as $value)
					{
						$balance_bak = $value['balance']+$balance;
						if($balance_bak>=0)
						{
							$obj->setData(array('balance'=>$balance_bak));
							$obj->update(' user_id = '.$value['user_id']);

							//用户余额进行的操作记入account_log表
							$log = new AccountLog();
							$config=array(
								'user_id'=>$value['user_id'],
							 	'admin_id'=>$this->admin['admin_id'], //如果需要的话
							 	'event'=>$even, //withdraw:提现,pay:余额支付,recharge:充值,drawback:退款到余额
							 	'num'=> $balance, //整形或者浮点，正为增加，负为减少
							 	'order_no' =>$order_no // drawback类型的log需要这个值
							 );
							 $re = $log->write($config);
						}
					}
				}
			}
			else
			{
				//按用户id数组查询出用户余额，然后进行充值
				$member_info = $obj->query(' user_id = '.$id);
				if(count($member_info)>0)
				{
					$balance_bak = $member_info[0]['balance']+$balance;
					if($balance_bak>=0)
					{
						$obj->setData(array('balance'=>$balance_bak));
						$obj->update(' user_id = '.$id);

						//用户余额进行的操作记入account_log表
						$log = new AccountLog();
						$config=array(
							'user_id'=>$id,
						 	'admin_id'=>$this->admin['admin_id'], //如果需要的话
						 	'event'=>$even, //withdraw:提现,pay:余额支付,recharge:充值,drawback:退款到余额
						 	'num'=> $balance, //整形或者浮点，正为增加，负为减少
						 	'order_no' =>$order_no // drawback类型的log需要这个值
						 );
						 $re = $log->write($config);
					}
				}
			}
			$this->setRenderData(array('where'=>1,'search'=>'','group'=>array()));
			$this->redirect('member_list',false);
			Util::showMessage('操作成功');
			return;
		}
		else
		{
			$this->setRenderData(array('where'=>1,'search'=>'','group'=>array()));
			$this->redirect('member_list',false);
			Util::showMessage('请选择要充值的会员');
			return;
		}
    }
	/**
	 * @brief 用户组添加
	 */
	function group_edit()
	{
		$gid = (int)IReq::get('gid');
		//编辑会员等级信息 读取会员等级信息
		if($gid)
		{
			$tb_user_group = new IModel('user_group');
			$group_info = $tb_user_group->query("id=".$gid);

			if(is_array($group_info) && ($info=$group_info[0]))
			{
				$this->data['group'] = array(
					'group_id'	=>	$info['id'],
					'group_name'=>	$info['group_name'],
					'discount'	=>	$info['discount'],
					'minexp'	=>	$info['minexp'],
					'maxexp'	=>	$info['maxexp']
				);
			}
			else
			{
				$this->redirect('group_list',false);
				Util::showMessage("没有找到相关记录！");
				return;
			}
		}
		$this->setRenderData($this->data);
		$this->redirect('group_edit');
	}

	/**
	 * @brief 保存用户组修改
	 */
	function group_save()
	{
		$maxexp   = IReq::get('maxexp');
		$minexp   = IReq::get('minexp');
		if($maxexp <= $minexp)
		{
			$errorMsg = '最大经验值必须大于最小经验值';
		}

		$group_id = (int)IReq::get('group_id','post');
		$form_array = array(
			'user_group'=>	array(
				array('name'=>'group_name', 'field'=>'group_name','rules'=>'required'),
				array('name'=>'discount', 'field'=>'discount'),
				array('name'=>'minexp', 'field'=>'minexp'),
				array('name'=>'maxexp', 'field'=>'maxexp'),
			),
		);
		//验证表单
		$validationObj = new Formvalidation($form_array);
		$form_data = $validationObj->run();
		foreach($form_data as $key => $value)
		{
			foreach($value as $v)
			{
				$group[$v['name']] = $v['postdate'];
				$tb_model[$v['field']] = $v['postdate'];
			}
		}
		if($validationObj->isError() || isset($errorMsg))
		{
			//验证失败
			$this->data['group'] = $group;
			$this->setRenderData($this->data);
			//加载视图
			$this->redirect('group_edit',false);
			$errorMsg = isset($errorMsg) ? $errorMsg : $validationObj->getError();
			Util::showMessage($errorMsg);
		}
		else
		{
			//验证成功
			$tb_user_group = new IModel("user_group");
			$tb_user_group->setData($tb_model);
			if($group_id)
			{
				$affected_rows = $tb_user_group->update("id=".$group_id);
				if($affected_rows)
				{
					$this->redirect('group_list',false);
					Util::showMessage('更新用户组成功！');
					return;
				}
				$this->redirect('group_list',false);
			}
			else
			{
				$gid = $tb_user_group->add();
				$this->redirect('group_list',false);
				if($gid)
				{
					Util::showMessage('添加用户组成功！');
				}
				else
				{
					Util::showMessage('添加用户组失败！');
				}
			}
		}
	}

	/**
	 * @brief 删除会员组
	 */
	function group_del()
	{
		$group_ids = IReq::get('check');
		$group_ids = is_array($group_ids) ? $group_ids : array($group_ids);
		$group_ids = IFilter::act($group_ids,'int');
		if($group_ids)
		{
			$ids = implode(',',$group_ids);
			if($ids)
			{
				$tb_user_group = new IModel('user_group');
				$where = "id in (".$ids.")";
				$tb_user_group->del($where);
			}
		}
		$this->redirect('group_list');
	}

	/**
	 * @brief 回收站
	 */
	function recycling()
	{
		$search = IReq::get('search');
		$keywords = IReq::get('keywords');
		$search_sql = IFilter::act($search,'string');
		$keywords = IFilter::act($keywords,'string');

		$where = ' 1 ';
		if($search && $keywords)
		{
			$where .= " and $search_sql like '%{$keywords_sql}%' ";
		}
		$this->data['search'] = $search;
		$this->data['keywords'] = $keywords;
		$this->data['where'] = $where;
		$tb_user_group = new IModel('user_group');
		$data_group = $tb_user_group->query();
		$data_group = is_array($data_group) ? $data_group : array();
		$group = array();
		foreach($data_group as $value)
		{
			$group[$value['id']] = $value['group_name'];
		}
		$this->data['group'] = $group;
		$this->setRenderData($this->data);
		$this->redirect('recycling');
	}

	/**
	 * @brief 彻底删除会员
	 */
	function member_del()
	{
		$user_ids = IReq::get('check');
		$user_ids = is_array($user_ids) ? $user_ids : array($user_ids);
		$user_ids = IFilter::act($user_ids,'int');
		if($user_ids)
		{
			$ids = implode(',',$user_ids);

			if($ids)
			{
				$tb_member = new IModel('member');
				$where = "user_id in (".$ids.")";
				$tb_member->del($where);

				$tb_user = new IModel('user');
				$where = "id in (".$ids.")";
				$tb_user->del($where);

				$logObj = new log('db');
				$logObj->write('operation',array("管理员:".$this->admin['admin_name'],"删除了用户","被删除的用户ID为：".$ids));
			}
		}
		$this->redirect('member_list');
	}

	/**
	 * @brief 从回收站还原会员
	 */
	function member_restore()
	{
		$user_ids = IReq::get('check');
		$user_ids = is_array($user_ids) ? $user_ids : array($user_ids);
		if($user_ids)
		{
			$user_ids = IFilter::act($user_ids,'int');
			$ids = implode(',',$user_ids);
			if($ids)
			{
				$tb_member = new IModel('member');
				$tb_member->setData(array('status'=>'1'));
				$where = "user_id in (".$ids.")";
				$tb_member->update($where);
			}
		}
		$this->redirect('recycling');
	}

	//[提现管理] 删除
	function withdraw_del()
	{
		$id   = IReq::get('id');

		if(!empty($id))
		{
			$id = IFilter::act($id,'int');
			$withdrawObj = new IModel('withdraw');

			if(is_array($id))
			{
				$idStr = join(',',$id);
				$where = ' id in ('.$idStr.')';
			}
			else
			{
				$where = 'id = '.$id;
			}

			$withdrawObj->del($where);
			$this->redirect('withdraw_recycle');
		}
		else
		{
			$this->redirect('withdraw_recycle',false);
			Util::showMessage('请选择要删除的数据');
		}
	}

	//[提现管理] 回收站 删除,恢复
	function withdraw_update()
	{
		$id   = IFilter::act( IReq::get('id') , 'int' );
		$type = IReq::get('type') ;

		if(!empty($id))
		{
			$withdrawObj = new IModel('withdraw');

			$is_del = ($type == 'res') ? '0' : '1';
			$dataArray = array(
				'is_del' => $is_del
			);

			if(is_array($id))
			{
				$idStr = join(',',$id);
				$where = ' id in ('.$idStr.')';
			}
			else
			{
				$where = 'id = '.$id;
			}

			$dataArray = array(
				'is_del' => $is_del,
			);

			$withdrawObj->setData($dataArray);
			$withdrawObj->update($where);
			$this->redirect('withdraw_list');
		}
		else
		{
			if($type == 'del')
			{
				$this->redirect('withdraw_list',false);
			}
			else
			{
				$this->redirect('withdraw_recycle',false);
			}
			Util::showMessage('请选择要删除的数据');
		}
	}

	//[提现管理] 详情展示
	function withdraw_detail()
	{
		$id = IFilter::act( IReq::get('id'),'int' );

		if($id)
		{
			$withdrawObj = new IModel('withdraw');
			$where       = 'id = '.$id;
			$this->withdrawRow = $withdrawObj->getObj($where);
			$this->redirect('withdraw_detail',false);
		}
		else
		{
			$this->redirect('withdraw_list');
		}
	}

	//[提现管理] 修改提现申请的状态
	function withdraw_status()
	{
		$id      = IFilter::act( IReq::get('id'),'int' );
		$re_note = IFilter::act( IReq::get('re_note'),'string' );

		if($id)
		{
			$withdrawObj = new IModel('withdraw');
			$dataArray = array(
				're_note'=> $re_note,
			);
			if(IReq::get('status') !== NULL)
			{
				$dataArray['status'] = IFilter::act(IReq::get('status') , 'int');
			}

			$withdrawObj->setData($dataArray);
			$where = "`id`= {$id} AND `status` = 0";
			$re = $withdrawObj->update($where);
			$this->withdraw_detail(true);

			if($re != 0)
			{
				$logObj = new log('db');
				$logObj->write('operation',array("管理员:".$this->admin['admin_name'],"修改了提现申请","ID值为：".$id));
			}

			Util::showMessage("更新成功");
		}
		else
		{
			$this->redirect('withdraw_list');
		}
	}

}
