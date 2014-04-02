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
	<?php $seo_data['title']=isset($site_config['name'])?$site_config['name']:""?>
	<?php if(isset($site_config['index_seo_title']) && $site_config['index_seo_title']!="" ){?>
		<?php $seo_data['title'].=$site_config['index_seo_title'];?>
	<?php }?>
	<?php if(isset($site_config['index_seo_keywords']) && $site_config['index_seo_keywords']!="" ){?>
		<?php $seo_data['keywords']=$site_config['index_seo_keywords'];?>
	<?php }?>
	<?php if(isset($site_config['index_seo_description']) && $site_config['index_seo_description']!="" ){?>
		<?php $seo_data['description']=$site_config['index_seo_description'];?>
	<?php }?>
	<?php seo::set($seo_data);?>

	<script type='text/javascript'>
		//dom载入完毕执行
		jQuery(function(){
			//index 分类展示
			$('#index_category tr').hover(
				function(){
					$(this).addClass('current');
				},
				function(){
					$(this).removeClass('current');
				}
			);

			//email订阅 事件绑定
			var tmpObj = $('input:text[name="orderinfo"]');
			var defaultText = tmpObj.val();
			tmpObj.bind({
				focus:function(){checkInput($(this),defaultText);},
				blur :function(){checkInput($(this),defaultText);}
			});
		});

		//显示抢购倒计时
		var cd_timer=new countdown();

		//电子邮件订阅
		function orderinfo()
		{
			var email = $('[name="orderinfo"]').val();
			if(validate(email,'email') == false)
			{
				alert('请填写正确的email地址');
			}
			else
			{
				$.getJSON('<?php echo IUrl::creatUrl("/site/email_registry");?>',{email:email},function(content){
					if(content.isError == false)
					{
						alert('订阅成功');
						$('[name="orderinfo"]').val('');
					}
					else
						alert(content.message);
				});
			}
		}
	</script>

	<div class="wrapper clearfix">
		<div class="sidebar f_r">

			<!--cms新闻展示-->
			<div class="box m_10">
				<div class="title"><h2>Shop资讯</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/article");?>">更多...</a></div>
				<div class="cont">
					<ul class="list">
						<?php $query = new IQuery("article");$query->where = "visiblity = 1 and top = 1";$query->order = "sort ASC,id DESC";$query->fields = "title,id,style,color";$query->limit = "5";$items = $query->find(); foreach($items as $key => $item){?>
						<?php $tmpId=$item['id'];?>
						<li><a href="<?php echo IUrl::creatUrl("/site/article_detail/id/$tmpId");?>"><?php echo Article::showTitle($item['title'],$item['color'],$item['style']);?></a></li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--cms新闻展示-->

			<div class="box">
				<div id="adHere_7"></div>
				<script language="javascript">
				(new adLoader()).load(7,'adHere_7');
				</script>
			</div>
		</div>

		<div class="main f_l">

			<?php if(count($this->index_slide)){?>
			<?php $num=count($this->index_slide);$i=0;$width=intval(100/$num);?>
			<div id="slide_box" class="slide box" style="width:750px;height:299px;overflow:hidden;position:relative;">
				<div id="slide_img" style="position:relative;">
					<?php foreach($this->index_slide as $key => $item){?>
					<a href="<?php echo isset($item['url'])?$item['url']:"";?>" target="_blank"><img src="<?php echo IUrl::creatUrl("")."$item[img]";?>" width="750" /></a>
					<?php break;?>
					<?php }?>
				</div>
				<div class="slide_button" style="width:760px;overflow:hidden;">
					<?php foreach($this->index_slide as $key => $item){?>
						<?php $i++;?>
						<?php if($i==$num){?>
							<?php $width=100-($num-1)*$width;?>
						<?php }?>
					<a style="width:<?php echo isset($width)?$width:"";?>%" href='<?php echo isset($item['url'])?$item['url']:"";?>' pic='<?php echo IUrl::creatUrl("")."$item[img]";?>'><?php echo isset($item['name'])?$item['name']:"";?></a>
					<?php }?>
				</div>

			</div>
			<?php }else{?>
			<div class="slide box" style="width:728px;height:299px;overflow:hidden;position:relative;">
			</div>
			<?php }?>

		</div>
<style type='text/css'>
.slide_button{position:absolute;bottom:0px;left:0px;right:0px;height:30px;overflow:hidden;width:100%;background:#fff;}
.slide_button a{display:block;height:30px;line-height:30px;color:#333;float:left;background:#dddddd;}
.slide_button a.current,#slide_name a:hover{background:#a8a8a8;color:#fff; font-weight:bold}
</style>
<script type='text/javascript'>
function slide(arr)
{
	var _self=this;
	this.is_mouseover=false;
	this.arr=arr;

	this.init=function()
	{
		$(arr+" .slide_button a").mouseover(function(){ _self.show(this); });
		$(arr+" .slide_button a").click(function(){_self.show(this);return false;});
		$(arr+" .slide_button a:first").click();
	}

	this.show=function(slide_a)
	{
		$(arr+ " .slide_button a").removeClass('current');
		$(slide_a).addClass('current');
		var src=$(slide_a).attr('pic');
		var e=$(arr+ " img");
		$(arr + " #slide_img a").attr('href',slide_a.href);
		e.fadeOut('fast',function(){e.attr('src',src);e.fadeIn('fast');});
		$(arr+ " .slide_button a").attr('href',this.href);
	}

	this.autonext=function()
	{
		if(_self.is_mouseover==true)
		{
			return;
		}
		var e=$(_self.arr).find(".slide_button .current").next();
		if(e.length==0)
		{
			e=$(_self.arr).find(".slide_button a:first");
		}
		e.click();

	}
	$(arr).hover(function(){_self.is_mouseover=true;},function(){_self.is_mouseover=false;});
	setInterval(_self.autonext,3000);
}

$(document).ready(function(){
	var slideObj=new slide("#slide_box");
	slideObj.init();
});

</script>
	</div>

	<div class="m_10">
		<div id="adHere_6"></div>
		<script language="javascript">
		(new adLoader()).load(6,'adHere_6');
		</script>
	</div>

	<div class="wrapper clearfix">
		<div class="sidebar f_r">

			<!--团购-->
			<div class="group_on box m_10">
				<div class="title"><h2>团购商品</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/groupon");?>">更多...</a></div>
				<div class="cont">
					<ul class="ranklist">
						<?php $query = new IQuery("regiment");$query->where = "is_close = 0 and NOW() between start_time and end_time";$query->limit = "5";$query->fields = "id,title,regiment_price,img";$query->order = "id desc";$items = $query->find(); foreach($items as $key => $item){?>
						<li class="current">
							<?php $tmpId=$item['id'];?>
							<a href="<?php echo IUrl::creatUrl("/site/groupon/id/$tmpId");?>"><img width="60" height="60" alt="<?php echo isset($item['title'])?$item['title']:"";?>" src="<?php echo IUrl::creatUrl("")."$item[img]";?>"></a>
							<a class="p_name" title="<?php echo isset($item['title'])?$item['title']:"";?>" href="<?php echo IUrl::creatUrl("/site/groupon/id/$tmpId");?>"><?php echo isset($item['title'])?$item['title']:"";?></a><p class="light_gray">团购价：<em>￥<?php echo isset($item['regiment_price'])?$item['regiment_price']:"";?></em></p>
						</li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--团购-->

			<!--限时抢购-->
			<div class="buying box m_10">
				<div class="title"><h2>限时抢购</h2></div>
				<div class="cont clearfix">
					<ul class="prolist">
						<?php $query = new IQuery("promotion as p");$query->join = "left join goods as go on go.id = p.condition";$query->fields = "p.end_time,go.list_img as list_img,p.name as name,p.award_value as award_value,go.id as goods_id,p.id as p_id,end_time";$query->where = "p.type = 1 and p.is_close = 0 and go.is_del = 0 and NOW() between start_time and end_time AND go.id is not null";$query->limit = "2";$items = $query->find(); foreach($items as $key => $item){?>
						<?php $free_time = ITime::getDiffSec($item['end_time'])?>
						<li>
							<p class="countdown">倒计时:<br /><b id='cd_hour_<?php echo isset($item['p_id'])?$item['p_id']:"";?>'><?php echo floor($free_time/3600);?></b>时<b id='cd_minute_<?php echo isset($item['p_id'])?$item['p_id']:"";?>'><?php echo floor(($free_time%3600)/60);?></b>分<b id='cd_second_<?php echo isset($item['p_id'])?$item['p_id']:"";?>'><?php echo $free_time%60;?></b>秒</p>

							<script language="javascript">
								cd_timer.add(<?php echo isset($item['p_id'])?$item['p_id']:"";?>);
							</script>
							<?php $tmpGoodsId=$item['goods_id'];$tmpPId=$item['p_id'];?>
							<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId/promo/time/regiment_id/$tmpPId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" width="175" height="175" alt="<?php echo isset($item['name'])?$item['name']:"";?>" title="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
							<p class="pro_title"><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId/promo/time/regiment_id/$tmpPId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
							<p class="light_gray">抢购价：<b>￥<?php echo isset($item['award_value'])?$item['award_value']:"";?></b></p>
							<div></div>
						</li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--限时抢购-->

			<!--热卖商品-->
			<div class="hot box m_10">
				<div class="title"><h2>热卖商品</h2></div>
				<div class="cont clearfix">
					<ul class="prolist">
						<?php $query = new IQuery("commend_goods as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->where = "co.commend_id = 3 and go.is_del = 0 AND go.id is not null";$query->fields = "go.list_img,go.sell_price,go.name,go.id";$query->limit = "8";$query->order = "sort asc,id desc";$items = $query->find(); foreach($items as $key => $item){?>
						<li>
							<?php $tmpId=$item['id']?>
							<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" width="85" height="85" alt="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
							<p class="pro_title"><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
							<p class="brown"><b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b></p>
						</li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--热卖商品-->

			<!--公告通知-->
			<div class="box m_10">
				<div class="title"><h2>公告通知</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/notice");?>">更多...</a></div>
				<div class="cont">
					<ul class="list">
						<?php $query = new IQuery("announcement");$query->limit = "5";$query->order = "id desc";$items = $query->find(); foreach($items as $key => $item){?>
						<?php $tmpId=$item['id'];?>
						<li><a href="<?php echo IUrl::creatUrl("/site/notice_detail/id/$tmpId");?>"><?php echo isset($item['title'])?$item['title']:"";?></a></li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--公告通知-->

			<!--关键词-->
			<div class="box m_10">
				<div class="title"><h2>关键词</h2><a class="more" href="<?php echo IUrl::creatUrl("/site/tags");?>">更多...</a></div>
				<div class="tag cont t_l">
					<?php $classArray = array('bold orange', 'orange');$colorIndex=0;?>
					<?php $query = new IQuery("keyword");$query->where = "hot = 1";$query->limit = "8";$query->order = "`order` asc";$items = $query->find(); foreach($items as $key => $item){?>
					<?php $searchWord =urlencode($item['word']);?>
					<a href="<?php echo IUrl::creatUrl("/site/search_list/word/$searchWord");?>" class="<?php echo $classArray[$colorIndex%count($classArray)];?>"><?php echo isset($item['word'])?$item['word']:"";?></a>
					<?php $colorIndex++;?>
					<?php }?>
				</div>
			</div>
			<!--关键词-->

			<!--电子订阅-->
			<div class="book box m_10">
				<div class="title"><h2>电子订阅</h2></div>
				<div class="cont">
					<p>我们会将最新的资讯发到您的Email</p>
					<input type="text" class="gray_m light_gray f_l" name='orderinfo' value="输入您的电子邮箱地址" />
					<label class="btn_orange"><input type="button" onclick="orderinfo();" value="订阅" /></label>
				</div>
			</div>
			<!--电子订阅-->

		</div>

		<div class="main f_l">

			<!--商品分类展示-->
			<div class="category box">
				<div class="title2">
					<h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/category.gif";?>" alt="商品分类" width="155" height="36" /></h2>
					<a class="more" href="<?php echo IUrl::creatUrl("/site/sitemap");?>">全部商品分类</a>
				</div>
			</div>
			<table id="index_category" class="sort_table m_10" width="100%">
				<col width="100px" />
				<col />
				<?php foreach($this->goodsCategory as $key => $first){?>
				<?php if($first['visibility'] == 1){?>
				<tr>
					<?php $tmpFirstId=$first['id'];?>
					<th><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$tmpFirstId");?>"><?php echo isset($first['name'])?$first['name']:"";?></a></th>
					<td>
						<?php if(isset($first['second'])){?>
						<?php foreach($first['second'] as $key => $second){?>
							<?php if($second['visibility'] == 1){?>
								<?php $tmpSecondId=$second['id'];?>
								<a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$tmpSecondId");?>"><?php echo isset($second['name'])?$second['name']:"";?></a> |
							<?php }?>
						<?php }?>
						<?php }?>
					</td>
				</tr>
				<?php }?>
				<?php }?>
			</table>
			<!--商品分类展示-->

			<!--最新商品-->
			<div class="box yellow m_10">
				<div class="title2">
					<h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/new_product.gif";?>" alt="最新商品" width="160" height="36" /></h2>
				</div>
				<div class="cont clearfix">
					<ul class="prolist">
						<?php $query = new IQuery("commend_goods as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->where = "co.commend_id = 1 and go.is_del = 0 AND go.id is not null";$query->fields = "go.list_img,go.sell_price,go.name,go.market_price,go.id";$query->limit = "8";$query->order = "id desc";$query->group = "id";$items = $query->find(); foreach($items as $key => $item){?>
						<li style="overflow:hidden">
							<?php $tmpId=$item['id'];?>
							<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" width="175" height="175" alt="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
							<p class="pro_title"><a title="<?php echo isset($item['name'])?$item['name']:"";?>" href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
							<p class="brown">惊喜价：<b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b></p>
							<p class="light_gray">市场价：<s>￥<?php echo isset($item['market_price'])?$item['market_price']:"";?></s></p>
						</li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--最新商品-->

			<!--首页推荐商品-->
			<?php $colorArray = array('green','yellow','purple');$colorIndex = 0;?>
			<?php foreach($this->goodsCategory as $key => $first){?>
			<?php if($first['visibility'] == 1){?>
			<div class="box <?php echo $colorArray[$colorIndex%count($colorArray)];?> m_10">
				<div class="title title3">
					<?php $tmpFirstId=$first['id'];?>
					<h2><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$tmpFirstId");?>"><strong><?php echo isset($first['name'])?$first['name']:"";?></strong></a></h2>
					<a class="more" href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$tmpFirstId");?>">更多商品...</a>
					<ul class="category f_r">
						<?php $secondIdArray = array()?>
						<?php if(isset($first['second'])){?>
						<?php foreach($first['second'] as $key => $second){?>
							<?php if($second['visibility'] == 1){?>
								<?php $secondIdArray[] = $second['id']?>
								<?php if($second['more']){?>
									<?php foreach($second['more'] as $key => $v){?>
										<?php $secondIdArray[] = $v['id']?>
									<?php }?>
								<?php }?>
								<?php $tmpSecondId=$second['id'];?>
								<li><a href="<?php echo IUrl::creatUrl("/site/pro_list/cat/$tmpSecondId");?>"><?php echo isset($second['name'])?$second['name']:"";?></a><span></span></li>
							<?php }?>
						<?php }?>
						<?php }?>
					</ul>
				</div>

				<div class="cont clearfix">
					<ul class="prolist">
						<?php $recomCatId = $first['id']?>
						<?php if(!empty($secondIdArray)){?>
							<?php $recomCatId .= ','.join(',', $secondIdArray );?>
						<?php }?>
						<?php $query = new IQuery("category_extend as ca");$query->join = "left join goods as go on go.id = ca.goods_id";$query->where = "ca.category_id in ($recomCatId) and go.is_del = 0";$query->limit = "8";$query->order = "go.sort asc,go.id desc";$query->fields = "DISTINCT go.list_img,go.id,go.name,go.sell_price,go.market_price";$items = $query->find(); foreach($items as $key => $item){?>
						<li style="overflow:hidden">
							<?php $tmpId=$item['id'];?>
							<a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" width="175" height="175" alt="<?php echo isset($item['name'])?$item['name']:"";?>" title="<?php echo isset($item['name'])?$item['name']:"";?>" /></a>
							<p class="pro_title"><a title="<?php echo isset($item['name'])?$item['name']:"";?>" href="<?php echo IUrl::creatUrl("/site/products/id/$tmpId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></p>
							<p class="brown">惊喜价：<b>￥<?php echo isset($item['sell_price'])?$item['sell_price']:"";?></b></p>
							<p class="light_gray">市场价：<s>￥<?php echo isset($item['market_price'])?$item['market_price']:"";?></s></p>
						</li>
						<?php }?>
					</ul>
				</div>

			</div>
			<?php $colorIndex++;?>
			<?php }?>
			<?php }?>

			<!--品牌列表-->
			<div class="brand box m_10">
				<div class="title2"><h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/brand.gif";?>" alt="品牌列表" width="155" height="36" /></h2><a class="more" href="<?php echo IUrl::creatUrl("/site/brand");?>">&lt;<span>全部品牌</span>&gt;</a></div>
				<div class="cont clearfix">
					<ul>
						<?php $query = new IQuery("brand");$query->fields = "id,name,logo";$query->order = "sort asc";$query->limit = "6";$items = $query->find(); foreach($items as $key => $item){?>
						<?php $tmpId=$item['id'];?>
						<li><a href="<?php echo IUrl::creatUrl("/site/brand_zone/id/$tmpId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[logo]";?>"  width="110" height="50"/><?php echo isset($item['name'])?$item['name']:"";?></a></li>
						<?php }?>
					</ul>
				</div>
			</div>
			<!--品牌列表-->

			<!--最新评论-->
			<div class="comment box m_10">
				<div class="title2"><h2><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/front/comment.gif";?>" alt="最新评论" width="155" height="36" /></h2></div>
				<div class="cont clearfix">
					<?php $query = new IQuery("comment as co");$query->join = "left join goods as go on co.goods_id = go.id";$query->order = "co.id desc";$query->limit = "6";$query->where = "co.status = 1 AND go.is_del = 0 AND go.id is not null";$query->fields = "go.list_img as list_img,go.name as name,co.point,co.contents,co.goods_id";$items = $query->find(); foreach($items as $key => $item){?>
					<dl class="no_bg">
						<?php $tmpGoodsId=$item['goods_id'];?>
						<dt><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId");?>"><img src="<?php echo IUrl::creatUrl("")."$item[list_img]";?>" width="65" height="65" /></a></dt>
						<dd><a href="<?php echo IUrl::creatUrl("/site/products/id/$tmpGoodsId");?>"><?php echo isset($item['name'])?$item['name']:"";?></a></dd>
						<dd><span class="grade"><i style="width:<?php echo $item['point']*14;?>px"></i></span></dd>
						<dd class="com_c"><?php echo isset($item['contents'])?$item['contents']:"";?></dd>
					</dl>
					<?php }?>
				</div>
			</div>
			<!--最新评论-->

		</div>
	</div>


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
