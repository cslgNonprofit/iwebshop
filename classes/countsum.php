<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file countsum.php
 * @brief 计算购物车中的商品价格
 * @author chendeshan
 * @date 2011-02-24
 * @version 0.6
 */
class CountSum
{
	/**
	 * @brief 计算商品价格
	 * @param Array $buyInfo ,购物车格式
	 * @return array or bool
	 */
	private function goodsCount($buyInfo)
	{
    	$this->weight        = 0;    //总重量
    	$this->sum           = 0;    //原始总额
    	$this->reduce        = 0;    //减少总额
    	$this->count         = 0;    //总量
    	$this->final_sum     = 0;    //应付总额
    	$this->proReduce     = 0;    //促销活动优惠额
    	$this->point         = 0;    //增加积分
    	$this->exp           = 0;    //增加经验
    	$this->isFreeFreight = false;//是否免运费

		$user_id      = ISafe::get('user_id');
		$group_id     = 0;
    	$goodsList    = array();
    	$productList  = array();

		//获取用户组ID及组的折扣率
		if($user_id != null)
		{
			$groupObj = new IModel('member as m , user_group as g');
			$groupRow = $groupObj->getObj('m.user_id = '.$user_id.' and m.group_id = g.id','g.*');
			if(!empty($groupRow))
			{
				$group_id       = $groupRow['id'];
				$group_discount = $groupRow['discount']/100;

				$groupPriceObj  = new IModel('group_price');
			}
		}

		/*开始计算goods和product的优惠信息 , 会根据条件分析出执行以下哪一种情况:
		 *(1)查看此商品(货品)是否已经根据不同会员组设定了优惠价格;
		 *(2)当前用户是否属于某个用户组中的成员，并且此用户组享受折扣率;
		 *(3)优惠价等于商品(货品)原价;
		 */

		//获取商品或货品数据
		/*Goods 拼装商品优惠价的数据*/
    	if(isset($buyInfo['goods']['id']) && !empty($buyInfo['goods']['id']))
    	{
    		//购物车中的商品数据
    		$goodsIdStr = join(',',$buyInfo['goods']['id']);
    		$goodsObj   = new IModel('goods as go');
    		$goodsList  = $goodsObj->query('go.id in ('.$goodsIdStr.')','go.name,go.id,go.list_img,go.sell_price,go.point,go.weight,go.store_nums,go.exp');

			if($group_id)
			{
				//获取 "优惠情况(1)" 中的商品优惠价格
				$discountGoodsResult = array();
	    		$discountGoodsList   = $groupPriceObj->query('products_id = 0 and goods_id in('.$goodsIdStr.') and group_id = '.$group_id);
	    		foreach($discountGoodsList as $val)
	    		{
	    			$discountGoodsResult[$val['goods_id']] = $val;
	    		}
			}

    		//开始优惠情况判断
    		foreach($goodsList as $key => $val)
    		{
    			//优惠情况(1)
    			if(isset($discountGoodsResult[$val['id']]['price']))
    			{
    				$goodsList[$key]['reduce'] = $val['sell_price'] - $discountGoodsResult[$val['id']]['price'];
    			}

    			//优惠情况(2)
    			else if(isset($group_discount) && $group_discount != 0)
    			{
    				$goodsList[$key]['reduce'] = $val['sell_price'] - $val['sell_price'] * $group_discount;
    			}

    			//优惠情况(3)
    			else
    			{
    				$goodsList[$key]['reduce'] = 0;
    			}

    			$goodsList[$key]['count'] = $buyInfo['goods']['data'][$val['id']]['count'];
    			$current_sum_all          = $goodsList[$key]['sell_price'] * $goodsList[$key]['count'];
    			$current_reduce_all       = $goodsList[$key]['reduce']     * $goodsList[$key]['count'];
    			$goodsList[$key]['sum']   = $current_sum_all - $current_reduce_all;

    			//全局统计
		    	$this->weight += $val['weight'] * $goodsList[$key]['count'];
		    	$this->point  += $val['point']  * $goodsList[$key]['count'];
		    	$this->exp    += $val['exp']    * $goodsList[$key]['count'];
		    	$this->sum    += $current_sum_all;
		    	$this->reduce += $current_reduce_all;
		    	$this->count  += $goodsList[$key]['count'];
		    }
    	}

		/*Product 拼装商品优惠价的数据*/
    	if(isset($buyInfo['product']['id']) && !empty($buyInfo['product']['id']))
    	{
    		//购物车中的货品数据
    		$productIdStr = join(',',$buyInfo['product']['id']);
    		$productObj   = new IQuery('products as pro,goods as go');
    		$productObj->where  = 'pro.id in ('.$productIdStr.') and go.id = pro.goods_id';
    		$productObj->fields = 'pro.sell_price,pro.weight,pro.id,pro.spec_array,pro.goods_id,pro.store_nums,go.name,go.point,go.exp,go.list_img';
    		$productList  = $productObj->find();

			if($group_id)
			{
				//获取 "优惠情况(1)" 中的商品优惠价格
				$discountProductResult = array();
	    		$discountProductList   = $groupPriceObj->query('products_id in ('.$productIdStr.') and group_id = '.$group_id);
	    		foreach($discountProductList as $val)
	    		{
	    			$discountProductResult[$val['goods_id']] = $val;
	    		}
			}

    		//开始优惠情况判断
    		foreach($productList as $key => $val)
    		{
    			//优惠情况(1)
    			if(isset($discountProductResult[$val['id']]['price']))
    			{
    				$productList[$key]['reduce'] = $val['sell_price'] - $discountProductResult[$val['id']]['price'];
    			}

    			//优惠情况(2)
    			else if(isset($group_discount) && $group_discount != 0)
    			{
    				$productList[$key]['reduce'] = $val['sell_price'] - $val['sell_price'] * $group_discount;
    			}

    			//优惠情况(3)
    			else
    			{
    				$productList[$key]['reduce'] = 0;
    			}

    			$productList[$key]['count'] = $buyInfo['product']['data'][$val['id']]['count'];
    			$current_sum_all            = $productList[$key]['sell_price']  * $productList[$key]['count'];
    			$current_reduce_all         = $productList[$key]['reduce']      * $productList[$key]['count'];
    			$productList[$key]['sum']   = $current_sum_all - $current_reduce_all;

    			//全局统计
		    	$this->weight += $val['weight'] * $productList[$key]['count'];
		    	$this->point  += $val['point']  * $productList[$key]['count'];
		    	$this->exp    += $val['exp']    * $productList[$key]['count'];
		    	$this->sum    += $current_sum_all;
		    	$this->reduce += $current_reduce_all;
		    	$this->count  += $productList[$key]['count'];
		    }
    	}

    	$final_sum = $this->sum - $this->reduce;

    	//总金额满足的促销规则
    	if($user_id)
    	{
	    	$proObj = new ProRule($final_sum);
	    	$proObj->setUserGroup($group_id);
	    	$this->isFreeFreight = $proObj->isFreeFreight();
	    	$this->promotion = $proObj->getInfo();
	    	$this->proReduce = $final_sum - $proObj->getSum();
    	}
    	else
    	{
	    	$this->promotion = array();
	    	$this->proReduce = 0;
    	}

    	$this->final_sum = $final_sum - $this->proReduce;

    	return array(
    		'final_sum'  => $this->final_sum,
    		'promotion'  => $this->promotion,
    		'proReduce'  => $this->proReduce,
    		'sum'        => $this->sum,
    		'goodsList'  => $goodsList,
    		'productList'=> $productList,
    		'count'      => $this->count,
    		'reduce'     => $this->reduce,
    		'weight'     => $this->weight,
    		'freeFreight'=> $this->isFreeFreight,
    		'point'      => $this->point,
    		'exp'        => $this->exp,
    	);
	}

	//购物车计算
	public function cart_count()
	{
		//获取购物车中的商品和货品信息
    	$cartObj    = new Cart();
    	$myCartInfo = $cartObj->getMyCart();

    	return $this->goodsCount($myCartInfo);
    }

    //计算非购物车中的商品
    public function direct_count($id,$type,$buy_num = 1,$promo='',$active_id='')
    {
    	/*正常购买流程*/
    	if($promo == '' || $active_id == '')
    	{
    		$buyInfo = array(
    			$type => array('id' => array($id) , 'data' => array($id => array('count' => $buy_num)),'count' => $buy_num)
    		);
    		return $this->goodsCount($buyInfo);
    	}

		/*活动购买流程*/
    	$user_id = ISafe::get('user_id') ? ISafe::get('user_id') : 0;

		//获取货品数据
		if($type == 'product')
		{
			$model      = new IModel('goods as go,products as pro');
			$productRow = $model->getObj('pro.id = '.$id.' and pro.goods_id = go.id and go.is_del = 0','pro.sell_price,pro.weight,pro.id,pro.spec_array,pro.goods_id,pro.store_nums,go.name,go.point,go.exp,go.list_img');

			if(empty($productRow))
			{
				IError::show(403,'参数错误,无法找到商品信息');
			}
			$typeRow    = $productRow;
			$goods_id   = $typeRow['goods_id'];
		}

		//获取商品数据
		else
		{
			$model      = new IModel('goods as go');
			$goodsRow   = $model->getObj('id = '.$id.' and is_del = 0','go.name,go.id,go.list_img,go.sell_price,go.point,go.weight,go.store_nums,go.exp');

			if(empty($goodsRow))
			{
				IError::show(403,'参数错误,无法找到商品信息');
			}
			$typeRow    = $goodsRow;
			$goods_id   = $id;
		}

		//库存判断
		if($buy_num <= 0 || $buy_num > $typeRow['store_nums'])
		{
			IError::show(403,'购买的数量不正确或大于商品的库存量');
			exit;
		}

		//限时抢购
		if($promo == 'time')
		{
			$promotionObj = new IModel('promotion');
			$promotionRow = $promotionObj->getObj('type = 1 and `condition` = '.$goods_id.' and NOW() between start_time and end_time and is_close = 0');
			if(!empty($promotionRow))
			{
				$memberObj    = new IModel('member');
				$memberRow    = $memberObj->getObj('user_id = '.$user_id,'group_id');
				if($promotionRow['user_group'] == 'all' || (isset($memberRow['group_id']) && stripos(','.$promotionRow['user_group'].',',$memberRow['group_id'])!==false))
				{
					$disPrice = $promotionRow['award_value'];
				}
				else
				{
					IError::show(403,'此活动仅限指定的用户组');
				}
			}
			else
			{
				IError::show(403,'不存在此限时抢购活动');
			}
		}

		//团购
		else if($promo == 'groupon')
		{
			$regimentObj = new IModel('regiment');
			$regimentRow = $regimentObj->getObj('id = '.$active_id.' and goods_id = '.$goods_id.' and NOW() between start_time and end_time and is_close = 0');
			if(!empty($regimentRow))
			{
				$disPrice = $regimentRow['regiment_price'];
			}
			else
			{
				IError::show(403,'不存在此团购活动');
			}
		}

		//没有优惠价格时为商品原价
		if(!isset($disPrice))
		{
			$disPrice = $typeRow['sell_price'];
		}

		//设置优惠价格，如果不存在则优惠价等于商品原价
		$typeRow['reduce'] = $typeRow['sell_price'] - $disPrice;
		$typeRow['count']  = $buy_num;
		$typeRow['sum']    = $disPrice * $buy_num;

		//拼接返回数据
		$result = array(
			'final_sum'   => $typeRow['sum'],
			'promotion'   => array(),
			'proReduce'   => 0,
			'sum'         => $typeRow['sell_price'] * $buy_num,
			'goodsList'   => ($type == 'goods') ? array($typeRow) : array(),
			'productList' => ($type == 'product') ? array($typeRow) : array(),
			'count'       => $buy_num,
			'reduce'      => $typeRow['reduce'] * $buy_num,
			'weight'      => $typeRow['weight'] * $buy_num,
			'point'       => $typeRow['point']  * $buy_num,
			'exp'         => $typeRow['exp']    * $buy_num,
			'freeFreight' => false,
		);

		return $result;
    }
}