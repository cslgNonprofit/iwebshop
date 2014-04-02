<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file taobao_csv.php
 * @brief csv文件导入、导出
 * @author relay
 * @date 2011-10-12
 * @version 2.1
 */

/**
 * @class ITaobaoCsv
 * @brief taobao_csv文件导入、导出
 */
class ITaobaoCsv
{
	/**
	 * @brief 构造函数
	 * */
	public function __construct(){}
	
	/**
	 *导入淘宝CSV文件
	 * @param <文件路径> $name
	 */
	function import($name)
	{
		$data = $this->get_csv_date($name);

		$errstr = -1;
		if($data)
		{
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
	           		$errstr++;
	           	}
			}
			$errstr = 0;
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
	 *导出淘宝CSV文件
	 * @param <文件路径> $name
	 */
    function export($result,$tao_arr)
    {
    	$filename = date('YmdHis')."_taobao.csv";
		header("Content-type:text/csv;charset=UTF-16LE");
		header("Content-Disposition:attachment;filename=".$filename);
    	if(empty($result)){
	        return $this->i("没有符合您要求的数据!");		
	    }
		$title = "宝贝名称	宝贝类目	店铺类目	新旧程度	省	城市	出售方式	宝贝价格	加价幅度	宝贝数量	有效期	运费承担	平邮	EMS	快递	付款方式	支付宝	发票	保修	自动重发	放入仓库	橱窗推荐	开始时间	心情故事	宝贝描述	宝贝图片	宝贝属性	团购价	最小团购件数	邮费模板ID	会员打折	修改时间	上传状态	图片状态	返点比例	新图片	视频	销售属性组合	用户输入ID串	用户输入名-值对	商户编码	销售属性别名	代充类型	宝贝编号	数字ID
";
	    echo "\xFF\xFE".$this->i($title);
		$this->array_to_string($result,$tao_arr);
		exit;
    }
    /**
	 *导出数据转换
	 * @param <array> $result
	 */
	function array_to_string($result,$tao_arr)
	{
	    foreach ($result as $value)
	    {
	    	//导出商品
	    	$tb_goods = new IModel('goods');
	    	$info = $tb_goods->getObj('id='.$value);
	    	
	    	$vo = array("\r\n","\n","\0");
	    	$content = str_replace($vo,"",$info['content']);
	    	$good = Util::string2csv($info['name'])."	".$tao_arr[0]."		0			b	".$info['sell_price']."	0	".$info['store_nums']."	7	1	".$tao_arr[1]."	".$tao_arr[2]."	".$tao_arr[3]."			0	0	0		0	".$info['create_time']."		".Util::string2csv($content)."					0	0	".$info['create_time']."	200		0								0		
";
	    	echo $this->i($good);
	    }
	}
	/**
	 *编码转换
	 * @param <string> $strInput
	 * @return <type>
	 */
	function i($strInput)
	{
	    return iconv('utf-8','UTF-16LE',$strInput);
	}
}
?>