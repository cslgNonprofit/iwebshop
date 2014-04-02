<?php
/**
 * @class csv
 * @brief csv 导入、导出类
 */
class Csv
{
	private $csvType = 'goods_csv';
	private $csv     = null;
	private $csvClass = array('goods_csv' => 'IGoodsCsv' , 'taobao_csv' => 'ITaobaoCsv');
	
	//获取csv对象
	public function __construct(){}
	
	//导入csv文件
	public function import($csvType,$csvPath,$mark='')
	{
		$is_succ = '0';
		if($csvType=='goods_csv')
		{
			$this->getInstance($csvType);
			return $this->csv->import($csvPath,$mark);
		}
		
		if($csvType=='taobao_csv')
		{
			$this->getInstance($csvType);
			return $this->csv->import($csvPath,$mark);
		}
	}
	
	//导出csv文件
	public function export($csvType,$id,$tao_arr)
	{
		if($csvType=='goods_csv')
		{
			$this->getInstance($csvType);
			$this->csv->export($id);
			$this->DownLoad();//生成并下载压缩文件
			IFile::clearDir('backup/goods');//删除goods文件夹下的所有文件
			return 0;
		}
		
		if($csvType=='taobao_csv')
		{
			$this->getInstance($csvType);
			return $this->csv->export($id,$tao_arr);
		}
	}
	/**
     * @brief   生成csv处理对象
     * @logType string $type csv类型
     * @return  object csv对象
     */
	public function getInstance($csvType)
	{
		$sUrl =  IWeb::$app->getBasePath();
	    include $sUrl.'plugins/csv/'.$csvType.'.php';
	 	$className = isset($this->csvClass[$csvType]) ? $this->csvClass[$csvType] : '';
	 	if(!class_exists($className))
    	{
    		throw new IException('the log class is not exists',403);
    	}

    	if(!$this->csv instanceof $className)
    	{
    		$this->csv = new $className;
    	}
	}
	/**
	 * 
	 */
	function DownLoad()
	{
		if(class_exists('ZipArchive'))
		{
			$dir = 'backup/goods';
			$zip = new ZipArchive();
			$fileName = 'goods.zip';
			if($zip->open($dir.'/'.$fileName,ZIPARCHIVE::CREATE)===true)
			{
				$zip->addFile($dir.'/'.'goods.csv',basename($dir.'/'.'goods.csv'));
				if(is_dir($dir.'/upload'))
				{
					$this->addFileToZip($dir.'/upload',$zip);
				}
			}
			$zip->close();
			
			header('Content-Description: File Transfer');
			header('Content-Length: '.filesize($dir.'/'.$fileName));
			header('Content-Disposition: attachment; filename='.basename($fileName));
			readfile($dir.'/'.$fileName);
		}
	}
	function addFileToZip($dir,$zip)
	{
		$handler = opendir($dir);
		
		while( ($filename = readdir($handler)) !== false )
		{
			if($filename != "." && $filename != "..")
			{
				if(is_dir($dir."/".$filename))
				{
					self::addFileToZip($dir."/".$filename,$zip);
				}
				else
				{
					$path = str_replace('backup/goods/','',$dir);
					$zip->addFile($dir."/".$filename,$path."/".$filename);
					
				}
			}
		}
		@closedir($handler);
	}
}

?>