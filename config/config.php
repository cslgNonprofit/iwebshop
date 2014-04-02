<?php
return array(
	'logs'=>array(
		'path'=>'logs/log',
		'type'=>'file'
	),
	'DB'=>array(
		'type'=>'mysql',
        'tablePre'=>'iwebshop_',
		'read'=>array(
			array('host'=>'localhost:3306','user'=>'root','passwd'=>'x297612','name'=>'iwebshop'),
		),

		'write'=>array(
			'host'=>'localhost:3306','user'=>'root','passwd'=>'x297612','name'=>'iwebshop',
		),
	),
	'langPath' => 'language',
	'viewPath' => 'views',
    'classes' => 'classes.*',
    'rewriteRule' =>'url',
	'theme' => 'default',		//主题
	'skin' => 'default',		//风格
	'timezone'	=> 'Etc/GMT-8',
	'upload' => 'upload',
	'dbbackup' => 'backup/database',
	'safe' => 'cookie',
	'safeLevel' => 'none',
	'lang' => 'zh_sc',
	'debug'=> false,
	'configExt'=> array('site_config'=>'config/site_config.php'),
	'encryptKey'=>'929362647e729f9b672db48af0f4e3b8',
);
?>