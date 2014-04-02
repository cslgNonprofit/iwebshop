<?php
/**
 * @copyright (c) 2009-2011 jooyea.net
 * @file form_validation.php
 * @brief form表单验证
 * @author Ben
 * @date 2011-1-12
 * @version 0.6
 */

/**
 * @class IFormValidation
 * @brief form表单验证
 */
class Formvalidation extends IFormValidation
{
	/**
	 * @param string
	 * @return bool
	 * @brief 检查是否是自然数
	 */
	function natural($str)
    {
   		return (bool)preg_match( '/^[0-9]+$/', $str);
    }
}
?>