<?php $user = $this->user?>
<?php $myCartObj = new Cart(); $myCartInfo = $myCartObj->getMyCart();$siteConfig=new Config("site_config");?>
<?php $siteConfigObj = new Config("site_config");$site_config   = $siteConfigObj->getInfo();?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo $siteConfig->name;?></title>
<link type="image/x-icon" href="favicon.ico" rel="icon">
<link type="image/x-icon" href="favicon.ico" rel="bookmark">
<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/css/index.css";?>" />
<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/css/jquery.jqzoom.css";?>" />
<script charset="UTF-8" src="/iwebshop/runtime/systemjs/jquery-1.4.4.min.js"></script>
<script charset="UTF-8" src="/iwebshop/runtime/systemjs/form.js"></script>
<link rel="stylesheet" type="text/css" href="/iwebshop/runtime/systemjs/autovalidate/style.css"/><script charset="UTF-8" src="/iwebshop/runtime/systemjs/autovalidate/validate.js"></script>
<script charset="UTF-8" src="/iwebshop/runtime/systemjs/artdialog/artDialog.min.js"></script>
<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/common.js";?>"></script>
<script type='text/javascript' src="<?php echo IUrl::creatUrl("/javascript/adloader/");?>"></script>
<link rel="stylesheet" type="text/css" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/";?>jquery.bxSlider/bx_styles/bx_styles.css" />
</head>
<body class="index">
<div class="container">
	<div class="header">
		<h1 class="logo"><a title="<?php echo $siteConfig->name;?>" style="background:url(<?php echo IUrl::creatUrl("")."image/logo.gif";?>);" href="<?php echo IUrl::creatUrl("");?>"><?php echo $siteConfig->name;?></a></h1>
		<ul class="shortcut">
			<li class="first"><a href="<?php echo IUrl::creatUrl("/ucenter/index");?>">我的账户</a></li><li><a href="<?php echo IUrl::creatUrl("/ucenter/order");?>">我的订单</a></li><li class='last'><a href="<?php echo IUrl::creatUrl("/site/help_list");?>">使用帮助</a></li>
		</ul>
		<p class="loginfo">
			<?php if((isset($user['user_id']) && $user['user_id']!='')){?><?php echo isset($user['username'])?$user['username']:"";?>您好，欢迎您来到<?php echo $siteConfig->name;?>购物！[<a href="<?php echo IUrl::creatUrl("/simple/logout");?>" class="reg">安全退出</a>]<?php }else{?>[<a href="<?php echo IUrl::creatUrl("/simple/login");?>">登录</a>
			<?php $callback = IReq::get('callback')?>
			<?php if($callback==""){?>
			<a class="reg" href="<?php echo IUrl::creatUrl("/simple/reg");?>">免费注册</a>
			<?php }else{?>
			<?php $callback=urlencode($callback);?>
			<a class="reg" href="<?php echo IUrl::creatUrl("/simple/reg/?callback=$callback");?>">免费注册</a>
			<?php }?>
			]
			<?php }?>
		</p>
	</div>
	<div class="navbar">
		<ul>
			<li><a href="<?php echo IUrl::creatUrl("");?>">首页</a></li>
			<?php $i=0;?>
			<?php $query = new IQuery("guide");$items = $query->find(); foreach($items as $key => $item){?>
			<?php $i++;$item['link']=IUrl::creatUrl($item['link']);?>
			<li <?php if($i==count($items)){?>style="background:none;"<?php }?>><a href="<?php echo isset($item['link'])?$item['link']:"";?>"><?php echo isset($item['name'])?$item['name']:"";?><span> </span></a></li>
			<?php }?>
		</ul>

		<div class="mycart">
			<dl>
				<dt><a href="<?php echo IUrl::creatUrl("/simple/cart");?>">购物车<b name="mycart_count"><?php echo isset($myCartInfo['count'])?$myCartInfo['count']:"";?></b>件</a></dt>
				<dd><a href="<?php echo IUrl::creatUrl("/simple/cart");?>">去结算</a></dd>
			</dl>

			<!--购物车浮动div 开始-->
			<div class="shopping" id='div_mycart' style='display:none;'>
			</div>
			<!--购物车浮动div 结束-->

		</div>
	</div>

	<div class="searchbar">
		<div class="allsort">
			<a href="javascript:void(0);">全部商品分类</a>

			<!--总的商品分类-开始-->
			<ul class="sortlist" id='div_allsort' style='display:none'>
				<?php $this->goodsCategory = block::goods_category();?>
				<?php foreach($this->goodsCategory as $key => $first){?>
					<li>
						<h2><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$first[id]");?>"><?php echo isset($first['name'])?$first['name']:"";?></a></h2>

						<!--商品分类 浮动div 开始-->
						<div class="sublist" style='display:none'>

							<div class="items">
								<strong>选择分类</strong>
								<?php if(isset($first['second'])){?>
								<?php foreach($first['second'] as $key => $second){?>
								<dl class="category selected">
									<dt>
										<a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$second[id]");?>"><?php echo isset($second['name'])?$second['name']:"";?></a>
									</dt>

									<dd>
										<?php if(isset($second['more'])){?>
										<?php foreach($second['more'] as $key => $third){?>
										<a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$third[id]");?>"><?php echo isset($third['name'])?$third['name']:"";?></a>|
										<?php }?>
										<?php }?>
									</dd>
								</dl>
								<?php }?>
								<?php }?>

							</div>

						</div>
						<!--商品分类 浮动div 结束-->

					</li>
				<?php }?>

			</ul>
			<!--总的商品分类-结束-->

		</div>

		<div class="searchbox">
			<form method='get'>
				<input type='hidden' name='controller' value='site' />
				<input type='hidden' name='action' value='search_list' />
				<?php $word = IReq::get('word');?>
				<input class="text" type="text" name='word' id="word" autocomplete="off" value="<?php echo $word ? $word : '输入关键字...';?>" />
				<input class="btn" type="submit" value="商品搜索" onclick="checkInput('word','输入关键字...');" />
			</form>

			<!--自动完成div 开始-->
			<ul class="auto_list" style='display:none'></ul>
			<!--自动完成div 开始-->

		</div>
		<div class="hotwords">热门搜索：
			<?php $query = new IQuery("keyword");$query->where = "hot = 1";$query->limit = "5";$query->order = "`order` asc";$items = $query->find(); foreach($items as $key => $item){?>
			<?php $tmpWord = urlencode($item['word']);?>
			<a href="<?php echo IUrl::creatUrl("/site/search_list/word/$tmpWord");?>"><?php echo isset($item['word'])?$item['word']:"";?></a>
			<?php }?>
		</div>
	</div>
	<div class="m_10" id="adHere_1"></div>
	<script language="javascript">
	(new adLoader()).load(1,'adHere_1');
	</script>

		<?php $seo_data=array(); $site_config=new Config('site_config');$site_config=$site_config->getInfo();?>
	<?php $seo_data['title']= $this->catRow['title']?$this->catRow['title']:$this->catRow['name']?>
	<?php if(isset($site_config['name'])){?>
		<?php $seo_data['title'].="_".$site_config['name']?>
	<?php }?>
	<?php if($this->catRow['keywords']!=""){?>
		<?php $seo_data['keywords']=$this->catRow['keywords']?>
	<?php }?>
	<?php if($this->catRow['descript']!=""){?>
		<?php $seo_data['description']=$this->catRow['descript']?>
	<?php }?>
	<?php seo::set($seo_data);?>

	<?php $allCatIdArray=array();$catIdArray=array();?>
	<?php $goodsCatTree = block::getCatTree($this->goodsCategory,$this->catId)?>

	<div class="position">
		<span>您当前的位置：</span>
		<a href="<?php echo IUrl::creatUrl("");?>"> 首页</a> »
		<?php if(isset($goodsCatTree['id'])){?>
		<a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$goodsCatTree[id]");?>"><?php echo isset($goodsCatTree['name'])?$goodsCatTree['name']:"";?></a>
		<?php if($goodsCatTree['id']!=$this->catRow['id']){?> »
			<?php echo isset($this->catRow['name'])?$this->catRow['name']:"";?>
		<?php }?>
		</div>
		<?php }?>
	<div class="wrapper clearfix container_2">

		<div class="sidebar f_l">

			<!--侧边栏分类-->
			<div class="box_2 m_10">

				<?php if(!empty($goodsCatTree)){?>
				<?php $allCatIdArray[]=$goodsCatTree['id']?>
				<div class="title"><?php echo isset($goodsCatTree['name'])?$goodsCatTree['name']:"";?></div>
				<div class="content">
					<?php if(isset($goodsCatTree['second'])){?>
					<?php foreach($goodsCatTree['second'] as $key => $second){?>
					<?php $allCatIdArray[]=$second['id']?>
					<dl class="clearfix">
						<dt><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$second[id]");?>"><?php echo isset($second['name'])?$second['name']:"";?></a></dt>
						<?php foreach($second['more'] as $key => $more){?>
						<?php $allCatIdArray[]=$more['id']?>
						<?php $catIdArray[]=$more['id'];?>
						<dd><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$more[id]");?>"><?php echo isset($more['name'])?$more['name']:"";?></a></dd>
						<?php }?>
					</dl>
					<?php }?>
					<?php }?>
				</div>
				<?php }?>
			</div>
			<!--侧边栏分类-->

			<!--销售排行-->
		  	<?php $query = new IQuery("category_extend as ca");$query->join = "left join goods as go on ca.goods_id = go.id left join order_goods as ord on ord.goods_id = go.id";$query->where = "ca.category_id in ($this->childId) and go.is_del = 0 and ord.goods_nums > 0";$query->fields = "go.id,go.name,go.list_img,go.sell_price,SUM(ord.goods_nums) as sum";$query->order = "sum desc";$query->group = "ord.goods_id";$query->limit = "10";$sellList = $query->find();?>
		  	<?php if(!empty($sellList)){?>
			<div class="box m_10">
				<div class="title">销售排行榜</div>
				<div class="content">
					<ul class="ranklist" id='ranklist'>
						<?php foreach($sellList as $key => $item){?>
					  	<li>
					  		<span><?php echo intval($key+1);?></span>
					  		<a href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" width="60" height="60" alt="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
					  		<a title="<?php echo isset($item['name'])?$item['name']:"";?>" class="p_name" href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a><b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b>
					  	</li>
					  	<?php }?>
					</ul>
				</div>
			</div>
			<?php }?>
			<!--销售排行-->

		</div>

		<div class="main f_r">
			<!--推荐商品-->
		  	<?php $query = new IQuery("category_extend as ca");$query->join = "left join goods as go on ca.goods_id = go.id left join commend_goods as co on co.goods_id = go.id";$query->where = "ca.category_id in ($this->childId) and co.commend_id = 4 and go.is_del = 0";$query->limit = "6";$query->order = "go.sort asc,go.id desc";$query->fields = "DISTINCT go.list_img,go.sell_price,go.name,go.id,go.market_price,go.description";$pro_list = $query->find();?>

		  	<?php if(!empty($pro_list)){?>
			<div class="brown_box m_10 clearfix">
				<p class="caption"><span>推荐</span></p>

				<ul class="prolist">
					<?php foreach($pro_list as $key => $item){?>
					<li>
						<a class="pic" href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" alt="<?php echo isset($item['name'])?$item['name']:"";?>" height="85px" width="85px"></a>
						<p class="pro_title"><a class="blue" href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a><span class="gray"><?php echo isset($item['description'])?$item['description']:"";?></span></p>
						<p><b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b> <s>￥<?php echo isset($item['market_price'])?$item['market_price']:"";?></s></p>
					</li>
					<?php }?>
				</ul>
			</div>
			<?php }?>
			<!--推荐商品-->

			<div class="box m_10">
				<div class="title"><?php echo isset($this->catRow['name'])?$this->catRow['name']:"";?></div>
				<div class="cont">

					<!--品牌展示-->
					<?php $query = new IQuery("category_extend as ca");$query->join = "left join goods as go on ca.goods_id = go.id left join brand as b on b.id = go.brand_id";$query->where = "ca.category_id in ( $this->childId ) and go.is_del = 0 and go.brand_id  !=  0";$query->fields = "DISTINCT b.id,b.name";$query->limit = "10";$brandList = $query->find();?>
					<?php if(!empty($brandList)){?>
					<dl class="sorting">
						<dt>品牌：</dt>
						<dd id='brand_dd'>
							<a class="nolimit current" href="<?php echo block::searchUrl('brand','');?>">不限</a>
							<?php foreach($brandList as $key => $item){?>
							<a href="<?php echo block::searchUrl('brand',$item['id']);?>" id='brand_<?php echo isset($item['id'])?$item['id']:"";?>'><?php echo isset($item['name'])?$item['name']:"";?></a>
							<?php }?>
						</dd>
					</dl>
					<?php }?>
					<!--品牌展示-->

					<?php if(stripos($this->childId,',') === false){?>

					<!--商品属性-->
					<?php $query = new IQuery("category as ca");$query->join = "left join attribute as attr on ca.model_id = attr.model_id";$query->where = "ca.id = $this->childId and attr.search = 1";$query->fields = "attr.name as name,attr.id ,attr.value as value";$items = $query->find(); foreach($items as $key => $item){?>
					<dl class="sorting">
						<dt><?php echo isset($item['name'])?$item['name']:"";?>：</dt>
						<dd id='attr_dd_<?php echo isset($item['id'])?$item['id']:"";?>'>
							<a class="nolimit current" href="<?php echo block::searchUrl('attr['.$item["id"].']','');?>">不限</a>
							<?php $attrVal = explode(',',$item['value']);?>
							<?php foreach($attrVal as $key => $attr){?>
							<a href="<?php echo block::searchUrl('attr['.$item["id"].']',$attr);?>" id="attr_<?php echo isset($item['id'])?$item['id']:"";?>_<?php echo urlencode($attr);?>"><?php echo isset($attr)?$attr:"";?></a>
							<?php }?>
						</dd>
					</dl>
					<?php }?>
					<!--商品属性-->

					<!--商品规格-->
					<?php if(!empty($this->spec)){?>
					<?php foreach($this->spec as $key => $item){?>
					<dl class="sorting">
						<dt><?php echo isset($item['name'])?$item['name']:"";?>：</dt>
						<dd id='spec_dd_<?php echo isset($item['id'])?$item['id']:"";?>'>
							<a class="nolimit current" href="<?php echo block::searchUrl('spec['.$item["id"].']','');?>">不限</a>
							<?php if($item['type'] == 1){?>
							<?php foreach(unserialize($item['value']) as $key => $spec){?>
							<a href="<?php echo block::searchUrl('spec['.$item["id"].']',$spec);?>" id='spec_<?php echo isset($item['id'])?$item['id']:"";?>_<?php echo urlencode($spec);?>'><?php echo isset($spec)?$spec:"";?></a>
							<?php }?>

							<?php }else{?>

							<?php foreach(unserialize($item['value']) as $key => $spec){?>
							<a href="<?php echo block::searchUrl('spec['.$item["id"].']',$spec);?>" id='spec_<?php echo isset($item['id'])?$item['id']:"";?>_<?php echo urlencode($spec);?>'><img src='<?php echo IUrl::creatUrl("");?><?php echo isset($spec)?$spec:"";?>' style='width:20px;height:20px' /></a>
							<?php }?>
							<?php }?>
						</dd>

					</dl>
					<?php }?>
					<?php }?>
					<!--商品规格-->

					<?php }?>

					<!--商品价格-->
					<dl class="sorting">
						<dt>价格：</dt>
						<dd id='price_dd'>
							<p class="f_r"><input type="text" class="mini" name="min_price" value="<?php echo IReq::get('min_price');?>" onchange="checkPrice(this);"> 至 <input type="text" class="mini" name="max_price" onchange="checkPrice(this);" value="<?php echo IReq::get('max_price');?>"> 元
							<label class="btn_gray_s"><input type="button" onclick="priceLink();" value="确定"></label></p>
							<a class="nolimit current" href="<?php echo block::searchUrl(array('min_price','max_price'),'');?>">不限</a>
							<?php $goodsPrice = goods_class::getGoodsPrice($this->childId)?>
							<?php foreach($goodsPrice as $key => $item){?>
								<?php $priceZone = explode('-',$item)?>
								<a href="<?php echo block::searchUrl(array('min_price','max_price'),array($priceZone[0],$priceZone[1]));?>" id="<?php echo isset($priceZone[0])?$priceZone[0]:"";?>-<?php echo isset($priceZone[1])?$priceZone[1]:"";?>"><?php echo isset($item)?$item:"";?></a>
							<?php }?>
						</dd>
					</dl>
					<!--商品价格-->
				</div>
			</div>

			<!--商品列表展示-->
			<div class="display_title">
				<span class="l"></span>
				<span class="r"></span>
				<span class="f_l">排序：</span>
				<ul>
					<?php foreach($this->orderArray as $key => $item){?>
						<?php if($this->order == $key){?>
							<?php $next = $key.'_toggle';$tip  = 'desc';?>
						<?php }else{?>
							<?php $next = $key;$tip  = '';?>
						<?php }?>
						<li class="<?php echo (stripos($this->order,$key)!==false) ? 'current':'';?>">
							<span class="l"></span><span class="r"></span>
							<a href="<?php echo block::searchUrl('order',$next);?>">
								<?php echo isset($item)?$item:"";?><span class='<?php echo isset($tip)?$tip:"";?>'>&nbsp;</span>
							</a>
						</li>
					<?php }?>
				</ul>
				<span class="f_l">显示方式：</span>
				<a class="show_b" href="<?php echo block::searchUrl('show_type','win');?>" title='橱窗展示' alt='橱窗展示'><span class='<?php echo $this->show_type == 'win' ? 'current':'';?>'></span></a>
				<a class="show_s" href="<?php echo block::searchUrl('show_type','list');?>" title='列表展示' alt='列表展示'><span class='<?php echo $this->show_type == 'list' ? 'current':'';?>'></span></a>
			</div>

			<?php if(!empty($this->resultData)){?>
			<ul class="display_list clearfix m_10">
				<?php foreach($this->resultData as $key => $item){?>
				<li class="clearfix <?php echo isset($this->show_type)?$this->show_type:"";?>">
					<div class="pic">
						<a title="<?php echo isset($item['name'])?$item['name']:"";?>" href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><img src="<?php echo Thumb::get($item['img'],$this->listImageWidth,$this->listImageHeight);?>" width="<?php echo isset($this->listImageWidth)?$this->listImageWidth:"";?>" height="<?php echo isset($this->listImageHeight)?$this->listImageHeight:"";?>" alt="<?php echo isset($item['name'])?$item['name']:"";?>" title="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
					</div>
					<h3 class="title"><a title="<?php echo isset($item['name'])?$item['name']:"";?>" class="p_name" href="<?php echo IUrl::creatUrl("/site/products/id/$item[id]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a><span>总销量：<?php echo intval($item['sell_num']);?><a class="blue" href="<?php echo IUrl::creatUrl("/site/comments_list/id/$item[id]");?>">( <?php echo intval($item['comments_num']);?>人评论 )</a></span><span class='grade'><i style='width:<?php echo 14*$item['average_point'];?>px'></i></span></h3>
					<div class="handle">
						<label class="btn_gray_m"><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/ucenter/shopping.gif";?>" width="15" height="15" /><input type="button" value="加入购物车" onclick="joinCart_list(<?php echo isset($item['id'])?$item['id']:"";?>);"></label>
						<label class="btn_gray_m"><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/ucenter/favorites.gif";?>" width="15" height="14" /><input type="button" value="收藏" onclick="favorite_add_ajax('<?php echo IUrl::creatUrl("/simple/favorite_add");?>','<?php echo isset($item['id'])?$item['id']:"";?>',this);"></label>
						<div class="msgbox" style="width:350px;display:none">
							<div class="msg_t"><a class="close f_r" onclick="$(this).parents('.msgbox').hide();">关闭</a>请选择规格</div>
							<div class="msg_c" id='product_box_<?php echo isset($item['id'])?$item['id']:"";?>'></div>
						</div>
					</div>
					<div class="price">￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?><s>￥<?php echo isset($item['market_price'])?$item['market_price']:"";?></s></div>
				</li>
				<?php }?>
			</ul>

			<div class="pages_bar">
				<?php echo $this->goodsObj->getPageBar();?>
			</div>

			<?php }else{?>
			<p class="display_list mt_10" style='margin-top:50px;margin-bottom:50px'>
				<strong class="gray f14">对不起，没有找到相关商品</strong>
			</p>
			<?php }?>
			<!--商品列表展示-->

		</div>
	</div>

	<script type='text/javascript'>
		//价格跳转
		function priceLink()
		{
			var minVal = $('[name="min_price"]').val();
			var maxVal = $('[name="max_price"]').val();
			if(isNaN(minVal) || isNaN(maxVal))
			{
				alert('价格填写不正确');
				return '';
			}
			var urlVal = "<?php echo preg_replace('|&min_price=\w*&max_price=\w*|','','?'.$_SERVER['QUERY_STRING']);?>";
			window.location.href=urlVal+'&min_price='+minVal+'&max_price='+maxVal;
		}

		//价格检查
		function checkPrice(obj)
		{
			if(isNaN(obj.value))
			{
				obj.value = '';
			}
		}

		//筛选条件按钮高亮
		$(document).ready(function(){
			<?php $attr_spec = Array('attr','spec');$brand = IReq::get('brand');?>

			<?php if(!empty($brand)){?>
			$('#brand_dd>a').removeClass('current');
			$('#brand_<?php echo isset($brand)?$brand:"";?>').addClass('current');
			<?php }?>

			<?php foreach($attr_spec as $key => $item){?>
				<?php $tempArray = IReq::get($item)?>
				<?php if(!empty($tempArray)){?>
					<?php $json = JSON::encode(array_map('urlencode',$tempArray))?>
					var attrArray = <?php echo isset($json)?$json:"";?>;
					for(val in attrArray)
					{
						if(attrArray[val])
						{
							$('#<?php echo isset($item)?$item:"";?>_dd_'+val+'>a').removeClass('current');
							document.getElementById('<?php echo isset($item)?$item:"";?>_'+val+'_'+attrArray[val]).className = 'current';
						}
					}
				<?php }?>
			<?php }?>

			<?php if(IReq::get('min_price') != ''){?>
			$('#price_dd>a').removeClass('current');
			$('#<?php echo IReq::get('min_price');?>-<?php echo IReq::get('max_price');?>').addClass('current');
			<?php }?>
		});
	</script>


	<div class="help m_10">
		<div class="cont clearfix">
			<?php $cat_list=array();?>
			<?php $query = new IQuery("help_category AS cat");$query->where = "position_foot = 1";$query->order = "sort ASC,id desc";$query->limit = "5";$items = $query->find(); foreach($items as $key => $item){?>
			<?php $cat_list[$item['id']]=$item;?>
			<?php }?>
			<?php if(count($cat_list)){?>
				<?php $width=floor(100/count($cat_list))-1;?>
			<?php }?>

			<?php foreach($cat_list as $cat_id => $cat){?>
			<dl style="width:<?php echo isset($width)?$width:"";?>%">
     			<dt><a href="<?php echo IUrl::creatUrl("/site/help_list/id/$cat[id]");?>"><?php echo isset($cat['name'])?$cat['name']:"";?></a></dt>
     			<?php $query = new IQuery("help");$query->where = "cat_id = $cat_id";$query->order = "sort ASC,id desc";$items = $query->find(); foreach($items as $key => $item){?>
					<dd><a href="<?php echo IUrl::creatUrl("/site/help/id/$item[id]");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></dd>
				<?php }?>
      		</dl>
      		<?php }?>
		</div>
	</div>
	<?php echo $siteConfig->site_footer_code;?>
</div>
<script type='text/javascript' src='<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/site.js";?>'></script>
<script type='text/javascript'>
	$('input:text[name="word"]').bind({
		keyup:function(){autoComplete('<?php echo IUrl::creatUrl("/site/autoComplete");?>','<?php echo IUrl::creatUrl("/site/search_list/word/@word@");?>','<?php echo isset($site_config['auto_finish'])?$site_config['auto_finish']:"";?>');}
	});

	var mycartLateCall = new lateCall(200,function(){showCart('<?php echo IUrl::creatUrl("/simple/showCart");?>')});

	//购物车div层
	$('.mycart').hover(
		function(){
			mycartLateCall.start();
		},
		function(){
			mycartLateCall.stop();
			$('#div_mycart').hide('slow');
		}
	);

	//[ajax]加入购物车
	function joinCart_ajax(id,type)
	{
		var url ="<?php echo IUrl::creatUrl("/simple/joinCart/random/@random@/goods_id/@goods_id@/type/@type@");?>";
		url = url.replace("@random@",Math.random()).replace("@goods_id@",id).replace("@type@",type);
		$.getJSON(url,function(content){
			if(content.isError == false)
			{
				var count = parseInt($('[name="mycart_count"]').html());
				$('[name="mycart_count"]').html(count + 1);
				$('.msgbox').hide();
				alert(content.message);
			}
			else
			{
				alert(content.message);
			}
		});
	}

	//列表页加入购物车统一接口
	function joinCart_list(id)
	{
		var url = "<?php echo IUrl::creatUrl("/simple/getProducts/id/@id@");?>";
		$.get('<?php echo IUrl::creatUrl("/simple/getProducts");?>',{id:id},function(content){
			if(content == '')
			{
				joinCart_ajax(id,'goods');
			}
			else
			{
				$('#product_box_'+id).html(content);
				$('#product_box_'+id).parent().show();
			}
		});
	}
</script>
</body>
</html>
