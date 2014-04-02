<?php
/**
 * @copyright Copyright(c) 2010 jooyea.net
 * @file application.php
 * @brief 应用的基本类文件
 * @author webning
 * @date 2010-12-10
 * @version 0.6
 */

/**
 * @brief IApplication 创建应用的基本类
 * @class IApplication
 */
abstract class IApplication
{
	//应用的名称
    public $name = 'My Application';
    //用户的编码
    public $charset = 'UTF-8';
    //用户的语言
    public $language = 'zh_sc';
    //应用的要目录
    private $basePath;
    //应用的config信息
    public $config;
    //id应用的唯一标识
    private $id;
    //运行时的路径
	private $runtimePath;
	//运行时的web目录
	private $webRunPath;
	//默认时区
    private $timezone = 'Asia/Shanghai';
    //渲染时的数据
    private $renderData = array();
    /**
     * @brief 构造函数
     * @param array or string $config 配置数组或者配置文件名称
     */
    public function __construct($config)
    {
        if(is_string($config)) $config = require($config);
        if(is_array($config)) $this->config = $config;
        else $this->config = array();

		//设为if true为了标注以后要再解决cli模式下的basePath
		if(!isset($_SERVER['DOCUMENT_ROOT']))
		{
			if(isset($_SERVER['SCRIPT_FILENAME']))
			{
				$_SERVER['DOCUMENT_ROOT'] = dirname( $_SERVER['SCRIPT_FILENAME'] );
			}
			elseif(isset($_SERVER['PATH_TRANSLATED']))
			{
				$_SERVER['DOCUMENT_ROOT'] =  dirname( rtrim($_SERVER['PATH_TRANSLATED'],"/\\"));
			}
		}

		if($web = true)
		{
			$script_dir = trim(dirname($_SERVER['SCRIPT_NAME']),'/\\');
			if( $script_dir != "" )
			{
				$script_dir .="/";
			}

			$basePath = rtrim($_SERVER['DOCUMENT_ROOT'],'/\\')."/" . $script_dir;
			$this->config['basePath'] = $basePath;
			$this->setBasePath($basePath);
		}

        if(isset($config['charset']))
        {
            $this->setCharset($config['charset']);
        }

        if(isset($config['classes']))
        {
            IWeb::setClasses($config['classes']);
        }
        if(isset($config['timezone']))
        {
            date_default_timezone_set($config['timezone']);
        }
        else
        {
            date_default_timezone_set($this->timezone);
        }

        $debugMode = (isset($config['debug']) && $config['debug'] === true ) ? true : false;
		$this->setDebugMode($debugMode);

		$this->disableMagicQuotes();

        if(!isset($config['upload'])) $this->config['upload'] = 'upload';

		//开始向拦截器里注册类
		if( isset($config['interceptor']) && is_array($config['interceptor']) )
		{
			IInterceptor::reg($config['interceptor']);
			register_shutdown_function( array('IInterceptor',"shutDown") );
		}
    }

    //执行请求
    abstract public function execRequest();
    /**
     * @brief 应用运行的方法
     * @return Void
     */
    public function run()
    {
		IInterceptor::run("onCreateApp");
        $this->execRequest();
		IInterceptor::run("onFinishApp");
    }
    /**
     * @brief 实现应用的结束方法
     * @param int $status 应该结束的状态码
     */
    public function end($status=0)
    {
        exit($status);
    }
    public function setId($id)
    {
        $this->id=$id;
    }
    public function getId()
    {
        return $this->id;
    }

    /**
     * @brief 取消魔法转义
     */
    public function disableMagicQuotes()
    {
		if(get_magic_quotes_gpc())
		{
			$_POST   = $this->_stripSlash($_POST);
			$_GET    = $this->_stripSlash($_GET);
			$_COOKIE = $this->_stripSlash($_COOKIE);
		}
    }

    /**
     * @brief 辅助disableMagicQuotes();
     */
    private function _stripSlash($arr)
    {
    	if(is_array($arr))
		{
			foreach($arr as $key=>$value)
			{
				$arr[$key] = $this->_stripSlash($value);
			}
			return $arr;
		}
		else
		{
			return stripslashes($arr);
		}
    }

    /**
     * @brief 设置调试模式
     * @param $flag true开启，false关闭
     */
    private function setDebugMode($flag)
    {
    	$basePath = $this->getBasePath();

    	if(function_exists("ini_set"))
		{
			ini_set("display_errors",$flag?"on":"off");
		}

    	if( $flag === true)
        {
			error_reporting(E_ALL | E_STRICT);
			IException::setDebugMode(true);
        }
		else
		{
			error_reporting(0);
			IException::setDebugMode(false);
		}

		set_error_handler("IException::phpError" , E_ALL|E_STRICT );
		set_exception_handler("IException::phpException");
		IException::setLogPath($basePath."backup/errorLog/".date("y-m-d").".log");
    }

    /**
     * @brief 设置应用的基本路径
     * @param string  $basePath 路径地址
     */
    public function setBasePath($basePath)
    {
        $this->basePath = $basePath;
    }
    /**
     * @brief 取得应用的路径
     * @return String 路径地址
     */
    public function getBasePath()
    {
        return $this->basePath;
    }
    /**
     * @brief 设置运行时的路径
     * @param mixed $runtimePath 路径地址
     */
    public function setRuntimePath($runtimePath)
    {
        $this->runtimePath = $runtimePath;
    }
    /**
     * @brief 得到当前的运行路径
     * @return String 路径地址
     */
    public function getRuntimePath()
    {
        if($this->runtimePath===null)
        {
            $this->runtimePath =  $this->getBasePath().'runtime'.DIRECTORY_SEPARATOR;
        }
        return $this->runtimePath;
	}
    /**
     * @brief 得到当前的运行URL路径
     * @return String 路径地址
     */
	public function getWebRunPath()
	{
		if($this->webRunPath === null)
		$this->webRunPath = IUrl::creatUrl('').str_replace(array(dirname(realpath(rtrim($_SERVER['DOCUMENT_ROOT'],'/\\')."/".ltrim($_SERVER['SCRIPT_NAME'],'/\\'))).DIRECTORY_SEPARATOR,'\\'),array('','/'),realpath($this->getRuntimePath()));
		return $this->webRunPath;
	}

    /**
     * @brief 设置渲染数据
     * @param array $data 数组的形式存储，渲染后键值将作为变量名。
     */
    public function setRenderData($data)
    {
        if(is_array($data))
        {
            $this->renderData = array_merge($this->renderData,$data);
        }
    }
    /**
     * @brief 取得应用级的渲染数据
     * @return array
     */
    public function getRenderData()
    {
        return $this->renderData;
    }
    /**
     * @brief 设置应用的语言
     * @param string  $language 语言名称
     */
    public function setLanguage($language)
    {
        $this->language = $language;
    }
    /**
     * @brief 得到应用的语言名
     * @return String 语言名称
     */
    public function getLanguage()
    {
        return $this->language;
    }
    /**
     * @brief 设置字符集编码
     * @param String $charset 字符编码
     */
    public function setCharset($charset)
    {
        $this->charset = $charset;
    }
    /**
     * @brief 获取字符集
     * @return String 字符集编码
     */
    public function getCharset()
    {
        return $this->charset;
    }
}
?>
