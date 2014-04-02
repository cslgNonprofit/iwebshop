<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file goods_csv.php
 * @brief csv文件导入、导出
 * @author relay
 * @date 2011-10-12
 * @version 2.1
 */

/**
 * @class IGoodsCsv
 * @brief iWebShop csv文件导入、导出
 */
class IGoodsCsv
{
	/**
	 * @brief 构造函数
	 * */
	public function __construct(){}
	/**
	 *导入CSV文件
	 * @param <文件路径> $name
	 * @param <文件标示> $mark
	 */
	function import($name,$mark)
	{
		$handle = fopen ($name,'r');
		$goods_col = array();
		$goods_col['1'] ='name';
		$goods_col['2'] ='goods_no';
		$goods_col['3'] ='model_id';
		$goods_col['4'] ='sell_price';
		$goods_col['5'] ='market_price';
		$goods_col['6'] ='cost_price';
		$goods_col['7'] ='create_time';
		$goods_col['8'] ='store_nums';
		$goods_col['9'] ='img';
		$goods_col['10'] ='is_del';
		$goods_col['11'] ='content';
		$goods_col['12'] ='keywords';
		$goods_col['13'] ='description';
		$goods_col['14'] ='tag_ids';
		$goods_col['15'] ='weight';
		$goods_col['16'] ='point';
		$goods_col['17'] ='unit';
		$goods_col['18'] ='brand_id';
		$goods_col['19'] ='visit';
		$goods_col['20'] ='favorite';
		$goods_col['21'] ='sort';
		$goods_col['22'] ='list_img';
		$goods_col['23'] ='small_img';
		$goods_col['24'] ='spec_array';
		$goods_col['25'] ='exp';

		$gid = '';
		$products_id = '';
		$total = 0;//数据总条数
		$suce = 0;//成功的总条数
		$group = array();
		$product = array();
		
		$config      = new Config("site_config");
		$config_info = $config->getInfo();

		$list_thumb_width  = isset($config_info['list_thumb_width'])  ? $config_info['list_thumb_width']  : 175;
	 	$list_thumb_height = isset($config_info['list_thumb_height']) ? $config_info['list_thumb_height'] : 175;
	 	$show_thumb_width  = isset($config_info['show_thumb_width'])  ? $config_info['show_thumb_width']  : 85;
		$show_thumb_height = isset($config_info['show_thumb_height']) ? $config_info['show_thumb_height'] : 85;
		
		while($data = fgetcsv ($handle)){
			$total++;
			$arr = array();
           	$num = count($data);
           //导入goods表
           for ($i=0; $i<$num; $i++){
           		if($i == $num){
                   break;
                }
  	           	if($data[0]=='*cols*')
	           	{
	           		break;
	           	}
	           	if($data[0] == 'gid')
	           	{
	           		if($i>0 && $i<26)
	           		{
		                $arr[$goods_col[$i]] = $this->i($data[$i]);
		                if($goods_col[$i]=='spec_array' || $goods_col[$i]=='content')
		                {
		                	$arr[$goods_col[$i]] = addslashes($arr[$goods_col[$i]]);
		                }
	           		}
	           		if($i==26)
	           		{
	           			$goods_no = $data[2];
		           		$obj_goods = new IQuery('goods');
		           		$obj_goods->fields = 'id';
		           		$obj_goods->where = "goods_no='{$goods_no}'";
		           		$goods_info = $obj_goods->find();
	           			if(file_exists($arr['img']))//判断图片是否存在
	                	{
	                		$arr['list_img'] = IImage::thumb($arr['img'],$list_thumb_width,$list_thumb_height,'_'.$list_thumb_width.'_'.$list_thumb_height);
					        $arr['small_img'] = IImage::thumb($arr['img'],$show_thumb_width,$show_thumb_height,'_'.$show_thumb_width.'_'.$show_thumb_height);
	                	}
		           		if(count($goods_info)==0 || empty($goods_no))
		           		{
		           			$tb_goods = new IModel('goods');
			           		$tb_goods->setData($arr);
			           		$gid = $tb_goods->add();
			           		$suce++; //如果新添加的，则处理图片
		           		}
		           		else
		           		{
		           			if($mark==1)
		           			{
		           				//生成新的商品
		           				$tb_goods = new IModel('goods');
				           		$tb_goods->setData($arr);
				           		$gid = $tb_goods->update('id='.$goods_info[0]['id']);
				           		$suce++;
		           			}
		           			else
		           			{
								$tb_goods = new IModel('goods');
				           		$tb_goods->setData($arr);
				           		$gid = $tb_goods->add();
				           		$suce++; //如果新添加的，则处理图片
		           			}
		           		}
	           		}
	           		//保存图片
	           		if($i==29)
	           		{
	           			if(!empty($data[$i]))
	           			{
	           				$photo = explode(',',substr($data[$i],0,-1));
	           				foreach ($photo as $v)
	           				{
	           					if(count($goods_info)==0 || empty($goods_no) || $mark==2)
		           				{
		           					if(file_exists(str_replace("'","",$v)))//判断图片是否存在
	        						{
	        							$md5 = md5_file(str_replace("'","",$v));
			           					//照片图库表
			           					$tb_goods_photo = new IModel('goods_photo');
			           					$goods_photo = $tb_goods_photo->getObj("id='".$md5."'");
			           					if(count($goods_photo)==0)
			           					{
			           						$tb_goods_photo->setData(array('id'=>$md5,'img'=>str_replace("'","",$v)));
			           						$tb_goods_photo->add();
			           					}
			           					//商品照片的关联表
			           					$tb_goods_photo_relation = new IModel('goods_photo_relation');
							       		$tb_goods_photo_relation->setData(array('goods_id'=>$gid,'photo_id'=>$md5));
						           		$tb_goods_photo_relation->add();
	        						}
		           				}
	           				}
	           			}
	           		}
	           		//保存商品标签
	           		if($i==30)
	           		{
	           			if(!empty($data[$i]))
	           			{
	           				$commend = explode(',',substr($data[$i],0,-1));
	           				foreach ($commend as $v)
	           				{
		           				$tb_commend_goods = new IModel('commend_goods');
					       		$tb_commend_goods->setData(array('goods_id'=>$gid,'commend_id'=>$v));
				           		$tb_commend_goods->add();
	           				}
	           			}
	           		}
	           		//会员组价格
	           		if($i==31)
	           		{
	           			if(!empty($data[$i]))
	           			{
	           				$group = explode(';',substr($data[$i],0,-1));
	           				foreach ($group as $gva)
	           				{
	           					$gprice = explode(',',$gva);
	           					$tb_group_price = new IModel('group_price');
					       		$tb_group_price->setData(array('goods_id'=>$gid,'products_id'=>$gprice[0],'group_id'=>$gprice[1],'price'=>$gprice[2]));
				           		$tb_group_price->add();
	           				}
	           			}
	           		}
	           		//商品扩展分类
	           		if($i==32)
	           		{
	           			if(!empty($data[$i]))
	           			{
	           				$cate_extend = explode('|',substr($data[$i],0,-1));
	           				foreach ($cate_extend as $cva)
	           				{
	           					$tb_cate_extend = new IModel('category_extend');
	           					$tb_cate_extend->setData(array('goods_id'=>$gid,'category_id'=>$cva));
	           					$tb_cate_extend->add();
	           				}
	           			}
	           		}
	           		//商品属性
	           		if($i>32)
	           		{
	           			if(!empty($data[$i]))
	           			{
	           				if(strstr($data[$i],'**a**'))
	           				{
	           					$tb_goods_attribute = new IModel('goods_attribute');
	           					$attr = explode('|',$data[$i]);
						       	$tb_goods_attribute->setData(array('goods_id'=>$gid,'attribute_id'=>str_replace('**a**','',$attr[0]),'attribute_value'=>$this->i($data[$i+1]),'model_id'=>$data[4]));
				           		$tb_goods_attribute->add();
	           				}
	           				if(strstr($data[$i],'**s**'))
	           				{
	           					$tb_goods_attribute = new IModel('goods_attribute');
	           					$spec = explode('|',$data[$i]);
						       	$tb_goods_attribute->setData(array('goods_id'=>$gid,'spec_id'=>str_replace('**s**','',$spec[0]),'spec_value'=>$this->i($data[$i+1]),'model_id'=>$data[4]));
				           		$tb_goods_attribute->add();
	           				}
	           			}
	           		}
	           	}
           }
           
           //导入products表 
            if($data[0] == 'pid')
           	{
           		$arr = array('goods_id'=>$gid,'products_no'=>$data[2],'sell_price'=>$data[5],'market_price'=>$data[6],'store_nums'=>$data[8],'weight'=>$data[15],
           		'spec_array'=>$data[24],'cost_price'=>$data[27],'spec_md5'=>$data[28]);
           		$tb_product = new IModel('products');
           		$tb_product->setData($arr);
           		$products_id = $tb_product->add();
           		$product[$products_id] = $data[1];
           		$suce++;
           	}
		}
		fclose ($handle);
		//修改用户组会员价的货品ID
		if(count($product)>0)
		{
			foreach ($product as $keys => $value)
			{
				$tb_group_price = new IModel('group_price');
				$group_price_info = $tb_group_price->query('products_id='.$value);
				if(count($group_price_info)>0)
				{
					foreach ($group_price_info as $va)
					{
						$tb_group_price->setData(array('products_id'=>$keys));
						$tb_group_price->update('id='.$va['id']);
					}
				}
			}
		}
		if($suce==0)
		{
			return -1;
		}
		return $total-$suce-1;
	}

	/**
	 *导出到CSV文件
	 * @param <array> $condition
	 */
	function export($condition) {
		$filename = date('YmdHis').".csv";
		//header("Content-type:text/csv");
		//header("Content-Disposition:attachment;filename=".$filename);
		if(!is_dir('backup/goods'))
		{
			mkdir('backup/goods',0777);
		}
		$string = Util::array2csv($this->array_to_string($condition));
		$backupObj = new DBBackup();
		$backupObj->writeFile('backup/goods/goods.csv',$string);
		return '0';
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
	    $title = array("*cols*",$this->e_i("商品名称"),$this->e_i("商品的货号"),$this->e_i("模型ID"),
	    $this->e_i("销售价格"),$this->e_i("市场价格"),$this->e_i("成本价格"),$this->e_i("创建时间"),$this->e_i("库存"),$this->e_i("原图"),
	    $this->e_i("是否删除"),$this->e_i("商品描述"),$this->e_i("SEO关键词"),$this->e_i("SEO描述"),$this->e_i("标签id"),$this->e_i("重量"),
	    $this->e_i("积分"),$this->e_i("计量单位"),$this->e_i("品牌ID"),$this->e_i("浏览次数"),$this->e_i("收藏次数"),$this->e_i("排序"),
	    $this->e_i("列表页缩略图"),$this->e_i("详细页缩略图"),$this->e_i("规格序列化"),$this->e_i("经验值"),$this->e_i("P商品ID"),$this->e_i("P成本价格"),
	    $this->e_i("PMD5"),$this->e_i("GPR图片ID"),$this->e_i("CG标签ID"),$this->e_i("GP会员组价格"),$this->e_i("CE扩展分类"),$this->e_i("GA属性ID"),
	    $this->e_i("GA属性值"),$this->e_i("GA规格ID"),$this->e_i("GA规格值")
	    );
	    $csv[] = $title;

	    foreach ($result as $value)
	    {
	    	//商品相册关联
	        $photo = '';
	        $photo_image = '';
	        $tb_goods_photo_relation = new IModel('goods_photo_relation');
	        $goods_photo_relation = $tb_goods_photo_relation->query('goods_id='.$value);
	        if(count($goods_photo_relation)>0)
	        {
	        	foreach ($goods_photo_relation as $va)
	        	{
	        		$photo .= "'".$va['photo_id']."',";
	        	}
	        	$photo = substr($photo,0,-1);
	        	//复制图片
	        	if(!is_dir('backup/goods/upload'))
				{
					mkdir('backup/goods/upload',0777);
				}
	        	$tb_goods_photo = new IModel('goods_photo');
	        	$goods_photo = $tb_goods_photo->query('id in ('.$photo.')');
	        	foreach ($goods_photo as $vg)
	        	{
	        		$dir = explode("/",$vg['img']);
	        		if(!is_dir('backup/goods/upload/'.$dir[1]))
	        		{
	        			mkdir('backup/goods/upload/'.$dir[1],0777);
	        		}
	        		if(!is_dir('backup/goods/upload/'.$dir[1].'/'.$dir[2]))
	        		{
	        			mkdir('backup/goods/upload/'.$dir[1].'/'.$dir[2],0777);
	        		}
	        		if(!is_dir('backup/goods/upload/'.$dir[1].'/'.$dir[2].'/'.$dir[3]))
	        		{
	        			mkdir('backup/goods/upload/'.$dir[1].'/'.$dir[2].'/'.$dir[3],0777);
	        		}
	        		//大图
	        		if(file_exists($vg['img']))//判断图片是否存在
	        		{
	        			$img = explode('/',$vg['img']);
	        			copy($vg['img'],'backup/goods/upload/'.$dir[1].'/'.$dir[2].'/'.$dir[3].'/'.$img[count($img)-1]);
	        		}
	        		$photo_image .= "'".$vg['img']."',";
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
	    	$good = array("gid",$this->e_i($info['name']),$info['goods_no'],$info['model_id'],
		    	$info['sell_price'],$info['market_price'],$info['cost_price'],$info['create_time'],$info['store_nums'],$info['img'],
		    	$info['is_del'],$this->e_i($content),$this->e_i($info['keywords']),$this->e_i($info['description']),$info['tag_ids'],$info['weight'],
		    	$info['point'],$this->e_i($info['unit']),$info['brand_id'],$info['visit'],$info['favorite'],$info['sort'],
		    	$info['list_img'],$info['small_img'],$this->e_i($info['spec_array']),$info['exp'],'','',
		    	'',$photo_image,$commend_id,$group,$cate_extend
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
	        				$good[]='**a**'.$va['attribute_id'].'|'.$this->e_i($att_info['name']);
	        			}
	        			else
	        			{
	        				$good[]='**a**'.$va['attribute_id'];
	        			}
	        		}
	        		if($va['attribute_value'])
	        		{
	        			$good[]=$this->e_i($va['attribute_value']);
	        		}
	        		if($va['spec_id'])
	        		{
	        			$tb_spec = new IModel('spec');
	        			$spec_info = $tb_spec->getObj('id='.$va['spec_id']);
	        			if(count($spec_info)>0)
	        			{
	        				$good[]='**s**'.$va['spec_id'].'|'.$this->e_i($spec_info['name']);
	        			}
	        			else
	        			{
	        				$good[]='**s**'.$va['spec_id'];	
	        			}
	        		}
	        		if($va['spec_value'])
	        		{
	        			$good[]=$this->e_i($va['spec_value']);
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
	        		'','',$this->e_i($va['spec_array']),'',$va['goods_id'],
	        		$va['cost_price'],$va['spec_md5']);
					$csv[] = $product;
	        	}
	        }
	    }
	   
	    return $csv;
	}
	/**
	 *编码转换
	 * @param <string> $strInput
	 * @return <type>
	 */
	private function i($strInput)
	{
	    return iconv('gb2312','utf-8//IGNORE',$strInput);
	}
	function e_i($strInput)
	{
	    return iconv('utf-8','gb2312//IGNORE',$strInput);
	}
	
}
?>