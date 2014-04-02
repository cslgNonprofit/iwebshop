<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file article.php
 * @brief 商品删除
 * @author relay
 * @date 2011-04-27
 * @version 0.6
 */
class goods_class
{
	/**
	* @brief 删除与商品相关表中的数据
	*/
	public function del($goods_id)
	{
		//删除推荐类商品
		$tb_commend_goods = new IModel('commend_goods');
		$commend_goods_info = $tb_commend_goods->query('goods_id = '.$goods_id);
		if(count($commend_goods_info)>0)
		{
			$tb_commend_goods->del('goods_id = '.$goods_id);
		}
		//删除商品公用属性
		$tb_goods_attribute = new IModel('goods_attribute');
		$goods_attribute_info = $tb_goods_attribute->query('goods_id = '.$goods_id);
		if(count($goods_attribute_info)>0)
		{
			$tb_goods_attribute->del('goods_id = '.$goods_id);
		}
		//删除相册商品关系表
		$tb_goods_relation = new IModel('goods_photo_relation');
		$goods_relation_info = $tb_goods_relation->query('goods_id = '.$goods_id);
		if(count($goods_relation_info)>0)
		{
			$tb_goods_relation->del('goods_id = '.$goods_id);
		}
		//删除货品表
		$tb_products = new IModel('products');
		$products_info = $tb_products->query('goods_id = '.$goods_id);
		if(count($products_info)>0)
		{
			$tb_products->del('goods_id = '.$goods_id);
		}
		//删除会员价格表
		$tb_group_price = new IModel('group_price');
		$group_price_info = $tb_group_price->query('goods_id = '.$goods_id);
		if(count($group_price_info)>0)
		{
			$tb_group_price->del('goods_id = '.$goods_id);
		}
		//删除扩展商品分类表
		$tb_cate_extend = new IModel('category_extend');
		$cate_extend_info = $tb_cate_extend->query('goods_id='.$goods_id);
		if(count($cate_extend_info)>0)
		{
			$tb_cate_extend->del('goods_id='.$goods_id);
		}
		//删除商品表
		$tb_goods = new IModel('goods');
		$tb_goods ->del('id='.$goods_id);
	}
	/**
	 * 修改商品
	 */
	public function edit($type,$goods_info)
	{
		$data = array();

		$data['goods_id'] = $type['gid'];
		$data['form'] = array(
			'goods_name'	=>	$goods_info['name'],
			'goods_no'		=>	$goods_info['goods_no'],
			'goods_model'	=>	$goods_info['model_id'],
			'brand_id'		=>	$goods_info['brand_id'],
			'is_del'        =>  $goods_info['is_del'],
			'up_time'		=>	$goods_info['up_time'],
			'down_time'		=>	$goods_info['down_time'],
			'sell_price'	=>	$goods_info['sell_price'],
			'market_price'	=>	$goods_info['market_price'],
			'cost_price'	=>	$goods_info['cost_price'],
			'store_nums'	=>	$goods_info['store_nums'],
			'weight'		=>	$goods_info['weight'],
			'unit'			=>	$goods_info['unit'],
			'point'			=>	$goods_info['point'],
			'focus_photo'	=>	$goods_info['img'],
			'content'		=>	$goods_info['content'],
			'seo_keywords'	=>	$goods_info['keywords'],
			'seo_description'=> $goods_info['description'],
			'sort'			=>  $goods_info['sort'],
			'exp'			=>  $goods_info['exp'],
			'spec_array'	=>	$goods_info['spec_array'],
			'keywords_for_search' =>array()
		);

		$data['admin_name'] = $type['admin_name'];
		$data['admin_pwd']  = $type['admin_pwd'];

		//获得配置文件中的数据
		$config = new Config("site_config");
		$config_info = $config->getInfo();
 		$show_thumb_width  = isset($config_info['show_thumb_width'])  ? $config_info['show_thumb_width']  : 85;
		$show_thumb_height = isset($config_info['show_thumb_height']) ? $config_info['show_thumb_height'] : 85;
	 	//show
	 	$show_img = '_'.$show_thumb_width.'_'.$show_thumb_height;
		$data['form']['thumb'] = $show_img;
		//获取keywords信息
		$obj = new IModel('goods_keywords');
		$keywords_for_search = $obj->getObj('goods_id='.$type['gid']);
		if($keywords_for_search)
		{
			$data['form']['keywords_for_search'] = explode(",",$keywords_for_search['keywords']);
		}


		//加载推荐类型
		$tb_commend_goods = new IModel('commend_goods');
		$commend_goods = $tb_commend_goods->query('goods_id='.$type['gid']);
		$data['commend_goods'] = '';
		if(count($commend_goods)>0)
		{
			foreach ($commend_goods as $value)
			{
				$data['commend_goods'] .= $value['commend_id'];
			}
		}
		//加载分类
		$tb_category = new IModel('category');
		$data['category'] = $this->sortdata($tb_category->query(false,'*','sort','asc'),0,' &nbsp;&nbsp; ');
		//所有扩展属性
		$tb_attribute = new IModel('attribute');
		$attribute_info = $tb_attribute->query('model_id='.$data['form']['goods_model']);
		$data['attribute'] = $attribute_info;
		$data['attribute_ids'] = '';
		if(count($attribute_info)>0){
			foreach ($attribute_info as $value)
			{
				$data['attribute_ids'] .= $value['id'].',';
			}
			$data['attribute_ids'] = substr($data['attribute_ids'],0,-1);
		}
		//goods_attribute
		$tb_goods_attribute = new IQuery('goods_attribute');
		$tb_goods_attribute->fields = 'attribute_id,attribute_value';
		$tb_goods_attribute->where = "goods_id=".$type['gid']." and attribute_id!=''";
		$goods_attribute = $tb_goods_attribute->find();
		$data['goods_attribute'] = ',';
		if(count($goods_attribute)>0){
			foreach ($goods_attribute as $value)
			{
				$data['goods_attribute'] .= $value['attribute_id'].'|'.$value['attribute_value'].',';
			}
		}
		//相册
		$tb_goods_photo = new IQuery('goods_photo_relation as ghr');
		$tb_goods_photo->join = 'left join goods_photo as gh on ghr.photo_id=gh.id';
		$tb_goods_photo->fields = 'gh.img';
		$tb_goods_photo->where = 'ghr.goods_id='.$type['gid'];
		$tb_goods_photo->order = 'ghr.id asc';
		$goods_photo_info = $tb_goods_photo->find();
		$data['goods_photo'] = $goods_photo_info;
		if(count($goods_photo_info)>0)
		{
			$data['photo_name'] = '';
			foreach ($goods_photo_info as $value)
			{
				$data['photo_name'] .= $value['img'].',';
			}
		}
		//相册属性
		//获得配置文件中的数据
		$config = new Config("site_config");
		$config_info = $config->getInfo();
		$show_thumb_width  = isset($config_info['show_thumb_width'])  ? $config_info['show_thumb_width']  : 85;
		$show_thumb_height = isset($config_info['show_thumb_height']) ? $config_info['show_thumb_height'] : 85;
	 	$data['show_attr'] = '_'.$show_thumb_width.'_'.$show_thumb_height;
		//规格属性
		$tb_spec_attr = new IQuery('goods_attribute as ga');
		$tb_spec_attr->fields = 'ga.spec_id';
		$tb_spec_attr->group = 'spec_id';
		$tb_spec_attr->where = "goods_id=".$type['gid']." and ga.spec_id!=''";
		$spec_attr_info = $tb_spec_attr->find();
		$data['spec_attr'] = count($spec_attr_info);
		$data['spec_id'] = '';
		if(count($spec_attr_info)>0)
		{
			foreach ($spec_attr_info as $value)
			{
				$data['spec_id'] .= $value['spec_id'].',';
			}
			$data['spec_id'] = substr($data['spec_id'],0,-1);
		}
		//加载会员级别
		$tb_user_group = new IModel('user_group');
		$info = $tb_user_group->query();
		$ids = '';
		if(count($info)>0){
			foreach ($info as $value)
			{
				$ids .= $value['id'].',';
			}
			$ids = substr($ids,0,-1);
		}
		$data['ids'] = $ids;

		return $data;
	}
	/**
	 * @param
	 * @return array
	 * @brief 无限极分类递归函数
	 */
	public static function sortdata($catArray, $id = 0 , $prefix = '')
	{
		static $formatCat = array();
		static $floor     = 0;

		foreach($catArray as $key => $val)
		{
			if($val['parent_id'] == $id)
			{
				$str         = self::nstr($prefix,$floor);
				$val['name'] = $str.$val['name'];

				$val['floor'] = $floor;
				$formatCat[]  = $val;

				unset($catArray[$key]);

				$floor++;
				self::sortdata($catArray, $val['id'] ,$prefix );
				$floor--;
			}
		}
		return $formatCat;
	}

	/**
	 * @brief 计算商品的价格区间
	 * @param $catId        商品分类id
	 * @param $showPriceNum 展示分组最大数量
	 * @return array        价格区间分组
	 */
	public static function getGoodsPrice($catId,$showPriceNum = 4)
	{
		$goodsObj     = new IModel('category_extend as ca,goods as go');
		$goodsPrice   = $goodsObj->getObj('ca.category_id in ('.$catId.') and ca.goods_id = go.id','MIN(sell_price) as min,MAX(sell_price) as max');
		if($goodsPrice['min'] <= 0)
		{
			return array();
		}

		$minBit = strlen(intval($goodsPrice['min']));
		if($minBit <= 2)
		{
			$minPrice = 99;
		}
		else
		{
			$minPrice = substr(intval($goodsPrice['min']),0,1).str_repeat('9',($minBit - 1));
		}

		//商品价格计算
		$result   = array('1-'.$minPrice);
		$perPrice = floor(($goodsPrice['max'] - $minPrice)/($showPriceNum - 1));

		if($perPrice > 0)
		{
			for($addPrice = $minPrice+1; $addPrice < $goodsPrice['max'];)
			{
				$stepPrice = $addPrice + $perPrice;
				$stepPrice = substr(intval($stepPrice),0,1).str_repeat('9',(strlen(intval($stepPrice)) - 1));
				$result[]  = $addPrice.'-'.$stepPrice;
				$addPrice  = $stepPrice + 1;
			}
		}

		return $result;
	}

	//处理商品列表显示缩进
	static function nstr($str,$num=0)
	{
		$return = '';
		for($i=0;$i<$num;$i++)
		{
			$return .= $str;
		}
		return $return;
	}
}

?>