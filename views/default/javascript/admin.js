jQuery(function(){
	//高度自适应
	initLayout();   
	$(window).resize(function(){   
		initLayout();   
	});
	function initLayout() {   
		var h1 = document.documentElement.clientHeight - $("#header").outerHeight(true) - $("#info_bar").height();   
		var h2 = h1 - $(".headbar").height() - $(".pages_bar").height() - 25; 
		$('#admin_left').height(h1); 
		$('#admin_right .content').height(h2);
	}
	//一级菜单切换
	$("#menu ul li:first-child").addClass("first");
	$("#menu ul li:last-child").addClass("last");
	$(":[name='menu']>li").click(function(){
		$(this).siblings().removeClass("selected");
        $(this).addClass("selected");					   
	});	
	//二级菜单展示效果
	$("ul.submenu>li>span").toggle(
		function(){
			$(this).next().css("display","none");
			$(this).addClass("selected");
		},
		function(){
			$(this).next().css("display","");
			$(this).removeClass("selected");
		}
	);
	//文字滚动显示
	$("#tips a:not(:first)").css("display","none");
	var tips_l=$("#tips a:last");
	var tips_f=$("#tips a:first");
	setInterval(function(){
		if($("#tips").children().length	!= 1){			 
			if(tips_l.is(":visible")){
				tips_f.fadeIn(500);
				tips_l.hide()
			}else{
				$("#tips a:visible").addClass("now");
				$("#tips a.now").next().fadeIn(500);
				$("#tips a.now").hide().removeClass("now");
			}
		}
	},3000);
	//搜索
	var sch_val = "输入商铺名称";
	$(".search>input.text").blur(
		function(){
			if($(this).val()==''){
				$(this).val(sch_val);
			}
		}
	).click(
		function(){
			if($(this).val()==sch_val){
				$(this).val('');
			}
		}
	);
	//关闭侧边栏
	$("#separator").click(function(){
			document.body.className = (document.body.className == "folden") ? "":"folden";
		}
	);
	
	/*
	//表格排序
	var headcells = $("tr[role='head']>th");
	$(headcells+"[sort='true']").css("cursor","pointer").click(
		function(){
			var index=headcells.index(this)+1;
			var arr=[]; 
			var row=$('#list_table tbody tr');
			var dataType=$(this).attr('datatype'); 
			$.each(row,function(i){arr[i]=row[i]});
			if($(this).find("span").hasClass("arrows_down")){
				arr.reverse();
				$(this).find("span").attr("className","arrows");
			}else {
				arr.sort(sortStr(index,dataType))
				$(this).find("span").attr("className","arrows_down");
			}
			var fragment=document.createDocumentFragment();
			$.each(arr,function(i){
				fragment.appendChild(arr[i]);
			});
			$('#list_table tbody').append(fragment);
		}
	);
	*/

});
function sortStr(index,dataType){ 
	return function(a,b){
		var aText=$(a).find('td:nth-child('+index+')').text();
		var bText=$(b).find('td:nth-child('+index+')').text();
		if(dataType!='text'){
			aText=Parse(aText,dataType);
			bText=Parse(bText,dataType);
			return aText>bText?-1:bText>aText?1:0;
		}else return aText.localeCompare(bText);
	} 
} 
function Parse(data,dataType){ 
	switch(dataType){ 
		case 'num': 
		return parseFloat(data)||0 
		case 'date': 
		return Date.parse(data)||0 
		default : 
		return splitStr(data) 
	}
} 
function splitStr(data){ 
	var re=/^[\$a-zA-z\u4e00-\u9fa5 ]*(.*?)[a-zA-z\u4e00-\u9fa5 ]*$/ 
	data=data.replace(re,'$1') 
	return parseFloat(data) 
}
//给select下拉列表设定初始值
function setSelected(id,value)
{
objSelect=document.getElementById(id)
    for(var i=0;i<objSelect.options.length;i++)
    {
        if(objSelect.options[i].value == value || objSelect.options[i].text == value)
        {
            objSelect.options[i].selected = true;
            break;
        }
     }
}
