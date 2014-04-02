<?php
/**
 * @copyright Copyright(c) 2010 jooyea.net
 * @file jspackage_class.php
 * @brief 系统JS包加载类文件
 * @author webning
 * @date 2010-12-22
 * @version 0.6
 */

 /**
  * @class IJSPackage
  * @brief IJSPackage 系统JS加载类
  */
 class IJSPackage
 {
     //系统JS注册表
     private static $JSPackages=array(
	     'jquery'=>'jquery-1.4.4.min.js',
	     'form'=>'form.js',
	     'dialog'=>'artdialog/artDialog.min.js',
	     'kindeditor'=>'editor/kindeditor-min.js',
	     'validate'=>array(
		     'js'=>'autovalidate/validate.js',
		     'css'=>'autovalidate/style.css'
	     ),
	     'my97date' =>'my97date/wdatepicker.js'
     );
     /**
      * @brief 加载系统的JS方法
      * @param mixed $name
      * @return String
	  */
	 private static $createfiles = array();
     public static function load($name,$charset='UTF-8')
	 {
		 if(isset(self::$JSPackages[$name]))
		{
			if(!isset(self::$createfiles[$name]))
			{
				$is_file = false;
				$file = null;
				if(is_string(self::$JSPackages[$name]))
				{
					if(stripos(self::$JSPackages[$name],'/')===false)
					{
						$is_file = true;
						$file = self::$JSPackages[$name];
					}
					else $file = dirname(self::$JSPackages[$name]);
				}
				else
				{
					if(is_array(self::$JSPackages[$name]['js'])) $file = dirname(self::$JSPackages[$name]['js'][0]);
					else $file = dirname(self::$JSPackages[$name]['js']);
				}
				if(!file_exists(IWeb::$app->getRuntimePath().'systemjs/'.$file))
				{
					self::$createfiles[$name] = true;
					IFile::xcopy(IWEB_PATH.'web/js/source/'.$file,IWeb::$app->getRuntimePath().'systemjs/'.$file);
				}
			}
			$webjspath = IWeb::$app->getWebRunPath().'/systemjs/';
			if(is_string(self::$JSPackages[$name])) return '<script charset="'.$charset.'" src="'.$webjspath.self::$JSPackages[$name].'"></script>';
			else if(is_array(self::$JSPackages[$name]))
			{
				$str='';
				if(isset(self::$JSPackages[$name]['css']))
				{
					if(is_string(self::$JSPackages[$name]['css'])) $str .= '<link rel="stylesheet" type="text/css" href="'.$webjspath.self::$JSPackages[$name]['css'].'"/>';
					else if(is_array(self::$JSPackages[$name]['css']))
					{
						foreach(self::$JSPackages[$name]['css'] as $css)
						{
							$str .= '<link rel="stylesheet" type="text/css" href="'.$webjspath.$css.'"/>';
						}
					}
				}
				if(isset(self::$JSPackages[$name]['js']))
				{
					if(is_array(self::$JSPackages[$name]['js']))
					{
						foreach(self::$JSPackages[$name]['js'] as $js)
						{
							$str .= '<script charset="'.$charset.'" src="'.$webjspath.$js.'"></script>';
						}
					}
					else
					{
						$str .= '<script charset="'.$charset.'" src="'.$webjspath.self::$JSPackages[$name]['js'].'"></script>';
					}
				}

				return $str;
			}
		}
		 else return '';
	 }
 }

 ?>
