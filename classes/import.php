<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file mess.php
 * @brief 导入csv文章
 * @author relay
 * @date 2011-07-14
 * @version 0.6
 */
class Import
{
	/**
	 *导入CSV文件
	 * @param <文件路径> $name
	 */
	function import_csv($name,$mark)
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
	           		if($i>0 && $i<25)
	           		{
		                $arr[$goods_col[$i]] = $this->i($data[$i]);
		                if($goods_col[$i]=='spec_array' || $goods_col[$i]=='content')
		                {
		                	$arr[$goods_col[$i]] = addslashes($arr[$goods_col[$i]]);
		                }
	           		}
	           		if($i==25)
	           		{
		           		$goods_no = $data[2];
		           		$obj_goods = new IQuery('goods');
		           		$obj_goods->fields = 'id';
		           		$obj_goods->where = "goods_no='{$goods_no}'";
		           		$goods_info = $obj_goods->find();
		           		if(count($goods_info)==0)
		           		{
		           			$tb_goods = new IModel('goods');
			           		$tb_goods->setData($arr);
			           		$gid = $tb_goods->add();
			           		$suce++;
		           		}
		           		else
		           		{
		           			if($mark==1)
		           			{
		           				$goods_id = $goods_info[0]['id'];
		           				//删除商品
		           				$goods_del = new goods_class();
		           				$goods_del->del($goods_id);
		           				//生成新的商品
		           				$arr['id'] = $goods_id;
		           				$tb_goods = new IModel('goods');
				           		$tb_goods->setData($arr);
				           		$gid = $tb_goods->add();
				           		$suce++;
		           			}
		           			else
		           			{
								return $this->i($data[1]);		           				
		           			}
		           		}
	           		}
	           		//保存图片
	           		if($i==28)
	           		{
	           			if(!empty($data[$i]))
	           			{
	           				$photo = explode(',',substr($data[$i],0,-1));
	           				foreach ($photo as $v)
	           				{
	           					$tb_goods_photo_relation = new IModel('goods_photo_relation');
					       		$tb_goods_photo_relation->setData(array('goods_id'=>$gid,'photo_id'=>$v));
				           		$tb_goods_photo_relation->add();
	           				}
	           			}
	           		}
	           		//保存商品标签
	           		if($i==29)
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
	           		if($i==30)
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
	           		if($i==31)
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
	           		if($i>31)
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
           		'spec_array'=>$data[24],'goods_id'=>$data[26],'cost_price'=>$data[27],'spec_md5'=>$data[28]);
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
		return 0;
	}
	/**
	 *导入淘宝CSV文件
	 * @param <文件路径> $name
	 */
	function import_taobao_csv($name)
	{
		$data=$this->get_csv_date($name);
	
		$errstr="";
		foreach ($data as $k=> $value){
		    $arr['name'] = $value['name'];
           	$arr['sell_price'] = $value['sell_price'];
           	$arr['market_price'] = $value['market_price'];
           	$arr['cost_price'] = $value['cost_price'];
           	$arr['store_nums'] = $value['store_nums'];
           	$arr['is_del'] = 0;
           	$arr['brand_id'] = 0;
           	$arr['model_id'] = 0;
           	$arr['weight'] = 0;
           	$arr['point'] = 0;
           	$arr['visit'] = 0;
           	$arr['favorite'] = 0;
           	$arr['sort'] = 99;
           	$arr['exp'] = 0;
           	$arr['spec_array'] = serialize(array());
           	$arr['create_time'] = date("Y-m-d H:i:s");
           	$arr['content'] = $value['content'];
			$tb_goods = new IModel('goods');
           	$tb_goods->setData($arr);
           	$gid = $tb_goods->add();
           	if($gid)
           	{
           		$goods_no = Block::goods_no($gid);
				$tb_goods->setData(array('goods_no'=>$goods_no));
				$tb_goods->update('id='.$gid);
           	}
           	else
           	{
           		$errstr.=($k+1).",";
           	}
		}
		return $errstr;
	}
	/**
	 * 解析csv文件
	 */
	function get_csv_date($file_name)
	{
		$str = file_get_contents($file_name);
        if($str{0} != "\xFF" || $str{1} != "\xFE"){
            return false;
        }
        //转码
        $str = $this->unicodeToUtf8(substr($str, 2));
        //切割字符串
        $str = preg_replace('/\t\"([^\t]+?)\"\t/es', "'\t\"' . stripslashes(str_replace(\"\n\", \"\", '\\1')) . '\"\t'", $str);
        $csv_array = explode("\n", $str);
        unset($csv_array[count($csv_array) -1]);
        unset($csv_array[0]);
        $product_array = array();
        if (!empty($csv_array)){
        	foreach ($csv_array as $k => $v){
        		$tmp = explode("\t", $v);
        		//商品名称
        		$tmp['name'] = str_replace("'",'',str_replace('"','',$tmp[0]));
        		//库存
        		$tmp['store_nums'] = intval($tmp[9]);
        		//商品价格
        		$tmp['sell_price'] = number_format($tmp[7],2);
           		$tmp['market_price'] = number_format($tmp[7],2);
           		$tmp['cost_price'] = number_format($tmp[7],2);
        		
        		//if(trim($tmp[35],'"') != ''){
					//图片
				//	$tmp['image'] = trim($tmp[35],'"');
				//}
				//$tmp['create_time'] = $tmp[22];
				//商品简介
           		$tmp['content'] = str_replace("'",'',str_replace('"','',$tmp[24]));
				
        		//$tmp['goods_intro'] = str_replace("'",'',str_replace('"','',$tmp[24]));
        		$product_array[] = $tmp;
        	}
        }
        return $product_array;
	}
	function unicodeToUtf8($str,$order="little")
    {
        $utf8string ="";
        $n=strlen($str);
        for ($i=0;$i<$n ;$i++ )
        {
            if ($order=="little")
            {
                $val = str_pad(dechex(ord($str[$i+1])), 2, 0, STR_PAD_LEFT) .
                       str_pad(dechex(ord($str[$i])),      2, 0, STR_PAD_LEFT);
            }
            else
            {
                $val = str_pad(dechex(ord($str[$i])),      2, 0, STR_PAD_LEFT) .
                       str_pad(dechex(ord($str[$i+1])), 2, 0, STR_PAD_LEFT);
            }
            $val = intval($val,16); // 由于上次的.连接，导致$val变为字符串，这里得转回来。
            $i++; // 两个字节表示一个unicode字符。
            $c = "";
            if($val < 0x7F)
            { // 0000-007F
                $c .= chr($val);
            }
            elseif($val < 0x800)
            { // 0080-07F0
                $c .= chr(0xC0 | ($val / 64));
                $c .= chr(0x80 | ($val % 64));
            }
            else
            { // 0800-FFFF
                $c .= chr(0xE0 | (($val / 64) / 64));
                $c .= chr(0x80 | (($val / 64) % 64));
                $c .= chr(0x80 | ($val % 64));
            }
            $utf8string .= $c;
        }
        /* 去除bom标记 才能使内置的iconv函数正确转换 */
        if (ord(substr($utf8string,0,1)) == 0xEF && ord(substr($utf8string,1,2)) == 0xBB && ord(substr($utf8string,2,1)) == 0xBF)
        {
            $utf8string = substr($utf8string,3);
        }
        return $utf8string;
    }
	/**
	 *编码转换
	 * @param <string> $strInput
	 * @return <type>
	 */
	function i($strInput)
	{
	    return iconv('gb2312','utf-8//IGNORE',$strInput);
	}
}