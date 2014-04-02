<?php
/**
 * @copyright Copyright(c) 2010 jooyea.net
 * @file curd_action.php
 * @brief 实现系统的自动增删改查
 * @author webning
 * @date 2010-12-23
 * @version 0.6
 */
/**
 * @brief 完成用户的自动增加删除修改功能DURD类
 * @class ICURDAction
 */
class ICURDAction extends IAction
{
    /**
     * @brief 处理curd动作
     * @return String
     */
    public function curd()
    {
        $action = $this->id;
        $controller = $this->controller;
        $curdinfo = $this->initinfo();
        if(is_array($curdinfo))
        {
            $modelName = $curdinfo['model'];
            $key = $curdinfo['key'];
            $actions = $curdinfo['actions'];
            switch($action)
            {
                case 'add':
                case 'upd':
                {

                    if(method_exists($controller,'getValidate')) $validate = $controller->getValidate();
                    else $validate =null;

                    if($validate!=null)
                    {

                        $formValidate = new IFormValidation($validate);

                        $data = $formValidate->run();
                    }

                    $model = new IModel($modelName);

                    if(isset($data) && $data!==null)
                    {
                        $model->setData($data[$modelName]);
                        if($action = 'add')  $flag = $model->add();
                        else  $flag = $model->upd("$key = '".IReq::get($key)."'");
                    }
                    if(isset($flag) && $flag)
                    {
                        $_GET['action'] = $actions['success'];
                    }
                    else
                    {
                        $_GET['action'] = $actions['fail'];
                    }
                    $controller->run();
                    return true;
                }
                case 'del':
                {
                    $model = new IModel($modelName);
                    $flag = $model->del("$key = '".IReq::get($key)."'");
                    if($flag)
                    {
                        $_GET['action']=$actions['success'];
                    }
                    else
                    {
                        $_GET['action'] = $actions['fail'];
                    }
                    $controller->run();
                    return true;
                }
                case 'get':
                {
                    $model = new IModel($modelName);
                    $rs = $model->getObj("$key = '".IReq::get($key)."'");
                    echo JSON::encode($rs);
                    return false;
                }
            }
        }
    }
    /**
     * @brief 分析curd的配置信息
     * @return mixed
     */
    private function initinfo()
    {
        $action = $this->id;
        $controller = $this->controller;
        if(method_exists($controller,'curd'))
        {
            $curdinfo = $controller->curd();
            $modelName = isset($curdinfo['model'])?$curdinfo['model']:null;
            if($modelName !==null)
            {
                $key = isset($curdinfo['key'])?$curdinfo['key']:'id';
                $actions = isset($curdinfo['actions'])?$curdinfo['actions']:null;
                if(is_array($actions))
                {
                    if(isset($actions[$action]))
                    {
                        $current = $actions[$action];
                    }
                    else
                    {
                        $current = isset($actions['*'])?$actions['*']:null;
                    }
                    if($current!==null)
                    {
                        $fail = isset($current['fail'])?$current['fail']:(isset($current[1])?$current[1]:'index');
                        $success = isset($current['success'])?$current['success']:(isset($current[0])?$current[0]:'index');
                        return array('model'=>$modelName,'key'=>$key, 'actions' =>array('success'=>$success,'fail'=>$fail) );
                    }
                    else
                    {
						throw new IException('class '.get_class($controller).' have curd error');
                    }
                }
            }
        }
        return null;
    }
    /**
     * @brief Action的运行方法
     */
    public function run()
    {
        $this->curd();
    }
}
?>
