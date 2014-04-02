<?php
/**
 * @copyright (c) 2009-2011 jooyea.net
 * @file form_validation.php
 * @brief form表单验证
 * @author Ben
 * @date 2010-12-14
 * @version 0.6
 */

/**
 * @class IFormValidation
 * @brief form表单验证
 */
class IFormValidation extends IValidate
{
	private $rules = array();
	private $validate = array();
	private $errorflag=false;
	private $fieldData = array();
	private $errorMsg = '';
	/**
	 * @param array $rules 验证规则
	 * 	 	$rules = array(
	 *			$table_name => array(			//$table_name 对应的数据表名称
	 * 				array(
	 *					'name'	=> 'name',			//form 元素名
	 *					'field' => 'name',			//数据表字段名
	 *					'label' => 'label',			//label	用于错误显示
	 *					'rules' => 'rules',			//验证规则，值为函数名，用“|”分割
	 *				)
	 * 			),
	 *		);
	 * @brief 构造函数，初始化验证规则
	 */
	function __construct($rules=array())
	{
		is_array($rules) && $this->rules = $rules;
		$this->setRules();
	}

	/**
	 * @param array $rules 验证规则
	 * @brief 设置、添加验证规则
	 */
	function setRules($rules=array())
	{
		if(!empty($rules) && is_array($rules))
		{
			$this->rules = array_merge_recursive($this->rules, $rules);
		}
		//初始化数据
		foreach($this->rules as $key => $value)
		{
			foreach ($value as $k=>$v)
			{
				$this->fieldData[$key][$v['name']] = array(
											'name'		=>	$v['name'],
											'field'		=>	isset($v['field'])?$v['field']:$v['name'],
											'label'		=>	isset($v['label'])?$v['label']:$v['name'],
											'rules'		=>	isset($v['rules'])?$v['rules']:'',
											'error'		=>	'',
											'postdate'	=>	null
										);
			}
		}
	}

	/**
	 * @param string $method form 表单提交方法，默认post方式提交
	 * @return array 表单验证后的信息
	 * @brief 表单元素验证
	 */
	function run()
	{
		$lang =new ILanguage();
		$lang->load("form_validation");
		foreach($this->fieldData as $key => $value)
		{
			foreach ($value as $k => $v)
			{
				//获取要验证的数据
				$this->fieldData[$key][$k]['postdate'] = IReq::get($this->fieldData[$key][$k]['name']);
				//发现有误不继续验证
				if($this->errorflag)
				{
					continue;
				}
				//获取验证规则
				$rules = explode('|', $v['rules']);
				foreach($rules as $rule)
				{
					//如果有数组带有错误信息，直接跳出
					if($this->fieldData[$key][$k]['error'] != '' || $this->errorflag)
					{
						break;
					}
					$param = FALSE;
					if (preg_match("/(.*?)\[(.*?)\]/", $rule, $match))
					{
						$rule	= $match[1];
						$param	= $match[2];
					}
					//如果验证规则为空，则跳过不进行验证
					if($rule=='') continue;

					//如果验证函数不存在，则进行正则表达式验证
					$result = true;
					if(method_exists($this, $rule))
					{
						//如果表单没有值并且不是必填的时候，不需要进行验证
						if($this->fieldData[$key][$k]['postdate'] || (!$this->fieldData[$key][$k]['postdate'] && $rule=='required'))
						{
							$result = $this->$rule($this->fieldData[$key][$k]['postdate'], $param);
						}
					}
					else
					{
						$result = $this->check($rule,$this->fieldData[$key][$k]['postdate']);
					}
					if(!$result)
					{
						//验证不通过，返回null，构建错误内容
						$msg = $lang->g('fv_'.$rule);
						$this->validate[$this->fieldData[$key][$k]['name']]=array('value'=>$this->fieldData[$key][$k]['postdate'],'msg'=>$this->fieldData[$key][$k]['label'].$msg);
						$this->fieldData[$key][$k]['error'] = $this->fieldData[$key][$k]['label'].$msg;
						$this->errorMsg = $this->fieldData[$key][$k]['label'].$msg;
						$this->errorflag=true;
					}
				}
			}
		}
		if ($this->errorflag)
		{
			IWeb::$app->setRenderData(array('validate'=>$this->validate));
		}
		return $this->fieldData;
	}

	/**
	 * return bool 验证不通过 true ,验证通过 false
	 * @brief 检查是否验证通过
	 */
	function isError()
	{
		return $this->errorflag;
	}

	/**
	 * @return string 错误信息
	 * @brief 获取错误信息
	 */
	function getError()
	{
		return $this->errorMsg;
	}
}
?>