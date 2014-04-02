<?php
/**
 * @copyright (c) 2011 jooyea.net
 * @file upload_class.php
 * @brief 文件上传处理
 * @author nswe
 * @date 2010-12-06
 * @version 0.6
 */

/**
 * @class IUpload
 * @brief 文件上传类
 */
class IUpload
{
	//允许上传附件类型
	private $allowType = array('jpg','gif','png','zip','rar','docx','doc');

	//附件存放物理目录
	private $dir = 'upload';

	//最大允许文件大小，单位为B(字节)
    private $maxsize;

    /**
     * @brief 构造函数
     * @param Int   $size 允许最大上传KB数
     * @param Array $type 允许上传的类型
     */
    function __construct($size = 2048,$type = array())
    {
    	//设置附件上传类型
    	if(!empty($type))
    	{
    		$this->allowType = $type;
    	}

    	//设置附件上传最大值
    	$ini_max_size  = $this->getIniPostMaxSize();
    	$uploadMaxSize = $size << 10;
    	$this->maxsize = ($uploadMaxSize <= $ini_max_size) ? $uploadMaxSize : $ini_max_size;
    }

    /**
     * @brief 获取环境POST数据的最大上传值
     * @return int 最大上传的字节数
     */
    private function getIniPostMaxSize()
    {
    	$maxSize = trim(ini_get('post_max_size'));
	    $unit    = strtolower($maxSize{strlen($maxSize)-1});
	    switch($unit)
	    {
	    	//GB单位
	        case 'g':
	        {
	        	return intval($maxSize) << 30;
	        }

			//MB单位
	        case 'm':
	        {
	        	return intval($maxSize) << 20;
	        }

			//KB单位
	        case 'k':
	        default:
	        {
	        	return intval($maxSize) << 10;
	        }
	        break;
	    }
    }

    /**
     * @brief 设置上传文件存放目录
     * @param String $dir 文件存放目录
     */
    function setDir($dir)
    {
    	if($dir != '' && !is_dir($dir))
    	{
    		IFile::mkdir($dir);
    	}
    	$dir       = strtr($dir,'\\','/');
    	$this->dir = substr($dir,0,-1)=='/' ? $dir : $dir.'/';
    }

    /**
     * @brief  开始执行上传
     * @return array 包含上传成功信息的数组
     *		$file = array(
	 *			 name    如果上传成功，则返回上传后的文件名称，如果失败，则返回客户端名称
	 *			 size    上传附件大小
	 *           fileSrc 上传文件完整路径
	 *			 dir     上传目录
	 *			 ininame 上传图片名
	 *			 flag    -1:文件类型不允许; -2:文件大小超出限制; 1:上传成功
	 *			 ext     上传附件扩展名
     *		);
     */
    public function execute()
    {
    	//总的文件上传信息
    	$info = array();

        foreach($_FILES as $field => $file)
        {
            $fileInfo = array();

			//不存在上传的文件名
            if(!isset($_FILES[$field]['name']) || $_FILES[$field]['name'] == '' || !isset($_FILES[$field]['tmp_name']))
            {
            	continue;
            }

			//上传控件为数组格式 file[]格式
            if(is_array($_FILES[$field]['name']))
            {
                $keys = array_keys($_FILES[$field]['name']);

                foreach($keys as $key)
                {
                    if(!isset($_FILES[$field]['name'][$key]) || $_FILES[$field]['name'][$key] == '')
                    {
                        continue;
                    }

                    //获取扩展名
                    $fileext = IFile::getFileType($_FILES[$field]['tmp_name'][$key]);
                    if(is_array($fileext) || $fileext == null)
                    {
                        $fileext = IFile::getFileSuffix($_FILES[$field]['name'][$key]);
                    }

					/*开始上传文件*/
                    //(1)上传类型不符合
                    if(!in_array($fileext,$this->allowType))
                    {
                        $fileInfo[$key]['name'] = $_FILES[$field]['name'][$key];
                        $fileInfo[$key]['flag'] = -1;
                    }

                    //(2)上传大小不符合
                    else if($_FILES[$field]['size'][$key] > $this->maxsize)
                    {
                        $fileInfo[$key]['name'] = $_FILES[$field]['name'][$key];
                        $fileInfo[$key]['flag'] = -2;
                    }

					//(3)成功情况
                    else
                    {
	                    //修改图片状态值
	                    $fileInfo[$key]['name']    = ITime::getDateTime('Ymdhis').mt_rand(100,999).'.'.$fileext;
	                    $fileInfo[$key]['dir']     = $this->dir;
	                    $fileInfo[$key]['size']    = $_FILES[$field]['size'][$key];
	                    $fileInfo[$key]['ininame'] = $_FILES[$field]['name'][$key];
	                    $fileInfo[$key]['ext']     = $fileext;
	                    $fileInfo[$key]['fileSrc'] = $fileInfo[$key]['dir'].$fileInfo[$key]['name'];

	                    if(is_uploaded_file($_FILES[$field]['tmp_name'][$key]))
	                    {
	                        if(move_uploaded_file($_FILES[$field]['tmp_name'][$key],$this->dir.$fileInfo[$key]['name']))
	                        {
	                            if(file_exists($_FILES[$field]['tmp_name'][$key]))
	                            {
	                                IFile::unlink($_FILES[$field]['tmp_name'][$key]);
	                            }
	                            $fileInfo[$key]['flag'] = 1;
	                        }
	                    }
                    }
                }
            }
            else
            {
                if($_FILES[$field]['name'] == '' || $_FILES[$field]['tmp_name'] == '')
                {
                    continue;
                }

                //获取扩展名
                $fileext = IFile::getFileType($_FILES[$field]['tmp_name']);
                if(is_array($fileext) || $fileext == null)
                {
                    $fileext = IFile::getFileSuffix($_FILES[$field]['name']);
                }

                /*开始上传文件*/
                //(1)上传类型不符合
                if(!in_array($fileext,$this->allowType))
                {
                    $fileInfo[0]['name'] = $_FILES[$field]['name'];
                    $fileInfo[0]['flag'] = -1;
                }

                //(2)上传大小不符合
                else if($_FILES[$field]['size'] > $this->maxsize)
                {
                    $fileInfo[0]['name'] = $_FILES[$field]['name'];
                    $fileInfo[0]['flag'] = -2;
                }

				//(3)成功情况
                else
                {
	                //修改图片状态值
	                $fileInfo[0]['name']    = ITime::getDateTime('Ymdhis').mt_rand(100,999).'.'.$fileext;
	                $fileInfo[0]['dir']     = $this->dir;
	                $fileInfo[0]['size']    = $_FILES[$field]['size'];
	                $fileInfo[0]['ininame'] = $_FILES[$field]['name'];
	                $fileInfo[0]['ext']     = $fileext;
	                $fileInfo[0]['fileSrc'] = $fileInfo[0]['dir'].$fileInfo[0]['name'];

	                if(is_uploaded_file($_FILES[$field]['tmp_name']))
	                {
	                    if(move_uploaded_file($_FILES[$field]['tmp_name'],$this->dir.$fileInfo[0]['name']))
	                    {
	                        if(file_exists($_FILES[$field]['tmp_name']))
	                        {
	                            IFile::unlink($_FILES[$field]['tmp_name']);
	                        }
	                        $fileInfo[0]['flag'] = 1;
	                    }
	                }
                }
            }
            $info[$field]=$fileInfo;
        }
        return $info;
    }

}
?>