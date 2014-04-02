/**
 *
 * JSWordSeg类
 * 简单的模拟分词，分出来的词最少两个字，最多maxLength个字
 *
 * @author walu<imcnan@gmail.com>
 * @version 0.1
 */
function JSWordSeg()
{
	var _self=this;
	
	this.text="";
	this.title="";
	//分出的词的长度限制
	this.maxLength=5;

	/**
	 * 设置Text
	 * @param string text
	 */
	this.setText=function(text)
	{
		_self.text=text;
	}
	
	/**
	 * 设置title
	 * @param string title
	 */
	this.setTitle=function(title)
	{
		_self.title=title;
	}
	
	/**
	 * 开始分词，从title里构造词-》去text里寻找出现的次数
	 * @return object {词语:出现的次数，词语:出现的次数}
	 */
	this.run=function()
	{
		//先把title里不是英文、数字、中文的东西提成空格
		for(var i=0;i<_self.title.length;i++)
		{
			if( ! _self.title[i].match(/[_a-zA-Z0-9\u4e00-\u9fa5]/)  )
			{
				regexp=null;
				regexp=new RegExp(_self.title[i],"g");
				_self.title=_self.title.replace(regexp," ");
			}
		}
		
		var len=_self.title.length;
		var i,j,str,count;
		var re={};
		for(i=0;i<len-2;i++)
		{
			tmp = _self.title[i].match(/\s/);
			if( typeof(tmp) == "object" && tmp != null  )
			{
				continue;
			}
			
			for(j=i+2; 1;j++)
			{
				if(j>len)
				{
					break;
				}
				str=_self.title.substr(i,j-i);
				tmp=(str.match(/^[a-z0-9]+$/i) || str.length<=_self.maxLength) &&  !str.match(/\s/);
				if(!tmp)
				{
					break;
				}
				
				count=_self.count(str);
				if(count>0)
				{
					re[str]=count;
				}
			}
			
		}
		
		var re_bak=re;
		//对分出来的词进行去重,取最长的一个
		for(var key in re)
		{
			for(var key2 in re_bak)
			{
				if( key2.search(key)>=0 && key2.length>key.length )
				{
					delete(re_bak[key]);
				}
			}
		}
		re=re_bak;
		
		/*取总数的1/2个或者5个*/
		var cmax_key=0,total=0,i=0;
		for(var key in re)
		{
			total++;
		}
		total=parseInt(total/2);
		var fun_re={};
		while(1)
		{
			for(var key in re)
			{
				if(cmax_key==0)
				{
					cmax_key=key;
				}
				
				if( re[key] >= re[cmax_key] )
				{
					cmax_key=key;
				}
			}
			
			if(cmax_key!=0)
			{
				fun_re[cmax_key]=re[cmax_key];
				delete re[cmax_key];
				cmax_key=0;
				i++;
			}
			else if(cmax_key==0 || i>total || i>5)
			{
				break;
			}
		}
		return fun_re;
	}

	/**
	 * 检测word在text里出现的次数
	 * @param string word
	 */
	this.count=function(word)
	{
		if(word.length==0)
		{
			return 0;
		}

		var regexp=null;
		var text_new=_self.text;
		regexp=new RegExp(word,'ig');
		text_new=text_new.replace(regexp,""); 
		var diff=_self.text.length - text_new.length;
		return diff/(word.length);
	}
}

function clearTagWord()
{
	$(".wordBox[delAble=1]").remove();
}
function regMoveTagWord()
{
	$(".wordBoxButton").unbind('click');
	$(".wordBoxButton").click(function(){
		var tag = $(this).parents("span:first");
		tag.find("span").remove();
		tagText=tag.text();
		tagValue=$("#keywords_for_search").val().replace((tagText+","),"");
		$("#keywords_for_search").val(   tagValue   )
		$(this).parents("span:first").remove();
		tag.remove();
	});
}
function addTagWord(tag , delAble)
{
	var regexp=null;
	regexp = new RegExp(">\s*"+tag+"\s*<",'i');
	if($("#tagWord").html().search(regexp)<0)
	{
		var str=$('<span class="wordBox" contentEditable=false>'+tag+'<span class="wordBoxButton">X</span></span>');
		if(delAble)
		{
			str.attr("delAble",1);
		}
		$("#tagWord").append(str);
		regMoveTagWord();
		$("#keywords_for_search").val( $("#keywords_for_search").val()+tag+",");
	}
	$("#trTagWord").show();
}
