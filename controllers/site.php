<?php
/**
 * @copyright Copyright(c) 2011 jooyea.net
 * @file site.php
 * @brief
 * @author webning
 * @date 2011-03-22
 * @version 0.6
 * @note
 */
/**
 * @brief Site
 * @class Site
 * @note
 */
class Site extends IController
{
    public $layout='site';

	function init()
	{
		$checkObj = new CheckRights($this);
		$checkObj->checkUserRights();
	}

	function index()
	{
		$siteConfigObj = new Config("site_config");
		$site_config   = $siteConfigObj->getInfo();
		$index_slide = isset($site_config['index_slide'])? unserialize($site_config['index_slide']) :array();
		$this->index_slide = $index_slide;
		$this->redirect('index');
	}

	//商品列表信息展示
	function goodsListFilter()
	{
		//获取配置信息
		$siteConfigObj = new Config("site_config");
		$site_config   = $siteConfigObj->getInfo();

		$show_type = IReq::get('show_type');

		//设置列表展示默认值
		if($show_type == null && isset($site_config['list_type']))
		{
			$show_type = $site_config['list_type'];
		}

		if($show_type == 'win')
		{
			$listImageWidth  = '200';
			$listImageHeight = '200';
		}
		else
		{
			$show_type       = 'list';
			$listImageWidth  = '115';
			$listImageHeight = '115';
		}

		//排序条件
		$order  = IReq::get('order');
		if($order == null && isset($site_config['order_by']))
		{
			if(isset($site_config['order_type']) && ($site_config['order_type'] == 'asc'))
			{
				$order = $site_config['order_by'].'_toggle';
			}
			else
			{
				$order = $site_config['order_by'];
			}
		}
		$orderArray = array('sale' =>'销量','cpoint' =>'评分','price'=>'价格','new'=>'最新上架');

		return array(
			'show_type'       => $show_type,
			'listImageWidth'  => $listImageWidth,
			'listImageHeight' => $listImageHeight,
			'order'           => $order,
			'orderArray'      => $orderArray,
		);
	}

	//[首页]商品搜索
	function search_list()
	{
		$return = $this->goodsListFilter();
		$this->show_type       = $return['show_type'];
		$this->listImageWidth  = $return['listImageWidth'];
		$this->listImageHeight = $return['listImageHeight'];
		$this->order           = $return['order'];
		$this->orderArray      = $return['orderArray'];

		$this->word            = IFilter::act(IReq::get('word'));
		$cat_id                = intval(IReq::get('cat'));

		if($this->word != '' && $this->word != '%' && $this->word != '_')
		{
			if($cat_id > 0)
			{
				$tb_goods = new IQuery('goods as go');
				$tb_goods->join   = "left join category_extend as ca on go.id = ca.goods_id";
				$tb_goods->where  = "go.name like '%$this->word%' and go.is_del = 0 and ca.category_id = $cat_id";
				$tb_goods->fields = "count(*) as num";
				$goodsNum         = $tb_goods->find();
				$this->findSum    = $goodsNum[0]['num'];
			}
			else
			{
				$goodsObj      = new IModel('goods');
				$goodsNum      = $goodsObj->getObj('name like "%'.$this->word.'%" and is_del=0','count(*) as num');
				$this->findSum = $goodsNum['num'];
			}

			//搜索关键字
			$tb_sear     = new IModel('search');
			$search_info = $tb_sear->getObj('keyword = "'.$this->word.'"','id');

			//如果是第一页，相应关键词的被搜索数量才加1
			if($search_info && intval(IReq::get('page')) < 2 )
			{
				//禁止刷新+1
				$allow_sep = "30";
				$flag = false;
				$time = ICookie::get('step');
				if(isset($time))
				{
					if (time() - $time > $allow_sep)
					{
						ICookie::set('step',time());
						$flag = true;
					}
				}
				else
				{
					ICookie::set('step',time());
					$flag = true;
				}
				if($flag)
				{
					$tb_sear->setData(array('num'=>'num + 1'));
					$tb_sear->update('id='.$search_info['id'],'num');
				}
			}
			elseif( !$search_info )
			{
				//如果数据库中没有这个词的信息，则新添
				$tb_sear->setData(array('keyword'=>$this->word,'num'=>1));
				$tb_sear->add();
			}
		}
		else
		{
			IError::show(403,'请输入正确的查询关键词');
		}
		$this->cat_id = $cat_id;
		$this->redirect('search_list');
	}

	//[site,ucenter头部分]自动完成
	function autoComplete()
	{
		$word = IFilter::act(IReq::get('word'));
		$isError = true;
		$data    = array();

		if($word != '' && $word != '%' && $word != '_')
		{
			$wordObj  = new IModel('keyword');
			$wordList = $wordObj->query('word like "'.$word.'%" and word != "'.$word.'"','word, goods_nums','','',10);

			if(!empty($wordList))
			{
				$isError = false;
				$data = $wordList;
			}
		}

		//json数据
		$result = array(
			'isError' => $isError,
			'data'    => $data,
		);

		echo JSON::encode($result);
	}

	//[首页]邮箱订阅
	function email_registry()
	{
		$email  = IReq::get('email');
		$result = array('isError' => true);

		if(!IValidate::email($email))
		{
			$result['message'] = '请填写正确的email地址';
		}
		else
		{
			$emailRegObj = new IModel('email_registry');
			$emailRow    = $emailRegObj->getObj('email = "'.$email.'"');

			if(!empty($emailRow))
			{
				$result['message'] = '此email已经订阅过了';
			}
			else
			{
				$dataArray = array(
					'email' => $email,
				);
				$emailRegObj->setData($dataArray);
				$status = $emailRegObj->add();
				if($status == true)
				{
					$result = array(
						'isError' => false,
						'message' => '订阅成功',
					);
				}
				else
				{
					$result['message'] = '订阅失败';
				}
			}
		}
		echo JSON::encode($result);
	}

	//[列表页]商品
	function pro_list()
	{
		$this->catId = intval(IReq::get('cat'));//分类id
		if($this->catId == 0)
		{
			IError::show(403,'缺少分类ID');
		}
		else
		{
			//查找分类信息
			$catObj       = new IModel('category');
			$this->catRow = $catObj->getObj('id = '.$this->catId);
			$catOther = $catObj->query('','id,name,parent_id,visibility','sort','asc');

			if(empty($this->catRow))
			{
				IError::show(403,'此分类不存在');
			}

			$catMore       = null;
			$this->childId = $this->catId;
			Block::recursion_goods_category($this->catRow,$catOther,$catObj,$catMore);

			//是最终实体的分类
			if($catMore == null)
			{
				$modelObj   = new IModel('model');
				$modelRow   = $modelObj->getObj('id = '.$this->catRow['model_id']);
				$spec       = (isset($modelRow['spec_ids']) && is_string($modelRow['spec_ids'])) ? unserialize($modelRow['spec_ids']) : array();
				$specIdArray= array();
				$this->spec = array();

				if(!empty($spec))
				{
					foreach($spec as $val)
					{
						$specIdArray[] = $val['id'];
					}
					$specId = join(',',$specIdArray);

					$specObj    = new IModel('spec');
					$this->spec = $specObj->query('id in ('.$specId.')');
				}
			}

			//分类容器
			else
			{
				foreach($catMore as $val)
				{
					$this->childId .= ','.$val['id'];
				}
			}

			$defaultWhere     = array('category_extend' => $this->childId);
			$this->resultData = $this->find($defaultWhere,$goodsObj);
			$this->goodsObj   = $goodsObj;

			$return = $this->goodsListFilter();
			$this->show_type       = $return['show_type'];
			$this->listImageWidth  = $return['listImageWidth'];
			$this->listImageHeight = $return['listImageHeight'];
			$this->order           = $return['order'];
			$this->orderArray      = $return['orderArray'];

			$this->redirect('pro_list');
		}
	}

	//[列表页检索]
	function find($defaultWhere,&$goodsObj)
	{
		//获取配置信息
		$siteConfigObj = new Config("site_config");
		$site_config   = $siteConfigObj->getInfo();

		//开始查询
		$goodsObj = new IQuery("goods as go");
		$goodsObj->page     = isset($_GET['page']) ? intval($_GET['page']) : 1;
		$goodsObj->pagesize = isset($site_config['list_num'])?$site_config['list_num']:20;
		$goodsObj->fields   = ' go.* ';

		/*where条件拼接*/
		//(1),当前产品分类
		$where = ' go.is_del = 0 ';

		//(2),商品属性,规格筛选
		$attrCond  = array();
		$specCond  = array();
		$childSql  = '';
		$attrArray = IReq::get('attr');
		$specArray = IReq::get('spec');

		if(!empty($attrArray))
		{
			foreach($attrArray as $key => $val)
			{
				if($key != '' && $val != '')
				{
					$attrCond[] = ' attribute_id = '.$key.' and FIND_IN_SET("'.$val.'",`attribute_value`)';
				}
			}
		}

		if(!empty($specArray))
		{
			foreach($specArray as $key => $val)
			{
				if($key != '' && $val != '')
				{
					$specCond[] = ' spec_id = '.$key.' and spec_value like "_|'.$val.'" ';
				}
			}
		}

		//合并规格与属性的值,并且生成SQL查询语句
		$GoodsId = array();
		$sumCond = array_merge($attrCond,$specCond);
		if(!empty($sumCond))
		{
			$tempArray = array();
			foreach($sumCond as $key => $cond)
			{
				$tempArray[] =  '('.$cond.')';
			}
			$childSql = join(' or ',$tempArray);

			$goodsAttrObj          = new IQuery('goods_attribute');
			$goodsAttrObj->fields  = 'goods_id';
			$goodsAttrObj->where   = $childSql;
			$goodsAttrObj->group   = 'goods_id';
			$goodsAttrObj->having  = 'count(goods_id) >= '.count($sumCond);
			$goodsIdArray          = $goodsAttrObj->find();

			if(empty($goodsIdArray))
			{
				$GoodsId[] = 0;
			}
			else
			{
				foreach($goodsIdArray as $key => $val)
				{
					$GoodsId[] = $val['goods_id'];
				}
			}
		}

		//(3),处理defaultWhere条件
		if(is_array($defaultWhere))
		{
			$where .= isset($defaultWhere['goods']) ? ' and '.$defaultWhere['goods'] : '';
			$currentCatGoods = array();
			if(isset($defaultWhere['category_extend']) && $defaultWhere['category_extend'] != '')
			{
				$categoryExtendObj  = new IModel('category_extend');
				$categoryExtendList = $categoryExtendObj->query("category_id in (".$defaultWhere['category_extend'].")",'goods_id');
				foreach($categoryExtendList as $val)
				{
					$currentCatGoods[] = $val['goods_id'];
				}

				if($GoodsId)
				{
					$GoodsId = array_intersect($currentCatGoods,$GoodsId);
				}
				else
				{
					$GoodsId = $currentCatGoods;
				}

				$GoodsId = empty($GoodsId) ? array(0) : $GoodsId;
			}
		}
		else if($defaultWhere != '')
		{
			$where .= ' and '.$defaultWhere;
		}

		if($GoodsId)
		{
			$where .= " and go.id in (".join(',',$GoodsId).") ";
		}

		//(4),商品价格
		$where.= floatval(IReq::get('min_price')) ? ' and go.sell_price >= '.floatval(IReq::get('min_price')) : '';
		$where.= floatval(IReq::get('max_price')) ? ' and go.sell_price <= '.floatval(IReq::get('max_price')) : '';

		//(5),商品品牌
		$where.= intval(IReq::get('brand'))       ? ' and go.brand_id = '.intval(IReq::get('brand')) : '';

		//排序类别
		$order = IReq::get('order');
		if($order == null)
		{
			$order = isset($site_config['order_by'])?$site_config['order_by']:'new';
			$asc   = isset($site_config['order_type'])?$site_config['order_type']:'desc';
		}
		else
		{
			if(stripos($order,'_toggle'))
			{
				$order = str_replace('_toggle','',$order);
				$asc   = 'asc';
			}
			else
			{
				$order = IFilter::act($order);
				$asc   = 'desc';
			}
		}

		switch($order)
		{
			//销售量
			case "sale":
			{
				$goodsObj->join   = ' left join order_goods as ord on (go.id = ord.goods_id) ';
				$goodsObj->fields.= ' , sum(ord.goods_nums) as sell_num';
				$goodsObj->order  = ' sell_num '.$asc;
				$goodsObj->group  = ' go.id ';
			}
			break;

			//评分
			case "cpoint":
			{
				$goodsObj->join   = ' left join comment as co on (go.id = co.goods_id) ';
				$goodsObj->fields.= ' ,sum(co.point) as sum_point ';
				$goodsObj->order  = ' sum_point '.$asc;
				$goodsObj->group  = 'go.id';
			}
			break;

			//最新上架
			case "new":
			{
				$goodsObj->order = ' go.id '.$asc;
			}
			break;

			//价格
			case "price":
			{
				$goodsObj->order = ' go.sell_price '.$asc;
			}
			break;
		}

		//设置IQuery类的各个属性
		$goodsObj->where = $where;
		$goodsList = $goodsObj->find();

		//拼接goodsID
		$goodsIdArray = array();
		foreach($goodsList as $val)
		{
			$goodsIdArray[] = $val['id'];
		}
		$goodsIdStr= join(',',$goodsIdArray);

		//查找订单和评论
		$resultArray = array();
		if(!empty($goodsIdArray))
		{
			/*由于 sale 的排序的方式会查询 order_goods 所以当 order 为 sale 方式时可以不必查询 order_goods */
			if($order != 'sale')
			{
				//订单对象
				$orderObj   = new IQuery('order_goods as ord');
				$orderObj->fields  = 'ord.goods_id , sum(ord.goods_nums) as sell_num';
				$orderObj->where   = 'goods_id in ('.$goodsIdStr.')';
				$orderObj->group   = 'ord.goods_id';
				$orderList = $orderObj->find();
				foreach($orderList as $val)
				{
					$resultArray[$val['goods_id']]['sell_num'] = $val['sell_num'];
				}
			}

			//评论对象
			$commentObj = new IQuery('comment as co');
			$commentObj->fields = 'co.goods_id , count(*) as comments_num , sum(co.point) / count(co.goods_id) as average_point';
			$commentObj->where  = ' goods_id in ('.$goodsIdStr.') and co.status = 1 ';
			$commentObj->group  = 'co.goods_id';
			$commentList = $commentObj->find();
			foreach($commentList as $val)
			{
				$resultArray[$val['goods_id']]['comments_num']  = $val['comments_num'];
				$resultArray[$val['goods_id']]['average_point'] = $val['average_point'];
			}

			//拼接goodsList中
			foreach($goodsList as $key => $val)
			{
				if($order != 'sale')
				{
					$sellNum = isset($resultArray[$val['id']]['sell_num'])     ? $resultArray[$val['id']]['sell_num']     : 0;
					$goodsList[$key]['sell_num'] = $sellNum;
				}

				//拼接评论和积分数据
				$commentsNum   = isset($resultArray[$val['id']]['comments_num'])  ? $resultArray[$val['id']]['comments_num']  : 0;
				$average_point = isset($resultArray[$val['id']]['average_point']) ? $resultArray[$val['id']]['average_point'] : 0;
				$goodsList[$key]['comments_num']  = $commentsNum;
				$goodsList[$key]['average_point'] = $average_point;
			}
		}
		return $goodsList;
	}

	//品牌专区
	function brand_zone()
	{
		$this->brand_id = intval(IReq::get('id'));
		if($this->brand_id == 0)
		{
			IError::show(404);
		}
		$brandObj = new IModel('brand');
		$this->brandRow = $brandObj->getObj('id = '.$this->brand_id);

		$return = $this->goodsListFilter();
		$this->show_type       = $return['show_type'];
		$this->listImageWidth  = $return['listImageWidth'];
		$this->listImageHeight = $return['listImageHeight'];
		$this->order           = $return['order'];
		$this->orderArray      = $return['orderArray'];

		$this->redirect('brand_zone');
	}

	//咨询
	function consult()
	{
		$this->goods_id = intval(IReq::get('id'));
		$this->callback = IReq::get('callback');
		if($this->goods_id == 0)
		{
			IError::show(403,'缺少商品ID参数');
		}

		$goodsObj   = new IModel('goods');
		$goodsRow   = $goodsObj->getObj('id = '.$this->goods_id);

		//获取次商品的评论数和平均分(保留小数点后一位)
		$commentObj = new IModel('comment');
		$commentRow = $commentObj->getObj('goods_id = '.$this->goods_id,'count(*) as comments,sum(`point`)/count(*) as apoint');
		$goodsRow['apoint']   = round($commentRow['apoint'],1);
		$goodsRow['comments'] = $commentRow['comments'];

		$this->goodsRow = $goodsRow;
		$this->redirect('consult');
	}

	//咨询动作
	function consult_act()
	{
		$goods_id   = intval(IReq::get('goods_id','post'));
		$captcha    = IReq::get('captcha','post');
		$question   = IFilter::act(IReq::get('question','post'));
		$type       = intval(IReq::get('type'));
		$callback   = IReq::get('callback');
		$message    = '';

    	if($captcha != ISafe::get('Captcha'))
    	{
    		$message = '验证码输入不正确';
    	}
    	else if(!trim($question))
    	{
    		$message = '咨询内容不能为空';
    	}
    	else if($goods_id == 0)
    	{
    		$message = '商品ID不能为空';
    	}
    	else
    	{
    		$goodsObj = new IModel('goods');
    		$goodsRow = $goodsObj->getObj('id = '.$goods_id);
    		if(empty($goodsRow))
    		{
    			$message = '不存在此商品';
    		}
    	}

    	if($message != '')
    	{
    		$this->callback = $callback;
    		$this->goods_id = $goods_id;
    		$dataArray = array(
    			'type'     => $type,
    			'question' => $question,
    		);
    		$this->consultRow = $dataArray;

			//渲染goods数据
			$goodsObj   = new IModel('goods');
			$goodsRow   = $goodsObj->getObj('id = '.$this->goods_id);

			//获取次商品的评论数和平均分(保留小数点后一位)
			$commentObj = new IModel('comment');
			$commentRow = $commentObj->getObj('goods_id = '.$this->goods_id,'count(*) as comments,sum(`point`)/count(*) as apoint');
			$goodsRow['apoint']   = round($commentRow['apoint'],1);
			$goodsRow['comments'] = $commentRow['comments'];
			$this->goodsRow = $goodsRow;

    		$this->redirect('consult',false);
    		Util::showMessage($message);
    	}
    	else
    	{
			$dataArray = array(
				'question' => $question,
				'goods_id' => $goods_id,
				'user_id'  => isset($this->user['user_id']) ? $this->user['user_id'] : 0,
				'time'     => ITime::getDateTime(),
				'type'     => $type,
			);

			$referObj = new IModel('refer');
			$referObj->setData($dataArray);
			$referObj->add();

			$this->redirect('success?callback=/site/products/id/'.$goods_id);
    	}
	}

	//公告详情页面
	function notice_detail()
	{
		$this->notice_id = IFilter::act(IReq::get('id'),'int');
		if($this->notice_id == '')
		{
			IError::show(403,'缺少公告ID参数');
		}
		else
		{
			$noObj           = new IModel('announcement');
			$this->noticeRow = $noObj->getObj('id = '.$this->notice_id);
			if(empty($this->noticeRow))
			{
				IError::show(403,'公告信息不存在');
			}
			$this->redirect('notice_detail');
		}
	}

	//咨询详情页面
	function article_detail()
	{
		$this->article_id = IFilter::act(IReq::get('id'),'int');
		if($this->article_id == '')
		{
			IError::show(403,'缺少咨询ID参数');
		}
		else
		{
			$articleObj       = new IModel('article');
			$this->articleRow = $articleObj->getObj('id = '.$this->article_id);
			if(empty($this->articleRow))
			{
				IError::show(403,'资讯文章不存在');
				exit;
			}

			//关联商品
			$relationObj = new IQuery('relation as r');
			$relationObj->join   = ' left join goods as go on r.goods_id = go.id ';
			$relationObj->where  = ' r.article_id = '.$this->article_id.' and go.id is not null ';

			$this->relationList  = $relationObj->find();
			$this->redirect('article_detail');
		}
	}

	//商品展示
	function products()
	{
		$date = array();
		//接收商品id
		if(IReq::get('id') === null)
		{
			IError::show(403,"传递的参数不正确");
		}
		$goods_id = IFilter::act(IReq::get('id'),'int');
		//使用商品id获得商品信息
		$tb_goods = new IModel('goods');
		$goods_info = $tb_goods->query('id='.$goods_id." AND is_del=0");
		if(count($goods_info)>0)
		{
			$date = $goods_info[0];
			$date['content1'] = $goods_info[0]['content'];
			//品牌名称
			$tb_brand = new IModel('brand');
			$brand_info = $tb_brand->query('id='.$date['brand_id']);
			if(count($brand_info)>0)
			{
				$date['brand'] = $brand_info[0]['name'];
			}
		}
		else
		{
			IError::show(403,"这件商品不存在");
		}
		//获取商品分类
		$categoryObj = new IModel('category_extend as ca,category as c');
		$categoryRow = $categoryObj->getObj('ca.goods_id = '.$goods_id.' and ca.category_id = c.id','c.id,c.name');
		$date['category'] =$categoryRow;

		//获得省份
		$tb_areas = new IQuery('areas');
		$tb_areas->where = 'parent_id=0';
		$areas_info = $tb_areas->find();
		$date['city'] = $areas_info;
		//获得规格
		$tb_goods_attribute = new IQuery('goods_attribute');
		$tb_goods_attribute->fields=' spec_id ';
		$tb_goods_attribute->group=' spec_id ';
		$tb_goods_attribute->where=" goods_id='".$goods_id."' and spec_id!='' ";
		$attribute_info = $tb_goods_attribute->find();
		if(count($attribute_info)>0)
		{
			$spec_ids = array();
			$i = 0;
			$tb_attribute = new IQuery('goods_attribute');
			$ids = '';
			foreach ($attribute_info as $value)
			{
				$tb_attribute->fields = ' spec_value,spec_id ';
				$tb_attribute->where = ' goods_id='.$date['id'].' and spec_id='.$value['spec_id'];
				$tb_info = $tb_attribute->find();
				$spec_ids[$i]['value']=$tb_info;
				//获得规格名
				$tb_spec = new IQuery('spec');
				$tb_spec->fields = 'name';
				$tb_spec->where = 'id='.$value['spec_id'];
				$spec_info = $tb_spec->find();
				if(count($spec_info)>0)
				{
					$spec_ids[$i]['name'] = $spec_info[0]['name'];
				}
				$i++;
				$ids .= $value['spec_id'].',';
			}
			$date['spec_ids'] = $spec_ids;
			$date['ids'] = $ids;
		}
		//商品图片
		$tb_goods_photo = new IQuery('goods_photo_relation as g');
		$tb_goods_photo->fields = 'p.id AS photo_id,p.img ';
		$tb_goods_photo->join = 'left join goods_photo as p on p.id=g.photo_id ';
		$tb_goods_photo->where =' g.goods_id='.$goods_id;
		$photo_info = $tb_goods_photo->find();

		//清除已经不存在的图片
		foreach($photo_info as $key=>$value)
		{
			if(!isset($value['photo_id']) || !isset($value['img']) || $value['photo_id']==null || $value['img']==null )
			{
				unset($photo_info[$key]);
			}

			$absolute_img=IWeb::$app->getBasePath();
			$absolute_img=$absolute_img."./".$value['img'];
			if(!file_exists($absolute_img) )
			{
				unset($photo_info[$key]);
			}
		}

		if(count($photo_info)>0)
		{
			//把默认图片调到第一个
			$goods_img = $goods_info[0]['img'];
			$tmp=array();
			foreach($photo_info as $key=>$value)
			{
				if($value['img']==$goods_img)
				{
					$tmp[] = $value;
					unset($photo_info[$key]);
				}
			}
			$tmp = array_merge($tmp,$photo_info);

			$photo_info = $tmp;
		}
		$date['photo']=$photo_info;
		//商品是否参加活动 ---抢购
		$date['active'] = IReq::get('promo') ? IReq::get('promo') : '';
		if($date['active'])
		{
			//商品参加活动 ---抢购
			$tb_promotion = new IQuery('promotion as p');
			$tb_promotion->fields = ' award_value,end_time,user_group ';
			$tb_promotion->where = 'type=1 and `condition`='.$goods_id.' and  NOW() between start_time and end_time';
			$promotion_info = $tb_promotion->find();
			if(count($promotion_info)>0)
			{
				$date['promotion']=$promotion_info[0];
			}
			//商品是否参加活动 ---团购
			$tb_regiment = new IQuery('regiment');
			$tb_regiment->fields = 'id,start_time,end_time,regiment_price,least_count,store_nums';
			$tb_regiment->where = 'goods_id = '.$goods_id.' and NOW() between start_time and end_time';
			$regiment_info = $tb_regiment->find();
			if(count($regiment_info)>0)
			{
				$date['regiment'] = $regiment_info[0];
			}
		}
		//获得扩展属性
		$tb_attribute_goods = new IQuery('goods_attribute as g ');
		$tb_attribute_goods->join = 'left join attribute as a on a.id=g.attribute_id ';
		$tb_attribute_goods->fields=' a.name,g.attribute_value ';
		$tb_attribute_goods->where=" goods_id='".$goods_id."' and attribute_id!=''";
		$attribute_goods_info = $tb_attribute_goods->find();
		$date['attribute'] = $attribute_goods_info;
		//用户最终购买
		$tb_good = new IQuery('order_goods as og ');
		$tb_good->fields = 'DISTINCT o.user_id';
		$tb_good->join = ' left join order as o on og.order_id=o.id ';
		$tb_good->where = 'og.goods_id='.$goods_id;
		$good_info = $tb_good->find();
		$date['shop_goods'] = '';
		if(count($good_info)>0){
			foreach ($good_info as $value)
			{
				if(!isset($value['user_id']))
				{
					$date['shop_goods'] .= '0,';
				}
				else
				{
					$date['shop_goods'] .= $value['user_id'].',';
				}
			}
			$date['shop_goods'] = substr($date['shop_goods'],0,-1);
		}
		else
		{
			$date['shop_goods'] = '0';
		}
		//评论
		$tb_comment = new IQuery('comment');
		$tb_comment->fields = ' sum(point) as po ,count(id) as numbers ';
		$tb_comment->where = 'goods_id='.$goods_id.' and status=1';
		$comment_info =$tb_comment->find();
		$date['comment_point']=0;
		$date['comment_num']=0;
		if(count($comment_info)>0)
		{
			$date['comment_point'] = $comment_info[0]['po'];
			$date['comment_num'] = $comment_info[0]['numbers'];
		}
		//购买记录
		$tb_shop = new IQuery('order_goods as og');
		$tb_shop->join = 'left join order as o on o.id=og.order_id';
		$tb_shop->fields = 'sum(goods_nums) as numb';
		$tb_shop->where = 'og.goods_id='.$goods_id.' and o.status = 5 and (to_days(now())-to_days(o.completion_time)) < 31';
		$shop_info = $tb_shop->find();
		$date['shop_num']=0;
		if(isset($shop_info[0]['numb'])>0){
			$date['shop_num'] = $shop_info[0]['numb'];
		}
		//购买前咨询
		$tb_refer = new IQuery('refer');
		$tb_refer->fields = 'count(id) as rid';
		$tb_refer->where = 'goods_id='.$goods_id;
		$refeer_info = $tb_refer->find();
		$date['refer'] = 0;
		if(count($refeer_info)>0){
			$date['refer'] = $refeer_info[0]['rid'];
		}
		//网友讨论
		$tb_discussion = new IQuery('discussion');
		$tb_discussion->fields = 'count(id) as did';
		$tb_discussion->where = 'goods_id='.$goods_id;
		$discussion_info = $tb_discussion->find();
		$date['discussion'] = 0;
		if(count($discussion_info)>0){
			$date['discussion'] = $discussion_info[0]['did'];
		}
		//获得登陆用户id
		$date['u_id'] = ISafe::get('user_id');
		//获得商品的最大值和最小值
		$tb_product = new IQuery('products');
		$tb_product->fields = 'max(sell_price) as ma ,min(sell_price) as mi,max(market_price) as mpa,min(market_price) as mpi';
		$tb_product->where = 'goods_id='.$goods_id;
		$product_info = $tb_product->find();
		$date['ma'] = '';
		$date['mi'] = '';
		$date['mpa'] = '';
		$date['mpi'] = '';
		if(count($product_info)>0)
		{
			$date['ma'] = $product_info[0]['ma'];
			$date['mi'] = $product_info[0]['mi'];
			$date['mpa'] = $product_info[0]['mpa'];
			$date['mpi'] = $product_info[0]['mpi'];
		}
		//url
		$date['url'] = IUrl::creatUrl();
		//获得会员价
		if($date['u_id'])
		{
			$tb_group_price = new IQuery('group_price as g');
			$tb_group_price->join = 'left join member as m on m.group_id=g.group_id';
			$tb_group_price->fields = 'g.price';
			$tb_group_price->where = 'g.goods_id='.$goods_id.' and g.products_id=0 and m.user_id='.$date['u_id'];
			$group_price_info = $tb_group_price->find();
			$date['group_price'] = 0;
			if(count($group_price_info)>0)
			{
				$date['group_price'] = $group_price_info[0]['price'];
			}
			else
			{
				//如果没有添加会员价格，则查看是否有折扣率
				$u_query = new IQuery('user_group as u');
				$u_query->join = 'left join member as m on m.group_id=u.id ';
				$u_query->where= 'm.user_id='.$date['u_id'];
				$user_info = $u_query->find();
				if(count($user_info)>0)
				{
					$date['group_price'] = $date['sell_price']*($user_info[0]['discount']/100);
				}
			}
		}

		//增加浏览次数
		if(!ISafe::get('visit'.$goods_id))
		{
			$tb_goods->setData(array('visit' => 'visit + 1'));
			$tb_goods->update('id = '.$goods_id,'visit');
			ISafe::set('visit'.$goods_id,'1');
		}

		$this->setRenderData($date);
		$this->redirect('products');
	}
	//商品讨论
	function discussion()
	{
		$goods_id = IFilter::act(IReq::get('id'));
		$receive  = IFilter::act(IReq::get('receive'));
		$captcha  = IReq::get('captcha');
		$return   = array('isError' => true , 'message' => '发生错误');

		if(!$this->user['user_id'])
		{
			$return['message'] = '请先登录系统';
		}
    	else if($captcha != ISafe::get('Captcha'))
    	{
    		$return['message'] = '验证码输入不正确';
    	}
    	else if(trim($receive) == '')
    	{
    		$return['message'] = '内容不能为空';
    	}
    	else
    	{
    		$return['isError'] = false;

    		//获取用户信息
			$memberObj = new IModel('member');
			$memberRow = $memberObj->getObj('user_id = '.$this->user['user_id'],'group_id');
			$return['user_name'] = $this->user['username'];
			if($memberRow['group_id'] != '')
			{
				$groupObj = new IModel('user_group');
				$groupRow = $groupObj->getObj('id = '.$memberRow['group_id'],'group_name');
				$return['group_name'] = isset($groupRow['group_name']) ? $groupRow['group_name'] : '';
			}

			//插入讨论表
			$tb_discussion = new IModel('discussion');
			$dataArray     = array(
				'goods_id' => $goods_id,
				'user_id'  => $this->user['user_id'],
				'time'     => date('Y-m-d H:i:s'),
				'contents' => $receive,
			);
			$tb_discussion->setData($dataArray);
			$tb_discussion->add();

			$return['time']    = $dataArray['time'];
    	}
    	echo JSON::encode($return);
	}
	//根据md5值确定products——id
	function spec_md5()
	{
		$cid = IFilter::act(IReq::get('cid'));
		$cidArray = explode(',',trim($cid,','));
		sort($cidArray);

		$gid =IFilter::act( IReq::get('gid') );
		$tb_products = new IModel('products');
		$procducts_info = $tb_products->query(" goods_id='".$gid."' and spec_md5='".md5(serialize($cidArray))."'");
		//获得货品的会员价格
		$user_id = ISafe::get('user_id');
		$group_price = 0;
		if($user_id)
		{
			$tb_group_price = new IQuery('group_price as g');
			$tb_group_price->join = 'left join member as m on m.group_id=g.group_id';
			$tb_group_price->fields = 'g.price';
			$tb_group_price->where = 'g.goods_id='.$gid.' and g.products_id='.$procducts_info[0]['id'].' and m.user_id='.$user_id;
			$group_price_info = $tb_group_price->find();
			if(count($group_price_info)>0)
			{
				$group_price = $group_price_info[0]['price'];
			}
		}
		$pid=0;
		if(count($procducts_info)>0){
			$pid = $procducts_info[0]['id'].','.$procducts_info[0]['sell_price'].','.$procducts_info[0]['market_price'].','.$procducts_info[0]['store_nums'].','.$procducts_info[0]['products_no'].','.$group_price;
		}
		echo $pid;
	}

	//顾客评论
	function comment_ajax()
	{
		$this->layout = '';
		$this->redirect('comment_ajax');
	}

	//评论列表页
	function comments_list()
	{
		$id= intval(IReq::get("id") );
		$type_config=array('bad'=>'1','middle'=>'2,3,4','good'=>'5');
		$type=IReq::get("type");
		if(!isset($type_config[$type]))
			$type=null;
		else
			$type=$type_config[$type];


		$data['comment_list']=array();

		$query=new IQuery("comment AS a");
		$query->fields = "a.*,b.username,b.head_ico";
		$query->join = "left join user AS b ON a.user_id=b.id";
		$query->where = " a.goods_id = {$id} ";
		if($type!==null)
			$query->where = " a.goods_id={$id} AND a.status=1  AND a.point IN ($type)";
		else
			$query->where = "a.goods_id={$id} AND a.status=1 ";
		$query->order = "a.id DESC";
		$query->page = IReq::get('page')?intval(IReq::get('page')):1;
		$query->pagesize = 10;
		$data['comment_list']=$query->find();
		$this->comment_query=$query;

		if($data['comment_list'])
		{
			$user_ids = array();
			foreach($data['comment_list'] as $value)
			{
				$user_ids[]=$value['user_id'];
			}
			$user_ids = implode(",", array_unique( $user_ids ) );
			$query = new IQuery("member AS a");
			$query->join = "left join user_group AS b ON a.user_id IN ({$user_ids}) AND a.group_id=b.id";
			$query->fields="a.user_id,b.group_name";
			$user_info = $query->find();
			$user_info = Util::array_rekey($user_info,'user_id');

			foreach($data['comment_list'] as $key=>$value)
			{
				$data['comment_list'][$key]['user_group_name']=isset($user_info[$value['user_id']]['group_name']) ? $user_info[$value['user_id']]['group_name'] : '';
			}
		}

		$data=array_merge($data, Comment_Class::get_comment_info($id) );
		$this->data=$data;
		$this->redirect('comments_list');
	}

	//提交评论页
	function comments()
	{
		if(IReq::get('id') === null )
		{
			IError::show(403,"传递的参数不完整");
		}

		$id = intval(IReq::get('id'));

		if(!isset($this->user['user_id']) || $this->user['user_id']===null )
		{
			IError::show(403,"登录后才允许评论");
		}

		$can_submit = Comment_Class::can_comment($id,$this->user['user_id']);
		if($can_submit[0]==-1)
		{
			IError::show(403,"没有这条数据");
		}

		$this->can_submit = $can_submit[0]==1;
		$this->comment=$can_submit[1];
		$this->comment_info = Comment_Class::get_comment_info($this->comment['goods_id'] );
		$this->redirect("comments");
	}

	function comment_add()
	{
		if(!isset($this->user['user_id']) || $this->user['user_id']===null )
			die("未登录用户不能评论");

		if(IReq::get('id')===null )
			die("传递的参数不完整");
		$id = intval(IReq::get('id'));

		$data['point'] = intval(IReq::get('point','post'));
		$data['contents'] = IReq::get("contents",'post');
		$data['contents'] = htmlspecialchars($data['contents'],ENT_QUOTES);
		$data['status'] = 1;

		if($data['point']==0)
		{
			die("请选择分数");
		}

		$can_submit = Comment_Class::can_comment( $id,$this->user['user_id'] );
		if($can_submit[0]!=1)
		{
			die("您不能评论此件商品");
		}

		$data['comment_time'] = date("Y-m-d",ITime::getNow());
		$tb_comment = new IModel("comment");
		$tb_comment->setData($data);
		$re=$tb_comment->update("id={$id}");
		if($re)
			echo "success";
		else
			die("评论失败");
	}

	function pic_show()
	{
		$this->layout="";
		$this->redirect("pic_show");
	}

	function help()
	{
		$id = intval(IReq::get("id"));
		$tb_help = new IModel("help");
		$help_row = $tb_help->query("id={$id}");
		if(!$help_row || !is_array($help_row))
		{
			IError::show(404,"您查找的页面已经不存在了");
		}
		$this->help_row = end( $help_row );

		$tb_help_cat = new IModel("help_category");
		$cat_row = $tb_help_cat->query("id={$this->help_row['cat_id']}");
		$this->cat_row = end($cat_row);
		$this->redirect("help");
	}

	function help_list()
	{
		$id = intval(IReq::get("id"));
		$tb_help_cat = new IModel("help_category");
		$cat_row = $tb_help_cat->query("id={$id}");
		if($cat_row)
		{
			$this->cat_row = end($cat_row);
		}
		else
		{
			$this->cat_row = array('id'=>0,'name'=>'站点帮助');
		}
		$this->redirect("help_list");
	}

	function groupon()
	{
		/**
		 * 团购清理
		 */
		$t=regiment::time_limit();
		$join_time=time()-$t*60;
		$join_time=date("Y-m-d H:i:s",$join_time);
		$tb = new IModel("regiment_user_relation");
		$list = $tb->query("join_time<'{$join_time}'");
		$order_no = array();
		if($list)
		{
			foreach($list as $key=>$value)
			{
				if($value['order_no']!="")
				{
					$order_no[] = trim($value['order_no']);
				}
			}
			$order_no=array_unique($order_no);
			//找出没有付款的订单
			$order_no="'".implode("','",$order_no)."'";
			$tb = new IModel("order");
			$tb->setData(array('if_del'=>1));
			$list = $tb->update("pay_status=0 AND order_no IN ({$order_no})");
		}
		/**
		 * 团购清理结束
		 */

		$id = IReq::get("id");
		$regiment_list = Regiment::getList($id);
		$regiment_list = $regiment_list['list'];
		$i = 1;
		foreach($regiment_list as $key => $value)
		{
			$regiment_list[$key]['order_num'] = sprintf("%02s",$i);
			$i++;
		}
		$this->regiment_list = $regiment_list;

		//往期团购
		$this->ever_list = Regiment::getEverList();
		$this->redirect("groupon");
	}

	function groupon_list()
	{
		$page = intval(IReq::get("page"));
		if($page===null)
		{
			$page=1;
		}

		$re = Regiment::getEverListByPage($page);
		$this->list = $re['list'];
		$this->query = $re['query'];
		$this->redirect("groupon_list");
	}

	function groupon_join()
	{
		$id = intval(IReq::get("id"));
		if($id===null)
		{
			$re = array('flag'=>false,'data'=>'没有这条数据');
			die( JSON::encode($re) );
		}

		$re = Regiment::join($id,isset($this->user['user_id'])?$this->user['user_id']:null );

		die( JSON::encode( $re ) );
	}

	//退订电子订阅
	function unsubscribe_act()
	{
		$email = IFilter::act(IReq::get('email'),'string');
		if($email==null)
		{
			die("请填写完整的数据");
		}
		$re = Subscribe::unsubscribe($email,$content);
		if($re['flag']==true)
			die('success');
		die($re['data']);
	}

	function ad_position_info()
	{
		$data=array('flag'=>false,'data'=>'');
		$id = IReq::get("id");
		if($id===null)
		{
			$data['data']="参数不完整";
			echo JSON::encode($data);
			die();
		}
		$id = intval($id);

		$tb = new IModel("ad_position");
		$re = $tb->query("id={$id} AND `status`=1");
		if(!$re)
		{
			echo JSON::encode($data);
			die();
		}
		$re = end($re);
		$data['data'] = $re;
		$data['flag'] = true;
		echo JSON::encode($data);
		die();
	}

	function ad_list()
	{
		$data = array('flag'=>false,'data'=>'');
		$id = IReq::get('id');
		if($id===null)
		{
			die( JSON::encode($data)  );
		}
		$id = intval($id);

		$now = date("Y-m-d H:i:s", ITime::getNow()   );
		$tb = new IModel("ad_manage");
		$re = $tb->query("position_id={$id} AND start_time < '{$now}' AND end_time > '{$now}' ORDER BY `order` ASC ");
		if(!$re)
		{
			echo JSON::encode($data);
			die();
		}
		$data['flag']=true;
		$data['data']=$re;
		echo JSON::encode($data );
		die();
	}
}
