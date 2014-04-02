<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>后台管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/css/admin.css";?>" />
<script charset="UTF-8" src="/iwebshop/runtime/systemjs/jquery-1.4.4.min.js"></script>
<script charset="UTF-8" src="/iwebshop/runtime/systemjs/artdialog/artDialog.min.js"></script>
<script charset="UTF-8" src="/iwebshop/runtime/systemjs/form.js"></script>
<link rel="stylesheet" type="text/css" href="/iwebshop/runtime/systemjs/autovalidate/style.css"/><script charset="UTF-8" src="/iwebshop/runtime/systemjs/autovalidate/validate.js"></script>
<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/common.js";?>"></script>
<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/admin.js";?>"></script>
<script type='text/javascript' src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/javascript/menu.js";?>"></script>
</head>
<body>
<div class="container">
	<div id="header">
		<div class="logo">
			<a href="<?php echo IUrl::creatUrl("/system/default");?>"><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/logo.gif";?>" width="303" height="43" /></a>
		</div>
		<div id="menu">
			<ul name="menu">
			</ul>
		</div>
		<p><a href="<?php echo IUrl::creatUrl("/systemadmin/logout");?>">退出管理</a> <a href="<?php echo IUrl::creatUrl("/system/default");?>">后台首页</a> <a href="<?php echo IUrl::creatUrl("");?>" target='_blank'>商城首页</a> <span>您好 <label class='bold'><?php echo isset($this->admin['admin_name'])?$this->admin['admin_name']:"";?></label>，当前身份 <label class='bold'><?php echo isset($this->admin['admin_role_name'])?$this->admin['admin_role_name']:"";?></label></span></p>
	</div>
	<?php $admin_id = $this->admin['admin_id']?>
	<div id="info_bar"><label class="navindex"><a href="<?php echo IUrl::creatUrl("/system/navigation");?>">快速导航管理</a></label><span class="nav_sec">
	<?php $query = new IQuery("quick_naviga");$query->where = "adminid = $admin_id and is_del = 0";$items = $query->find(); foreach($items as $key => $item){?>
	<a href="<?php echo isset($item['url'])?$item['url']:"";?>" class="selected"><?php echo isset($item['naviga_name'])?$item['naviga_name']:"";?></a>
	<?php }?>
	</span></div>
	<div id="admin_left">
		<ul class="submenu">
		</ul>
		<div id="copyright">
			
		</div>
	</div>
	<?php $menu = new Menu();?>
	<script type='text/javascript'>
		var data = <?php echo $menu->submenu();?>;
		var current = '<?php echo $menu->current;?>';
		var url='<?php echo IUrl::creatUrl("/");?>';
		initMenu(data,current,url);
	</script>
	<div id="admin_right">
	<div class="content_box" style="border:none">
	<div class="content">
		<?php $installfile = 'install';?>
		<?php if(file_exists($installfile)){?>
		<div class="red_box"><img src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/error.gif";?>" />您的安装目录没有删除，为了商店安全，请尽快删除！</div>
		<?php }?>
		<table width="45%" cellspacing="0" cellpadding="5" class="border_table_org" style="float:left">
			<thead>
				<tr><th>概况</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<table class="list_table2" width="100%">
							<colgroup>
								<col width="100px" />
								<col />
								<col width="80px" />
							</colgroup>
							<tr><th>销售总额</th><td colspan="2"><?php $query = new IQuery("order");$query->fields = "sum(order_amount) as amount";$query->where = "`status` = 5";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php if(empty($item['amount'])){?>0<?php }else{?><?php echo isset($item['amount'])?$item['amount']:"";?><?php }?></b> 元<?php }?></td></tr>
							<tr><th>今年销售总额</th><td colspan="2"><?php $query = new IQuery("order");$query->fields = "sum(order_amount) as amount";$query->where = "`status` = 5 and YEAR(create_time) = YEAR(now())";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php if(empty($item['amount'])){?>0<?php }else{?><?php echo isset($item['amount'])?$item['amount']:"";?><?php }?></b> 元<?php }?></td></tr>
							<tr><th>客户</th><td colspan="2"><?php $query = new IQuery("user");$query->fields = "count(id) as coun";$items = $query->find(); foreach($items as $key => $item){?><?php echo isset($item['coun'])?$item['coun']:"";?>个<?php }?></td></tr>
							<tr><th>产品</th><td colspan="2"><?php $query = new IQuery("goods");$query->fields = "count(id) as coun";$query->where = "is_del = 0";$items = $query->find(); foreach($items as $key => $item){?><?php echo isset($item['coun'])?$item['coun']:"";?>个<?php }?></td></tr>
							<tr><th>咨询</th><td>总共：<?php $query = new IQuery("refer");$query->fields = "count(id) as coun";$items = $query->find(); foreach($items as $key => $item){?><?php echo isset($item['coun'])?$item['coun']:"";?>个<?php }?></td><td><?php $query = new IQuery("refer");$query->fields = "count(id) as coun";$query->where = "`status` = 0";$items = $query->find(); foreach($items as $key => $item){?>未处理<a href="<?php echo IUrl::creatUrl("/comment/refer_list/status/0");?>"><b class="red3 f14"><?php echo isset($item['coun'])?$item['coun']:"";?></b></a>个<?php }?></td></tr>
							<tr><th>评论</th><td colspan="2"><?php $query = new IQuery("comment");$query->fields = "count(id) as coun";$items = $query->find(); foreach($items as $key => $item){?>总共：<a href="<?php echo IUrl::creatUrl("/comment/comment_list");?>"><b class="red3 f14"><?php echo isset($item['coun'])?$item['coun']:"";?></b></a>个<?php }?></td></tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		<table width="45%" cellspacing="0" cellpadding="5" class="border_table_org" style="float:left">
			<thead>
				<tr><th>订单信息</th></tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<table class="list_table2" width="100%">
							<colgroup>
								<col width="100px" />
								<col />
							</colgroup>
							<tr><th>总订单</th><td colspan="2"><?php $query = new IQuery("order");$query->fields = "count(id) as coun";$query->where = "if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['coun'])?$item['coun']:"";?></b>个<?php }?></td></tr>
							<tr><th>新订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as coun";$query->where = "status = 1 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['coun'])?$item['coun']:"";?></b> 个<?php }?></td></tr>
							<tr><th>未付款订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as coun";$query->where = "pay_status = 0 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/order_list/pay_status/0");?>"><?php echo isset($item['coun'])?$item['coun']:"";?>个</a><?php }?></td></tr>
							<tr><th>未发货订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as coun";$query->where = "distribution_status = 0 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/order_list/distribution_status/0");?>"><?php echo isset($item['coun'])?$item['coun']:"";?>个</a><?php }?></td></tr>
							<tr><th>七天未确认订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as coun";$query->where = "distribution_status = 1 and pay_status = 1 and status = 2 and to_days(now())-to_days(send_time)>7 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><b class="f14 red3"><?php echo isset($item['coun'])?$item['coun']:"";?></b>个<?php }?></td></tr>
							<tr><th>完成订单</th><td><?php $query = new IQuery("order");$query->fields = "count(id) as coun";$query->where = "`status` = 5 and if_del = 0";$items = $query->find(); foreach($items as $key => $item){?><a href="<?php echo IUrl::creatUrl("/order/order_list/status/5");?>"><b class="f14 red3"><?php echo isset($item['coun'])?$item['coun']:"";?></b>个</a><?php }?></td></tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

		<table width="98%" cellspacing="0" cellpadding="0" class="border_table_org" style="float:left">
			<thead>
				<tr><th>最新10条订单</th></tr>
			</thead>
			<tbody>
				<tr>
					<td style="padding:5px 0">
						<table class="list_table3" width="100%">
							<colgroup>
								<col width="200px" />
								<col width="100px" />
								<col width="85px" />
								<col width="80px" />
								<col width="150px" />
								<col />
							</colgroup>
							<thead>
									<th>订单号</th>
									<th>收货人</th>
									<th>支付状态</th>
									<th>金额</th>
									<th>下单时间</th>
									<th>操作</th>
							</thead>
							<tbody>
							<?php $query = new IQuery("order as o");$query->join = "left join delivery as d on o.distribution = d.id left join payment as p on o.pay_type = p.id left join user as u on u.id = o.user_id";$query->fields = "o.id as oid,d.name as dname,p.name as pname,o.order_no,o.accept_name,o.pay_status,o.distribution_status,u.username,o.create_time,o.status,o.if_print,o.order_amount";$query->where = "o.status < 3 and if_del = 0";$query->order = "o.id desc";$query->limit = "10";$items = $query->find(); foreach($items as $key => $item){?>
							<tr>
								<td><?php echo isset($item['order_no'])?$item['order_no']:"";?></td>
								<td><b><?php echo isset($item['accept_name'])?$item['accept_name']:"";?></b></td>
								<td><?php if($item['pay_status']==0){?>未付款<?php }elseif($item['pay_status']==1){?><b>已付款</b><?php }elseif($item['pay_status']==2){?>退款完成<?php }else{?><span class="red"><b>申请退款</b></span><?php }?></td>
								<td><b class="red3">￥<?php echo isset($item['order_amount'])?$item['order_amount']:"";?></b></td>
								<td><?php echo isset($item['create_time'])?$item['create_time']:"";?></td>
								<td><a href="<?php echo IUrl::creatUrl("/order/order_show/id/$item[oid]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_check.gif";?>" title="查看" /></a>					<?php if($item['status']<3){?>
									<a href="<?php echo IUrl::creatUrl("/order/order_edit/id/$item[oid]");?>"><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_edit.gif";?>" title="编辑"/></a>
									<?php }else{?>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<?php }?>
									<a href="javascript:void(0)" onclick="delModel({link:'<?php echo IUrl::creatUrl("/order/order_del/id/$item[oid]");?>'})" ><img class="operator" src="<?php echo IUrl::creatUrl("")."views/".$this->theme."/skin/".$this->skin."/images/admin/icon_del.gif";?>" title="删除"/></a>
								</td>
							</tr>
							<?php }?>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

	</div>
</div>
	</div>
	<div id="separator"></div>
</div>
<script type='text/javascript'>
	//隔行换色
	$(".list_table tr::nth-child(even)").addClass('even');
	$(".list_table tr").hover(
		function () {
			$(this).addClass("sel");
		},
		function () {
			$(this).removeClass("sel");
		}
	);
	$(function(){
		 $('#headth th').each(function(i){
			var width = $('#headth th:eq('+i+')').width();
			$('#conth tr:eq(0) td:eq('+i+')').width(width-2);
		});
	});
</script>
</body>
</html>
