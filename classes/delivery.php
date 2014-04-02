<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file article.php
 * @brief 订单中配送方式的计算
 * @author relay
 * @date 2011-02-24
 * @version 0.6
 */

class Delivery
{
	/**
	 * @param $province string 省份的id
	 * @param $weight int 货物的重量
	 * @param $goodsSum float 商品总价格
	 * @return array()
	 * @brief 配送方式计算管理模块
	 */
	static function getDelivery($province,$weight=0,$goodsSum=0)
	{
		$data = array();
		//获得配送方式表的对象
     	$delivery = new IModel('delivery');
     	//获取配送方式列表
     	$where = 'is_delete = 0 and status = 1';
     	$list = $delivery->query($where,'*','sort','asc');

     	foreach($list as $value)
     	{
     		if($value['price_type']==0)
     		{
     			//当配送方式是统一配置的时候，不进行区分地区价格
     			$data[$value['id']]['id'] = $value['id'];
     			$data[$value['id']]['name'] = $value['name'];
     			$data[$value['id']]['description'] = $value['description'];
     			$data[$value['id']]['type'] = $value['type'];
     			//获得首重和续重
     			$first_w = $value['first_weight'];
     			$secon_w = $value['second_weight'];
     			if($first_w>=$weight)
     			{
     				//当商品重量小于或等于首重的时候
     				$data[$value['id']]['price'] = $value['first_price'];
     				//判断是否能送到该地区，0为送到，1为送不到
     				$data[$value['id']]['if_delivery'] = '0';
     			}
     			else
     			{
     				//当商品重量大于首重的时候
     				$middel_w = $weight - $first_w;
     				$num = intval($middel_w / $secon_w);
     				if(($middel_w % $secon_w) > 0)
     				{
     					$num++;
     				}
     				$data[$value['id']]['price'] = (int)$value['first_price'] + (int)$value['second_price'] * $num;
     				$data[$value['id']]['if_delivery'] = '0';
     			}
     		}
     		else
     		{
     			//当配送方式为指定区域和价格的时候
     			$data[$value['id']]['id'] = $value['id'];
     			$data[$value['id']]['name'] = $value['name'];
     			$data[$value['id']]['description'] = $value['description'];
     			$data[$value['id']]['type'] = $value['type'];
     			//判断是否设置默认费用了
     			if($value['open_default']==1)
     			{
     				//启用默认费用
     				$ket_va = '';
     				$flag = false;
     				$area_groupid = unserialize($value['area_groupid']);
     				foreach ($area_groupid as $key => $va)
     				{
     					if(strpos(';;'.$va,';'.$province.';'))
     					{
     						$ket_va = $key;
     						$flag = true;
     						break;
     					}
     				}
     				//获得首重和续重
	     			$first_w = $value['first_weight'];
	     			$secon_w = $value['second_weight'];
     				if($flag)
     				{
     					//判断当用户收货地址--设置--了价格的时候
     					$firstprice = unserialize($value['firstprice']);
     					$secondprice = unserialize($value['secondprice']);
		     			if($first_w>=$weight)
		     			{
		     				//当商品重量小于或等于首重的时候
		     				$data[$value['id']]['price'] = $firstprice[$ket_va];
		     				//判断是否能送到该地区，0为送到，1为送不到
		     				$data[$value['id']]['if_delivery'] = '0';
		     			}
		     			else
		     			{
		     				//当商品重量大于首重的时候
		     				$middel_w = $weight - $first_w;
		     				$num = intval($middel_w / $secon_w);
		     				if(($middel_w % $secon_w) > 0)
		     				{
		     					$num++;
		     				}
		     				$data[$value['id']]['price'] = (int)$firstprice[$ket_va] + ((int)$secondprice[$ket_va]) * $num;
		     				$data[$value['id']]['if_delivery'] = '0';
		     			}
     				}
     				else
     				{
     					//判断当用户收货地址--没有设置--价格的时候,启用默认设置
	     				if($first_w>=$weight)
		     			{
		     				//当商品重量小于或等于首重的时候
		     				$data[$value['id']]['price'] = $value['first_price'];
		     				//判断是否能送到该地区，0为送到，1为送不到
		     				$data[$value['id']]['if_delivery'] = '0';
		     			}
		     			else
		     			{
		     				//当商品重量大于首重的时候
		     				$middel_w = $weight - $first_w;
		     				$num = intval($middel_w / $secon_w);
		     				if(($middel_w % $secon_w) > 0)
		     				{
		     					$num++;
		     				}

		     				$data[$value['id']]['price'] = (int)$value['first_price'] + (int)$value['second_price'] * $num;
		     				$data[$value['id']]['if_delivery'] = '0';
		     			}
     				}
     			}
     			else
     			{
     				//不启用默认费用
     				$ket_va = '';
     				$flag = false;
     				$area_groupid = unserialize($value['area_groupid']);
     				foreach ($area_groupid as $key => $va)
     				{
     					if(strpos(';;'.$va,';'.$province.';'))
     					{
     						$ket_va = $key;
     						$flag = true;
     						break;
     					}
     				}
     				//获得首重和续重
	     			$first_w = (int)$value['first_weight'];
	     			$secon_w = (int)$value['second_weight'];
     				if($flag)
     				{
     					//当用户收货的地址设置了价格时候
     					$firstprice = unserialize($value['firstprice']);
     					$secondprice = unserialize($value['secondprice']);
     					if($first_w>=$weight)
		     			{
		     				//当商品重量小于或等于首重的时候
		     				$data[$value['id']]['price'] = $firstprice[$ket_va];
		     			}
		     			else
		     			{
		     				//当商品重量大于首重的时候
		     				$middel_w = $weight - $first_w;
		     				$num = intval($middel_w / $secon_w);
		     				if(($middel_w % $secon_w) > 0)
		     				{
		     					$num++;
		     				}
		     				$data[$value['id']]['price'] = (int)$firstprice[$ket_va] + (int)$secondprice[$ket_va] * $num;
		     			}
		     			//判断是否能送到该地区，0为送到，1为送不到
		     			$data[$value['id']]['if_delivery'] = '0';
     				}
     				else
     				{
     					//当用户收货的地址没有设置运费的时候-----将不能使用默认价格
     					$data[$value['id']]['price'] = '0';
     					$data[$value['id']]['if_delivery'] = '1';
     				}
     			}
     		}

     		//计算保价
     		if($value['is_save_price'] == 1)
     		{
     			$tempProtectPrice = $goodsSum * ($value['save_rate']/100);
     			if($tempProtectPrice <= $value['low_price'])
     			{
     				$data[$value['id']]['protect_price'] = $value['low_price'];
     			}
     			else
     			{
     				$data[$value['id']]['protect_price'] = $tempProtectPrice;
     			}
     		}
     		else
     		{
     			$data[$value['id']]['protect_price'] = 0;
     		}
     	}
     	return $data;
	}
}