<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file mess.php
 * @brief 导出csv文章
 * @author relay
 * @date 2011-07-14
 * @version 0.6
 */
class Export
{
	/**
	 *导出到CSV文件
	 * @param <array> $condition
	 */
	function export_csv($condition)
	{
		$filename = date('YmdHis').".csv";
		header("Content-type:text/csv");
		header("Content-Disposition:attachment;filename=".$filename);
		$string = Util::array2csv($this->array_to_string($condition));
		die($string);
		
	}
	/**
	 *导出数据转换
	 * @param <array> $result
	 */
	function array_to_string($result)
	{
	    if(empty($result)){
	        return $this->i("没有符合您要求的数据!");
	    }
	    $csv = array();
	    $title = array("*cols*",$this->i("商品名称"),$this->i("商品的货号"),$this->i("模型ID"),
	    $this->i("销售价格"),$this->i("市场价格"),$this->i("成本价格"),$this->i("创建时间"),$this->i("库存"),$this->i("原图"),
	    $this->i("是否删除"),$this->i("商品描述"),$this->i("SEO关键词"),$this->i("SEO描述"),$this->i("标签id"),$this->i("重量"),
	    $this->i("积分"),$this->i("计量单位"),$this->i("品牌ID"),$this->i("浏览次数"),$this->i("收藏次数"),$this->i("排序"),
	    $this->i("列表页缩略图"),$this->i("详细页缩略图"),$this->i("规格序列化"),$this->i("经验值"),$this->i("P商品ID"),$this->i("P成本价格"),
	    $this->i("PMD5"),$this->i("GPR图片ID"),$this->i("CG标签ID"),$this->i("GP会员组价格"),$this->i("CE扩展分类"),$this->i("GA属性ID"),
	    $this->i("GA属性值"),$this->i("GA规格ID"),$this->i("GA规格值")
	    );
	    $csv[] = $title;

	    foreach ($result as $value)
	    {
	    	//商品相册关联
	        $photo = '';
	        $tb_goods_photo_relation = new IModel('goods_photo_relation');
	        $goods_photo_relation = $tb_goods_photo_relation->query('goods_id='.$value);
	        if(count($goods_photo_relation)>0)
	        {
	        	foreach ($goods_photo_relation as $va)
	        	{
	        		$photo .= $va['photo_id'].',';
	        	}
	        }
	    	//推荐类商品
	        $commend_id = '';
	        $tb_commend_goods = new IModel('commend_goods');
	        $commend_goods = $tb_commend_goods->query('goods_id='.$value);
	        if(count($commend_goods)>0)
	        {
	        	foreach ($commend_goods as $va)
	        	{
	        		$commend_id .= $va['commend_id'].',';
	        	}
	        }
	    	//会员价格
	        $group = '';
	        $tb_group_price = new IModel('group_price');
	        $group_price = $tb_group_price->query('goods_id='.$value);
	        if(count($group_price)>0)
	        {
	        	foreach ($group_price as $va)
	        	{
	        		$group .= $va['products_id'].','.$va['group_id'].','.$va['price'].';';
	        	}
	        }
	        //商品扩展分类
	        $cate_extend = '';
	        $tb_cate_extend = new IModel('category_extend');
	        $cate_extend_info = $tb_cate_extend->query('goods_id='.$value);
	        if(count($cate_extend_info)>0)
	        {
	        	foreach ($cate_extend_info as $va)
	        	{
	        		$cate_extend .= $va['category_id'].'|';
	        	}
	        }
	    	//导出商品
	    	$tb_goods = new IModel('goods');
	    	$info = $tb_goods->getObj('id='.$value);
	    	
	    	$vo = array("\r\n","\n","\0");
	    	$content = str_replace($vo,"",$info['content']);
	    	$good = array("gid",$this->i($info['name']),$info['goods_no'],$info['model_id'],
		    	$info['sell_price'],$info['market_price'],$info['cost_price'],$info['create_time'],$info['store_nums'],$info['img'],
		    	$info['is_del'],$this->i($content),$this->i($info['keywords']),$this->i($info['description']),$info['tag_ids'],$info['weight'],
		    	$info['point'],$this->i($info['unit']),$info['brand_id'],$info['visit'],$info['favorite'],$info['sort'],
		    	$info['list_img'],$info['small_img'],$this->i($info['spec_array']),$info['exp'],'','',
		    	'',$photo,$commend_id,$group,$cate_extend
	    	);
	    	//商品属性表
	        $tb_goods_attribute = new IModel('goods_attribute');
	        $goods_attribute = $tb_goods_attribute->query('goods_id='.$value);
	        if(count($goods_attribute)>0)
	        {
	        	foreach ($goods_attribute as $va)
	        	{
	        		if($va['attribute_id'])
	        		{
	        			$tb_attribute = new IModel('attribute');
	        			$att_info = $tb_attribute->getObj('id='.$va['attribute_id']);
	        			if(count($att_info)>0)
	        			{
	        				$good[]='**a**'.$va['attribute_id'].'|'.$this->i($att_info['name']);
	        			}
	        			else
	        			{
	        				$good[]='**a**'.$va['attribute_id'];
	        			}
	        		}
	        		if($va['attribute_value'])
	        		{
	        			$good[]=$this->i($va['attribute_value']);
	        		}
	        		if($va['spec_id'])
	        		{
	        			$tb_spec = new IModel('spec');
	        			$spec_info = $tb_spec->getObj('id='.$va['spec_id']);
	        			if(count($spec_info)>0)
	        			{
	        				$good[]='**s**'.$va['spec_id'].'|'.$this->i($spec_info['name']);
	        			}
	        			else
	        			{
	        				$good[]='**s**'.$va['spec_id'];	
	        			}
	        		}
	        		if($va['spec_value'])
	        		{
	        			$good[]=$this->i($va['spec_value']);
	        		}
	        	}
	        }
	    	$csv[] = $good;
	        //导出货品,$va['goods_id']
	        $tb_product = new IModel('products');
	        $products_info = $tb_product->query('goods_id='.$value);
	        if(count($products_info)>0)
	        {
	        	foreach ($products_info as $va)
	        	{
	        		$product = array("pid",$va['id'],$va['products_no'],'','',
	        		$va['sell_price'],$va['market_price'],'',$va['store_nums'],'',
	        		'','','','','',$va['weight'],'','','','','','',
	        		'','',$this->i($va['spec_array']),'',$va['goods_id'],
	        		$va['cost_price'],$va['spec_md5']);
					$csv[] = $product;
	        	}
	        }
	    }
	   
	    return $csv;
	}
	/**
	 *获取导出报表的数据
	 * @param <string> $condition
	 * @return <type>
	 */
	function get_export_data($condition)
	{
	    $tb_goods = new IQuery('goods');
	    if($condition)
	    {
	    	$tb_goods->where = 'id in ('.$condition.')';
	    }
	    $goods_info = $tb_goods ->find();
	    
	    return $goods_info;
	}
	/**
	 *编码转换
	 * @param <string> $strInput
	 * @return <type>
	 */
	function i($strInput)
	{
	    return iconv('utf-8','gb2312//IGNORE',$strInput);
	}
}