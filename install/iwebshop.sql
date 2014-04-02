-- phpMyAdmin SQL Dump
-- version 2.10.2
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2011 年 06 月 07 日 00:49
-- 服务器版本: 5.0.45
-- PHP 版本: 5.2.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- 数据库: `iwebshop`
--

-- --------------------------------------------------------

--
-- 表的结构 `iweb_account_log`
--

DROP TABLE IF EXISTS `iweb_account_log`;
CREATE TABLE `iweb_account_log` (
  `id` int(11) NOT NULL auto_increment,
  `admin_id` int(11) NOT NULL COMMENT '管理员ID',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `type` tinyint(1) NOT NULL default '0' COMMENT '0增加,1减少',
  `event` tinyint(4) NOT NULL COMMENT '操作类型，意义请看accountLog类',
  `time` datetime NOT NULL COMMENT '发生时间',
  `amount` float(10,2) NOT NULL COMMENT '金额',
  `amount_log` float(10,2) NOT NULL COMMENT '每次增减后面的金额记录',
  `note` text COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='账户余额日志表';

-- --------------------------------------------------------

--
-- 表的结构 `iwebshop_find_password`
--

DROP TABLE IF EXISTS `iwebshop_find_password`;
CREATE TABLE  `iwebshop_find_password` (
  `id` INT(11) NOT NULL auto_increment ,
  `user_id` INT(11) NOT NULL COMMENT '用户ID',
  `hash` CHAR(32) NOT NULL COMMENT 'hash值',
  `addtime` INT NOT NULL COMMENT '申请找回的时间',
  PRIMARY KEY (`id`) ,
  INDEX (`hash`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 COMMENT='找回密码';

--
-- 表的结构 `iweb_address`
--

DROP TABLE IF EXISTS `iweb_address`;
CREATE TABLE `iweb_address` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `accept_name` varchar(20) NOT NULL COMMENT '收货人姓名',
  `zip` varchar(6) default NULL COMMENT '邮编',
  `telphone` varchar(20) default NULL COMMENT '联系电话',
  `country` int(11) default NULL COMMENT '国ID',
  `province` int(11) NOT NULL COMMENT '省ID',
  `city` int(11) NOT NULL COMMENT '市ID',
  `area` int(11) default NULL COMMENT '区ID',
  `address` varchar(250) default NULL COMMENT '收货地址',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `default` tinyint(1) NOT NULL default '0' COMMENT '是否默认,0:为非默认,1:默认',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='收货信息表';

-- --------------------------------------------------------

DROP TABLE IF EXISTS `iweb_freight_company`;
CREATE TABLE `iweb_freight_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `freight_type` varchar(255) DEFAULT NULL COMMENT '货运类型',
  `freight_name` varchar(255) NOT NULL COMMENT '货运公司名称',
  `url` varchar(255) DEFAULT NULL COMMENT '网址',
  `sort` tinyint(3) DEFAULT '99' COMMENT '排序',
  `is_del` tinyint(3) DEFAULT '0' COMMENT '0未删除1删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='货运公司';

INSERT INTO `iweb_freight_company` VALUES (1,'CNEMS','中国邮政','http://www.ems.com.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (2,'CNST','申通快递','http://www.sto.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (3,'CNTT','天天快递','http://www.ttkd.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (4,'CNYT','圆通速递','http://www.yto.net.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (5,'CNSF','顺丰速运','http://www.sf-express.com',0,0);
INSERT INTO `iweb_freight_company` VALUES (6,'CNYD','韵达快递','http://www.yundaex.com',0,0);
INSERT INTO `iweb_freight_company` VALUES (7,'CNZT','中通速递','http://www.zto.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (8,'CNLB','龙邦物流','http://www.lbex.com.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (9,'CNZJS','宅急送','http://www.zjs.com.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (10,'CNQY','全一快递','http://www.apex100.com',0,0);
INSERT INTO `iweb_freight_company` VALUES (11,'CNHT','汇通速递','http://www.htky365.com',0,0);
INSERT INTO `iweb_freight_company` VALUES (12,'CNMH','民航快递','http://www.cae.com.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (13,'CNYF','亚风速递','http://www.airfex.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (14,'CNKJ','快捷速递','http://www.fastexpress.com.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (15,'DDS','DDS快递','http://www.qc-dds.net',0,0);
INSERT INTO `iweb_freight_company` VALUES (16,'CNHY','华宇物流','http://www.hoau.net',0,0);
INSERT INTO `iweb_freight_company` VALUES (17,'CNZY','中铁快运','http://www.cre.cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (18,'FEDEX','FedEx','http://www.fedex.com/cn',0,0);
INSERT INTO `iweb_freight_company` VALUES (19,'UPS','UPS','http://www.ups.com',0,0);
INSERT INTO `iweb_freight_company` VALUES (20,'DHL','DHL','http://www.cn.dhl.com',0,0);

--
-- 表的结构 `iweb_admin`
--

DROP TABLE IF EXISTS `iweb_admin`;
CREATE TABLE `iweb_admin` (
  `id` int(11) NOT NULL auto_increment COMMENT '管理员ID',
  `admin_name` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `create_time` datetime default NULL COMMENT '创建时间',
  `email` varchar(255) default NULL COMMENT 'Email',
  `last_ip` varchar(30) default NULL COMMENT '最后登录IP',
  `last_time` datetime default NULL COMMENT '最后登录时间',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '删除状态 1删除,0正常',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='管理员用户表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_admin_role`
--

DROP TABLE IF EXISTS `iweb_admin_role`;
CREATE TABLE `iweb_admin_role` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `rights` text COMMENT '权限',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '删除状态 1删除,0正常',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='后台角色分组表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_ad_manage`
--

DROP TABLE IF EXISTS `iweb_ad_manage`;
CREATE TABLE `iweb_ad_manage` (
  `id` int(11) NOT NULL auto_increment COMMENT '广告ID',
  `name` varchar(50) NOT NULL COMMENT '广告名称',
  `type` tinyint(1) NOT NULL COMMENT '广告类型 1:img 2:flash 3:code 4:文字',
  `position_id` int(11) NOT NULL COMMENT '广告位ID',
  `link` varchar(255) default NULL COMMENT '链接地址',
  `order` int(6) default NULL COMMENT '排列顺序',
  `width` int(11) default NULL COMMENT '广告宽度',
  `height` int(11) default NULL COMMENT '广告高度',
  `start_time` date default NULL COMMENT '开始时间',
  `end_time` date default NULL COMMENT '结束时间',
  `content` text COMMENT '图片、flash路径，文字，code等',
  `description` varchar(255) default NULL COMMENT '描述',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='广告记录表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_ad_position`
--

DROP TABLE IF EXISTS `iweb_ad_position`;
CREATE TABLE `iweb_ad_position` (
  `id` int(11) NOT NULL auto_increment COMMENT '广告位ID',
  `name` varchar(50) NOT NULL COMMENT '广告位名称',
  `width` int(6) default NULL COMMENT '广告位宽度',
  `height` int(6) default NULL COMMENT '广告位高度',
  `type` tinyint(1) default NULL COMMENT '1:img; 2:flash; 3:文字; 4:code; 5:幻灯片',
  `fashion` tinyint(2) default NULL COMMENT '1:轮显;2:随即',
  `status` tinyint(1) default '0' COMMENT '1:开启; 0: 关闭',
  `ad_nums` int(11) default NULL COMMENT '广告显示数量',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='广告位记录表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_after_sell`
--

DROP TABLE IF EXISTS `iweb_after_sell`;
CREATE TABLE `iweb_after_sell` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL COMMENT '订单ID',
  `user_id` int(11) default NULL COMMENT '退货人',
  `time` datetime default NULL COMMENT '申请时间',
  `cause` varchar(255) default NULL COMMENT '原因',
  `done` tinyint(1) default '1' COMMENT '1退2换',
  `status` tinyint(1) default '0' COMMENT '0未处理 1处理中 2 处理结束',
  `name` varchar(255) default NULL COMMENT '开户名',
  `account_bank` varchar(255) default NULL COMMENT '开户行',
  `belong_bank` varchar(255) default NULL COMMENT '所属银行',
  `returns_type` int(11) default NULL COMMENT '1站内2支付宝3银行',
  `account` varchar(255) default NULL COMMENT '支付宝、快钱等账号',
  `content` text COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='退换申请表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_announcement`
--

DROP TABLE IF EXISTS `iweb_announcement`;
CREATE TABLE `iweb_announcement` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(250) NOT NULL COMMENT '公告标题',
  `content` text COMMENT '公告内容',
  `time` datetime default NULL COMMENT '发布时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='公告消息表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_areas`
--

DROP TABLE IF EXISTS `iweb_areas`;
CREATE TABLE `iweb_areas` (
  `area_id` int(10) unsigned NOT NULL auto_increment,
  `parent_id` int(10) unsigned default NULL COMMENT '上一级的id值',
  `area_name` varchar(50) default NULL COMMENT '地区名称',
  `sort` mediumint(8) unsigned NOT NULL default '99' COMMENT '排序',
  PRIMARY KEY  (`area_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='地区信息';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_article`
--

DROP TABLE IF EXISTS `iweb_article`;
CREATE TABLE `iweb_article` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(250) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `create_time` datetime default NULL COMMENT '发布时间',
  `keywords` varchar(255) default NULL COMMENT '关键词',
  `description` varchar(255) default NULL COMMENT '描述',
  `visiblity` tinyint(1) default NULL COMMENT '是否显示 0:不显示,1:显示',
  `top` tinyint(1) default NULL COMMENT '置顶',
  `sort` int(11) default '0' COMMENT '排序',
  `style` tinyint(1) default '0' COMMENT '标题字体 0正常 1粗体,2斜体',
  `color` varchar(7) default NULL COMMENT '标题颜色',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文章表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_article_category`
--

DROP TABLE IF EXISTS `iweb_article_category`;
CREATE TABLE `iweb_article_category` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `parent_id` int(11) NOT NULL default '0' COMMENT '父分类',
  `issys` tinyint(1) default NULL COMMENT '系统分类',
  `sort` int(11) default NULL COMMENT '排序',
  `path` varchar(255) default NULL COMMENT '路径',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文章分类';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_attribute`
--

DROP TABLE IF EXISTS `iweb_attribute`;
CREATE TABLE `iweb_attribute` (
  `id` int(11) NOT NULL auto_increment COMMENT '属性ID',
  `model_id` int(4) default NULL COMMENT '模型ID',
  `type` tinyint(1) default NULL COMMENT '输入控件的类型,单选,复选等',
  `name` varchar(50) default NULL COMMENT '名称',
  `value` text COMMENT '属性值',
  `search` tinyint(1) default '0' COMMENT '是否支持搜索0不支持1支持',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='属性表';

-- --------------------------------------------------------

--
-- 表的结构 `iwebshop_search`
--
DROP TABLE IF EXISTS `iwebshop_search`;
CREATE TABLE `iwebshop_search` (
  `id` int(11) NOT NULL auto_increment,
  `keyword` varchar(255) NOT NULL COMMENT '搜索关键字',
  `num` int(5) default '0' COMMENT '搜索次数',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='搜索关键字';


--
-- 表的结构 `iweb_brand`
--

DROP TABLE IF EXISTS `iweb_brand`;
CREATE TABLE `iweb_brand` (
  `id` int(11) NOT NULL auto_increment COMMENT '品牌ID',
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `logo` varchar(255) default NULL COMMENT 'logo地址',
  `url` varchar(255) default NULL COMMENT '网址',
  `description` varchar(255) default NULL COMMENT '描述',
  `sort` int(4) default NULL COMMENT '排序',
  `category_ids` varchar(255) default NULL COMMENT '品牌分类分类,逗号分割id ',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='品牌表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_brand_category`
--

DROP TABLE IF EXISTS `iweb_brand_category`;
CREATE TABLE `iweb_brand_category` (
  `id` int(11) NOT NULL auto_increment COMMENT '分类ID',
  `name` varchar(255) default NULL COMMENT '分类名称',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='品牌分类表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_category`
--

DROP TABLE IF EXISTS `iweb_category`;
CREATE TABLE `iweb_category` (
  `id` int(11) NOT NULL auto_increment COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `parent_id` int(11) default NULL COMMENT '父分类ID',
  `sort` int(11) default '50' COMMENT '排序',
  `visibility` tinyint(1) default '1' COMMENT '首页是否显示 1显示 0 不显示',
  `model_id` int(11) default NULL COMMENT '默认模型ID',
  `keywords` varchar(255) default NULL COMMENT 'SEO 关键词',
  `descript` varchar(255) default NULL COMMENT 'SEO 描述',
  `title` varchar(255) default NULL COMMENT 'SEO 标题 title',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='产品分类表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_category_extend`
--

DROP TABLE IF EXISTS `iweb_category_extend`;
CREATE TABLE `iweb_category_extend` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `category_id` int(11) NOT NULL COMMENT '商品分类ID',
  PRIMARY KEY  (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商品扩展分类表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_collection_doc`
--

DROP TABLE IF EXISTS `iweb_collection_doc`;
CREATE TABLE `iweb_collection_doc` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL COMMENT '订单号',
  `user_id` int(11) default NULL COMMENT '付款人',
  `amount` float(10,2) NOT NULL default '0.00' COMMENT '金额',
  `time` datetime default NULL COMMENT '时间',
  `payment_id` int(11) default NULL COMMENT '银行、支付宝等',
  `admin_id` int(11) default NULL COMMENT '管理员id',
  `collection_account` varchar(255) default NULL COMMENT '收款账户',
  `recharge_id` int(11) default '0' COMMENT '充值ID',
  `pay_status` tinyint(1) default NULL COMMENT '支付状态，0为准备，1为支付成功',
  `note` text COMMENT '收款备注',
  `if_del` tinyint(2) default '0' COMMENT '1为删除',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='收款单';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_commend_goods`
--

DROP TABLE IF EXISTS `iweb_commend_goods`;
CREATE TABLE `iweb_commend_goods` (
  `id` int(11) NOT NULL auto_increment,
  `commend_id` int(11) NOT NULL COMMENT '推荐类型ID 1:最新商品 2:特价商品 3:热卖排行 4:推荐商品',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  PRIMARY KEY  (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='推荐类商品';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_comment`
--

DROP TABLE IF EXISTS `iweb_comment`;
CREATE TABLE `iweb_comment` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `order_no` varchar(20) default NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `time` datetime NOT NULL COMMENT '购买时间',
  `comment_time` date default NULL COMMENT '评论时间',
  `contents` text COMMENT '评论内容',
  `point` tinyint(1) NOT NULL default '0' COMMENT '评论的分数',
  `status` tinyint(1) default '0' COMMENT '评论状态：0：未评论 1:已评论',
  PRIMARY KEY  (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商品评论表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_consume_log`
--

DROP TABLE IF EXISTS `iweb_consume_log`;
CREATE TABLE `iweb_consume_log` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` float(10,2) NOT NULL default '0.00' COMMENT '金额',
  `time` datetime default NULL COMMENT '时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='消费记录表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_delivery`
--

DROP TABLE IF EXISTS `iweb_delivery`;
CREATE TABLE `iweb_delivery` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL COMMENT '快递名称',
  `description` varchar(50) default NULL COMMENT '快递描述',
  `area` text COMMENT '配送区域',
  `area_groupid` text COMMENT '配送区域id',
  `firstprice` text COMMENT '配送地址对应的首重价格',
  `secondprice` text COMMENT '配送地区对应的续重价格',
  `type` tinyint(1) default NULL COMMENT '配送类型 0先付款后发货 1先发货后付款',
  `first_weight` int(11) default NULL COMMENT '单位 克',
  `second_weight` int(11) default NULL COMMENT '单位 克',
  `first_price` float(10,2) NOT NULL default '0.00' COMMENT '首重价格',
  `second_price` float(10,2) NOT NULL default '0.00' COMMENT '续重价格',
  `status` tinyint(1) default '0' COMMENT '开启状态',
  `sort` int(11) default '99' COMMENT '排序',
  `is_save_price` tinyint(1) default '0' COMMENT '是否支持物流保价 1支持保价 0  不支持保价',
  `save_rate` int(11) default NULL COMMENT '保价费率',
  `low_price` float(10,2) NOT NULL default '0.00' COMMENT '最低保价',
  `price_type` tinyint(1) default '0' COMMENT '费用类型 0统一设置 1指定地区费用',
  `open_default` tinyint(1) default '1' COMMENT '启用默认费用 1启用 0 不启用',
  `is_delete` tinyint(1) unsigned default '0' COMMENT '是否删除 0:未删除 1:删除',
  `freight_id` int(11) unsigned default NULL COMMENT '货运公司ID',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='配送方式表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_delivery_doc`
--

DROP TABLE IF EXISTS `iweb_delivery_doc`;
CREATE TABLE `iweb_delivery_doc` (
  `id` int(11) NOT NULL auto_increment COMMENT '发货单ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `user_id` int(11) default NULL COMMENT '用户ID',
  `admin_id` int(11) default NULL COMMENT '管理员ID',
  `name` varchar(255) default NULL COMMENT '收货人',
  `postcode` int(6) default NULL COMMENT '邮编',
  `telphone` varchar(20) default NULL COMMENT '联系电话',
  `country` int(11) default NULL COMMENT '国ID',
  `province` int(11) default NULL COMMENT '省ID',
  `city` int(11) default NULL COMMENT '市ID',
  `area` int(11) default NULL COMMENT '区ID',
  `address` varchar(250) default NULL COMMENT '收货地址',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `time` datetime default NULL COMMENT '创建时间',
  `freight` float(10,2) NOT NULL default '0.00' COMMENT '运费',
  `delivery_code` varchar(255) default NULL COMMENT '物流单号',
  `delivery_type` varchar(255) default NULL COMMENT '物流方式',
  `note` text COMMENT '管理员添加的备注信息',
  `if_del` tinyint(3) default NULL COMMENT '1为删除',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='发货单';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_delivery_goods`
--

DROP TABLE IF EXISTS `iweb_delivery_goods`;
CREATE TABLE `iweb_delivery_goods` (
  `id` int(11) NOT NULL auto_increment,
  `delivery_id` int(11) NOT NULL COMMENT '发货单ID',
  `goods_id` int(11) default NULL COMMENT '商品ID',
  `product_id` int(11) default NULL COMMENT '货品id',
  `goods_code` varchar(255) default NULL COMMENT '货号',
  `goods_nums` int(11) default NULL COMMENT '货品数量',
  `time` datetime default NULL COMMENT '时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发货清单';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_discussion`
--

DROP TABLE IF EXISTS `iweb_discussion`;
CREATE TABLE `iweb_discussion` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `time` datetime NOT NULL COMMENT '评论时间',
  `contents` text COMMENT '评论内容',
  `is_check` tinyint(1) default '0' COMMENT '审核状态,0未审核 1已审核',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商品讨论表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_email_registry`
--

DROP TABLE IF EXISTS `iweb_email_registry`;
CREATE TABLE `iweb_email_registry` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(80) NOT NULL COMMENT 'Email',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Email订阅表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_favorite`
--

DROP TABLE IF EXISTS `iweb_favorite`;
CREATE TABLE `iweb_favorite` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `rid` int(11) NOT NULL COMMENT '商品或货品ID',
  `time` datetime NOT NULL COMMENT '收藏时间',
  `summary` varchar(255) default NULL COMMENT '备注',
  `cat_id` int(11) NOT NULL COMMENT '商品分类',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='收藏夹表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_fitting_relation`
--

DROP TABLE IF EXISTS `iweb_fitting_relation`;
CREATE TABLE `iweb_fitting_relation` (
  `id` int(11) NOT NULL auto_increment,
  `fitting_id` int(11) NOT NULL COMMENT '配件商品ID',
  `goods_id` int(11) NOT NULL COMMENT '附属商品ID',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='配件关系表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_goods`
--

DROP TABLE IF EXISTS `iweb_goods`;
CREATE TABLE `iweb_goods` (
  `id` int(11) NOT NULL auto_increment COMMENT '商品ID',
  `name` varchar(50) NOT NULL COMMENT '商品名称',
  `goods_no` varchar(20) default NULL COMMENT '商品的货号',
  `model_id` int(11) default NULL COMMENT '模型ID',
  `sell_price` float(10,2) default NULL COMMENT '销售价格',
  `market_price` float(10,2) default NULL COMMENT '市场价格',
  `cost_price` float(10,2) default NULL COMMENT '成本价格',
  `up_time` datetime default NULL COMMENT '上架时间',
  `down_time` datetime default NULL COMMENT '下架时间',
  `create_time` datetime default NULL COMMENT '创建时间',
  `store_nums` int(11) NOT NULL default '0' COMMENT '库存',
  `img` varchar(255) default NULL COMMENT '原图',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '删除 0未删除 1已删除',
  `content` text COMMENT '商品描述',
  `keywords` varchar(255) default NULL COMMENT 'SEO关键词',
  `description` varchar(255) default NULL COMMENT 'SEO描述',
  `tag_ids` varchar(255) default NULL COMMENT '标签id',
  `weight` float(10,2) default NULL COMMENT '重量',
  `point` int(11) default '0' COMMENT '积分',
  `unit` varchar(10) default NULL COMMENT '计量单位',
  `brand_id` int(11) default NULL COMMENT '品牌ID',
  `visit` int(11) default NULL COMMENT '浏览次数',
  `favorite` int(11) default NULL COMMENT '收藏次数',
  `sort` int(11) default '99' COMMENT '排序',
  `list_img` varchar(255) default '' COMMENT '列表页缩略图 大图',
  `small_img` varchar(255) default NULL COMMENT '详细页缩略图 小图',
  `spec_array` text COMMENT '序列化存储规格,key值为规则ID，value为此商品具有的规格值',
  `exp` int(11) default '0' COMMENT '经验值',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_goods_attribute`
--

DROP TABLE IF EXISTS `iweb_goods_attribute`;
CREATE TABLE `iweb_goods_attribute` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) default NULL COMMENT '商品ID',
  `attribute_id` int(11) default NULL COMMENT '属性ID',
  `attribute_value` varchar(500) default NULL COMMENT '属性值',
  `spec_id` int(11) default NULL COMMENT '规格ID',
  `spec_value` varchar(500) default NULL COMMENT '规格值',
  `model_id` int(11) default NULL COMMENT '模型ID',
  `order` int(11) default NULL COMMENT '排序',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='属性值表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_goods_car`
--

DROP TABLE IF EXISTS `iweb_goods_car`;
CREATE TABLE `iweb_goods_car` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL COMMENT '用户ID',
  `content` text COMMENT '购物内容',
  `create_time` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='购物车';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_goods_photo`
--

DROP TABLE IF EXISTS `iweb_goods_photo`;
CREATE TABLE `iweb_goods_photo` (
  `id` char(32) NOT NULL COMMENT '图片的md5值',
  `img` varchar(255) default NULL COMMENT '原始图片路径',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='图片表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_goods_photo_relation`
--

DROP TABLE IF EXISTS `iweb_goods_photo_relation`;
CREATE TABLE `iweb_goods_photo_relation` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `photo_id` char(32) NOT NULL default '' COMMENT '图片ID,图片的md5值',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='相册商品关系表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_group_price`
--

DROP TABLE IF EXISTS `iweb_group_price`;
CREATE TABLE `iweb_group_price` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL default '0' COMMENT '产品ID',
  `products_id` int(11) NOT NULL default '0' COMMENT '规格id',
  `group_id` int(11) NOT NULL COMMENT '用户组ID',
  `price` float(10,2) NOT NULL default '0.00' COMMENT '价格',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='记录某件商品对于某组会员的价格关系表，优先权大于组设定的折扣率。';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_guide`
--

DROP TABLE IF EXISTS `iweb_guide`;
CREATE TABLE `iweb_guide` (
  `order` smallint(5) NOT NULL COMMENT '排序',
  `name` varchar(255) NOT NULL COMMENT '导航名字',
  `link` varchar(255) NOT NULL COMMENT '链接地址',
  PRIMARY KEY  (`order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='首页导航栏';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_help`
--

DROP TABLE IF EXISTS `iweb_help`;
CREATE TABLE `iweb_help` (
  `id` int(11) NOT NULL auto_increment,
  `cat_id` smallint(6) NOT NULL COMMENT '帮助分类，如果为0则代表着是下面的帮助单页',
  `sort` int(11) NOT NULL COMMENT '顺序',
  `name` varchar(50) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `dateline` int(11) NOT NULL COMMENT '发布时间',
  PRIMARY KEY  (`id`),
  KEY `cat_id` (`cat_id`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='帮助';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_help_category`
--

DROP TABLE IF EXISTS `iweb_help_category`;
CREATE TABLE `iweb_help_category` (
  `id` smallint(6) NOT NULL auto_increment,
  `name` varchar(10) NOT NULL COMMENT '标题',
  `sort` smallint(6) NOT NULL COMMENT '顺序',
  `position_left` tinyint(4) NOT NULL COMMENT '是否在帮助内容、列表页面的左侧显示',
  `position_foot` tinyint(4) NOT NULL COMMENT '是否在整站页面下方显示',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='帮助分类';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_invoice`
--

DROP TABLE IF EXISTS `iweb_invoice`;
CREATE TABLE `iweb_invoice` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(11) NOT NULL COMMENT '抬头 单位名称/个人',
  `order_id` int(11) NOT NULL COMMENT '订单号',
  `time` datetime default NULL COMMENT '时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='发票记录表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_keyword`
--

DROP TABLE IF EXISTS `iweb_keyword`;
CREATE TABLE `iweb_keyword` (
  `word` varchar(15) NOT NULL COMMENT '关键词',
  `goods_nums` int(11) NOT NULL default '1' COMMENT '产品数量',
  `hot` tinyint(1) NOT NULL default '0' COMMENT '是否为热门',
  `order` int(5) NOT NULL default '99' COMMENT '关键词排序',
  PRIMARY KEY  (`word`),
  KEY `hot` (`hot`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关键词';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_log_error`
--

DROP TABLE IF EXISTS `iweb_log_error`;
CREATE TABLE `iweb_log_error` (
  `id` int(11) NOT NULL auto_increment,
  `file` varchar(200) default NULL COMMENT '文件',
  `line` smallint(5) unsigned NOT NULL COMMENT '出错文件行数',
  `content` varchar(500) default NULL COMMENT '内容',
  `datetime` datetime NOT NULL COMMENT '时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='错误日志表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_log_operation`
--

DROP TABLE IF EXISTS `iweb_log_operation`;
CREATE TABLE `iweb_log_operation` (
  `id` int(11) NOT NULL auto_increment,
  `author` varchar(80) default NULL COMMENT '操作人员',
  `action` varchar(200) default NULL COMMENT '动作',
  `content` text COMMENT '内容',
  `datetime` datetime NOT NULL COMMENT '时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='日志操作记录';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_log_sql`
--

DROP TABLE IF EXISTS `iweb_log_sql`;
CREATE TABLE `iweb_log_sql` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(500) NOT NULL COMMENT '执行的SQL语句',
  `runtime` float unsigned NOT NULL COMMENT '语句执行时间(秒)',
  `datetime` datetime NOT NULL COMMENT '发生的时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SQL日志记录';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_member`
--

DROP TABLE IF EXISTS `iweb_member`;
CREATE TABLE `iweb_member` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `true_name` varchar(50) default NULL COMMENT '真实姓名',
  `telephone` varchar(50) default NULL COMMENT '联系电话',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `area` varchar(255) default NULL COMMENT '地区',
  `contact_addr` varchar(250) default NULL COMMENT '联系地址',
  `qq` varchar(15) default NULL COMMENT 'QQ',
  `msn` varchar(250) default NULL COMMENT 'MSN',
  `sex` tinyint(1) default '1' COMMENT '性别1男2女',
  `birthday` date default NULL COMMENT '生日',
  `group_id` int(6) NOT NULL default '0' COMMENT '分组',
  `exp` int(11) NOT NULL default '0' COMMENT '经验值',
  `point` int(11) NOT NULL default '0' COMMENT '积分',
  `message_ids` text COMMENT '消息ID',
  `time` datetime default NULL COMMENT '注册日期时间',
  `zip` varchar(10) default NULL COMMENT '邮政编码',
  `status` tinyint(1) default '1' COMMENT '用户状态 1正常状态 2 删除至回收站 3锁定',
  `prop` text default NULL COMMENT '用户拥有的工具',
  `balance` float(10,2) NOT NULL default '0.00' COMMENT '用户余额',
  `last_login` datetime default NULL COMMENT '最后一次登录时间',
  `custom` varchar(255) default NULL COMMENT '用户习惯方式,配送和支付方式等信息',
  PRIMARY KEY  (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_merch_ship_info`
--

DROP TABLE IF EXISTS `iweb_merch_ship_info`;
CREATE TABLE `iweb_merch_ship_info` (
  `id` int(11) NOT NULL auto_increment,
  `ship_name` varchar(255) default NULL COMMENT '发货点名称',
  `ship_user_name` varchar(255) default NULL COMMENT '发货人姓名',
  `sex` tinyint(1) default NULL COMMENT '性别',
  `country` int(11) default NULL COMMENT '国id',
  `province` int(11) default NULL COMMENT '省id',
  `city` int(11) default NULL COMMENT '市id',
  `area` int(11) default NULL COMMENT '地区id',
  `postcode` int(6) default NULL COMMENT '邮编',
  `address` varchar(255) default NULL COMMENT '具体地址',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `telphone` varchar(20) default NULL COMMENT '电话',
  `is_default` tinyint(1) NOT NULL default '0' COMMENT '1为默认地址，0则不是',
  `note` text COMMENT '备注',
  `addtime` datetime default NULL COMMENT '保存时间',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '0为删除，1为显示',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商家发货点信息';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_message`
--

DROP TABLE IF EXISTS `iweb_message`;
CREATE TABLE `iweb_message` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `time` datetime default NULL COMMENT '发送时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='站内消息';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_model`
--

DROP TABLE IF EXISTS `iweb_model`;
CREATE TABLE `iweb_model` (
  `id` int(11) NOT NULL auto_increment COMMENT '模型ID',
  `name` varchar(50) NOT NULL COMMENT '模型名称',
  `spec_ids` text COMMENT '序列化方式存储规格ID及展现方式',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='模型表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_msg_template`
--

DROP TABLE IF EXISTS `iweb_msg_template`;
CREATE TABLE `iweb_msg_template` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL COMMENT '模板名称',
  `title` varchar(255) default NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '模板内容',
  `variable` varchar(255) default NULL COMMENT '模板中的变量标签',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='消息模板表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_navigate`
--

DROP TABLE IF EXISTS `iweb_navigate`;
CREATE TABLE `iweb_navigate` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `floor` int(11) default NULL COMMENT '层次',
  `order` int(11) default NULL COMMENT '顺序',
  `url` varchar(255) default NULL COMMENT '链接',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='导航栏表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_notify_registry`
--

DROP TABLE IF EXISTS `iweb_notify_registry`;
CREATE TABLE `iweb_notify_registry` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) default NULL COMMENT '商品ID',
  `user_id` int(11) default NULL COMMENT '用户ID',
  `email` varchar(255) default NULL COMMENT 'emaill',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `register_time` datetime default NULL COMMENT '登记时间',
  `notify_time` datetime default NULL COMMENT '通知时间',
  `notify_status` tinyint(1) default '0' COMMENT '0未通知1已通知',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='到货通知表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_order`
--

DROP TABLE IF EXISTS `iweb_order`;
CREATE TABLE `iweb_order` (
  `id` int(11) NOT NULL auto_increment,
  `order_no` varchar(20) default NULL COMMENT '订单号',
  `user_id` int(11) default NULL COMMENT '用户ID',
  `accept_name` varchar(20) default NULL COMMENT '收货人姓名',
  `pay_code` varchar(255) default NULL COMMENT '支付账号',
  `pay_type` int(11) default NULL COMMENT '支付类型,0表示货到付款',
  `distribution` int(11) default NULL COMMENT '配送类型',
  `status` tinyint(1) default NULL COMMENT '订单状态1:生成订单,2：确认订单,3取消订单,4作废订单,5完成订单',
  `pay_status` tinyint(1) default NULL COMMENT '支付状态0：未支付，1：已支付，2：退款，3：申请退款',
  `distribution_status` tinyint(1) default NULL COMMENT '配送状态0：未发送，1：已发送，2：换货，3：申请换货',
  `postcode` varchar(6) default NULL COMMENT '邮编',
  `telphone` varchar(20) default NULL COMMENT '联系电话',
  `country` int(11) default NULL COMMENT '国ID',
  `province` int(11) default NULL COMMENT '省ID',
  `city` int(11) default NULL COMMENT '市ID',
  `area` int(11) default NULL COMMENT '区ID',
  `address` varchar(250) default NULL COMMENT '收货地址',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `payable_amount` float(10,2) default NULL COMMENT '应付商品总金额',
  `real_amount` float(10,2) NOT NULL default '0.00' COMMENT '实付商品总金额',
  `payable_freight` float(10,2) NOT NULL default '0.00' COMMENT '总运费金额',
  `real_freight` float(10,2) NOT NULL default '0.00' COMMENT '实付运费',
  `pay_time` datetime default NULL COMMENT '付款时间',
  `send_time` datetime default NULL COMMENT '发货时间',
  `create_time` datetime default NULL COMMENT '下单时间',
  `completion_time` datetime default NULL COMMENT '订单完成时间',
  `invoice` tinyint(1) NOT NULL default '0' COMMENT '发票：0不索要1索要',
  `postscript` varchar(255) default NULL COMMENT '用户附言',
  `note` text COMMENT '管理员备注',
  `if_del` tinyint(1) default '0' COMMENT '是否删除1为删除',
  `insured` float(10,2) NOT NULL default '0.00' COMMENT '保价',
  `if_insured` tinyint(1) default '0' COMMENT '是否保价0:不保价，1保价',
  `pay_fee` float(10,2) NOT NULL default '0.00' COMMENT '支付手续费',
  `invoice_title` varchar(100) default NULL COMMENT '发票抬头',
  `taxes` float(10,2) NOT NULL default '0.00' COMMENT '税金',
  `promotions` float(10,2) NOT NULL default '0.00' COMMENT '促销优惠金额',
  `discount` float(10,2) NOT NULL default '0.00' COMMENT '订单折扣或涨价',
  `order_amount` float(10,2) NOT NULL default '0.00' COMMENT '订单总金额',
  `if_print` varchar(255) default NULL COMMENT '已打印的类型,类型的代码以逗号进行分割; shop购物单,pick配货单,merge购物和配货,express快递单',
  `prop` varchar(255) default NULL COMMENT '使用的道具id',
  `accept_time` varchar(80) default NULL COMMENT '用户收货时间',
  `exp` int(5) unsigned NOT NULL default '0' COMMENT '增加的经验',
  `point` int(5) unsigned NOT NULL default '0' COMMENT '增加的积分',
  `type` tinyint(1) unsigned NOT NULL default '0' COMMENT '0普通订单,1团购订单,2限时抢购',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='订单表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_order_goods`
--

DROP TABLE IF EXISTS `iweb_order_goods`;
CREATE TABLE `iweb_order_goods` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL COMMENT '订单ID',
  `goods_id` int(11) default NULL COMMENT '商品ID',
  `product_id` int(11) default NULL COMMENT '货品ID',
  `goods_price` float(10,2) NOT NULL default '0.00' COMMENT '商品价格',
  `real_price` float(10,2) NOT NULL default '0.00' COMMENT '实付金额',
  `goods_nums` int(11) NOT NULL default '1' COMMENT '商品数量',
  `goods_weight` float NOT NULL default '0' COMMENT '重量',
  `shipments` int(11) NOT NULL default '0' COMMENT '发货数量',
  `goods_array` text COMMENT '商品和货品名称name和序规格value列化',
  PRIMARY KEY  (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='订单商品表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_order_log`
--

DROP TABLE IF EXISTS `iweb_order_log`;
CREATE TABLE `iweb_order_log` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL COMMENT '订单id',
  `user` varchar(20) default NULL COMMENT '操作人：顾客或admin',
  `action` varchar(20) default NULL COMMENT '动作',
  `addtime` datetime default NULL COMMENT '添加时间',
  `result` varchar(10) default NULL COMMENT '操作的结果',
  `note` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='订单日志表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_order_prop_relation`
--

DROP TABLE IF EXISTS `iweb_order_prop_relation`;
CREATE TABLE `iweb_order_prop_relation` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL COMMENT '订单ID',
  `prop_id` int(11) default NULL COMMENT '道具ID',
  `user_id` int(11) default NULL COMMENT '用户ID',
  `create_time` datetime default NULL COMMENT '生成时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='订单与道具表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_payment`
--

DROP TABLE IF EXISTS `iweb_payment`;
CREATE TABLE `iweb_payment` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL COMMENT '支付名称',
  `type` tinyint(1) default NULL COMMENT '1:线上、2:线下',
  `description` text COMMENT '描述',
  `poundage` float(10,2) NOT NULL default '0.00' COMMENT '手续费',
  `status` tinyint(1) default '0' COMMENT '安装状态 0启用 1禁用',
  `plugin_id` varchar(32) default NULL COMMENT '支付插件ID',
  `config` text COMMENT '序列号存储插件配置信息',
  `order` int(11) default NULL COMMENT '排序',
  `poundage_type` tinyint(1) default NULL COMMENT '手续费方式，1百分比2固定值',
  `note` text COMMENT '支付说明',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='支付方式表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_pay_plugin`
--

DROP TABLE IF EXISTS `iweb_pay_plugin`;
CREATE TABLE `iweb_pay_plugin` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `description` text COMMENT '描述',
  `logo` varchar(255) default NULL COMMENT 'logo',
  `file_path` varchar(255) default NULL COMMENT '接口文件路径',
  `version` varchar(255) default NULL COMMENT '版本号',
  `visibility` tinyint(1) NOT NULL default '0' COMMENT '是否显示:0为隐藏,1为显示',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='支付插件表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_point_log`
--

DROP TABLE IF EXISTS `iweb_point_log`;
CREATE TABLE `iweb_point_log` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `datetime` datetime NOT NULL COMMENT '发生时间',
  `value` int(11) NOT NULL COMMENT '积分增减 增加正数 减少负数',
  `intro` varchar(50) NOT NULL COMMENT '积分改动说明',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='积分增减记录表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_products`
--

DROP TABLE IF EXISTS `iweb_products`;
CREATE TABLE `iweb_products` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL COMMENT '货品ID',
  `products_no` varchar(20) default NULL COMMENT '货品的货号(以商品的货号加横线加数字组成)',
  `spec_array` text COMMENT '序列化的规则值,key规则ID,value此货品所具有的规则值',
  `store_nums` int(11) NOT NULL default '0' COMMENT '库存',
  `market_price` float(10,2) NOT NULL default '0.00' COMMENT '市场价格',
  `sell_price` float(10,2) NOT NULL default '0.00' COMMENT '销售价格',
  `cost_price` float(10,2) NOT NULL default '0.00' COMMENT '成本价格',
  `weight` float(10,2) NOT NULL default '0.00' COMMENT '重量',
  `goods_code` varchar(255) default NULL COMMENT '货号',
  `spec_md5` char(32) default NULL COMMENT '规格的md5值',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='货品表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_promotion`
--

DROP TABLE IF EXISTS `iweb_promotion`;
CREATE TABLE `iweb_promotion` (
  `id` int(11) NOT NULL auto_increment,
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `condition` int(11) NOT NULL COMMENT '生效条件 type=0时为消费额度 type=1时为goods_id',
  `type` tinyint(1) NOT NULL default '0' COMMENT '活动类型 0:购物车促销规则 1:商品限时抢购',
  `award_value` varchar(255) default NULL COMMENT '奖励值 type=0时奖励值 type=1时为抢购价格',
  `name` varchar(20) NOT NULL COMMENT '活动名称',
  `intro` text COMMENT '活动介绍',
  `award_type` tinyint(1) NOT NULL default '0' COMMENT '奖励方式:0限时抢购 1减金额 2奖励折扣 3赠送积分 4赠送代金券 5赠送赠品 6免运费',
  `is_close` tinyint(1) NOT NULL default '0' COMMENT '是否关闭 0:否 1:是',
  `user_group` text COMMENT '允许参与活动的用户组,all表示所有用户组',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='记录促销活动的表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_online_recharge`
--

DROP TABLE IF EXISTS `iweb_online_recharge`;
CREATE TABLE `iweb_online_recharge` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `recharge_no` varchar(20) NOT NULL COMMENT '充值单号',
  `account` float(10,2) NOT NULL default '0.00' COMMENT '充值金额',
  `time` datetime NOT NULL COMMENT '时间',
  `payment_name` varchar(80) NOT NULL COMMENT '充值方式名称',
  `status` tinyint(1) NOT NULL default '0' COMMENT '充值状态 0:未成功 1:充值成功',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='在线充值表';


-- --------------------------------------------------------

--
-- 表的结构 `iweb_promotion_goods`
--

DROP TABLE IF EXISTS `iweb_promotion_goods`;
CREATE TABLE `iweb_promotion_goods` (
  `id` int(11) NOT NULL auto_increment,
  `promotion_id` int(11) NOT NULL COMMENT '活动ID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `product_id` int(11) default NULL COMMENT '货品ID',
  `goods_nums` int(11) default NULL COMMENT '商品数量',
  `goods_price` float(10,2) NOT NULL default '0.00' COMMENT '商品价格',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='活动商品表';

-- --------------------------------------------------------

--
-- 表的结构 `iwebshop_oauth_user`
--

DROP TABLE IF EXISTS `iwebshop_oauth_user`;
CREATE TABLE `iwebshop_oauth_user` (
  `id` int(11) NOT NULL auto_increment,
  `oauth_user_id` varchar(80) NOT NULL COMMENT '第三方平台的用户唯一标识',
  `oauth_id` smallint(5) NOT NULL COMMENT '第三方平台id',
  `user_id` int(11) NOT NULL COMMENT '系统内部的用户id',
  `datetime` datetime NOT NULL COMMENT '绑定时间',
  PRIMARY KEY  (`id`),
  KEY `index1` (`oauth_user_id`,`oauth_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='oauth开发平台绑定用户表';

--
-- 表的结构 `iwebshop_oauth`
--

DROP TABLE IF EXISTS `iwebshop_oauth`;
CREATE TABLE `iwebshop_oauth` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL COMMENT '名称',
  `config` text default NULL COMMENT '配置信息',
  `file` varchar(80) NOT NULL COMMENT '接口文件名称',
  `description` varchar(80) default NULL COMMENT '描述',
  `is_close` tinyint(1) NOT NULL default '0' COMMENT '是否关闭;0开启,1关闭',
  `logo` varchar(80) default NULL COMMENT 'logo',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='认证方案';

INSERT INTO iwebshop_oauth VALUES (1, '人人网', '', 'renren', '人人网开放平台', 1, 'plugins/oauth/images/renren.gif');
INSERT INTO iwebshop_oauth VALUES (2, 'QQ', '', 'qq', '腾讯开发平台', 1, 'plugins/oauth/images/qq.gif');
INSERT INTO iwebshop_oauth VALUES (3, '新浪', '', 'sina', '新浪微博的开发平台', 1, 'plugins/oauth/images/sina.gif');
INSERT INTO iwebshop_oauth VALUES (4, '淘宝', '', 'taobao', '淘宝的开放平台', 1, 'plugins/oauth/images/taobao.gif');

--
-- 表的结构 `iweb_promotion_log`
--

DROP TABLE IF EXISTS `iweb_promotion_log`;
CREATE TABLE `iweb_promotion_log` (
  `id` int(11) NOT NULL auto_increment,
  `promotion_id` int(11) default NULL COMMENT '活动ID',
  `user_id` int(11) default NULL COMMENT '参与用户',
  `buy_nums` int(11) default NULL COMMENT '购买件数',
  `goods_id` int(11) default NULL COMMENT '商品ID',
  `product_id` int(11) default NULL COMMENT '货品ID',
  `join_time` datetime default NULL COMMENT '参与时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='活动记录表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_prop`
--

DROP TABLE IF EXISTS `iweb_prop`;
CREATE TABLE `iweb_prop` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL COMMENT '道具名称',
  `card_name` varchar(32) default NULL COMMENT '道具的卡号',
  `card_pwd` varchar(32) default NULL COMMENT '道具的密码',
  `start_time` datetime default NULL COMMENT '开始时间',
  `end_time` datetime default NULL COMMENT '结束时间',
  `value` float(10,2) NOT NULL default '0.00' COMMENT '面值',
  `type` tinyint(1) NOT NULL default '0' COMMENT '道具类型 0:代金券',
  `condition` varchar(255) default NULL COMMENT '条件数据 type=0时,表示ticket的表id,模型id',
  `is_close` tinyint(1) NOT NULL default '0' COMMENT '是否关闭 0:正常,1:关闭,2:下订单未支付时临时锁定',
  `img` varchar(255) default NULL COMMENT '道具图片',
  `is_userd` tinyint(1) NOT NULL default '0' COMMENT '是否被使用过 0:未使用,1:已使用',
  `is_send` tinyint(1) NOT NULL default '0' COMMENT '是否被发送过 0:否 1:是',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='道具表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_quick_naviga`
--

DROP TABLE IF EXISTS `iweb_quick_naviga`;
CREATE TABLE `iweb_quick_naviga` (
  `id` int(11) NOT NULL auto_increment,
  `adminid` int(11) default NULL COMMENT '管理员id',
  `naviga_name` varchar(255) default NULL COMMENT '导航名称',
  `url` varchar(255) default NULL COMMENT '导航链接',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '是否删除1为删除',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='管理员快速导航';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_refer`
--

DROP TABLE IF EXISTS `iweb_refer`;
CREATE TABLE `iweb_refer` (
  `id` int(11) NOT NULL auto_increment,
  `question` text NOT NULL COMMENT '咨询内容',
  `user_id` int(11) default NULL COMMENT '咨询人会员ID，非会员为空',
  `goods_id` int(11) default NULL COMMENT '产品ID',
  `order_id` int(11) default NULL COMMENT '订单ID',
  `answer` text COMMENT '回复内容',
  `admin_id` int(11) default NULL COMMENT '管理员ID',
  `status` tinyint(1) default '0' COMMENT '0：待回复 1已回复 9关闭 ',
  `time` datetime default NULL COMMENT '咨询时间',
  `reply_time` datetime default NULL COMMENT '回复时间',
  `type` tinyint(1) default '0' COMMENT '咨询的类别',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='咨询表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_refundment_doc`
--

DROP TABLE IF EXISTS `iweb_refundment_doc`;
CREATE TABLE `iweb_refundment_doc` (
  `id` int(11) NOT NULL auto_increment,
  `order_no` varchar(20) NOT NULL default '' COMMENT '订单号',
  `order_id` int(11) default NULL COMMENT '订单id',
  `user_id` int(11) default NULL COMMENT '收款人',
  `amount` float(10,2) NOT NULL default '0.00' COMMENT '退款金额',
  `time` datetime default NULL COMMENT '时间',
  `refundment_type` tinyint(1) default '0' COMMENT '退款类型：0：退款至账户余额 1：退款至银行卡 2：其它方式',
  `refundment_username` varchar(30) default NULL COMMENT '开户名',
  `refundment_name` varchar(100) default NULL COMMENT '名称或者开户行',
  `refundment_account` varchar(255) default NULL COMMENT '退款账户',
  `refundment_bank` int(11) default '0' COMMENT '充值ID',
  `admin_id` int(11) default NULL COMMENT '管理员id',
  `pay_status` tinyint(3) default '0' COMMENT '退款状态，0：申请退款 1：退款失败 2:退款成功',
  `content` text COMMENT '申请退款原因',
  `dispose_time` datetime default NULL COMMENT '处理时间',
  `dispose_idea` text COMMENT '处理意见',
  `if_del` tinyint(3) default '0' COMMENT '1删除',
  `bank_name` varchar(30) default NULL COMMENT '管理员实际退款银行名称',
  `bank_account` varchar(255) default NULL COMMENT '管理员实际退款到账号',
  `bank_time` datetime default NULL COMMENT '管理员实际退款的退款时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='退款单';

-- --------------------------------------------------------

DROP TABLE IF EXISTS `iweb_goods_keywords`;
CREATE TABLE `iweb_goods_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `keywords` text NOT NULL COMMENT '商品对应的关键词',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商品与关键词关系表';

--
-- 表的结构 `iweb_regiment`
--

DROP TABLE IF EXISTS `iweb_regiment`;
CREATE TABLE `iweb_regiment` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL COMMENT '团购标题',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `store_nums` int(11) NOT NULL default '0' COMMENT '库存量',
  `sum_count` int(11) NOT NULL default '0' COMMENT '已销售量',
  `least_count` int(11) NOT NULL default '0' COMMENT '最少购买数量',
  `intro` varchar(255) default NULL COMMENT '介绍',
  `is_close` tinyint(1) NOT NULL default '0' COMMENT '是否关闭',
  `regiment_price` float(10,2) NOT NULL default '0.00' COMMENT '团购价格',
  `sell_price` int(11) NOT NULL default '0' COMMENT '原来价格',
  `goods_id` int(11) NOT NULL COMMENT '关联商品id',
  `img` varchar(255) default NULL COMMENT '商品图片',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='团购';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_regiment_user_relation`
--

DROP TABLE IF EXISTS `iweb_regiment_user_relation`;
CREATE TABLE `iweb_regiment_user_relation` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `regiment_id` int(11) NOT NULL COMMENT '团购id',
  `join_time` datetime NOT NULL COMMENT '用户参加团购的时间，过了一定时间此名额失效',
  `is_over` tinyint(4) NOT NULL COMMENT '1:已经完成购买,0：未完成',
  `hash` varchar(32) NOT NULL COMMENT '未登录用户的唯一性hash',
  `order_no` varchar(20) NOT NULL default ' 0' COMMENT '与这次团购行为的关联的订单号',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='团购与用户关系表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_relation`
--

DROP TABLE IF EXISTS `iweb_relation`;
CREATE TABLE `iweb_relation` (
  `id` int(11) NOT NULL auto_increment,
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `article_id` int(11) NOT NULL COMMENT '文章ID',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='文章商品关系表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_returns_doc`
--

DROP TABLE IF EXISTS `iweb_returns_doc`;
CREATE TABLE `iweb_returns_doc` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL COMMENT '订单ID',
  `user_id` int(11) default NULL COMMENT '退货用户ID',
  `admin_id` int(11) default NULL COMMENT '管理员ID',
  `reason` varchar(50) default NULL COMMENT '退货原因',
  `postcode` int(6) default NULL COMMENT '邮编',
  `telphone` varchar(20) default NULL COMMENT '联系电话',
  `country` int(11) default NULL COMMENT '国ID',
  `province` int(11) default NULL COMMENT '省ID',
  `city` int(11) default NULL COMMENT '市ID',
  `area` int(11) default NULL COMMENT '区ID',
  `address` varchar(250) default NULL COMMENT '退货地址',
  `mobile` varchar(20) default NULL COMMENT '手机',
  `time` datetime default NULL COMMENT '创建时间',
  `freight` float(10,2) NOT NULL default '0.00' COMMENT '运费',
  `delivery_code` varchar(255) default NULL COMMENT '物流单号',
  `delivery_type` varchar(255) default NULL COMMENT '物流方式',
  `note` text COMMENT '备注',
  `name` varchar(50) default NULL COMMENT '退货人姓名',
  `if_del` tinyint(3) default NULL COMMENT '1为删除',
  `state` tinyint(3) default NULL COMMENT '0申请退货1退货成功2退货失败',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='退货单';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_right`
--

DROP TABLE IF EXISTS `iweb_right`;
CREATE TABLE `iweb_right` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL COMMENT '权限名字',
  `right` text COMMENT '权限码(控制器+动作)',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '删除状态 1删除,0正常',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='权限资源码';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_series`
--

DROP TABLE IF EXISTS `iweb_series`;
CREATE TABLE `iweb_series` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL COMMENT '名称',
  `price` float(10,2) NOT NULL default '0.00' COMMENT '销售价格',
  `nums` int(11) default NULL COMMENT '数量',
  `weight` float default NULL COMMENT '重量',
  `status` tinyint(1) default '1' COMMENT '1上架，0下架',
  `create_time` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='捆绑销售表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_series_relation`
--

DROP TABLE IF EXISTS `iweb_series_relation`;
CREATE TABLE `iweb_series_relation` (
  `id` int(11) NOT NULL auto_increment,
  `series_id` int(11) default NULL COMMENT '捆绑ID',
  `goods_id` int(11) default NULL COMMENT '商品ID',
  `nums` int(11) default NULL COMMENT '数量',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='捆绑产品关系表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_spec`
--

DROP TABLE IF EXISTS `iweb_spec`;
CREATE TABLE `iweb_spec` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL COMMENT '规格名称',
  `value` text COMMENT '规格值',
  `type` tinyint(1) NOT NULL default '1' COMMENT '显示类型 1文字 2图片',
  `note` varchar(255) default NULL COMMENT '备注说明',
  `is_del` tinyint(1) default '0' COMMENT '是否删除1删除',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='规格表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_spec_photo`
--

DROP TABLE IF EXISTS `iweb_spec_photo`;
CREATE TABLE `iweb_spec_photo` (
  `id` int(11) NOT NULL auto_increment,
  `address` varchar(255) default NULL COMMENT '图片地址',
  `name` varchar(100) default NULL COMMENT '图片名称',
  `create_time` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='规格图片表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_suggestion`
--

DROP TABLE IF EXISTS `iweb_suggestion`;
CREATE TABLE `iweb_suggestion` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `time` datetime default NULL COMMENT '提问时间',
  `admin_id` int(11) default NULL COMMENT '管理员ID',
  `re_content` text COMMENT '回复内容',
  `re_time` datetime default NULL COMMENT '回复时间',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='意见箱表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_ticket`
--

DROP TABLE IF EXISTS `iweb_ticket`;
CREATE TABLE `iweb_ticket` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL COMMENT '代金券名称',
  `value` float(10,2) NOT NULL default '0.00' COMMENT '代金券面额值',
  `start_time` datetime default NULL COMMENT '开始时间',
  `end_time` datetime default NULL COMMENT '结束时间',
  `point` int(11) NOT NULL default '0' COMMENT '兑换优惠券所需积分,如果是0表示禁止兑换',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='代金券类型表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_user`
--

DROP TABLE IF EXISTS `iweb_user`;
CREATE TABLE `iweb_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` varchar(250) default NULL COMMENT 'Email',
  `head_ico` varchar(250) default NULL COMMENT '头像',
  PRIMARY KEY  (`id`),
  KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户表';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_user_group`
--

DROP TABLE IF EXISTS `iweb_user_group`;
CREATE TABLE `iweb_user_group` (
  `id` int(11) NOT NULL auto_increment COMMENT '用户组ID',
  `group_name` varchar(20) NOT NULL COMMENT '组名',
  `discount` float NOT NULL default '0' COMMENT '折扣率',
  `minexp` int(11) default NULL COMMENT '最小经验',
  `maxexp` int(11) default NULL COMMENT '最大经验',
  `message_ids` varchar(255) default NULL COMMENT '消息ID',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='用户组';

-- --------------------------------------------------------

--
-- 表的结构 `iweb_withdraw`
--

DROP TABLE IF EXISTS `iweb_withdraw`;
CREATE TABLE `iweb_withdraw` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `time` datetime NOT NULL COMMENT '时间',
  `amount` float(10,2) NOT NULL default '0.00' COMMENT '金额',
  `account` varchar(255) default NULL COMMENT '收款账号',
  `type` tinyint(1) default NULL COMMENT '1银行2支付宝等',
  `name` varchar(255) default NULL COMMENT '开户名',
  `account_bank` varchar(255) default NULL COMMENT '开户行',
  `belong_bank` varchar(255) default NULL COMMENT '所属银行',
  `status` tinyint(1) NOT NULL default '0' COMMENT '-1失败,0未处理,1处理中,2成功',
  `note` varchar(255) default NULL COMMENT '用户备注',
  `re_note` varchar(255) default NULL COMMENT '回复备注信息',
  `is_del` tinyint(1) NOT NULL default '0' COMMENT '0未删除,1已删除',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='提现记录';

--
-- 导出表中的数据 `iweb_ad_manage`
--
INSERT INTO `iweb_ad_manage` VALUES (16, '首页左上方广告', 1, 5, 'http://www.baidu.com', 99, 0, 0, '2011-05-01', '2011-08-05', 'upload/2011/06/07/20110607105359556.png', '首页左上方广告');
INSERT INTO `iweb_ad_manage` VALUES (23, '首页中部通栏广告', 1, 6, 'http://www.google.com', 99, 0, 0, '2011-05-03', '2015-06-11', 'upload/2011/06/07/20110607105518688.png', '首页中部通栏广告');
INSERT INTO `iweb_ad_manage` VALUES (18, '首页右上方', 1, 7, 'http://www.facebook.com', 99, 0, 0, '2011-05-02', '2015-06-30', 'upload/2011/06/07/20110607105608864.png', '首页右上方');
INSERT INTO `iweb_ad_manage` VALUES (19, '商品搜索结果页198*120', 1, 8, 'http://www.163.com', 99, 198, 120, '2011-05-05', '2015-06-10', 'upload/2011/06/07/20110607105655941.png', '1');
INSERT INTO `iweb_ad_manage` VALUES (22, '文章公告内容页左侧', 1, 10, 'http://www.jooyea.net', 99, 0, 0, '2011-05-02', '2015-12-10', 'upload/2011/06/07/20110607105620728.png', '1');
INSERT INTO `iweb_ad_manage` VALUES (24, '首页中部通栏广告', 1, 6, 'http://www.google.com', 99, 0, 0, '2011-05-03', '2015-06-11', 'upload/2011/06/07/20110607105547573.png', '首页中部通栏广告');

--
-- 导出表中的数据 `iweb_ad_position`
--

INSERT INTO `iweb_ad_position` VALUES (1, '页面顶部通栏广告条', 0, 0, 0, 1, 0, 3);
INSERT INTO `iweb_ad_position` VALUES (5, '首页左上方748*299', 748, 299, 0, 1, 1, 1);
INSERT INTO `iweb_ad_position` VALUES (6, '首页中部通栏', 0, 0, 0, 1, 1, 1);
INSERT INTO `iweb_ad_position` VALUES (7, '首页又上方198*104', 198, 104, 0, 1, 1, 1);
INSERT INTO `iweb_ad_position` VALUES (8, '商品搜索结果页左侧', 198, 120, 0, 1, 1, 1);
INSERT INTO `iweb_ad_position` VALUES (10, '文章-公告内容页左册', 0, 0, 0, 1, 1, 1);

--
-- 导出表中的数据 `iweb_areas`
--

INSERT INTO `iweb_areas` VALUES (1, 0, '﻿北京', 99);
INSERT INTO `iweb_areas` VALUES (2, 1, '北京市', 99);
INSERT INTO `iweb_areas` VALUES (3, 2, '东城区', 99);
INSERT INTO `iweb_areas` VALUES (4, 2, '西城区', 99);
INSERT INTO `iweb_areas` VALUES (5, 2, '崇文区', 99);
INSERT INTO `iweb_areas` VALUES (6, 2, '宣武区', 99);
INSERT INTO `iweb_areas` VALUES (7, 2, '朝阳区', 99);
INSERT INTO `iweb_areas` VALUES (8, 2, '丰台区', 99);
INSERT INTO `iweb_areas` VALUES (9, 2, '石景山区', 99);
INSERT INTO `iweb_areas` VALUES (10, 2, '海淀区', 99);
INSERT INTO `iweb_areas` VALUES (11, 2, '门头沟区', 99);
INSERT INTO `iweb_areas` VALUES (12, 2, '房山区', 99);
INSERT INTO `iweb_areas` VALUES (13, 2, '通州区', 99);
INSERT INTO `iweb_areas` VALUES (14, 2, '顺义区', 99);
INSERT INTO `iweb_areas` VALUES (15, 2, '昌平区', 99);
INSERT INTO `iweb_areas` VALUES (16, 2, '大兴区', 99);
INSERT INTO `iweb_areas` VALUES (17, 2, '怀柔区', 99);
INSERT INTO `iweb_areas` VALUES (18, 2, '平谷区', 99);
INSERT INTO `iweb_areas` VALUES (19, 2, '密云县', 99);
INSERT INTO `iweb_areas` VALUES (20, 2, '延庆县', 99);
INSERT INTO `iweb_areas` VALUES (21, 0, '上海', 99);
INSERT INTO `iweb_areas` VALUES (22, 21, '上海市', 99);
INSERT INTO `iweb_areas` VALUES (23, 22, '黄浦区', 99);
INSERT INTO `iweb_areas` VALUES (24, 22, '卢湾区', 99);
INSERT INTO `iweb_areas` VALUES (25, 22, '徐汇区', 99);
INSERT INTO `iweb_areas` VALUES (26, 22, '长宁区', 99);
INSERT INTO `iweb_areas` VALUES (27, 22, '静安区', 99);
INSERT INTO `iweb_areas` VALUES (28, 22, '普陀区', 99);
INSERT INTO `iweb_areas` VALUES (29, 22, '闸北区', 99);
INSERT INTO `iweb_areas` VALUES (30, 22, '虹口区', 99);
INSERT INTO `iweb_areas` VALUES (31, 22, '杨浦区', 99);
INSERT INTO `iweb_areas` VALUES (32, 22, '闵行区', 99);
INSERT INTO `iweb_areas` VALUES (33, 22, '宝山区', 99);
INSERT INTO `iweb_areas` VALUES (34, 22, '嘉定区', 99);
INSERT INTO `iweb_areas` VALUES (35, 22, '浦东新区', 99);
INSERT INTO `iweb_areas` VALUES (36, 22, '金山区', 99);
INSERT INTO `iweb_areas` VALUES (37, 22, '松江区', 99);
INSERT INTO `iweb_areas` VALUES (38, 22, '青浦区', 99);
INSERT INTO `iweb_areas` VALUES (39, 22, '南汇区', 99);
INSERT INTO `iweb_areas` VALUES (40, 22, '奉贤区', 99);
INSERT INTO `iweb_areas` VALUES (41, 22, '崇明县', 99);
INSERT INTO `iweb_areas` VALUES (42, 0, '天津', 99);
INSERT INTO `iweb_areas` VALUES (43, 42, '天津市', 99);
INSERT INTO `iweb_areas` VALUES (44, 43, '和平区', 99);
INSERT INTO `iweb_areas` VALUES (45, 43, '河东区', 99);
INSERT INTO `iweb_areas` VALUES (46, 43, '河西区', 99);
INSERT INTO `iweb_areas` VALUES (47, 43, '南开区', 99);
INSERT INTO `iweb_areas` VALUES (48, 43, '河北区', 99);
INSERT INTO `iweb_areas` VALUES (49, 43, '红桥区', 99);
INSERT INTO `iweb_areas` VALUES (50, 43, '塘沽区', 99);
INSERT INTO `iweb_areas` VALUES (51, 43, '汉沽区', 99);
INSERT INTO `iweb_areas` VALUES (52, 43, '大港区', 99);
INSERT INTO `iweb_areas` VALUES (53, 43, '东丽区', 99);
INSERT INTO `iweb_areas` VALUES (54, 43, '西青区', 99);
INSERT INTO `iweb_areas` VALUES (55, 43, '津南区', 99);
INSERT INTO `iweb_areas` VALUES (56, 43, '北辰区', 99);
INSERT INTO `iweb_areas` VALUES (57, 43, '武清区', 99);
INSERT INTO `iweb_areas` VALUES (58, 43, '宝坻区', 99);
INSERT INTO `iweb_areas` VALUES (59, 43, '宁河县', 99);
INSERT INTO `iweb_areas` VALUES (60, 43, '静海县', 99);
INSERT INTO `iweb_areas` VALUES (61, 43, '蓟县', 99);
INSERT INTO `iweb_areas` VALUES (62, 0, '重庆', 99);
INSERT INTO `iweb_areas` VALUES (63, 62, '重庆市', 99);
INSERT INTO `iweb_areas` VALUES (64, 63, '万州区', 99);
INSERT INTO `iweb_areas` VALUES (65, 63, '涪陵区', 99);
INSERT INTO `iweb_areas` VALUES (66, 63, '渝中区', 99);
INSERT INTO `iweb_areas` VALUES (67, 63, '大渡口区', 99);
INSERT INTO `iweb_areas` VALUES (68, 63, '江北区', 99);
INSERT INTO `iweb_areas` VALUES (69, 63, '沙坪坝区', 99);
INSERT INTO `iweb_areas` VALUES (70, 63, '九龙坡区', 99);
INSERT INTO `iweb_areas` VALUES (71, 63, '南岸区', 99);
INSERT INTO `iweb_areas` VALUES (72, 63, '北碚区', 99);
INSERT INTO `iweb_areas` VALUES (73, 63, '万盛区', 99);
INSERT INTO `iweb_areas` VALUES (74, 63, '双桥区', 99);
INSERT INTO `iweb_areas` VALUES (75, 63, '渝北区', 99);
INSERT INTO `iweb_areas` VALUES (76, 63, '巴南区', 99);
INSERT INTO `iweb_areas` VALUES (77, 63, '黔江区', 99);
INSERT INTO `iweb_areas` VALUES (78, 63, '长寿区', 99);
INSERT INTO `iweb_areas` VALUES (79, 63, '綦江县', 99);
INSERT INTO `iweb_areas` VALUES (80, 63, '潼南县', 99);
INSERT INTO `iweb_areas` VALUES (81, 63, '铜梁县', 99);
INSERT INTO `iweb_areas` VALUES (82, 63, '大足县', 99);
INSERT INTO `iweb_areas` VALUES (83, 63, '荣昌县', 99);
INSERT INTO `iweb_areas` VALUES (84, 63, '璧山县', 99);
INSERT INTO `iweb_areas` VALUES (85, 63, '梁平县', 99);
INSERT INTO `iweb_areas` VALUES (86, 63, '城口县', 99);
INSERT INTO `iweb_areas` VALUES (87, 63, '丰都县', 99);
INSERT INTO `iweb_areas` VALUES (88, 63, '垫江县', 99);
INSERT INTO `iweb_areas` VALUES (89, 63, '武隆县', 99);
INSERT INTO `iweb_areas` VALUES (90, 63, '忠县', 99);
INSERT INTO `iweb_areas` VALUES (91, 63, '开县', 99);
INSERT INTO `iweb_areas` VALUES (92, 63, '云阳县', 99);
INSERT INTO `iweb_areas` VALUES (93, 63, '奉节县', 99);
INSERT INTO `iweb_areas` VALUES (94, 63, '巫山县', 99);
INSERT INTO `iweb_areas` VALUES (95, 63, '巫溪县', 99);
INSERT INTO `iweb_areas` VALUES (96, 63, '石柱土家族自治县', 99);
INSERT INTO `iweb_areas` VALUES (97, 63, '秀山土家族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (98, 63, '酉阳土家族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (99, 63, '彭水苗族土家族自治县', 99);
INSERT INTO `iweb_areas` VALUES (100, 63, '江津市', 99);
INSERT INTO `iweb_areas` VALUES (101, 63, '合川市', 99);
INSERT INTO `iweb_areas` VALUES (102, 63, '永川市', 99);
INSERT INTO `iweb_areas` VALUES (103, 63, '南川市', 99);
INSERT INTO `iweb_areas` VALUES (104, 0, '安徽', 99);
INSERT INTO `iweb_areas` VALUES (105, 104, '合肥市', 99);
INSERT INTO `iweb_areas` VALUES (106, 105, '瑶海区', 99);
INSERT INTO `iweb_areas` VALUES (107, 105, '庐阳区', 99);
INSERT INTO `iweb_areas` VALUES (108, 105, '蜀山区', 99);
INSERT INTO `iweb_areas` VALUES (109, 105, '包河区', 99);
INSERT INTO `iweb_areas` VALUES (110, 105, '长丰县', 99);
INSERT INTO `iweb_areas` VALUES (111, 105, '肥东县', 99);
INSERT INTO `iweb_areas` VALUES (112, 105, '肥西县', 99);
INSERT INTO `iweb_areas` VALUES (113, 104, '安庆市', 99);
INSERT INTO `iweb_areas` VALUES (114, 113, '迎江区', 99);
INSERT INTO `iweb_areas` VALUES (115, 113, '大观区', 99);
INSERT INTO `iweb_areas` VALUES (116, 113, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (117, 113, '怀宁县', 99);
INSERT INTO `iweb_areas` VALUES (118, 113, '枞阳县', 99);
INSERT INTO `iweb_areas` VALUES (119, 113, '潜山县', 99);
INSERT INTO `iweb_areas` VALUES (120, 113, '太湖县', 99);
INSERT INTO `iweb_areas` VALUES (121, 113, '宿松县', 99);
INSERT INTO `iweb_areas` VALUES (122, 113, '望江县', 99);
INSERT INTO `iweb_areas` VALUES (123, 113, '岳西县', 99);
INSERT INTO `iweb_areas` VALUES (124, 113, '桐城市', 99);
INSERT INTO `iweb_areas` VALUES (125, 104, '蚌埠市', 99);
INSERT INTO `iweb_areas` VALUES (126, 125, '龙子湖区', 99);
INSERT INTO `iweb_areas` VALUES (127, 125, '蚌山区', 99);
INSERT INTO `iweb_areas` VALUES (128, 125, '禹会区', 99);
INSERT INTO `iweb_areas` VALUES (129, 125, '淮上区', 99);
INSERT INTO `iweb_areas` VALUES (130, 125, '怀远县', 99);
INSERT INTO `iweb_areas` VALUES (131, 125, '五河县', 99);
INSERT INTO `iweb_areas` VALUES (132, 125, '固镇县', 99);
INSERT INTO `iweb_areas` VALUES (133, 104, '亳州市', 99);
INSERT INTO `iweb_areas` VALUES (134, 133, '谯城区', 99);
INSERT INTO `iweb_areas` VALUES (135, 133, '涡阳县', 99);
INSERT INTO `iweb_areas` VALUES (136, 133, '蒙城县', 99);
INSERT INTO `iweb_areas` VALUES (137, 133, '利辛县', 99);
INSERT INTO `iweb_areas` VALUES (138, 104, '巢湖市', 99);
INSERT INTO `iweb_areas` VALUES (139, 138, '居巢区', 99);
INSERT INTO `iweb_areas` VALUES (140, 138, '庐江县', 99);
INSERT INTO `iweb_areas` VALUES (141, 138, '无为县', 99);
INSERT INTO `iweb_areas` VALUES (142, 138, '含山县', 99);
INSERT INTO `iweb_areas` VALUES (143, 138, '和县', 99);
INSERT INTO `iweb_areas` VALUES (144, 104, '池州市', 99);
INSERT INTO `iweb_areas` VALUES (145, 144, '贵池区', 99);
INSERT INTO `iweb_areas` VALUES (146, 144, '东至县', 99);
INSERT INTO `iweb_areas` VALUES (147, 144, '石台县', 99);
INSERT INTO `iweb_areas` VALUES (148, 144, '青阳县', 99);
INSERT INTO `iweb_areas` VALUES (149, 104, '滁州市', 99);
INSERT INTO `iweb_areas` VALUES (150, 149, '琅琊区', 99);
INSERT INTO `iweb_areas` VALUES (151, 149, '南谯区', 99);
INSERT INTO `iweb_areas` VALUES (152, 149, '来安县', 99);
INSERT INTO `iweb_areas` VALUES (153, 149, '全椒县', 99);
INSERT INTO `iweb_areas` VALUES (154, 149, '定远县', 99);
INSERT INTO `iweb_areas` VALUES (155, 149, '凤阳县', 99);
INSERT INTO `iweb_areas` VALUES (156, 149, '天长市', 99);
INSERT INTO `iweb_areas` VALUES (157, 149, '明光市', 99);
INSERT INTO `iweb_areas` VALUES (158, 104, '阜阳市', 99);
INSERT INTO `iweb_areas` VALUES (159, 158, '颍州区', 99);
INSERT INTO `iweb_areas` VALUES (160, 158, '颍东区', 99);
INSERT INTO `iweb_areas` VALUES (161, 158, '颍泉区', 99);
INSERT INTO `iweb_areas` VALUES (162, 158, '临泉县', 99);
INSERT INTO `iweb_areas` VALUES (163, 158, '太和县', 99);
INSERT INTO `iweb_areas` VALUES (164, 158, '阜南县', 99);
INSERT INTO `iweb_areas` VALUES (165, 158, '颍上县', 99);
INSERT INTO `iweb_areas` VALUES (166, 158, '界首市', 99);
INSERT INTO `iweb_areas` VALUES (167, 104, '淮北市', 99);
INSERT INTO `iweb_areas` VALUES (168, 167, '杜集区', 99);
INSERT INTO `iweb_areas` VALUES (169, 167, '相山区', 99);
INSERT INTO `iweb_areas` VALUES (170, 167, '烈山区', 99);
INSERT INTO `iweb_areas` VALUES (171, 167, '濉溪县', 99);
INSERT INTO `iweb_areas` VALUES (172, 104, '淮南市', 99);
INSERT INTO `iweb_areas` VALUES (173, 172, '大通区', 99);
INSERT INTO `iweb_areas` VALUES (174, 172, '田家庵区', 99);
INSERT INTO `iweb_areas` VALUES (175, 172, '谢家集区', 99);
INSERT INTO `iweb_areas` VALUES (176, 172, '八公山区', 99);
INSERT INTO `iweb_areas` VALUES (177, 172, '潘集区', 99);
INSERT INTO `iweb_areas` VALUES (178, 172, '凤台县', 99);
INSERT INTO `iweb_areas` VALUES (179, 104, '黄山市', 99);
INSERT INTO `iweb_areas` VALUES (180, 179, '屯溪区', 99);
INSERT INTO `iweb_areas` VALUES (181, 179, '黄山区', 99);
INSERT INTO `iweb_areas` VALUES (182, 179, '徽州区', 99);
INSERT INTO `iweb_areas` VALUES (183, 179, '歙县', 99);
INSERT INTO `iweb_areas` VALUES (184, 179, '休宁县', 99);
INSERT INTO `iweb_areas` VALUES (185, 179, '黟县', 99);
INSERT INTO `iweb_areas` VALUES (186, 179, '祁门县', 99);
INSERT INTO `iweb_areas` VALUES (187, 104, '六安市', 99);
INSERT INTO `iweb_areas` VALUES (188, 187, '金安区', 99);
INSERT INTO `iweb_areas` VALUES (189, 187, '裕安区', 99);
INSERT INTO `iweb_areas` VALUES (190, 187, '寿县', 99);
INSERT INTO `iweb_areas` VALUES (191, 187, '霍邱县', 99);
INSERT INTO `iweb_areas` VALUES (192, 187, '舒城县', 99);
INSERT INTO `iweb_areas` VALUES (193, 187, '金寨县', 99);
INSERT INTO `iweb_areas` VALUES (194, 187, '霍山县', 99);
INSERT INTO `iweb_areas` VALUES (195, 104, '马鞍山市', 99);
INSERT INTO `iweb_areas` VALUES (196, 195, '金家庄区', 99);
INSERT INTO `iweb_areas` VALUES (197, 195, '花山区', 99);
INSERT INTO `iweb_areas` VALUES (198, 195, '雨山区', 99);
INSERT INTO `iweb_areas` VALUES (199, 195, '当涂县', 99);
INSERT INTO `iweb_areas` VALUES (200, 104, '宿州市', 99);
INSERT INTO `iweb_areas` VALUES (201, 200, '墉桥区', 99);
INSERT INTO `iweb_areas` VALUES (202, 200, '砀山县', 99);
INSERT INTO `iweb_areas` VALUES (203, 200, '萧县', 99);
INSERT INTO `iweb_areas` VALUES (204, 200, '灵璧县', 99);
INSERT INTO `iweb_areas` VALUES (205, 200, '泗县', 99);
INSERT INTO `iweb_areas` VALUES (206, 104, '铜陵市', 99);
INSERT INTO `iweb_areas` VALUES (207, 206, '铜官山区', 99);
INSERT INTO `iweb_areas` VALUES (208, 206, '狮子山区', 99);
INSERT INTO `iweb_areas` VALUES (209, 206, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (210, 206, '铜陵县', 99);
INSERT INTO `iweb_areas` VALUES (211, 104, '芜湖市', 99);
INSERT INTO `iweb_areas` VALUES (212, 211, '镜湖区', 99);
INSERT INTO `iweb_areas` VALUES (213, 211, '马塘区', 99);
INSERT INTO `iweb_areas` VALUES (214, 211, '新芜区', 99);
INSERT INTO `iweb_areas` VALUES (215, 211, '鸠江区', 99);
INSERT INTO `iweb_areas` VALUES (216, 211, '芜湖县', 99);
INSERT INTO `iweb_areas` VALUES (217, 211, '繁昌县', 99);
INSERT INTO `iweb_areas` VALUES (218, 211, '南陵县', 99);
INSERT INTO `iweb_areas` VALUES (219, 104, '宣城市', 99);
INSERT INTO `iweb_areas` VALUES (220, 219, '宣州区', 99);
INSERT INTO `iweb_areas` VALUES (221, 219, '郎溪县', 99);
INSERT INTO `iweb_areas` VALUES (222, 219, '广德县', 99);
INSERT INTO `iweb_areas` VALUES (223, 219, '泾县', 99);
INSERT INTO `iweb_areas` VALUES (224, 219, '绩溪县', 99);
INSERT INTO `iweb_areas` VALUES (225, 219, '旌德县', 99);
INSERT INTO `iweb_areas` VALUES (226, 219, '宁国市', 99);
INSERT INTO `iweb_areas` VALUES (227, 0, '福建', 99);
INSERT INTO `iweb_areas` VALUES (228, 227, '福州市', 99);
INSERT INTO `iweb_areas` VALUES (229, 228, '鼓楼区', 99);
INSERT INTO `iweb_areas` VALUES (230, 228, '台江区', 99);
INSERT INTO `iweb_areas` VALUES (231, 228, '仓山区', 99);
INSERT INTO `iweb_areas` VALUES (232, 228, '马尾区', 99);
INSERT INTO `iweb_areas` VALUES (233, 228, '晋安区', 99);
INSERT INTO `iweb_areas` VALUES (234, 228, '闽侯县', 99);
INSERT INTO `iweb_areas` VALUES (235, 228, '连江县', 99);
INSERT INTO `iweb_areas` VALUES (236, 228, '罗源县', 99);
INSERT INTO `iweb_areas` VALUES (237, 228, '闽清县', 99);
INSERT INTO `iweb_areas` VALUES (238, 228, '永泰县', 99);
INSERT INTO `iweb_areas` VALUES (239, 228, '平潭县', 99);
INSERT INTO `iweb_areas` VALUES (240, 228, '福清市', 99);
INSERT INTO `iweb_areas` VALUES (241, 228, '长乐市', 99);
INSERT INTO `iweb_areas` VALUES (242, 227, '龙岩市', 99);
INSERT INTO `iweb_areas` VALUES (243, 242, '新罗区', 99);
INSERT INTO `iweb_areas` VALUES (244, 242, '长汀县', 99);
INSERT INTO `iweb_areas` VALUES (245, 242, '永定县', 99);
INSERT INTO `iweb_areas` VALUES (246, 242, '上杭县', 99);
INSERT INTO `iweb_areas` VALUES (247, 242, '武平县', 99);
INSERT INTO `iweb_areas` VALUES (248, 242, '连城县', 99);
INSERT INTO `iweb_areas` VALUES (249, 242, '漳平市', 99);
INSERT INTO `iweb_areas` VALUES (250, 227, '南平市', 99);
INSERT INTO `iweb_areas` VALUES (251, 250, '延平区', 99);
INSERT INTO `iweb_areas` VALUES (252, 250, '顺昌县', 99);
INSERT INTO `iweb_areas` VALUES (253, 250, '浦城县', 99);
INSERT INTO `iweb_areas` VALUES (254, 250, '光泽县', 99);
INSERT INTO `iweb_areas` VALUES (255, 250, '松溪县', 99);
INSERT INTO `iweb_areas` VALUES (256, 250, '政和县', 99);
INSERT INTO `iweb_areas` VALUES (257, 250, '邵武市', 99);
INSERT INTO `iweb_areas` VALUES (258, 250, '武夷山市', 99);
INSERT INTO `iweb_areas` VALUES (259, 250, '建瓯市', 99);
INSERT INTO `iweb_areas` VALUES (260, 250, '建阳市', 99);
INSERT INTO `iweb_areas` VALUES (261, 227, '宁德市', 99);
INSERT INTO `iweb_areas` VALUES (262, 261, '蕉城区', 99);
INSERT INTO `iweb_areas` VALUES (263, 261, '霞浦县', 99);
INSERT INTO `iweb_areas` VALUES (264, 261, '古田县', 99);
INSERT INTO `iweb_areas` VALUES (265, 261, '屏南县', 99);
INSERT INTO `iweb_areas` VALUES (266, 261, '寿宁县', 99);
INSERT INTO `iweb_areas` VALUES (267, 261, '周宁县', 99);
INSERT INTO `iweb_areas` VALUES (268, 261, '柘荣县', 99);
INSERT INTO `iweb_areas` VALUES (269, 261, '福安市', 99);
INSERT INTO `iweb_areas` VALUES (270, 261, '福鼎市', 99);
INSERT INTO `iweb_areas` VALUES (271, 227, '莆田市', 99);
INSERT INTO `iweb_areas` VALUES (272, 271, '城厢区', 99);
INSERT INTO `iweb_areas` VALUES (273, 271, '涵江区', 99);
INSERT INTO `iweb_areas` VALUES (274, 271, '荔城区', 99);
INSERT INTO `iweb_areas` VALUES (275, 271, '秀屿区', 99);
INSERT INTO `iweb_areas` VALUES (276, 271, '仙游县', 99);
INSERT INTO `iweb_areas` VALUES (277, 227, '泉州市', 99);
INSERT INTO `iweb_areas` VALUES (278, 277, '鲤城区', 99);
INSERT INTO `iweb_areas` VALUES (279, 277, '丰泽区', 99);
INSERT INTO `iweb_areas` VALUES (280, 277, '洛江区', 99);
INSERT INTO `iweb_areas` VALUES (281, 277, '泉港区', 99);
INSERT INTO `iweb_areas` VALUES (282, 277, '惠安县', 99);
INSERT INTO `iweb_areas` VALUES (283, 277, '安溪县', 99);
INSERT INTO `iweb_areas` VALUES (284, 277, '永春县', 99);
INSERT INTO `iweb_areas` VALUES (285, 277, '德化县', 99);
INSERT INTO `iweb_areas` VALUES (286, 277, '金门县', 99);
INSERT INTO `iweb_areas` VALUES (287, 277, '石狮市', 99);
INSERT INTO `iweb_areas` VALUES (288, 277, '晋江市', 99);
INSERT INTO `iweb_areas` VALUES (289, 277, '南安市', 99);
INSERT INTO `iweb_areas` VALUES (290, 227, '三明市', 99);
INSERT INTO `iweb_areas` VALUES (291, 290, '梅列区', 99);
INSERT INTO `iweb_areas` VALUES (292, 290, '三元区', 99);
INSERT INTO `iweb_areas` VALUES (293, 290, '明溪县', 99);
INSERT INTO `iweb_areas` VALUES (294, 290, '清流县', 99);
INSERT INTO `iweb_areas` VALUES (295, 290, '宁化县', 99);
INSERT INTO `iweb_areas` VALUES (296, 290, '大田县', 99);
INSERT INTO `iweb_areas` VALUES (297, 290, '尤溪县', 99);
INSERT INTO `iweb_areas` VALUES (298, 290, '沙县', 99);
INSERT INTO `iweb_areas` VALUES (299, 290, '将乐县', 99);
INSERT INTO `iweb_areas` VALUES (300, 290, '泰宁县', 99);
INSERT INTO `iweb_areas` VALUES (301, 290, '建宁县', 99);
INSERT INTO `iweb_areas` VALUES (302, 290, '永安市', 99);
INSERT INTO `iweb_areas` VALUES (303, 227, '厦门市', 99);
INSERT INTO `iweb_areas` VALUES (304, 303, '思明区', 99);
INSERT INTO `iweb_areas` VALUES (305, 303, '海沧区', 99);
INSERT INTO `iweb_areas` VALUES (306, 303, '湖里区', 99);
INSERT INTO `iweb_areas` VALUES (307, 303, '集美区', 99);
INSERT INTO `iweb_areas` VALUES (308, 303, '同安区', 99);
INSERT INTO `iweb_areas` VALUES (309, 303, '翔安区', 99);
INSERT INTO `iweb_areas` VALUES (310, 227, '漳州市', 99);
INSERT INTO `iweb_areas` VALUES (311, 310, '芗城区', 99);
INSERT INTO `iweb_areas` VALUES (312, 310, '龙文区', 99);
INSERT INTO `iweb_areas` VALUES (313, 310, '云霄县', 99);
INSERT INTO `iweb_areas` VALUES (314, 310, '漳浦县', 99);
INSERT INTO `iweb_areas` VALUES (315, 310, '诏安县', 99);
INSERT INTO `iweb_areas` VALUES (316, 310, '长泰县', 99);
INSERT INTO `iweb_areas` VALUES (317, 310, '东山县', 99);
INSERT INTO `iweb_areas` VALUES (318, 310, '南靖县', 99);
INSERT INTO `iweb_areas` VALUES (319, 310, '平和县', 99);
INSERT INTO `iweb_areas` VALUES (320, 310, '华安县', 99);
INSERT INTO `iweb_areas` VALUES (321, 310, '龙海市', 99);
INSERT INTO `iweb_areas` VALUES (322, 0, '甘肃', 99);
INSERT INTO `iweb_areas` VALUES (323, 322, '兰州市', 99);
INSERT INTO `iweb_areas` VALUES (324, 323, '城关区', 99);
INSERT INTO `iweb_areas` VALUES (325, 323, '七里河区', 99);
INSERT INTO `iweb_areas` VALUES (326, 323, '西固区', 99);
INSERT INTO `iweb_areas` VALUES (327, 323, '安宁区', 99);
INSERT INTO `iweb_areas` VALUES (328, 323, '红古区', 99);
INSERT INTO `iweb_areas` VALUES (329, 323, '永登县', 99);
INSERT INTO `iweb_areas` VALUES (330, 323, '皋兰县', 99);
INSERT INTO `iweb_areas` VALUES (331, 323, '榆中县', 99);
INSERT INTO `iweb_areas` VALUES (332, 322, '白银市', 99);
INSERT INTO `iweb_areas` VALUES (333, 332, '白银区', 99);
INSERT INTO `iweb_areas` VALUES (334, 332, '平川区', 99);
INSERT INTO `iweb_areas` VALUES (335, 332, '靖远县', 99);
INSERT INTO `iweb_areas` VALUES (336, 332, '会宁县', 99);
INSERT INTO `iweb_areas` VALUES (337, 332, '景泰县', 99);
INSERT INTO `iweb_areas` VALUES (338, 322, '定西市', 99);
INSERT INTO `iweb_areas` VALUES (339, 338, '安定区', 99);
INSERT INTO `iweb_areas` VALUES (340, 338, '通渭县', 99);
INSERT INTO `iweb_areas` VALUES (341, 338, '陇西县', 99);
INSERT INTO `iweb_areas` VALUES (342, 338, '渭源县', 99);
INSERT INTO `iweb_areas` VALUES (343, 338, '临洮县', 99);
INSERT INTO `iweb_areas` VALUES (344, 338, '漳县', 99);
INSERT INTO `iweb_areas` VALUES (345, 338, '岷县', 99);
INSERT INTO `iweb_areas` VALUES (346, 322, '甘南藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (347, 346, '合作市', 99);
INSERT INTO `iweb_areas` VALUES (348, 346, '临潭县', 99);
INSERT INTO `iweb_areas` VALUES (349, 346, '卓尼县', 99);
INSERT INTO `iweb_areas` VALUES (350, 346, '舟曲县', 99);
INSERT INTO `iweb_areas` VALUES (351, 346, '迭部县', 99);
INSERT INTO `iweb_areas` VALUES (352, 346, '玛曲县', 99);
INSERT INTO `iweb_areas` VALUES (353, 346, '碌曲县', 99);
INSERT INTO `iweb_areas` VALUES (354, 346, '夏河县', 99);
INSERT INTO `iweb_areas` VALUES (355, 322, '嘉峪关市', 99);
INSERT INTO `iweb_areas` VALUES (356, 322, '金昌市', 99);
INSERT INTO `iweb_areas` VALUES (357, 356, '金川区', 99);
INSERT INTO `iweb_areas` VALUES (358, 356, '永昌县', 99);
INSERT INTO `iweb_areas` VALUES (359, 322, '酒泉市', 99);
INSERT INTO `iweb_areas` VALUES (360, 359, '肃州区', 99);
INSERT INTO `iweb_areas` VALUES (361, 359, '金塔县', 99);
INSERT INTO `iweb_areas` VALUES (362, 359, '安西县', 99);
INSERT INTO `iweb_areas` VALUES (363, 359, '肃北蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (364, 359, '阿克塞哈萨克族自治县', 99);
INSERT INTO `iweb_areas` VALUES (365, 359, '玉门市', 99);
INSERT INTO `iweb_areas` VALUES (366, 359, '敦煌市', 99);
INSERT INTO `iweb_areas` VALUES (367, 322, '临夏回族自治州', 99);
INSERT INTO `iweb_areas` VALUES (368, 367, '临夏市', 99);
INSERT INTO `iweb_areas` VALUES (369, 367, '临夏县', 99);
INSERT INTO `iweb_areas` VALUES (370, 367, '康乐县', 99);
INSERT INTO `iweb_areas` VALUES (371, 367, '永靖县', 99);
INSERT INTO `iweb_areas` VALUES (372, 367, '广河县', 99);
INSERT INTO `iweb_areas` VALUES (373, 367, '和政县', 99);
INSERT INTO `iweb_areas` VALUES (374, 367, '东乡族自治县', 99);
INSERT INTO `iweb_areas` VALUES (375, 367, '积石山保安族东乡族撒拉族自治县', 99);
INSERT INTO `iweb_areas` VALUES (376, 322, '陇南市', 99);
INSERT INTO `iweb_areas` VALUES (377, 376, '武都区', 99);
INSERT INTO `iweb_areas` VALUES (378, 376, '成县', 99);
INSERT INTO `iweb_areas` VALUES (379, 376, '文县', 99);
INSERT INTO `iweb_areas` VALUES (380, 376, '宕昌县', 99);
INSERT INTO `iweb_areas` VALUES (381, 376, '康县', 99);
INSERT INTO `iweb_areas` VALUES (382, 376, '西和县', 99);
INSERT INTO `iweb_areas` VALUES (383, 376, '礼县', 99);
INSERT INTO `iweb_areas` VALUES (384, 376, '徽县', 99);
INSERT INTO `iweb_areas` VALUES (385, 376, '两当县', 99);
INSERT INTO `iweb_areas` VALUES (386, 322, '平凉市', 99);
INSERT INTO `iweb_areas` VALUES (387, 386, '崆峒区', 99);
INSERT INTO `iweb_areas` VALUES (388, 386, '泾川县', 99);
INSERT INTO `iweb_areas` VALUES (389, 386, '灵台县', 99);
INSERT INTO `iweb_areas` VALUES (390, 386, '崇信县', 99);
INSERT INTO `iweb_areas` VALUES (391, 386, '华亭县', 99);
INSERT INTO `iweb_areas` VALUES (392, 386, '庄浪县', 99);
INSERT INTO `iweb_areas` VALUES (393, 386, '静宁县', 99);
INSERT INTO `iweb_areas` VALUES (394, 322, '庆阳市', 99);
INSERT INTO `iweb_areas` VALUES (395, 394, '西峰区', 99);
INSERT INTO `iweb_areas` VALUES (396, 394, '庆城县', 99);
INSERT INTO `iweb_areas` VALUES (397, 394, '环县', 99);
INSERT INTO `iweb_areas` VALUES (398, 394, '华池县', 99);
INSERT INTO `iweb_areas` VALUES (399, 394, '合水县', 99);
INSERT INTO `iweb_areas` VALUES (400, 394, '正宁县', 99);
INSERT INTO `iweb_areas` VALUES (401, 394, '宁县', 99);
INSERT INTO `iweb_areas` VALUES (402, 394, '镇原县', 99);
INSERT INTO `iweb_areas` VALUES (403, 322, '天水市', 99);
INSERT INTO `iweb_areas` VALUES (404, 403, '秦城区', 99);
INSERT INTO `iweb_areas` VALUES (405, 403, '北道区', 99);
INSERT INTO `iweb_areas` VALUES (406, 403, '清水县', 99);
INSERT INTO `iweb_areas` VALUES (407, 403, '秦安县', 99);
INSERT INTO `iweb_areas` VALUES (408, 403, '甘谷县', 99);
INSERT INTO `iweb_areas` VALUES (409, 403, '武山县', 99);
INSERT INTO `iweb_areas` VALUES (410, 403, '张家川回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (411, 322, '武威市', 99);
INSERT INTO `iweb_areas` VALUES (412, 411, '凉州区', 99);
INSERT INTO `iweb_areas` VALUES (413, 411, '民勤县', 99);
INSERT INTO `iweb_areas` VALUES (414, 411, '古浪县', 99);
INSERT INTO `iweb_areas` VALUES (415, 411, '天祝藏族自治县', 99);
INSERT INTO `iweb_areas` VALUES (416, 322, '张掖市', 99);
INSERT INTO `iweb_areas` VALUES (417, 416, '甘州区', 99);
INSERT INTO `iweb_areas` VALUES (418, 416, '肃南裕固族自治县', 99);
INSERT INTO `iweb_areas` VALUES (419, 416, '民乐县', 99);
INSERT INTO `iweb_areas` VALUES (420, 416, '临泽县', 99);
INSERT INTO `iweb_areas` VALUES (421, 416, '高台县', 99);
INSERT INTO `iweb_areas` VALUES (422, 416, '山丹县', 99);
INSERT INTO `iweb_areas` VALUES (423, 0, '广东', 99);
INSERT INTO `iweb_areas` VALUES (424, 423, '广州市', 99);
INSERT INTO `iweb_areas` VALUES (425, 424, '东山区', 99);
INSERT INTO `iweb_areas` VALUES (426, 424, '荔湾区', 99);
INSERT INTO `iweb_areas` VALUES (427, 424, '越秀区', 99);
INSERT INTO `iweb_areas` VALUES (428, 424, '海珠区', 99);
INSERT INTO `iweb_areas` VALUES (429, 424, '天河区', 99);
INSERT INTO `iweb_areas` VALUES (430, 424, '芳村区', 99);
INSERT INTO `iweb_areas` VALUES (431, 424, '白云区', 99);
INSERT INTO `iweb_areas` VALUES (432, 424, '黄埔区', 99);
INSERT INTO `iweb_areas` VALUES (433, 424, '番禺区', 99);
INSERT INTO `iweb_areas` VALUES (434, 424, '花都区', 99);
INSERT INTO `iweb_areas` VALUES (435, 424, '增城市', 99);
INSERT INTO `iweb_areas` VALUES (436, 424, '从化市', 99);
INSERT INTO `iweb_areas` VALUES (437, 423, '潮州市', 99);
INSERT INTO `iweb_areas` VALUES (438, 437, '湘桥区', 99);
INSERT INTO `iweb_areas` VALUES (439, 437, '潮安县', 99);
INSERT INTO `iweb_areas` VALUES (440, 437, '饶平县', 99);
INSERT INTO `iweb_areas` VALUES (441, 423, '东莞市', 99);
INSERT INTO `iweb_areas` VALUES (442, 423, '佛山市', 99);
INSERT INTO `iweb_areas` VALUES (443, 442, '禅城区', 99);
INSERT INTO `iweb_areas` VALUES (444, 442, '南海区', 99);
INSERT INTO `iweb_areas` VALUES (445, 442, '顺德区', 99);
INSERT INTO `iweb_areas` VALUES (446, 442, '三水区', 99);
INSERT INTO `iweb_areas` VALUES (447, 442, '高明区', 99);
INSERT INTO `iweb_areas` VALUES (448, 423, '河源市', 99);
INSERT INTO `iweb_areas` VALUES (449, 448, '源城区', 99);
INSERT INTO `iweb_areas` VALUES (450, 448, '紫金县', 99);
INSERT INTO `iweb_areas` VALUES (451, 448, '龙川县', 99);
INSERT INTO `iweb_areas` VALUES (452, 448, '连平县', 99);
INSERT INTO `iweb_areas` VALUES (453, 448, '和平县', 99);
INSERT INTO `iweb_areas` VALUES (454, 448, '东源县', 99);
INSERT INTO `iweb_areas` VALUES (455, 423, '惠州市', 99);
INSERT INTO `iweb_areas` VALUES (456, 455, '惠城区', 99);
INSERT INTO `iweb_areas` VALUES (457, 455, '惠阳区', 99);
INSERT INTO `iweb_areas` VALUES (458, 455, '博罗县', 99);
INSERT INTO `iweb_areas` VALUES (459, 455, '惠东县', 99);
INSERT INTO `iweb_areas` VALUES (460, 455, '龙门县', 99);
INSERT INTO `iweb_areas` VALUES (461, 423, '江门市', 99);
INSERT INTO `iweb_areas` VALUES (462, 461, '蓬江区', 99);
INSERT INTO `iweb_areas` VALUES (463, 461, '江海区', 99);
INSERT INTO `iweb_areas` VALUES (464, 461, '新会区', 99);
INSERT INTO `iweb_areas` VALUES (465, 461, '台山市', 99);
INSERT INTO `iweb_areas` VALUES (466, 461, '开平市', 99);
INSERT INTO `iweb_areas` VALUES (467, 461, '鹤山市', 99);
INSERT INTO `iweb_areas` VALUES (468, 461, '恩平市', 99);
INSERT INTO `iweb_areas` VALUES (469, 423, '揭阳市', 99);
INSERT INTO `iweb_areas` VALUES (470, 469, '榕城区', 99);
INSERT INTO `iweb_areas` VALUES (471, 469, '揭东县', 99);
INSERT INTO `iweb_areas` VALUES (472, 469, '揭西县', 99);
INSERT INTO `iweb_areas` VALUES (473, 469, '惠来县', 99);
INSERT INTO `iweb_areas` VALUES (474, 469, '普宁市', 99);
INSERT INTO `iweb_areas` VALUES (475, 423, '茂名市', 99);
INSERT INTO `iweb_areas` VALUES (476, 475, '茂南区', 99);
INSERT INTO `iweb_areas` VALUES (477, 475, '茂港区', 99);
INSERT INTO `iweb_areas` VALUES (478, 475, '电白县', 99);
INSERT INTO `iweb_areas` VALUES (479, 475, '高州市', 99);
INSERT INTO `iweb_areas` VALUES (480, 475, '化州市', 99);
INSERT INTO `iweb_areas` VALUES (481, 475, '信宜市', 99);
INSERT INTO `iweb_areas` VALUES (482, 423, '梅江区', 99);
INSERT INTO `iweb_areas` VALUES (483, 423, '梅州市', 99);
INSERT INTO `iweb_areas` VALUES (484, 483, '梅县', 99);
INSERT INTO `iweb_areas` VALUES (485, 483, '大埔县', 99);
INSERT INTO `iweb_areas` VALUES (486, 483, '丰顺县', 99);
INSERT INTO `iweb_areas` VALUES (487, 483, '五华县', 99);
INSERT INTO `iweb_areas` VALUES (488, 483, '平远县', 99);
INSERT INTO `iweb_areas` VALUES (489, 483, '蕉岭县', 99);
INSERT INTO `iweb_areas` VALUES (490, 483, '兴宁市', 99);
INSERT INTO `iweb_areas` VALUES (491, 423, '清远市', 99);
INSERT INTO `iweb_areas` VALUES (492, 491, '清城区', 99);
INSERT INTO `iweb_areas` VALUES (493, 491, '佛冈县', 99);
INSERT INTO `iweb_areas` VALUES (494, 491, '阳山县', 99);
INSERT INTO `iweb_areas` VALUES (495, 491, '连山壮族瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (496, 491, '连南瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (497, 491, '清新县', 99);
INSERT INTO `iweb_areas` VALUES (498, 491, '英德市', 99);
INSERT INTO `iweb_areas` VALUES (499, 491, '连州市', 99);
INSERT INTO `iweb_areas` VALUES (500, 423, '汕头市', 99);
INSERT INTO `iweb_areas` VALUES (501, 500, '龙湖区', 99);
INSERT INTO `iweb_areas` VALUES (502, 500, '金平区', 99);
INSERT INTO `iweb_areas` VALUES (503, 500, '濠江区', 99);
INSERT INTO `iweb_areas` VALUES (504, 500, '潮阳区', 99);
INSERT INTO `iweb_areas` VALUES (505, 500, '潮南区', 99);
INSERT INTO `iweb_areas` VALUES (506, 500, '澄海区', 99);
INSERT INTO `iweb_areas` VALUES (507, 500, '南澳县', 99);
INSERT INTO `iweb_areas` VALUES (508, 423, '汕尾市', 99);
INSERT INTO `iweb_areas` VALUES (509, 508, '城区', 99);
INSERT INTO `iweb_areas` VALUES (510, 508, '海丰县', 99);
INSERT INTO `iweb_areas` VALUES (511, 508, '陆河县', 99);
INSERT INTO `iweb_areas` VALUES (512, 508, '陆丰市', 99);
INSERT INTO `iweb_areas` VALUES (513, 423, '韶关市', 99);
INSERT INTO `iweb_areas` VALUES (514, 513, '武江区', 99);
INSERT INTO `iweb_areas` VALUES (515, 513, '浈江区', 99);
INSERT INTO `iweb_areas` VALUES (516, 513, '曲江区', 99);
INSERT INTO `iweb_areas` VALUES (517, 513, '始兴县', 99);
INSERT INTO `iweb_areas` VALUES (518, 513, '仁化县', 99);
INSERT INTO `iweb_areas` VALUES (519, 513, '翁源县', 99);
INSERT INTO `iweb_areas` VALUES (520, 513, '乳源瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (521, 513, '新丰县', 99);
INSERT INTO `iweb_areas` VALUES (522, 513, '乐昌市', 99);
INSERT INTO `iweb_areas` VALUES (523, 513, '南雄市', 99);
INSERT INTO `iweb_areas` VALUES (524, 423, '深圳市', 99);
INSERT INTO `iweb_areas` VALUES (525, 524, '罗湖区', 99);
INSERT INTO `iweb_areas` VALUES (526, 524, '福田区', 99);
INSERT INTO `iweb_areas` VALUES (527, 524, '南山区', 99);
INSERT INTO `iweb_areas` VALUES (528, 524, '宝安区', 99);
INSERT INTO `iweb_areas` VALUES (529, 524, '龙岗区', 99);
INSERT INTO `iweb_areas` VALUES (530, 524, '盐田区', 99);
INSERT INTO `iweb_areas` VALUES (531, 423, '阳江市', 99);
INSERT INTO `iweb_areas` VALUES (532, 531, '江城区', 99);
INSERT INTO `iweb_areas` VALUES (533, 531, '阳西县', 99);
INSERT INTO `iweb_areas` VALUES (534, 531, '阳东县', 99);
INSERT INTO `iweb_areas` VALUES (535, 531, '阳春市', 99);
INSERT INTO `iweb_areas` VALUES (536, 423, '云浮市', 99);
INSERT INTO `iweb_areas` VALUES (537, 536, '云城区', 99);
INSERT INTO `iweb_areas` VALUES (538, 536, '新兴县', 99);
INSERT INTO `iweb_areas` VALUES (539, 536, '郁南县', 99);
INSERT INTO `iweb_areas` VALUES (540, 536, '云安县', 99);
INSERT INTO `iweb_areas` VALUES (541, 536, '罗定市', 99);
INSERT INTO `iweb_areas` VALUES (542, 423, '湛江市', 99);
INSERT INTO `iweb_areas` VALUES (543, 542, '赤坎区', 99);
INSERT INTO `iweb_areas` VALUES (544, 542, '霞山区', 99);
INSERT INTO `iweb_areas` VALUES (545, 542, '坡头区', 99);
INSERT INTO `iweb_areas` VALUES (546, 542, '麻章区', 99);
INSERT INTO `iweb_areas` VALUES (547, 542, '遂溪县', 99);
INSERT INTO `iweb_areas` VALUES (548, 542, '徐闻县', 99);
INSERT INTO `iweb_areas` VALUES (549, 542, '廉江市', 99);
INSERT INTO `iweb_areas` VALUES (550, 542, '雷州市', 99);
INSERT INTO `iweb_areas` VALUES (551, 542, '吴川市', 99);
INSERT INTO `iweb_areas` VALUES (552, 423, '肇庆市', 99);
INSERT INTO `iweb_areas` VALUES (553, 552, '端州区', 99);
INSERT INTO `iweb_areas` VALUES (554, 552, '鼎湖区', 99);
INSERT INTO `iweb_areas` VALUES (555, 552, '广宁县', 99);
INSERT INTO `iweb_areas` VALUES (556, 552, '怀集县', 99);
INSERT INTO `iweb_areas` VALUES (557, 552, '封开县', 99);
INSERT INTO `iweb_areas` VALUES (558, 552, '德庆县', 99);
INSERT INTO `iweb_areas` VALUES (559, 552, '高要市', 99);
INSERT INTO `iweb_areas` VALUES (560, 552, '四会市', 99);
INSERT INTO `iweb_areas` VALUES (561, 423, '中山市', 99);
INSERT INTO `iweb_areas` VALUES (562, 423, '珠海市', 99);
INSERT INTO `iweb_areas` VALUES (563, 562, '香洲区', 99);
INSERT INTO `iweb_areas` VALUES (564, 562, '斗门区', 99);
INSERT INTO `iweb_areas` VALUES (565, 562, '金湾区', 99);
INSERT INTO `iweb_areas` VALUES (566, 0, '广西', 99);
INSERT INTO `iweb_areas` VALUES (567, 566, '南宁市', 99);
INSERT INTO `iweb_areas` VALUES (568, 567, '兴宁区', 99);
INSERT INTO `iweb_areas` VALUES (569, 567, '青秀区', 99);
INSERT INTO `iweb_areas` VALUES (570, 567, '江南区', 99);
INSERT INTO `iweb_areas` VALUES (571, 567, '西乡塘区', 99);
INSERT INTO `iweb_areas` VALUES (572, 567, '良庆区', 99);
INSERT INTO `iweb_areas` VALUES (573, 567, '邕宁区', 99);
INSERT INTO `iweb_areas` VALUES (574, 567, '武鸣县', 99);
INSERT INTO `iweb_areas` VALUES (575, 567, '隆安县', 99);
INSERT INTO `iweb_areas` VALUES (576, 567, '马山县', 99);
INSERT INTO `iweb_areas` VALUES (577, 567, '上林县', 99);
INSERT INTO `iweb_areas` VALUES (578, 567, '宾阳县', 99);
INSERT INTO `iweb_areas` VALUES (579, 567, '横县', 99);
INSERT INTO `iweb_areas` VALUES (580, 566, '百色市', 99);
INSERT INTO `iweb_areas` VALUES (581, 580, '右江区', 99);
INSERT INTO `iweb_areas` VALUES (582, 580, '田阳县', 99);
INSERT INTO `iweb_areas` VALUES (583, 580, '田东县', 99);
INSERT INTO `iweb_areas` VALUES (584, 580, '平果县', 99);
INSERT INTO `iweb_areas` VALUES (585, 580, '德保县', 99);
INSERT INTO `iweb_areas` VALUES (586, 580, '靖西县', 99);
INSERT INTO `iweb_areas` VALUES (587, 580, '那坡县', 99);
INSERT INTO `iweb_areas` VALUES (588, 580, '凌云县', 99);
INSERT INTO `iweb_areas` VALUES (589, 580, '乐业县', 99);
INSERT INTO `iweb_areas` VALUES (590, 580, '田林县', 99);
INSERT INTO `iweb_areas` VALUES (591, 580, '西林县', 99);
INSERT INTO `iweb_areas` VALUES (592, 580, '隆林各族自治县', 99);
INSERT INTO `iweb_areas` VALUES (593, 566, '北海市', 99);
INSERT INTO `iweb_areas` VALUES (594, 593, '海城区', 99);
INSERT INTO `iweb_areas` VALUES (595, 593, '银海区', 99);
INSERT INTO `iweb_areas` VALUES (596, 593, '铁山港区', 99);
INSERT INTO `iweb_areas` VALUES (597, 593, '合浦县', 99);
INSERT INTO `iweb_areas` VALUES (598, 566, '崇左市', 99);
INSERT INTO `iweb_areas` VALUES (599, 598, '江洲区', 99);
INSERT INTO `iweb_areas` VALUES (600, 598, '扶绥县', 99);
INSERT INTO `iweb_areas` VALUES (601, 598, '宁明县', 99);
INSERT INTO `iweb_areas` VALUES (602, 598, '龙州县', 99);
INSERT INTO `iweb_areas` VALUES (603, 598, '大新县', 99);
INSERT INTO `iweb_areas` VALUES (604, 598, '天等县', 99);
INSERT INTO `iweb_areas` VALUES (605, 598, '凭祥市', 99);
INSERT INTO `iweb_areas` VALUES (606, 566, '防城港市', 99);
INSERT INTO `iweb_areas` VALUES (607, 606, '港口区', 99);
INSERT INTO `iweb_areas` VALUES (608, 606, '防城区', 99);
INSERT INTO `iweb_areas` VALUES (609, 606, '上思县', 99);
INSERT INTO `iweb_areas` VALUES (610, 606, '东兴市', 99);
INSERT INTO `iweb_areas` VALUES (611, 566, '贵港市', 99);
INSERT INTO `iweb_areas` VALUES (612, 611, '港北区', 99);
INSERT INTO `iweb_areas` VALUES (613, 611, '港南区', 99);
INSERT INTO `iweb_areas` VALUES (614, 611, '覃塘区', 99);
INSERT INTO `iweb_areas` VALUES (615, 611, '平南县', 99);
INSERT INTO `iweb_areas` VALUES (616, 611, '桂平市', 99);
INSERT INTO `iweb_areas` VALUES (617, 566, '桂林市', 99);
INSERT INTO `iweb_areas` VALUES (618, 617, '秀峰区', 99);
INSERT INTO `iweb_areas` VALUES (619, 617, '叠彩区', 99);
INSERT INTO `iweb_areas` VALUES (620, 617, '象山区', 99);
INSERT INTO `iweb_areas` VALUES (621, 617, '七星区', 99);
INSERT INTO `iweb_areas` VALUES (622, 617, '雁山区', 99);
INSERT INTO `iweb_areas` VALUES (623, 617, '阳朔县', 99);
INSERT INTO `iweb_areas` VALUES (624, 617, '临桂县', 99);
INSERT INTO `iweb_areas` VALUES (625, 617, '灵川县', 99);
INSERT INTO `iweb_areas` VALUES (626, 617, '全州县', 99);
INSERT INTO `iweb_areas` VALUES (627, 617, '兴安县', 99);
INSERT INTO `iweb_areas` VALUES (628, 617, '永福县', 99);
INSERT INTO `iweb_areas` VALUES (629, 617, '灌阳县', 99);
INSERT INTO `iweb_areas` VALUES (630, 617, '龙胜各族自治县', 99);
INSERT INTO `iweb_areas` VALUES (631, 617, '资源县', 99);
INSERT INTO `iweb_areas` VALUES (632, 617, '平乐县', 99);
INSERT INTO `iweb_areas` VALUES (633, 617, '荔蒲县', 99);
INSERT INTO `iweb_areas` VALUES (634, 617, '恭城瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (635, 566, '河池市', 99);
INSERT INTO `iweb_areas` VALUES (636, 635, '金城江区', 99);
INSERT INTO `iweb_areas` VALUES (637, 635, '南丹县', 99);
INSERT INTO `iweb_areas` VALUES (638, 635, '天峨县', 99);
INSERT INTO `iweb_areas` VALUES (639, 635, '凤山县', 99);
INSERT INTO `iweb_areas` VALUES (640, 635, '东兰县', 99);
INSERT INTO `iweb_areas` VALUES (641, 635, '罗城仫佬族自治县', 99);
INSERT INTO `iweb_areas` VALUES (642, 635, '环江毛南族自治县', 99);
INSERT INTO `iweb_areas` VALUES (643, 635, '巴马瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (644, 635, '都安瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (645, 635, '大化瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (646, 635, '宜州市', 99);
INSERT INTO `iweb_areas` VALUES (647, 566, '贺州市', 99);
INSERT INTO `iweb_areas` VALUES (648, 647, '八步区', 99);
INSERT INTO `iweb_areas` VALUES (649, 647, '昭平县', 99);
INSERT INTO `iweb_areas` VALUES (650, 647, '钟山县', 99);
INSERT INTO `iweb_areas` VALUES (651, 647, '富川瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (652, 566, '来宾市', 99);
INSERT INTO `iweb_areas` VALUES (653, 652, '兴宾区', 99);
INSERT INTO `iweb_areas` VALUES (654, 652, '忻城县', 99);
INSERT INTO `iweb_areas` VALUES (655, 652, '象州县', 99);
INSERT INTO `iweb_areas` VALUES (656, 652, '武宣县', 99);
INSERT INTO `iweb_areas` VALUES (657, 652, '金秀瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (658, 652, '合山市', 99);
INSERT INTO `iweb_areas` VALUES (659, 566, '柳州市', 99);
INSERT INTO `iweb_areas` VALUES (660, 659, '城中区', 99);
INSERT INTO `iweb_areas` VALUES (661, 659, '鱼峰区', 99);
INSERT INTO `iweb_areas` VALUES (662, 659, '柳南区', 99);
INSERT INTO `iweb_areas` VALUES (663, 659, '柳北区', 99);
INSERT INTO `iweb_areas` VALUES (664, 659, '柳江县', 99);
INSERT INTO `iweb_areas` VALUES (665, 659, '柳城县', 99);
INSERT INTO `iweb_areas` VALUES (666, 659, '鹿寨县', 99);
INSERT INTO `iweb_areas` VALUES (667, 659, '融安县', 99);
INSERT INTO `iweb_areas` VALUES (668, 659, '融水苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (669, 659, '三江侗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (670, 566, '钦州市', 99);
INSERT INTO `iweb_areas` VALUES (671, 670, '钦南区', 99);
INSERT INTO `iweb_areas` VALUES (672, 670, '钦北区', 99);
INSERT INTO `iweb_areas` VALUES (673, 670, '灵山县', 99);
INSERT INTO `iweb_areas` VALUES (674, 670, '浦北县', 99);
INSERT INTO `iweb_areas` VALUES (675, 566, '梧州市', 99);
INSERT INTO `iweb_areas` VALUES (676, 675, '万秀区', 99);
INSERT INTO `iweb_areas` VALUES (677, 675, '蝶山区', 99);
INSERT INTO `iweb_areas` VALUES (678, 675, '长洲区', 99);
INSERT INTO `iweb_areas` VALUES (679, 675, '苍梧县', 99);
INSERT INTO `iweb_areas` VALUES (680, 675, '藤县', 99);
INSERT INTO `iweb_areas` VALUES (681, 675, '蒙山县', 99);
INSERT INTO `iweb_areas` VALUES (682, 675, '岑溪市', 99);
INSERT INTO `iweb_areas` VALUES (683, 566, '玉林市', 99);
INSERT INTO `iweb_areas` VALUES (684, 683, '玉州区', 99);
INSERT INTO `iweb_areas` VALUES (685, 683, '容县', 99);
INSERT INTO `iweb_areas` VALUES (686, 683, '陆川县', 99);
INSERT INTO `iweb_areas` VALUES (687, 683, '博白县', 99);
INSERT INTO `iweb_areas` VALUES (688, 683, '兴业县', 99);
INSERT INTO `iweb_areas` VALUES (689, 683, '北流市', 99);
INSERT INTO `iweb_areas` VALUES (690, 0, '贵州', 99);
INSERT INTO `iweb_areas` VALUES (691, 690, '贵阳市', 99);
INSERT INTO `iweb_areas` VALUES (692, 691, '南明区', 99);
INSERT INTO `iweb_areas` VALUES (693, 691, '云岩区', 99);
INSERT INTO `iweb_areas` VALUES (694, 691, '花溪区', 99);
INSERT INTO `iweb_areas` VALUES (695, 691, '乌当区', 99);
INSERT INTO `iweb_areas` VALUES (696, 691, '白云区', 99);
INSERT INTO `iweb_areas` VALUES (697, 691, '小河区', 99);
INSERT INTO `iweb_areas` VALUES (698, 691, '开阳县', 99);
INSERT INTO `iweb_areas` VALUES (699, 691, '息烽县', 99);
INSERT INTO `iweb_areas` VALUES (700, 691, '修文县', 99);
INSERT INTO `iweb_areas` VALUES (701, 691, '清镇市', 99);
INSERT INTO `iweb_areas` VALUES (702, 690, '安顺市', 99);
INSERT INTO `iweb_areas` VALUES (703, 702, '西秀区', 99);
INSERT INTO `iweb_areas` VALUES (704, 702, '平坝县', 99);
INSERT INTO `iweb_areas` VALUES (705, 702, '普定县', 99);
INSERT INTO `iweb_areas` VALUES (706, 702, '镇宁布依族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (707, 702, '关岭布依族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (708, 702, '紫云苗族布依族自治县', 99);
INSERT INTO `iweb_areas` VALUES (709, 690, '毕节地区', 99);
INSERT INTO `iweb_areas` VALUES (710, 709, '毕节市', 99);
INSERT INTO `iweb_areas` VALUES (711, 709, '大方县', 99);
INSERT INTO `iweb_areas` VALUES (712, 709, '黔西县', 99);
INSERT INTO `iweb_areas` VALUES (713, 709, '金沙县', 99);
INSERT INTO `iweb_areas` VALUES (714, 709, '织金县', 99);
INSERT INTO `iweb_areas` VALUES (715, 709, '纳雍县', 99);
INSERT INTO `iweb_areas` VALUES (716, 709, '威宁彝族回族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (717, 709, '赫章县', 99);
INSERT INTO `iweb_areas` VALUES (718, 690, '六盘水市', 99);
INSERT INTO `iweb_areas` VALUES (719, 718, '钟山区', 99);
INSERT INTO `iweb_areas` VALUES (720, 718, '六枝特区', 99);
INSERT INTO `iweb_areas` VALUES (721, 718, '水城县', 99);
INSERT INTO `iweb_areas` VALUES (722, 718, '盘县', 99);
INSERT INTO `iweb_areas` VALUES (723, 690, '黔东南苗族侗族自治州', 99);
INSERT INTO `iweb_areas` VALUES (724, 723, '凯里市', 99);
INSERT INTO `iweb_areas` VALUES (725, 723, '黄平县', 99);
INSERT INTO `iweb_areas` VALUES (726, 723, '施秉县', 99);
INSERT INTO `iweb_areas` VALUES (727, 723, '三穗县', 99);
INSERT INTO `iweb_areas` VALUES (728, 723, '镇远县', 99);
INSERT INTO `iweb_areas` VALUES (729, 723, '岑巩县', 99);
INSERT INTO `iweb_areas` VALUES (730, 723, '天柱县', 99);
INSERT INTO `iweb_areas` VALUES (731, 723, '锦屏县', 99);
INSERT INTO `iweb_areas` VALUES (732, 723, '剑河县', 99);
INSERT INTO `iweb_areas` VALUES (733, 723, '台江县', 99);
INSERT INTO `iweb_areas` VALUES (734, 723, '黎平县', 99);
INSERT INTO `iweb_areas` VALUES (735, 723, '榕江县', 99);
INSERT INTO `iweb_areas` VALUES (736, 723, '从江县', 99);
INSERT INTO `iweb_areas` VALUES (737, 723, '雷山县', 99);
INSERT INTO `iweb_areas` VALUES (738, 723, '麻江县', 99);
INSERT INTO `iweb_areas` VALUES (739, 723, '丹寨县', 99);
INSERT INTO `iweb_areas` VALUES (740, 690, '黔南布依族苗族自治州', 99);
INSERT INTO `iweb_areas` VALUES (741, 740, '都匀市', 99);
INSERT INTO `iweb_areas` VALUES (742, 740, '福泉市', 99);
INSERT INTO `iweb_areas` VALUES (743, 740, '荔波县', 99);
INSERT INTO `iweb_areas` VALUES (744, 740, '贵定县', 99);
INSERT INTO `iweb_areas` VALUES (745, 740, '瓮安县', 99);
INSERT INTO `iweb_areas` VALUES (746, 740, '独山县', 99);
INSERT INTO `iweb_areas` VALUES (747, 740, '平塘县', 99);
INSERT INTO `iweb_areas` VALUES (748, 740, '罗甸县', 99);
INSERT INTO `iweb_areas` VALUES (749, 740, '长顺县', 99);
INSERT INTO `iweb_areas` VALUES (750, 740, '龙里县', 99);
INSERT INTO `iweb_areas` VALUES (751, 740, '惠水县', 99);
INSERT INTO `iweb_areas` VALUES (752, 740, '三都水族自治县', 99);
INSERT INTO `iweb_areas` VALUES (753, 690, '黔西南布依族苗族自治州', 99);
INSERT INTO `iweb_areas` VALUES (754, 753, '兴义市', 99);
INSERT INTO `iweb_areas` VALUES (755, 753, '兴仁县', 99);
INSERT INTO `iweb_areas` VALUES (756, 753, '普安县', 99);
INSERT INTO `iweb_areas` VALUES (757, 753, '晴隆县', 99);
INSERT INTO `iweb_areas` VALUES (758, 753, '贞丰县', 99);
INSERT INTO `iweb_areas` VALUES (759, 753, '望谟县', 99);
INSERT INTO `iweb_areas` VALUES (760, 753, '册亨县', 99);
INSERT INTO `iweb_areas` VALUES (761, 753, '安龙县', 99);
INSERT INTO `iweb_areas` VALUES (762, 690, '铜仁地区', 99);
INSERT INTO `iweb_areas` VALUES (763, 762, '铜仁市', 99);
INSERT INTO `iweb_areas` VALUES (764, 762, '江口县', 99);
INSERT INTO `iweb_areas` VALUES (765, 762, '玉屏侗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (766, 762, '石阡县', 99);
INSERT INTO `iweb_areas` VALUES (767, 762, '思南县', 99);
INSERT INTO `iweb_areas` VALUES (768, 762, '印江土家族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (769, 762, '德江县', 99);
INSERT INTO `iweb_areas` VALUES (770, 762, '沿河土家族自治县', 99);
INSERT INTO `iweb_areas` VALUES (771, 762, '松桃苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (772, 762, '万山特区', 99);
INSERT INTO `iweb_areas` VALUES (773, 690, '遵义市', 99);
INSERT INTO `iweb_areas` VALUES (774, 773, '红花岗区', 99);
INSERT INTO `iweb_areas` VALUES (775, 773, '汇川区', 99);
INSERT INTO `iweb_areas` VALUES (776, 773, '遵义县', 99);
INSERT INTO `iweb_areas` VALUES (777, 773, '桐梓县', 99);
INSERT INTO `iweb_areas` VALUES (778, 773, '绥阳县', 99);
INSERT INTO `iweb_areas` VALUES (779, 773, '正安县', 99);
INSERT INTO `iweb_areas` VALUES (780, 773, '道真仡佬族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (781, 773, '务川仡佬族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (782, 773, '凤冈县', 99);
INSERT INTO `iweb_areas` VALUES (783, 773, '湄潭县', 99);
INSERT INTO `iweb_areas` VALUES (784, 773, '余庆县', 99);
INSERT INTO `iweb_areas` VALUES (785, 773, '习水县', 99);
INSERT INTO `iweb_areas` VALUES (786, 773, '赤水市', 99);
INSERT INTO `iweb_areas` VALUES (787, 773, '仁怀市', 99);
INSERT INTO `iweb_areas` VALUES (788, 0, '海南', 99);
INSERT INTO `iweb_areas` VALUES (789, 788, '海口市', 99);
INSERT INTO `iweb_areas` VALUES (790, 789, '秀英区', 99);
INSERT INTO `iweb_areas` VALUES (791, 789, '龙华区', 99);
INSERT INTO `iweb_areas` VALUES (792, 789, '琼山区', 99);
INSERT INTO `iweb_areas` VALUES (793, 789, '美兰区', 99);
INSERT INTO `iweb_areas` VALUES (794, 788, '白沙黎族自治县', 99);
INSERT INTO `iweb_areas` VALUES (795, 788, '保亭黎族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (796, 788, '昌江黎族自治县', 99);
INSERT INTO `iweb_areas` VALUES (797, 788, '澄迈县', 99);
INSERT INTO `iweb_areas` VALUES (798, 788, '儋州市', 99);
INSERT INTO `iweb_areas` VALUES (799, 788, '定安县', 99);
INSERT INTO `iweb_areas` VALUES (800, 788, '东方市', 99);
INSERT INTO `iweb_areas` VALUES (801, 788, '乐东黎族自治县', 99);
INSERT INTO `iweb_areas` VALUES (802, 788, '临高县', 99);
INSERT INTO `iweb_areas` VALUES (803, 788, '陵水黎族自治县', 99);
INSERT INTO `iweb_areas` VALUES (804, 788, '南沙群岛', 99);
INSERT INTO `iweb_areas` VALUES (805, 788, '琼海市', 99);
INSERT INTO `iweb_areas` VALUES (806, 788, '琼中黎族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (807, 788, '三亚市', 99);
INSERT INTO `iweb_areas` VALUES (808, 788, '屯昌县', 99);
INSERT INTO `iweb_areas` VALUES (809, 788, '万宁市', 99);
INSERT INTO `iweb_areas` VALUES (810, 788, '文昌市', 99);
INSERT INTO `iweb_areas` VALUES (811, 788, '五指山市', 99);
INSERT INTO `iweb_areas` VALUES (812, 788, '西沙群岛', 99);
INSERT INTO `iweb_areas` VALUES (813, 788, '中沙群岛的岛礁及其海域', 99);
INSERT INTO `iweb_areas` VALUES (814, 0, '河北', 99);
INSERT INTO `iweb_areas` VALUES (815, 814, '石家庄市', 99);
INSERT INTO `iweb_areas` VALUES (816, 815, '长安区', 99);
INSERT INTO `iweb_areas` VALUES (817, 815, '桥东区', 99);
INSERT INTO `iweb_areas` VALUES (818, 815, '桥西区', 99);
INSERT INTO `iweb_areas` VALUES (819, 815, '新华区', 99);
INSERT INTO `iweb_areas` VALUES (820, 815, '井陉矿区', 99);
INSERT INTO `iweb_areas` VALUES (821, 815, '裕华区', 99);
INSERT INTO `iweb_areas` VALUES (822, 815, '井陉县', 99);
INSERT INTO `iweb_areas` VALUES (823, 815, '正定县', 99);
INSERT INTO `iweb_areas` VALUES (824, 815, '栾城县', 99);
INSERT INTO `iweb_areas` VALUES (825, 815, '行唐县', 99);
INSERT INTO `iweb_areas` VALUES (826, 815, '灵寿县', 99);
INSERT INTO `iweb_areas` VALUES (827, 815, '高邑县', 99);
INSERT INTO `iweb_areas` VALUES (828, 815, '深泽县', 99);
INSERT INTO `iweb_areas` VALUES (829, 815, '赞皇县', 99);
INSERT INTO `iweb_areas` VALUES (830, 815, '无极县', 99);
INSERT INTO `iweb_areas` VALUES (831, 815, '平山县', 99);
INSERT INTO `iweb_areas` VALUES (832, 815, '元氏县', 99);
INSERT INTO `iweb_areas` VALUES (833, 815, '赵县', 99);
INSERT INTO `iweb_areas` VALUES (834, 815, '辛集市', 99);
INSERT INTO `iweb_areas` VALUES (835, 815, '藁城市', 99);
INSERT INTO `iweb_areas` VALUES (836, 815, '晋州市', 99);
INSERT INTO `iweb_areas` VALUES (837, 815, '新乐市', 99);
INSERT INTO `iweb_areas` VALUES (838, 815, '鹿泉市', 99);
INSERT INTO `iweb_areas` VALUES (839, 814, '保定市', 99);
INSERT INTO `iweb_areas` VALUES (840, 839, '新市区', 99);
INSERT INTO `iweb_areas` VALUES (841, 839, '北市区', 99);
INSERT INTO `iweb_areas` VALUES (842, 839, '南市区', 99);
INSERT INTO `iweb_areas` VALUES (843, 839, '满城县', 99);
INSERT INTO `iweb_areas` VALUES (844, 839, '清苑县', 99);
INSERT INTO `iweb_areas` VALUES (845, 839, '涞水县', 99);
INSERT INTO `iweb_areas` VALUES (846, 839, '阜平县', 99);
INSERT INTO `iweb_areas` VALUES (847, 839, '徐水县', 99);
INSERT INTO `iweb_areas` VALUES (848, 839, '定兴县', 99);
INSERT INTO `iweb_areas` VALUES (849, 839, '唐县', 99);
INSERT INTO `iweb_areas` VALUES (850, 839, '高阳县', 99);
INSERT INTO `iweb_areas` VALUES (851, 839, '容城县', 99);
INSERT INTO `iweb_areas` VALUES (852, 839, '涞源县', 99);
INSERT INTO `iweb_areas` VALUES (853, 839, '望都县', 99);
INSERT INTO `iweb_areas` VALUES (854, 839, '安新县', 99);
INSERT INTO `iweb_areas` VALUES (855, 839, '易县', 99);
INSERT INTO `iweb_areas` VALUES (856, 839, '曲阳县', 99);
INSERT INTO `iweb_areas` VALUES (857, 839, '蠡县', 99);
INSERT INTO `iweb_areas` VALUES (858, 839, '顺平县', 99);
INSERT INTO `iweb_areas` VALUES (859, 839, '博野县', 99);
INSERT INTO `iweb_areas` VALUES (860, 839, '雄县', 99);
INSERT INTO `iweb_areas` VALUES (861, 839, '涿州市', 99);
INSERT INTO `iweb_areas` VALUES (862, 839, '定州市', 99);
INSERT INTO `iweb_areas` VALUES (863, 839, '安国市', 99);
INSERT INTO `iweb_areas` VALUES (864, 839, '高碑店市', 99);
INSERT INTO `iweb_areas` VALUES (865, 814, '沧州市', 99);
INSERT INTO `iweb_areas` VALUES (866, 865, '新华区', 99);
INSERT INTO `iweb_areas` VALUES (867, 865, '运河区', 99);
INSERT INTO `iweb_areas` VALUES (868, 865, '沧县', 99);
INSERT INTO `iweb_areas` VALUES (869, 865, '青县', 99);
INSERT INTO `iweb_areas` VALUES (870, 865, '东光县', 99);
INSERT INTO `iweb_areas` VALUES (871, 865, '海兴县', 99);
INSERT INTO `iweb_areas` VALUES (872, 865, '盐山县', 99);
INSERT INTO `iweb_areas` VALUES (873, 865, '肃宁县', 99);
INSERT INTO `iweb_areas` VALUES (874, 865, '南皮县', 99);
INSERT INTO `iweb_areas` VALUES (875, 865, '吴桥县', 99);
INSERT INTO `iweb_areas` VALUES (876, 865, '献县', 99);
INSERT INTO `iweb_areas` VALUES (877, 865, '孟村回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (878, 865, '泊头市', 99);
INSERT INTO `iweb_areas` VALUES (879, 865, '任丘市', 99);
INSERT INTO `iweb_areas` VALUES (880, 865, '黄骅市', 99);
INSERT INTO `iweb_areas` VALUES (881, 865, '河间市', 99);
INSERT INTO `iweb_areas` VALUES (882, 814, '承德市', 99);
INSERT INTO `iweb_areas` VALUES (883, 882, '双桥区', 99);
INSERT INTO `iweb_areas` VALUES (884, 882, '双滦区', 99);
INSERT INTO `iweb_areas` VALUES (885, 882, '鹰手营子矿区', 99);
INSERT INTO `iweb_areas` VALUES (886, 882, '承德县', 99);
INSERT INTO `iweb_areas` VALUES (887, 882, '兴隆县', 99);
INSERT INTO `iweb_areas` VALUES (888, 882, '平泉县', 99);
INSERT INTO `iweb_areas` VALUES (889, 882, '滦平县', 99);
INSERT INTO `iweb_areas` VALUES (890, 882, '隆化县', 99);
INSERT INTO `iweb_areas` VALUES (891, 882, '丰宁满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (892, 882, '宽城满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (893, 882, '围场满族蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (894, 814, '邯郸市', 99);
INSERT INTO `iweb_areas` VALUES (895, 894, '邯山区', 99);
INSERT INTO `iweb_areas` VALUES (896, 894, '丛台区', 99);
INSERT INTO `iweb_areas` VALUES (897, 894, '复兴区', 99);
INSERT INTO `iweb_areas` VALUES (898, 894, '峰峰矿区', 99);
INSERT INTO `iweb_areas` VALUES (899, 894, '邯郸县', 99);
INSERT INTO `iweb_areas` VALUES (900, 894, '临漳县', 99);
INSERT INTO `iweb_areas` VALUES (901, 894, '成安县', 99);
INSERT INTO `iweb_areas` VALUES (902, 894, '大名县', 99);
INSERT INTO `iweb_areas` VALUES (903, 894, '涉县', 99);
INSERT INTO `iweb_areas` VALUES (904, 894, '磁县', 99);
INSERT INTO `iweb_areas` VALUES (905, 894, '肥乡县', 99);
INSERT INTO `iweb_areas` VALUES (906, 894, '永年县', 99);
INSERT INTO `iweb_areas` VALUES (907, 894, '邱县', 99);
INSERT INTO `iweb_areas` VALUES (908, 894, '鸡泽县', 99);
INSERT INTO `iweb_areas` VALUES (909, 894, '广平县', 99);
INSERT INTO `iweb_areas` VALUES (910, 894, '馆陶县', 99);
INSERT INTO `iweb_areas` VALUES (911, 894, '魏县', 99);
INSERT INTO `iweb_areas` VALUES (912, 894, '曲周县', 99);
INSERT INTO `iweb_areas` VALUES (913, 894, '武安市', 99);
INSERT INTO `iweb_areas` VALUES (914, 814, '衡水市', 99);
INSERT INTO `iweb_areas` VALUES (915, 914, '桃城区', 99);
INSERT INTO `iweb_areas` VALUES (916, 914, '枣强县', 99);
INSERT INTO `iweb_areas` VALUES (917, 914, '武邑县', 99);
INSERT INTO `iweb_areas` VALUES (918, 914, '武强县', 99);
INSERT INTO `iweb_areas` VALUES (919, 914, '饶阳县', 99);
INSERT INTO `iweb_areas` VALUES (920, 914, '安平县', 99);
INSERT INTO `iweb_areas` VALUES (921, 914, '故城县', 99);
INSERT INTO `iweb_areas` VALUES (922, 914, '景县', 99);
INSERT INTO `iweb_areas` VALUES (923, 914, '阜城县', 99);
INSERT INTO `iweb_areas` VALUES (924, 914, '冀州市', 99);
INSERT INTO `iweb_areas` VALUES (925, 914, '深州市', 99);
INSERT INTO `iweb_areas` VALUES (926, 814, '廊坊市', 99);
INSERT INTO `iweb_areas` VALUES (927, 926, '安次区', 99);
INSERT INTO `iweb_areas` VALUES (928, 926, '广阳区', 99);
INSERT INTO `iweb_areas` VALUES (929, 926, '固安县', 99);
INSERT INTO `iweb_areas` VALUES (930, 926, '永清县', 99);
INSERT INTO `iweb_areas` VALUES (931, 926, '香河县', 99);
INSERT INTO `iweb_areas` VALUES (932, 926, '大城县', 99);
INSERT INTO `iweb_areas` VALUES (933, 926, '文安县', 99);
INSERT INTO `iweb_areas` VALUES (934, 926, '大厂回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (935, 926, '霸州市', 99);
INSERT INTO `iweb_areas` VALUES (936, 926, '三河市', 99);
INSERT INTO `iweb_areas` VALUES (937, 814, '秦皇岛市', 99);
INSERT INTO `iweb_areas` VALUES (938, 937, '海港区', 99);
INSERT INTO `iweb_areas` VALUES (939, 937, '山海关区', 99);
INSERT INTO `iweb_areas` VALUES (940, 937, '北戴河区', 99);
INSERT INTO `iweb_areas` VALUES (941, 937, '青龙满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (942, 937, '昌黎县', 99);
INSERT INTO `iweb_areas` VALUES (943, 937, '抚宁县', 99);
INSERT INTO `iweb_areas` VALUES (944, 937, '卢龙县', 99);
INSERT INTO `iweb_areas` VALUES (945, 814, '唐山市', 99);
INSERT INTO `iweb_areas` VALUES (946, 945, '路南区', 99);
INSERT INTO `iweb_areas` VALUES (947, 945, '路北区', 99);
INSERT INTO `iweb_areas` VALUES (948, 945, '古冶区', 99);
INSERT INTO `iweb_areas` VALUES (949, 945, '开平区', 99);
INSERT INTO `iweb_areas` VALUES (950, 945, '丰南区', 99);
INSERT INTO `iweb_areas` VALUES (951, 945, '丰润区', 99);
INSERT INTO `iweb_areas` VALUES (952, 945, '滦县', 99);
INSERT INTO `iweb_areas` VALUES (953, 945, '滦南县', 99);
INSERT INTO `iweb_areas` VALUES (954, 945, '乐亭县', 99);
INSERT INTO `iweb_areas` VALUES (955, 945, '迁西县', 99);
INSERT INTO `iweb_areas` VALUES (956, 945, '玉田县', 99);
INSERT INTO `iweb_areas` VALUES (957, 945, '唐海县', 99);
INSERT INTO `iweb_areas` VALUES (958, 945, '遵化市', 99);
INSERT INTO `iweb_areas` VALUES (959, 945, '迁安市', 99);
INSERT INTO `iweb_areas` VALUES (960, 814, '邢台市', 99);
INSERT INTO `iweb_areas` VALUES (961, 960, '桥东区', 99);
INSERT INTO `iweb_areas` VALUES (962, 960, '桥西区', 99);
INSERT INTO `iweb_areas` VALUES (963, 960, '邢台县', 99);
INSERT INTO `iweb_areas` VALUES (964, 960, '临城县', 99);
INSERT INTO `iweb_areas` VALUES (965, 960, '内丘县', 99);
INSERT INTO `iweb_areas` VALUES (966, 960, '柏乡县', 99);
INSERT INTO `iweb_areas` VALUES (967, 960, '隆尧县', 99);
INSERT INTO `iweb_areas` VALUES (968, 960, '任县', 99);
INSERT INTO `iweb_areas` VALUES (969, 960, '南和县', 99);
INSERT INTO `iweb_areas` VALUES (970, 960, '宁晋县', 99);
INSERT INTO `iweb_areas` VALUES (971, 960, '巨鹿县', 99);
INSERT INTO `iweb_areas` VALUES (972, 960, '新河县', 99);
INSERT INTO `iweb_areas` VALUES (973, 960, '广宗县', 99);
INSERT INTO `iweb_areas` VALUES (974, 960, '平乡县', 99);
INSERT INTO `iweb_areas` VALUES (975, 960, '威县', 99);
INSERT INTO `iweb_areas` VALUES (976, 960, '清河县', 99);
INSERT INTO `iweb_areas` VALUES (977, 960, '临西县', 99);
INSERT INTO `iweb_areas` VALUES (978, 960, '南宫市', 99);
INSERT INTO `iweb_areas` VALUES (979, 960, '沙河市', 99);
INSERT INTO `iweb_areas` VALUES (980, 814, '张家口市', 99);
INSERT INTO `iweb_areas` VALUES (981, 980, '桥东区', 99);
INSERT INTO `iweb_areas` VALUES (982, 980, '桥西区', 99);
INSERT INTO `iweb_areas` VALUES (983, 980, '宣化区', 99);
INSERT INTO `iweb_areas` VALUES (984, 980, '下花园区', 99);
INSERT INTO `iweb_areas` VALUES (985, 980, '宣化县', 99);
INSERT INTO `iweb_areas` VALUES (986, 980, '张北县', 99);
INSERT INTO `iweb_areas` VALUES (987, 980, '康保县', 99);
INSERT INTO `iweb_areas` VALUES (988, 980, '沽源县', 99);
INSERT INTO `iweb_areas` VALUES (989, 980, '尚义县', 99);
INSERT INTO `iweb_areas` VALUES (990, 980, '蔚县', 99);
INSERT INTO `iweb_areas` VALUES (991, 980, '阳原县', 99);
INSERT INTO `iweb_areas` VALUES (992, 980, '怀安县', 99);
INSERT INTO `iweb_areas` VALUES (993, 980, '万全县', 99);
INSERT INTO `iweb_areas` VALUES (994, 980, '怀来县', 99);
INSERT INTO `iweb_areas` VALUES (995, 980, '涿鹿县', 99);
INSERT INTO `iweb_areas` VALUES (996, 980, '赤城县', 99);
INSERT INTO `iweb_areas` VALUES (997, 980, '崇礼县', 99);
INSERT INTO `iweb_areas` VALUES (998, 0, '河南', 99);
INSERT INTO `iweb_areas` VALUES (999, 998, '郑州市', 99);
INSERT INTO `iweb_areas` VALUES (1000, 999, '中原区', 99);
INSERT INTO `iweb_areas` VALUES (1001, 999, '二七区', 99);
INSERT INTO `iweb_areas` VALUES (1002, 999, '管城回族区', 99);
INSERT INTO `iweb_areas` VALUES (1003, 999, '金水区', 99);
INSERT INTO `iweb_areas` VALUES (1004, 999, '上街区', 99);
INSERT INTO `iweb_areas` VALUES (1005, 999, '邙山区', 99);
INSERT INTO `iweb_areas` VALUES (1006, 999, '中牟县', 99);
INSERT INTO `iweb_areas` VALUES (1007, 999, '巩义市', 99);
INSERT INTO `iweb_areas` VALUES (1008, 999, '荥阳市', 99);
INSERT INTO `iweb_areas` VALUES (1009, 999, '新密市', 99);
INSERT INTO `iweb_areas` VALUES (1010, 999, '新郑市', 99);
INSERT INTO `iweb_areas` VALUES (1011, 999, '登封市', 99);
INSERT INTO `iweb_areas` VALUES (1012, 998, '安阳市', 99);
INSERT INTO `iweb_areas` VALUES (1013, 1012, '文峰区', 99);
INSERT INTO `iweb_areas` VALUES (1014, 1012, '北关区', 99);
INSERT INTO `iweb_areas` VALUES (1015, 1012, '殷都区', 99);
INSERT INTO `iweb_areas` VALUES (1016, 1012, '龙安区', 99);
INSERT INTO `iweb_areas` VALUES (1017, 1012, '安阳县', 99);
INSERT INTO `iweb_areas` VALUES (1018, 1012, '汤阴县', 99);
INSERT INTO `iweb_areas` VALUES (1019, 1012, '滑县', 99);
INSERT INTO `iweb_areas` VALUES (1020, 1012, '内黄县', 99);
INSERT INTO `iweb_areas` VALUES (1021, 1012, '林州市', 99);
INSERT INTO `iweb_areas` VALUES (1022, 998, '鹤壁市', 99);
INSERT INTO `iweb_areas` VALUES (1023, 1022, '鹤山区', 99);
INSERT INTO `iweb_areas` VALUES (1024, 1022, '山城区', 99);
INSERT INTO `iweb_areas` VALUES (1025, 1022, '淇滨区', 99);
INSERT INTO `iweb_areas` VALUES (1026, 1022, '浚县', 99);
INSERT INTO `iweb_areas` VALUES (1027, 1022, '淇县', 99);
INSERT INTO `iweb_areas` VALUES (1028, 998, '济源市', 99);
INSERT INTO `iweb_areas` VALUES (1029, 998, '焦作市', 99);
INSERT INTO `iweb_areas` VALUES (1030, 1029, '解放区', 99);
INSERT INTO `iweb_areas` VALUES (1031, 1029, '中站区', 99);
INSERT INTO `iweb_areas` VALUES (1032, 1029, '马村区', 99);
INSERT INTO `iweb_areas` VALUES (1033, 1029, '山阳区', 99);
INSERT INTO `iweb_areas` VALUES (1034, 1029, '修武县', 99);
INSERT INTO `iweb_areas` VALUES (1035, 1029, '博爱县', 99);
INSERT INTO `iweb_areas` VALUES (1036, 1029, '武陟县', 99);
INSERT INTO `iweb_areas` VALUES (1037, 1029, '温县', 99);
INSERT INTO `iweb_areas` VALUES (1038, 1029, '济源市', 99);
INSERT INTO `iweb_areas` VALUES (1039, 1029, '沁阳市', 99);
INSERT INTO `iweb_areas` VALUES (1040, 1029, '孟州市', 99);
INSERT INTO `iweb_areas` VALUES (1041, 998, '开封市', 99);
INSERT INTO `iweb_areas` VALUES (1042, 1041, '龙亭区', 99);
INSERT INTO `iweb_areas` VALUES (1043, 1041, '顺河回族区', 99);
INSERT INTO `iweb_areas` VALUES (1044, 1041, '鼓楼区', 99);
INSERT INTO `iweb_areas` VALUES (1045, 1041, '南关区', 99);
INSERT INTO `iweb_areas` VALUES (1046, 1041, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (1047, 1041, '杞县', 99);
INSERT INTO `iweb_areas` VALUES (1048, 1041, '通许县', 99);
INSERT INTO `iweb_areas` VALUES (1049, 1041, '尉氏县', 99);
INSERT INTO `iweb_areas` VALUES (1050, 1041, '开封县', 99);
INSERT INTO `iweb_areas` VALUES (1051, 1041, '兰考县', 99);
INSERT INTO `iweb_areas` VALUES (1052, 998, '洛阳市', 99);
INSERT INTO `iweb_areas` VALUES (1053, 1052, '老城区', 99);
INSERT INTO `iweb_areas` VALUES (1054, 1052, '西工区', 99);
INSERT INTO `iweb_areas` VALUES (1055, 1052, '廛河回族区', 99);
INSERT INTO `iweb_areas` VALUES (1056, 1052, '涧西区', 99);
INSERT INTO `iweb_areas` VALUES (1057, 1052, '吉利区', 99);
INSERT INTO `iweb_areas` VALUES (1058, 1052, '洛龙区', 99);
INSERT INTO `iweb_areas` VALUES (1059, 1052, '孟津县', 99);
INSERT INTO `iweb_areas` VALUES (1060, 1052, '新安县', 99);
INSERT INTO `iweb_areas` VALUES (1061, 1052, '栾川县', 99);
INSERT INTO `iweb_areas` VALUES (1062, 1052, '嵩县', 99);
INSERT INTO `iweb_areas` VALUES (1063, 1052, '汝阳县', 99);
INSERT INTO `iweb_areas` VALUES (1064, 1052, '宜阳县', 99);
INSERT INTO `iweb_areas` VALUES (1065, 1052, '洛宁县', 99);
INSERT INTO `iweb_areas` VALUES (1066, 1052, '伊川县', 99);
INSERT INTO `iweb_areas` VALUES (1067, 1052, '偃师市', 99);
INSERT INTO `iweb_areas` VALUES (1068, 998, '漯河市', 99);
INSERT INTO `iweb_areas` VALUES (1069, 1068, '源汇区', 99);
INSERT INTO `iweb_areas` VALUES (1070, 1068, '郾城区', 99);
INSERT INTO `iweb_areas` VALUES (1071, 1068, '召陵区', 99);
INSERT INTO `iweb_areas` VALUES (1072, 1068, '舞阳县', 99);
INSERT INTO `iweb_areas` VALUES (1073, 1068, '临颍县', 99);
INSERT INTO `iweb_areas` VALUES (1074, 998, '南阳市', 99);
INSERT INTO `iweb_areas` VALUES (1075, 1074, '宛城区', 99);
INSERT INTO `iweb_areas` VALUES (1076, 1074, '卧龙区', 99);
INSERT INTO `iweb_areas` VALUES (1077, 1074, '南召县', 99);
INSERT INTO `iweb_areas` VALUES (1078, 1074, '方城县', 99);
INSERT INTO `iweb_areas` VALUES (1079, 1074, '西峡县', 99);
INSERT INTO `iweb_areas` VALUES (1080, 1074, '镇平县', 99);
INSERT INTO `iweb_areas` VALUES (1081, 1074, '内乡县', 99);
INSERT INTO `iweb_areas` VALUES (1082, 1074, '淅川县', 99);
INSERT INTO `iweb_areas` VALUES (1083, 1074, '社旗县', 99);
INSERT INTO `iweb_areas` VALUES (1084, 1074, '唐河县', 99);
INSERT INTO `iweb_areas` VALUES (1085, 1074, '新野县', 99);
INSERT INTO `iweb_areas` VALUES (1086, 1074, '桐柏县', 99);
INSERT INTO `iweb_areas` VALUES (1087, 1074, '邓州市', 99);
INSERT INTO `iweb_areas` VALUES (1088, 998, '平顶山市', 99);
INSERT INTO `iweb_areas` VALUES (1089, 1088, '新华区', 99);
INSERT INTO `iweb_areas` VALUES (1090, 1088, '卫东区', 99);
INSERT INTO `iweb_areas` VALUES (1091, 1088, '石龙区', 99);
INSERT INTO `iweb_areas` VALUES (1092, 1088, '湛河区', 99);
INSERT INTO `iweb_areas` VALUES (1093, 1088, '宝丰县', 99);
INSERT INTO `iweb_areas` VALUES (1094, 1088, '叶县', 99);
INSERT INTO `iweb_areas` VALUES (1095, 1088, '鲁山县', 99);
INSERT INTO `iweb_areas` VALUES (1096, 1088, '郏县', 99);
INSERT INTO `iweb_areas` VALUES (1097, 1088, '舞钢市', 99);
INSERT INTO `iweb_areas` VALUES (1098, 1088, '汝州市', 99);
INSERT INTO `iweb_areas` VALUES (1099, 998, '濮阳市', 99);
INSERT INTO `iweb_areas` VALUES (1100, 1099, '华龙区', 99);
INSERT INTO `iweb_areas` VALUES (1101, 1099, '清丰县', 99);
INSERT INTO `iweb_areas` VALUES (1102, 1099, '南乐县', 99);
INSERT INTO `iweb_areas` VALUES (1103, 1099, '范县', 99);
INSERT INTO `iweb_areas` VALUES (1104, 1099, '台前县', 99);
INSERT INTO `iweb_areas` VALUES (1105, 1099, '濮阳县', 99);
INSERT INTO `iweb_areas` VALUES (1106, 998, '三门峡市', 99);
INSERT INTO `iweb_areas` VALUES (1107, 1106, '湖滨区', 99);
INSERT INTO `iweb_areas` VALUES (1108, 1106, '渑池县', 99);
INSERT INTO `iweb_areas` VALUES (1109, 1106, '陕县', 99);
INSERT INTO `iweb_areas` VALUES (1110, 1106, '卢氏县', 99);
INSERT INTO `iweb_areas` VALUES (1111, 1106, '义马市', 99);
INSERT INTO `iweb_areas` VALUES (1112, 1106, '灵宝市', 99);
INSERT INTO `iweb_areas` VALUES (1113, 998, '商丘市', 99);
INSERT INTO `iweb_areas` VALUES (1114, 1113, '梁园区', 99);
INSERT INTO `iweb_areas` VALUES (1115, 1113, '睢阳区', 99);
INSERT INTO `iweb_areas` VALUES (1116, 1113, '民权县', 99);
INSERT INTO `iweb_areas` VALUES (1117, 1113, '睢县', 99);
INSERT INTO `iweb_areas` VALUES (1118, 1113, '宁陵县', 99);
INSERT INTO `iweb_areas` VALUES (1119, 1113, '柘城县', 99);
INSERT INTO `iweb_areas` VALUES (1120, 1113, '虞城县', 99);
INSERT INTO `iweb_areas` VALUES (1121, 1113, '夏邑县', 99);
INSERT INTO `iweb_areas` VALUES (1122, 1113, '永城市', 99);
INSERT INTO `iweb_areas` VALUES (1123, 998, '新乡市', 99);
INSERT INTO `iweb_areas` VALUES (1124, 1123, '红旗区', 99);
INSERT INTO `iweb_areas` VALUES (1125, 1123, '卫滨区', 99);
INSERT INTO `iweb_areas` VALUES (1126, 1123, '凤泉区', 99);
INSERT INTO `iweb_areas` VALUES (1127, 1123, '牧野区', 99);
INSERT INTO `iweb_areas` VALUES (1128, 1123, '新乡县', 99);
INSERT INTO `iweb_areas` VALUES (1129, 1123, '获嘉县', 99);
INSERT INTO `iweb_areas` VALUES (1130, 1123, '原阳县', 99);
INSERT INTO `iweb_areas` VALUES (1131, 1123, '延津县', 99);
INSERT INTO `iweb_areas` VALUES (1132, 1123, '封丘县', 99);
INSERT INTO `iweb_areas` VALUES (1133, 1123, '长垣县', 99);
INSERT INTO `iweb_areas` VALUES (1134, 1123, '卫辉市', 99);
INSERT INTO `iweb_areas` VALUES (1135, 1123, '辉县市', 99);
INSERT INTO `iweb_areas` VALUES (1136, 998, '信阳市', 99);
INSERT INTO `iweb_areas` VALUES (1137, 1136, '师河区', 99);
INSERT INTO `iweb_areas` VALUES (1138, 1136, '平桥区', 99);
INSERT INTO `iweb_areas` VALUES (1139, 1136, '罗山县', 99);
INSERT INTO `iweb_areas` VALUES (1140, 1136, '光山县', 99);
INSERT INTO `iweb_areas` VALUES (1141, 1136, '新县', 99);
INSERT INTO `iweb_areas` VALUES (1142, 1136, '商城县', 99);
INSERT INTO `iweb_areas` VALUES (1143, 1136, '固始县', 99);
INSERT INTO `iweb_areas` VALUES (1144, 1136, '潢川县', 99);
INSERT INTO `iweb_areas` VALUES (1145, 1136, '淮滨县', 99);
INSERT INTO `iweb_areas` VALUES (1146, 1136, '息县', 99);
INSERT INTO `iweb_areas` VALUES (1147, 998, '许昌市', 99);
INSERT INTO `iweb_areas` VALUES (1148, 1147, '魏都区', 99);
INSERT INTO `iweb_areas` VALUES (1149, 1147, '许昌县', 99);
INSERT INTO `iweb_areas` VALUES (1150, 1147, '鄢陵县', 99);
INSERT INTO `iweb_areas` VALUES (1151, 1147, '襄城县', 99);
INSERT INTO `iweb_areas` VALUES (1152, 1147, '禹州市', 99);
INSERT INTO `iweb_areas` VALUES (1153, 1147, '长葛市', 99);
INSERT INTO `iweb_areas` VALUES (1154, 998, '周口市', 99);
INSERT INTO `iweb_areas` VALUES (1155, 1154, '川汇区', 99);
INSERT INTO `iweb_areas` VALUES (1156, 1154, '扶沟县', 99);
INSERT INTO `iweb_areas` VALUES (1157, 1154, '西华县', 99);
INSERT INTO `iweb_areas` VALUES (1158, 1154, '商水县', 99);
INSERT INTO `iweb_areas` VALUES (1159, 1154, '沈丘县', 99);
INSERT INTO `iweb_areas` VALUES (1160, 1154, '郸城县', 99);
INSERT INTO `iweb_areas` VALUES (1161, 1154, '淮阳县', 99);
INSERT INTO `iweb_areas` VALUES (1162, 1154, '太康县', 99);
INSERT INTO `iweb_areas` VALUES (1163, 1154, '鹿邑县', 99);
INSERT INTO `iweb_areas` VALUES (1164, 1154, '项城市', 99);
INSERT INTO `iweb_areas` VALUES (1165, 998, '驻马店市', 99);
INSERT INTO `iweb_areas` VALUES (1166, 1165, '驿城区', 99);
INSERT INTO `iweb_areas` VALUES (1167, 1165, '西平县', 99);
INSERT INTO `iweb_areas` VALUES (1168, 1165, '上蔡县', 99);
INSERT INTO `iweb_areas` VALUES (1169, 1165, '平舆县', 99);
INSERT INTO `iweb_areas` VALUES (1170, 1165, '正阳县', 99);
INSERT INTO `iweb_areas` VALUES (1171, 1165, '确山县', 99);
INSERT INTO `iweb_areas` VALUES (1172, 1165, '泌阳县', 99);
INSERT INTO `iweb_areas` VALUES (1173, 1165, '汝南县', 99);
INSERT INTO `iweb_areas` VALUES (1174, 1165, '遂平县', 99);
INSERT INTO `iweb_areas` VALUES (1175, 1165, '新蔡县', 99);
INSERT INTO `iweb_areas` VALUES (1176, 0, '黑龙江', 99);
INSERT INTO `iweb_areas` VALUES (1177, 1176, '哈尔滨市', 99);
INSERT INTO `iweb_areas` VALUES (1178, 1177, '道里区', 99);
INSERT INTO `iweb_areas` VALUES (1179, 1177, '南岗区', 99);
INSERT INTO `iweb_areas` VALUES (1180, 1177, '道外区', 99);
INSERT INTO `iweb_areas` VALUES (1181, 1177, '香坊区', 99);
INSERT INTO `iweb_areas` VALUES (1182, 1177, '动力区', 99);
INSERT INTO `iweb_areas` VALUES (1183, 1177, '平房区', 99);
INSERT INTO `iweb_areas` VALUES (1184, 1177, '松北区', 99);
INSERT INTO `iweb_areas` VALUES (1185, 1177, '呼兰区', 99);
INSERT INTO `iweb_areas` VALUES (1186, 1177, '依兰县', 99);
INSERT INTO `iweb_areas` VALUES (1187, 1177, '方正县', 99);
INSERT INTO `iweb_areas` VALUES (1188, 1177, '宾县', 99);
INSERT INTO `iweb_areas` VALUES (1189, 1177, '巴彦县', 99);
INSERT INTO `iweb_areas` VALUES (1190, 1177, '木兰县', 99);
INSERT INTO `iweb_areas` VALUES (1191, 1177, '通河县', 99);
INSERT INTO `iweb_areas` VALUES (1192, 1177, '延寿县', 99);
INSERT INTO `iweb_areas` VALUES (1193, 1177, '阿城市', 99);
INSERT INTO `iweb_areas` VALUES (1194, 1177, '双城市', 99);
INSERT INTO `iweb_areas` VALUES (1195, 1177, '尚志市', 99);
INSERT INTO `iweb_areas` VALUES (1196, 1177, '五常市', 99);
INSERT INTO `iweb_areas` VALUES (1197, 1176, '大庆市', 99);
INSERT INTO `iweb_areas` VALUES (1198, 1197, '萨尔图区', 99);
INSERT INTO `iweb_areas` VALUES (1199, 1197, '龙凤区', 99);
INSERT INTO `iweb_areas` VALUES (1200, 1197, '让胡路区', 99);
INSERT INTO `iweb_areas` VALUES (1201, 1197, '红岗区', 99);
INSERT INTO `iweb_areas` VALUES (1202, 1197, '大同区', 99);
INSERT INTO `iweb_areas` VALUES (1203, 1197, '肇州县', 99);
INSERT INTO `iweb_areas` VALUES (1204, 1197, '肇源县', 99);
INSERT INTO `iweb_areas` VALUES (1205, 1197, '林甸县', 99);
INSERT INTO `iweb_areas` VALUES (1206, 1197, '杜尔伯特蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1207, 1176, '大兴安岭地区', 99);
INSERT INTO `iweb_areas` VALUES (1208, 1207, '呼玛县', 99);
INSERT INTO `iweb_areas` VALUES (1209, 1207, '塔河县', 99);
INSERT INTO `iweb_areas` VALUES (1210, 1207, '漠河县', 99);
INSERT INTO `iweb_areas` VALUES (1211, 1176, '鹤岗市', 99);
INSERT INTO `iweb_areas` VALUES (1212, 1211, '向阳区', 99);
INSERT INTO `iweb_areas` VALUES (1213, 1211, '工农区', 99);
INSERT INTO `iweb_areas` VALUES (1214, 1211, '南山区', 99);
INSERT INTO `iweb_areas` VALUES (1215, 1211, '兴安区', 99);
INSERT INTO `iweb_areas` VALUES (1216, 1211, '东山区', 99);
INSERT INTO `iweb_areas` VALUES (1217, 1211, '兴山区', 99);
INSERT INTO `iweb_areas` VALUES (1218, 1211, '萝北县', 99);
INSERT INTO `iweb_areas` VALUES (1219, 1211, '绥滨县', 99);
INSERT INTO `iweb_areas` VALUES (1220, 1176, '黑河市', 99);
INSERT INTO `iweb_areas` VALUES (1221, 1220, '爱辉区', 99);
INSERT INTO `iweb_areas` VALUES (1222, 1220, '嫩江县', 99);
INSERT INTO `iweb_areas` VALUES (1223, 1220, '逊克县', 99);
INSERT INTO `iweb_areas` VALUES (1224, 1220, '孙吴县', 99);
INSERT INTO `iweb_areas` VALUES (1225, 1220, '北安市', 99);
INSERT INTO `iweb_areas` VALUES (1226, 1220, '五大连池市', 99);
INSERT INTO `iweb_areas` VALUES (1227, 1176, '鸡西市', 99);
INSERT INTO `iweb_areas` VALUES (1228, 1227, '鸡冠区', 99);
INSERT INTO `iweb_areas` VALUES (1229, 1227, '恒山区', 99);
INSERT INTO `iweb_areas` VALUES (1230, 1227, '滴道区', 99);
INSERT INTO `iweb_areas` VALUES (1231, 1227, '梨树区', 99);
INSERT INTO `iweb_areas` VALUES (1232, 1227, '城子河区', 99);
INSERT INTO `iweb_areas` VALUES (1233, 1227, '麻山区', 99);
INSERT INTO `iweb_areas` VALUES (1234, 1227, '鸡东县', 99);
INSERT INTO `iweb_areas` VALUES (1235, 1227, '虎林市', 99);
INSERT INTO `iweb_areas` VALUES (1236, 1227, '密山市', 99);
INSERT INTO `iweb_areas` VALUES (1237, 1176, '佳木斯市', 99);
INSERT INTO `iweb_areas` VALUES (1238, 1237, '永红区', 99);
INSERT INTO `iweb_areas` VALUES (1239, 1237, '向阳区', 99);
INSERT INTO `iweb_areas` VALUES (1240, 1237, '前进区', 99);
INSERT INTO `iweb_areas` VALUES (1241, 1237, '东风区', 99);
INSERT INTO `iweb_areas` VALUES (1242, 1237, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (1243, 1237, '桦南县', 99);
INSERT INTO `iweb_areas` VALUES (1244, 1237, '桦川县', 99);
INSERT INTO `iweb_areas` VALUES (1245, 1237, '汤原县', 99);
INSERT INTO `iweb_areas` VALUES (1246, 1237, '抚远县', 99);
INSERT INTO `iweb_areas` VALUES (1247, 1237, '同江市', 99);
INSERT INTO `iweb_areas` VALUES (1248, 1237, '富锦市', 99);
INSERT INTO `iweb_areas` VALUES (1249, 1176, '牡丹江市', 99);
INSERT INTO `iweb_areas` VALUES (1250, 1249, '东安区', 99);
INSERT INTO `iweb_areas` VALUES (1251, 1249, '阳明区', 99);
INSERT INTO `iweb_areas` VALUES (1252, 1249, '爱民区', 99);
INSERT INTO `iweb_areas` VALUES (1253, 1249, '西安区', 99);
INSERT INTO `iweb_areas` VALUES (1254, 1249, '东宁县', 99);
INSERT INTO `iweb_areas` VALUES (1255, 1249, '林口县', 99);
INSERT INTO `iweb_areas` VALUES (1256, 1249, '绥芬河市', 99);
INSERT INTO `iweb_areas` VALUES (1257, 1249, '海林市', 99);
INSERT INTO `iweb_areas` VALUES (1258, 1249, '宁安市', 99);
INSERT INTO `iweb_areas` VALUES (1259, 1249, '穆棱市', 99);
INSERT INTO `iweb_areas` VALUES (1260, 1176, '七台河市', 99);
INSERT INTO `iweb_areas` VALUES (1261, 1260, '新兴区', 99);
INSERT INTO `iweb_areas` VALUES (1262, 1260, '桃山区', 99);
INSERT INTO `iweb_areas` VALUES (1263, 1260, '茄子河区', 99);
INSERT INTO `iweb_areas` VALUES (1264, 1260, '勃利县', 99);
INSERT INTO `iweb_areas` VALUES (1265, 1176, '齐齐哈尔市', 99);
INSERT INTO `iweb_areas` VALUES (1266, 1265, '龙沙区', 99);
INSERT INTO `iweb_areas` VALUES (1267, 1265, '建华区', 99);
INSERT INTO `iweb_areas` VALUES (1268, 1265, '铁锋区', 99);
INSERT INTO `iweb_areas` VALUES (1269, 1265, '昂昂溪区', 99);
INSERT INTO `iweb_areas` VALUES (1270, 1265, '富拉尔基区', 99);
INSERT INTO `iweb_areas` VALUES (1271, 1265, '碾子山区', 99);
INSERT INTO `iweb_areas` VALUES (1272, 1265, '梅里斯达斡尔族区', 99);
INSERT INTO `iweb_areas` VALUES (1273, 1265, '龙江县', 99);
INSERT INTO `iweb_areas` VALUES (1274, 1265, '依安县', 99);
INSERT INTO `iweb_areas` VALUES (1275, 1265, '泰来县', 99);
INSERT INTO `iweb_areas` VALUES (1276, 1265, '甘南县', 99);
INSERT INTO `iweb_areas` VALUES (1277, 1265, '富裕县', 99);
INSERT INTO `iweb_areas` VALUES (1278, 1265, '克山县', 99);
INSERT INTO `iweb_areas` VALUES (1279, 1265, '克东县', 99);
INSERT INTO `iweb_areas` VALUES (1280, 1265, '拜泉县', 99);
INSERT INTO `iweb_areas` VALUES (1281, 1265, '讷河市', 99);
INSERT INTO `iweb_areas` VALUES (1282, 1176, '双鸭山市', 99);
INSERT INTO `iweb_areas` VALUES (1283, 1282, '尖山区', 99);
INSERT INTO `iweb_areas` VALUES (1284, 1282, '岭东区', 99);
INSERT INTO `iweb_areas` VALUES (1285, 1282, '四方台区', 99);
INSERT INTO `iweb_areas` VALUES (1286, 1282, '宝山区', 99);
INSERT INTO `iweb_areas` VALUES (1287, 1282, '集贤县', 99);
INSERT INTO `iweb_areas` VALUES (1288, 1282, '友谊县', 99);
INSERT INTO `iweb_areas` VALUES (1289, 1282, '宝清县', 99);
INSERT INTO `iweb_areas` VALUES (1290, 1282, '饶河县', 99);
INSERT INTO `iweb_areas` VALUES (1291, 1176, '绥化市', 99);
INSERT INTO `iweb_areas` VALUES (1292, 1291, '北林区', 99);
INSERT INTO `iweb_areas` VALUES (1293, 1291, '望奎县', 99);
INSERT INTO `iweb_areas` VALUES (1294, 1291, '兰西县', 99);
INSERT INTO `iweb_areas` VALUES (1295, 1291, '青冈县', 99);
INSERT INTO `iweb_areas` VALUES (1296, 1291, '庆安县', 99);
INSERT INTO `iweb_areas` VALUES (1297, 1291, '明水县', 99);
INSERT INTO `iweb_areas` VALUES (1298, 1291, '绥棱县', 99);
INSERT INTO `iweb_areas` VALUES (1299, 1291, '安达市', 99);
INSERT INTO `iweb_areas` VALUES (1300, 1291, '肇东市', 99);
INSERT INTO `iweb_areas` VALUES (1301, 1291, '海伦市', 99);
INSERT INTO `iweb_areas` VALUES (1302, 1176, '伊春市', 99);
INSERT INTO `iweb_areas` VALUES (1303, 1302, '伊春区', 99);
INSERT INTO `iweb_areas` VALUES (1304, 1302, '南岔区', 99);
INSERT INTO `iweb_areas` VALUES (1305, 1302, '友好区', 99);
INSERT INTO `iweb_areas` VALUES (1306, 1302, '西林区', 99);
INSERT INTO `iweb_areas` VALUES (1307, 1302, '翠峦区', 99);
INSERT INTO `iweb_areas` VALUES (1308, 1302, '新青区', 99);
INSERT INTO `iweb_areas` VALUES (1309, 1302, '美溪区', 99);
INSERT INTO `iweb_areas` VALUES (1310, 1302, '金山屯区', 99);
INSERT INTO `iweb_areas` VALUES (1311, 1302, '五营区', 99);
INSERT INTO `iweb_areas` VALUES (1312, 1302, '乌马河区', 99);
INSERT INTO `iweb_areas` VALUES (1313, 1302, '汤旺河区', 99);
INSERT INTO `iweb_areas` VALUES (1314, 1302, '带岭区', 99);
INSERT INTO `iweb_areas` VALUES (1315, 1302, '乌伊岭区', 99);
INSERT INTO `iweb_areas` VALUES (1316, 1302, '红星区', 99);
INSERT INTO `iweb_areas` VALUES (1317, 1302, '上甘岭区', 99);
INSERT INTO `iweb_areas` VALUES (1318, 1302, '嘉荫县', 99);
INSERT INTO `iweb_areas` VALUES (1319, 1302, '铁力市', 99);
INSERT INTO `iweb_areas` VALUES (1320, 0, '湖北', 99);
INSERT INTO `iweb_areas` VALUES (1321, 1320, '武汉市', 99);
INSERT INTO `iweb_areas` VALUES (1322, 1321, '江岸区', 99);
INSERT INTO `iweb_areas` VALUES (1323, 1321, '江汉区', 99);
INSERT INTO `iweb_areas` VALUES (1324, 1321, '乔口区', 99);
INSERT INTO `iweb_areas` VALUES (1325, 1321, '汉阳区', 99);
INSERT INTO `iweb_areas` VALUES (1326, 1321, '武昌区', 99);
INSERT INTO `iweb_areas` VALUES (1327, 1321, '青山区', 99);
INSERT INTO `iweb_areas` VALUES (1328, 1321, '洪山区', 99);
INSERT INTO `iweb_areas` VALUES (1329, 1321, '东西湖区', 99);
INSERT INTO `iweb_areas` VALUES (1330, 1321, '汉南区', 99);
INSERT INTO `iweb_areas` VALUES (1331, 1321, '蔡甸区', 99);
INSERT INTO `iweb_areas` VALUES (1332, 1321, '江夏区', 99);
INSERT INTO `iweb_areas` VALUES (1333, 1321, '黄陂区', 99);
INSERT INTO `iweb_areas` VALUES (1334, 1321, '新洲区', 99);
INSERT INTO `iweb_areas` VALUES (1335, 1320, '鄂州市', 99);
INSERT INTO `iweb_areas` VALUES (1336, 1335, '梁子湖区', 99);
INSERT INTO `iweb_areas` VALUES (1337, 1335, '华容区', 99);
INSERT INTO `iweb_areas` VALUES (1338, 1335, '鄂城区', 99);
INSERT INTO `iweb_areas` VALUES (1339, 1320, '恩施土家族苗族自治州', 99);
INSERT INTO `iweb_areas` VALUES (1340, 1339, '恩施市', 99);
INSERT INTO `iweb_areas` VALUES (1341, 1339, '利川市', 99);
INSERT INTO `iweb_areas` VALUES (1342, 1339, '建始县', 99);
INSERT INTO `iweb_areas` VALUES (1343, 1339, '巴东县', 99);
INSERT INTO `iweb_areas` VALUES (1344, 1339, '宣恩县', 99);
INSERT INTO `iweb_areas` VALUES (1345, 1339, '咸丰县', 99);
INSERT INTO `iweb_areas` VALUES (1346, 1339, '来凤县', 99);
INSERT INTO `iweb_areas` VALUES (1347, 1339, '鹤峰县', 99);
INSERT INTO `iweb_areas` VALUES (1348, 1320, '黄冈市', 99);
INSERT INTO `iweb_areas` VALUES (1349, 1348, '黄州区', 99);
INSERT INTO `iweb_areas` VALUES (1350, 1348, '团风县', 99);
INSERT INTO `iweb_areas` VALUES (1351, 1348, '红安县', 99);
INSERT INTO `iweb_areas` VALUES (1352, 1348, '罗田县', 99);
INSERT INTO `iweb_areas` VALUES (1353, 1348, '英山县', 99);
INSERT INTO `iweb_areas` VALUES (1354, 1348, '浠水县', 99);
INSERT INTO `iweb_areas` VALUES (1355, 1348, '蕲春县', 99);
INSERT INTO `iweb_areas` VALUES (1356, 1348, '黄梅县', 99);
INSERT INTO `iweb_areas` VALUES (1357, 1348, '麻城市', 99);
INSERT INTO `iweb_areas` VALUES (1358, 1348, '武穴市', 99);
INSERT INTO `iweb_areas` VALUES (1359, 1320, '黄石市', 99);
INSERT INTO `iweb_areas` VALUES (1360, 1359, '黄石港区', 99);
INSERT INTO `iweb_areas` VALUES (1361, 1359, '西塞山区', 99);
INSERT INTO `iweb_areas` VALUES (1362, 1359, '下陆区', 99);
INSERT INTO `iweb_areas` VALUES (1363, 1359, '铁山区', 99);
INSERT INTO `iweb_areas` VALUES (1364, 1359, '阳新县', 99);
INSERT INTO `iweb_areas` VALUES (1365, 1359, '大冶市', 99);
INSERT INTO `iweb_areas` VALUES (1366, 1320, '荆门市', 99);
INSERT INTO `iweb_areas` VALUES (1367, 1366, '东宝区', 99);
INSERT INTO `iweb_areas` VALUES (1368, 1366, '掇刀区', 99);
INSERT INTO `iweb_areas` VALUES (1369, 1366, '京山县', 99);
INSERT INTO `iweb_areas` VALUES (1370, 1366, '沙洋县', 99);
INSERT INTO `iweb_areas` VALUES (1371, 1366, '钟祥市', 99);
INSERT INTO `iweb_areas` VALUES (1372, 1320, '荆州市', 99);
INSERT INTO `iweb_areas` VALUES (1373, 1372, '沙市区', 99);
INSERT INTO `iweb_areas` VALUES (1374, 1372, '荆州区', 99);
INSERT INTO `iweb_areas` VALUES (1375, 1372, '公安县', 99);
INSERT INTO `iweb_areas` VALUES (1376, 1372, '监利县', 99);
INSERT INTO `iweb_areas` VALUES (1377, 1372, '江陵县', 99);
INSERT INTO `iweb_areas` VALUES (1378, 1372, '石首市', 99);
INSERT INTO `iweb_areas` VALUES (1379, 1372, '洪湖市', 99);
INSERT INTO `iweb_areas` VALUES (1380, 1372, '松滋市', 99);
INSERT INTO `iweb_areas` VALUES (1381, 1320, '潜江市', 99);
INSERT INTO `iweb_areas` VALUES (1382, 1320, '神农架林区', 99);
INSERT INTO `iweb_areas` VALUES (1383, 1320, '十堰市', 99);
INSERT INTO `iweb_areas` VALUES (1384, 1383, '茅箭区', 99);
INSERT INTO `iweb_areas` VALUES (1385, 1383, '张湾区', 99);
INSERT INTO `iweb_areas` VALUES (1386, 1383, '郧县', 99);
INSERT INTO `iweb_areas` VALUES (1387, 1383, '郧西县', 99);
INSERT INTO `iweb_areas` VALUES (1388, 1383, '竹山县', 99);
INSERT INTO `iweb_areas` VALUES (1389, 1383, '竹溪县', 99);
INSERT INTO `iweb_areas` VALUES (1390, 1383, '房县', 99);
INSERT INTO `iweb_areas` VALUES (1391, 1383, '丹江口市', 99);
INSERT INTO `iweb_areas` VALUES (1392, 1320, '随州市', 99);
INSERT INTO `iweb_areas` VALUES (1393, 1392, '曾都区', 99);
INSERT INTO `iweb_areas` VALUES (1394, 1392, '广水市', 99);
INSERT INTO `iweb_areas` VALUES (1395, 1320, '天门市', 99);
INSERT INTO `iweb_areas` VALUES (1396, 1320, '仙桃市', 99);
INSERT INTO `iweb_areas` VALUES (1397, 1320, '咸宁市', 99);
INSERT INTO `iweb_areas` VALUES (1398, 1397, '咸安区', 99);
INSERT INTO `iweb_areas` VALUES (1399, 1397, '嘉鱼县', 99);
INSERT INTO `iweb_areas` VALUES (1400, 1397, '通城县', 99);
INSERT INTO `iweb_areas` VALUES (1401, 1397, '崇阳县', 99);
INSERT INTO `iweb_areas` VALUES (1402, 1397, '通山县', 99);
INSERT INTO `iweb_areas` VALUES (1403, 1397, '赤壁市', 99);
INSERT INTO `iweb_areas` VALUES (1404, 1320, '襄樊市', 99);
INSERT INTO `iweb_areas` VALUES (1405, 1404, '襄城区', 99);
INSERT INTO `iweb_areas` VALUES (1406, 1404, '樊城区', 99);
INSERT INTO `iweb_areas` VALUES (1407, 1404, '襄阳区', 99);
INSERT INTO `iweb_areas` VALUES (1408, 1404, '南漳县', 99);
INSERT INTO `iweb_areas` VALUES (1409, 1404, '谷城县', 99);
INSERT INTO `iweb_areas` VALUES (1410, 1404, '保康县', 99);
INSERT INTO `iweb_areas` VALUES (1411, 1404, '老河口市', 99);
INSERT INTO `iweb_areas` VALUES (1412, 1404, '枣阳市', 99);
INSERT INTO `iweb_areas` VALUES (1413, 1404, '宜城市', 99);
INSERT INTO `iweb_areas` VALUES (1414, 1320, '孝感市', 99);
INSERT INTO `iweb_areas` VALUES (1415, 1414, '孝南区', 99);
INSERT INTO `iweb_areas` VALUES (1416, 1414, '孝昌县', 99);
INSERT INTO `iweb_areas` VALUES (1417, 1414, '大悟县', 99);
INSERT INTO `iweb_areas` VALUES (1418, 1414, '云梦县', 99);
INSERT INTO `iweb_areas` VALUES (1419, 1414, '应城市', 99);
INSERT INTO `iweb_areas` VALUES (1420, 1414, '安陆市', 99);
INSERT INTO `iweb_areas` VALUES (1421, 1414, '汉川市', 99);
INSERT INTO `iweb_areas` VALUES (1422, 1320, '宜昌市', 99);
INSERT INTO `iweb_areas` VALUES (1423, 1422, '西陵区', 99);
INSERT INTO `iweb_areas` VALUES (1424, 1422, '伍家岗区', 99);
INSERT INTO `iweb_areas` VALUES (1425, 1422, '点军区', 99);
INSERT INTO `iweb_areas` VALUES (1426, 1422, '猇亭区', 99);
INSERT INTO `iweb_areas` VALUES (1427, 1422, '夷陵区', 99);
INSERT INTO `iweb_areas` VALUES (1428, 1422, '远安县', 99);
INSERT INTO `iweb_areas` VALUES (1429, 1422, '兴山县', 99);
INSERT INTO `iweb_areas` VALUES (1430, 1422, '秭归县', 99);
INSERT INTO `iweb_areas` VALUES (1431, 1422, '长阳土家族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1432, 1422, '五峰土家族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1433, 1422, '宜都市', 99);
INSERT INTO `iweb_areas` VALUES (1434, 1422, '当阳市', 99);
INSERT INTO `iweb_areas` VALUES (1435, 1422, '枝江市', 99);
INSERT INTO `iweb_areas` VALUES (1436, 0, '湖南', 99);
INSERT INTO `iweb_areas` VALUES (1437, 1436, '长沙市', 99);
INSERT INTO `iweb_areas` VALUES (1438, 1437, '芙蓉区', 99);
INSERT INTO `iweb_areas` VALUES (1439, 1437, '天心区', 99);
INSERT INTO `iweb_areas` VALUES (1440, 1437, '岳麓区', 99);
INSERT INTO `iweb_areas` VALUES (1441, 1437, '开福区', 99);
INSERT INTO `iweb_areas` VALUES (1442, 1437, '雨花区', 99);
INSERT INTO `iweb_areas` VALUES (1443, 1437, '长沙县', 99);
INSERT INTO `iweb_areas` VALUES (1444, 1437, '望城县', 99);
INSERT INTO `iweb_areas` VALUES (1445, 1437, '宁乡县', 99);
INSERT INTO `iweb_areas` VALUES (1446, 1437, '浏阳市', 99);
INSERT INTO `iweb_areas` VALUES (1447, 1436, '常德市', 99);
INSERT INTO `iweb_areas` VALUES (1448, 1447, '武陵区', 99);
INSERT INTO `iweb_areas` VALUES (1449, 1447, '鼎城区', 99);
INSERT INTO `iweb_areas` VALUES (1450, 1447, '安乡县', 99);
INSERT INTO `iweb_areas` VALUES (1451, 1447, '汉寿县', 99);
INSERT INTO `iweb_areas` VALUES (1452, 1447, '澧县', 99);
INSERT INTO `iweb_areas` VALUES (1453, 1447, '临澧县', 99);
INSERT INTO `iweb_areas` VALUES (1454, 1447, '桃源县', 99);
INSERT INTO `iweb_areas` VALUES (1455, 1447, '石门县', 99);
INSERT INTO `iweb_areas` VALUES (1456, 1447, '津市市', 99);
INSERT INTO `iweb_areas` VALUES (1457, 1436, '郴州市', 99);
INSERT INTO `iweb_areas` VALUES (1458, 1457, '北湖区', 99);
INSERT INTO `iweb_areas` VALUES (1459, 1457, '苏仙区', 99);
INSERT INTO `iweb_areas` VALUES (1460, 1457, '桂阳县', 99);
INSERT INTO `iweb_areas` VALUES (1461, 1457, '宜章县', 99);
INSERT INTO `iweb_areas` VALUES (1462, 1457, '永兴县', 99);
INSERT INTO `iweb_areas` VALUES (1463, 1457, '嘉禾县', 99);
INSERT INTO `iweb_areas` VALUES (1464, 1457, '临武县', 99);
INSERT INTO `iweb_areas` VALUES (1465, 1457, '汝城县', 99);
INSERT INTO `iweb_areas` VALUES (1466, 1457, '桂东县', 99);
INSERT INTO `iweb_areas` VALUES (1467, 1457, '安仁县', 99);
INSERT INTO `iweb_areas` VALUES (1468, 1457, '资兴市', 99);
INSERT INTO `iweb_areas` VALUES (1469, 1436, '衡阳市', 99);
INSERT INTO `iweb_areas` VALUES (1470, 1469, '珠晖区', 99);
INSERT INTO `iweb_areas` VALUES (1471, 1469, '雁峰区', 99);
INSERT INTO `iweb_areas` VALUES (1472, 1469, '石鼓区', 99);
INSERT INTO `iweb_areas` VALUES (1473, 1469, '蒸湘区', 99);
INSERT INTO `iweb_areas` VALUES (1474, 1469, '南岳区', 99);
INSERT INTO `iweb_areas` VALUES (1475, 1469, '衡阳县', 99);
INSERT INTO `iweb_areas` VALUES (1476, 1469, '衡南县', 99);
INSERT INTO `iweb_areas` VALUES (1477, 1469, '衡山县', 99);
INSERT INTO `iweb_areas` VALUES (1478, 1469, '衡东县', 99);
INSERT INTO `iweb_areas` VALUES (1479, 1469, '祁东县', 99);
INSERT INTO `iweb_areas` VALUES (1480, 1469, '耒阳市', 99);
INSERT INTO `iweb_areas` VALUES (1481, 1469, '常宁市', 99);
INSERT INTO `iweb_areas` VALUES (1482, 1436, '怀化市', 99);
INSERT INTO `iweb_areas` VALUES (1483, 1482, '鹤城区', 99);
INSERT INTO `iweb_areas` VALUES (1484, 1482, '中方县', 99);
INSERT INTO `iweb_areas` VALUES (1485, 1482, '沅陵县', 99);
INSERT INTO `iweb_areas` VALUES (1486, 1482, '辰溪县', 99);
INSERT INTO `iweb_areas` VALUES (1487, 1482, '溆浦县', 99);
INSERT INTO `iweb_areas` VALUES (1488, 1482, '会同县', 99);
INSERT INTO `iweb_areas` VALUES (1489, 1482, '麻阳苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1490, 1482, '新晃侗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1491, 1482, '芷江侗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1492, 1482, '靖州苗族侗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1493, 1482, '通道侗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1494, 1482, '洪江市', 99);
INSERT INTO `iweb_areas` VALUES (1495, 1436, '娄底市', 99);
INSERT INTO `iweb_areas` VALUES (1496, 1495, '娄星区', 99);
INSERT INTO `iweb_areas` VALUES (1497, 1495, '双峰县', 99);
INSERT INTO `iweb_areas` VALUES (1498, 1495, '新化县', 99);
INSERT INTO `iweb_areas` VALUES (1499, 1495, '冷水江市', 99);
INSERT INTO `iweb_areas` VALUES (1500, 1495, '涟源市', 99);
INSERT INTO `iweb_areas` VALUES (1501, 1436, '邵阳市', 99);
INSERT INTO `iweb_areas` VALUES (1502, 1501, '双清区', 99);
INSERT INTO `iweb_areas` VALUES (1503, 1501, '大祥区', 99);
INSERT INTO `iweb_areas` VALUES (1504, 1501, '北塔区', 99);
INSERT INTO `iweb_areas` VALUES (1505, 1501, '邵东县', 99);
INSERT INTO `iweb_areas` VALUES (1506, 1501, '新邵县', 99);
INSERT INTO `iweb_areas` VALUES (1507, 1501, '邵阳县', 99);
INSERT INTO `iweb_areas` VALUES (1508, 1501, '隆回县', 99);
INSERT INTO `iweb_areas` VALUES (1509, 1501, '洞口县', 99);
INSERT INTO `iweb_areas` VALUES (1510, 1501, '绥宁县', 99);
INSERT INTO `iweb_areas` VALUES (1511, 1501, '新宁县', 99);
INSERT INTO `iweb_areas` VALUES (1512, 1501, '城步苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1513, 1501, '武冈市', 99);
INSERT INTO `iweb_areas` VALUES (1514, 1436, '湘潭市', 99);
INSERT INTO `iweb_areas` VALUES (1515, 1514, '雨湖区', 99);
INSERT INTO `iweb_areas` VALUES (1516, 1514, '岳塘区', 99);
INSERT INTO `iweb_areas` VALUES (1517, 1514, '湘潭县', 99);
INSERT INTO `iweb_areas` VALUES (1518, 1514, '湘乡市', 99);
INSERT INTO `iweb_areas` VALUES (1519, 1514, '韶山市', 99);
INSERT INTO `iweb_areas` VALUES (1520, 1436, '湘西土家族苗族自治州', 99);
INSERT INTO `iweb_areas` VALUES (1521, 1520, '吉首市', 99);
INSERT INTO `iweb_areas` VALUES (1522, 1520, '泸溪县', 99);
INSERT INTO `iweb_areas` VALUES (1523, 1520, '凤凰县', 99);
INSERT INTO `iweb_areas` VALUES (1524, 1520, '花垣县', 99);
INSERT INTO `iweb_areas` VALUES (1525, 1520, '保靖县', 99);
INSERT INTO `iweb_areas` VALUES (1526, 1520, '古丈县', 99);
INSERT INTO `iweb_areas` VALUES (1527, 1520, '永顺县', 99);
INSERT INTO `iweb_areas` VALUES (1528, 1520, '龙山县', 99);
INSERT INTO `iweb_areas` VALUES (1529, 1436, '益阳市', 99);
INSERT INTO `iweb_areas` VALUES (1530, 1529, '资阳区', 99);
INSERT INTO `iweb_areas` VALUES (1531, 1529, '赫山区', 99);
INSERT INTO `iweb_areas` VALUES (1532, 1529, '南县', 99);
INSERT INTO `iweb_areas` VALUES (1533, 1529, '桃江县', 99);
INSERT INTO `iweb_areas` VALUES (1534, 1529, '安化县', 99);
INSERT INTO `iweb_areas` VALUES (1535, 1529, '沅江市', 99);
INSERT INTO `iweb_areas` VALUES (1536, 1436, '永州市', 99);
INSERT INTO `iweb_areas` VALUES (1537, 1536, '芝山区', 99);
INSERT INTO `iweb_areas` VALUES (1538, 1536, '冷水滩区', 99);
INSERT INTO `iweb_areas` VALUES (1539, 1536, '祁阳县', 99);
INSERT INTO `iweb_areas` VALUES (1540, 1536, '东安县', 99);
INSERT INTO `iweb_areas` VALUES (1541, 1536, '双牌县', 99);
INSERT INTO `iweb_areas` VALUES (1542, 1536, '道县', 99);
INSERT INTO `iweb_areas` VALUES (1543, 1536, '江永县', 99);
INSERT INTO `iweb_areas` VALUES (1544, 1536, '宁远县', 99);
INSERT INTO `iweb_areas` VALUES (1545, 1536, '蓝山县', 99);
INSERT INTO `iweb_areas` VALUES (1546, 1536, '新田县', 99);
INSERT INTO `iweb_areas` VALUES (1547, 1536, '江华瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1548, 1436, '岳阳市', 99);
INSERT INTO `iweb_areas` VALUES (1549, 1548, '岳阳楼区', 99);
INSERT INTO `iweb_areas` VALUES (1550, 1548, '云溪区', 99);
INSERT INTO `iweb_areas` VALUES (1551, 1548, '君山区', 99);
INSERT INTO `iweb_areas` VALUES (1552, 1548, '岳阳县', 99);
INSERT INTO `iweb_areas` VALUES (1553, 1548, '华容县', 99);
INSERT INTO `iweb_areas` VALUES (1554, 1548, '湘阴县', 99);
INSERT INTO `iweb_areas` VALUES (1555, 1548, '平江县', 99);
INSERT INTO `iweb_areas` VALUES (1556, 1548, '汨罗市', 99);
INSERT INTO `iweb_areas` VALUES (1557, 1548, '临湘市', 99);
INSERT INTO `iweb_areas` VALUES (1558, 1436, '张家界市', 99);
INSERT INTO `iweb_areas` VALUES (1559, 1558, '永定区', 99);
INSERT INTO `iweb_areas` VALUES (1560, 1558, '武陵源区', 99);
INSERT INTO `iweb_areas` VALUES (1561, 1558, '慈利县', 99);
INSERT INTO `iweb_areas` VALUES (1562, 1558, '桑植县', 99);
INSERT INTO `iweb_areas` VALUES (1563, 1436, '株洲市', 99);
INSERT INTO `iweb_areas` VALUES (1564, 1563, '荷塘区', 99);
INSERT INTO `iweb_areas` VALUES (1565, 1563, '芦淞区', 99);
INSERT INTO `iweb_areas` VALUES (1566, 1563, '石峰区', 99);
INSERT INTO `iweb_areas` VALUES (1567, 1563, '天元区', 99);
INSERT INTO `iweb_areas` VALUES (1568, 1563, '株洲县', 99);
INSERT INTO `iweb_areas` VALUES (1569, 1563, '攸县', 99);
INSERT INTO `iweb_areas` VALUES (1570, 1563, '茶陵县', 99);
INSERT INTO `iweb_areas` VALUES (1571, 1563, '炎陵县', 99);
INSERT INTO `iweb_areas` VALUES (1572, 1563, '醴陵市', 99);
INSERT INTO `iweb_areas` VALUES (1573, 0, '吉林', 99);
INSERT INTO `iweb_areas` VALUES (1574, 1573, '长春市', 99);
INSERT INTO `iweb_areas` VALUES (1575, 1574, '南关区', 99);
INSERT INTO `iweb_areas` VALUES (1576, 1574, '宽城区', 99);
INSERT INTO `iweb_areas` VALUES (1577, 1574, '朝阳区', 99);
INSERT INTO `iweb_areas` VALUES (1578, 1574, '二道区', 99);
INSERT INTO `iweb_areas` VALUES (1579, 1574, '绿园区', 99);
INSERT INTO `iweb_areas` VALUES (1580, 1574, '双阳区', 99);
INSERT INTO `iweb_areas` VALUES (1581, 1574, '农安县', 99);
INSERT INTO `iweb_areas` VALUES (1582, 1574, '九台市', 99);
INSERT INTO `iweb_areas` VALUES (1583, 1574, '榆树市', 99);
INSERT INTO `iweb_areas` VALUES (1584, 1574, '德惠市', 99);
INSERT INTO `iweb_areas` VALUES (1585, 1573, '白城市', 99);
INSERT INTO `iweb_areas` VALUES (1586, 1585, '洮北区', 99);
INSERT INTO `iweb_areas` VALUES (1587, 1585, '镇赉县', 99);
INSERT INTO `iweb_areas` VALUES (1588, 1585, '通榆县', 99);
INSERT INTO `iweb_areas` VALUES (1589, 1585, '洮南市', 99);
INSERT INTO `iweb_areas` VALUES (1590, 1585, '大安市', 99);
INSERT INTO `iweb_areas` VALUES (1591, 1573, '白山市', 99);
INSERT INTO `iweb_areas` VALUES (1592, 1591, '八道江区', 99);
INSERT INTO `iweb_areas` VALUES (1593, 1591, '抚松县', 99);
INSERT INTO `iweb_areas` VALUES (1594, 1591, '靖宇县', 99);
INSERT INTO `iweb_areas` VALUES (1595, 1591, '长白朝鲜族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1596, 1591, '江源县', 99);
INSERT INTO `iweb_areas` VALUES (1597, 1591, '临江市', 99);
INSERT INTO `iweb_areas` VALUES (1598, 1573, '吉林市', 99);
INSERT INTO `iweb_areas` VALUES (1599, 1598, '昌邑区', 99);
INSERT INTO `iweb_areas` VALUES (1600, 1598, '龙潭区', 99);
INSERT INTO `iweb_areas` VALUES (1601, 1598, '船营区', 99);
INSERT INTO `iweb_areas` VALUES (1602, 1598, '丰满区', 99);
INSERT INTO `iweb_areas` VALUES (1603, 1598, '永吉县', 99);
INSERT INTO `iweb_areas` VALUES (1604, 1598, '蛟河市', 99);
INSERT INTO `iweb_areas` VALUES (1605, 1598, '桦甸市', 99);
INSERT INTO `iweb_areas` VALUES (1606, 1598, '舒兰市', 99);
INSERT INTO `iweb_areas` VALUES (1607, 1598, '磐石市', 99);
INSERT INTO `iweb_areas` VALUES (1608, 1573, '辽源市', 99);
INSERT INTO `iweb_areas` VALUES (1609, 1608, '龙山区', 99);
INSERT INTO `iweb_areas` VALUES (1610, 1608, '西安区', 99);
INSERT INTO `iweb_areas` VALUES (1611, 1608, '东丰县', 99);
INSERT INTO `iweb_areas` VALUES (1612, 1608, '东辽县', 99);
INSERT INTO `iweb_areas` VALUES (1613, 1573, '四平市', 99);
INSERT INTO `iweb_areas` VALUES (1614, 1613, '铁西区', 99);
INSERT INTO `iweb_areas` VALUES (1615, 1613, '铁东区', 99);
INSERT INTO `iweb_areas` VALUES (1616, 1613, '梨树县', 99);
INSERT INTO `iweb_areas` VALUES (1617, 1613, '伊通满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1618, 1613, '公主岭市', 99);
INSERT INTO `iweb_areas` VALUES (1619, 1613, '双辽市', 99);
INSERT INTO `iweb_areas` VALUES (1620, 1573, '松原市', 99);
INSERT INTO `iweb_areas` VALUES (1621, 1620, '宁江区', 99);
INSERT INTO `iweb_areas` VALUES (1622, 1620, '前郭尔罗斯蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1623, 1620, '长岭县', 99);
INSERT INTO `iweb_areas` VALUES (1624, 1620, '乾安县', 99);
INSERT INTO `iweb_areas` VALUES (1625, 1620, '扶余县', 99);
INSERT INTO `iweb_areas` VALUES (1626, 1573, '通化市', 99);
INSERT INTO `iweb_areas` VALUES (1627, 1626, '东昌区', 99);
INSERT INTO `iweb_areas` VALUES (1628, 1626, '二道江区', 99);
INSERT INTO `iweb_areas` VALUES (1629, 1626, '通化县', 99);
INSERT INTO `iweb_areas` VALUES (1630, 1626, '辉南县', 99);
INSERT INTO `iweb_areas` VALUES (1631, 1626, '柳河县', 99);
INSERT INTO `iweb_areas` VALUES (1632, 1626, '梅河口市', 99);
INSERT INTO `iweb_areas` VALUES (1633, 1626, '集安市', 99);
INSERT INTO `iweb_areas` VALUES (1634, 1573, '延边朝鲜族自治州', 99);
INSERT INTO `iweb_areas` VALUES (1635, 1634, '延吉市', 99);
INSERT INTO `iweb_areas` VALUES (1636, 1634, '图们市', 99);
INSERT INTO `iweb_areas` VALUES (1637, 1634, '敦化市', 99);
INSERT INTO `iweb_areas` VALUES (1638, 1634, '珲春市', 99);
INSERT INTO `iweb_areas` VALUES (1639, 1634, '龙井市', 99);
INSERT INTO `iweb_areas` VALUES (1640, 1634, '和龙市', 99);
INSERT INTO `iweb_areas` VALUES (1641, 1634, '汪清县', 99);
INSERT INTO `iweb_areas` VALUES (1642, 1634, '安图县', 99);
INSERT INTO `iweb_areas` VALUES (1643, 0, '江苏', 99);
INSERT INTO `iweb_areas` VALUES (1644, 1643, '南京市', 99);
INSERT INTO `iweb_areas` VALUES (1645, 1644, '玄武区', 99);
INSERT INTO `iweb_areas` VALUES (1646, 1644, '白下区', 99);
INSERT INTO `iweb_areas` VALUES (1647, 1644, '秦淮区', 99);
INSERT INTO `iweb_areas` VALUES (1648, 1644, '建邺区', 99);
INSERT INTO `iweb_areas` VALUES (1649, 1644, '鼓楼区', 99);
INSERT INTO `iweb_areas` VALUES (1650, 1644, '下关区', 99);
INSERT INTO `iweb_areas` VALUES (1651, 1644, '浦口区', 99);
INSERT INTO `iweb_areas` VALUES (1652, 1644, '栖霞区', 99);
INSERT INTO `iweb_areas` VALUES (1653, 1644, '雨花台区', 99);
INSERT INTO `iweb_areas` VALUES (1654, 1644, '江宁区', 99);
INSERT INTO `iweb_areas` VALUES (1655, 1644, '六合区', 99);
INSERT INTO `iweb_areas` VALUES (1656, 1644, '溧水县', 99);
INSERT INTO `iweb_areas` VALUES (1657, 1644, '高淳县', 99);
INSERT INTO `iweb_areas` VALUES (1658, 1643, '常州市', 99);
INSERT INTO `iweb_areas` VALUES (1659, 1658, '天宁区', 99);
INSERT INTO `iweb_areas` VALUES (1660, 1658, '钟楼区', 99);
INSERT INTO `iweb_areas` VALUES (1661, 1658, '戚墅堰区', 99);
INSERT INTO `iweb_areas` VALUES (1662, 1658, '新北区', 99);
INSERT INTO `iweb_areas` VALUES (1663, 1658, '武进区', 99);
INSERT INTO `iweb_areas` VALUES (1664, 1658, '溧阳市', 99);
INSERT INTO `iweb_areas` VALUES (1665, 1658, '金坛市', 99);
INSERT INTO `iweb_areas` VALUES (1666, 1643, '淮安市', 99);
INSERT INTO `iweb_areas` VALUES (1667, 1666, '清河区', 99);
INSERT INTO `iweb_areas` VALUES (1668, 1666, '楚州区', 99);
INSERT INTO `iweb_areas` VALUES (1669, 1666, '淮阴区', 99);
INSERT INTO `iweb_areas` VALUES (1670, 1666, '清浦区', 99);
INSERT INTO `iweb_areas` VALUES (1671, 1666, '涟水县', 99);
INSERT INTO `iweb_areas` VALUES (1672, 1666, '洪泽县', 99);
INSERT INTO `iweb_areas` VALUES (1673, 1666, '盱眙县', 99);
INSERT INTO `iweb_areas` VALUES (1674, 1666, '金湖县', 99);
INSERT INTO `iweb_areas` VALUES (1675, 1643, '连云港市', 99);
INSERT INTO `iweb_areas` VALUES (1676, 1675, '连云区', 99);
INSERT INTO `iweb_areas` VALUES (1677, 1675, '新浦区', 99);
INSERT INTO `iweb_areas` VALUES (1678, 1675, '海州区', 99);
INSERT INTO `iweb_areas` VALUES (1679, 1675, '赣榆县', 99);
INSERT INTO `iweb_areas` VALUES (1680, 1675, '东海县', 99);
INSERT INTO `iweb_areas` VALUES (1681, 1675, '灌云县', 99);
INSERT INTO `iweb_areas` VALUES (1682, 1675, '灌南县', 99);
INSERT INTO `iweb_areas` VALUES (1683, 1643, '南通市', 99);
INSERT INTO `iweb_areas` VALUES (1684, 1683, '崇川区', 99);
INSERT INTO `iweb_areas` VALUES (1685, 1683, '港闸区', 99);
INSERT INTO `iweb_areas` VALUES (1686, 1683, '海安县', 99);
INSERT INTO `iweb_areas` VALUES (1687, 1683, '如东县', 99);
INSERT INTO `iweb_areas` VALUES (1688, 1683, '启东市', 99);
INSERT INTO `iweb_areas` VALUES (1689, 1683, '如皋市', 99);
INSERT INTO `iweb_areas` VALUES (1690, 1683, '通州市', 99);
INSERT INTO `iweb_areas` VALUES (1691, 1683, '海门市', 99);
INSERT INTO `iweb_areas` VALUES (1692, 1643, '苏州市', 99);
INSERT INTO `iweb_areas` VALUES (1693, 1692, '沧浪区', 99);
INSERT INTO `iweb_areas` VALUES (1694, 1692, '平江区', 99);
INSERT INTO `iweb_areas` VALUES (1695, 1692, '金阊区', 99);
INSERT INTO `iweb_areas` VALUES (1696, 1692, '虎丘区', 99);
INSERT INTO `iweb_areas` VALUES (1697, 1692, '吴中区', 99);
INSERT INTO `iweb_areas` VALUES (1698, 1692, '相城区', 99);
INSERT INTO `iweb_areas` VALUES (1699, 1692, '常熟市', 99);
INSERT INTO `iweb_areas` VALUES (1700, 1692, '张家港市', 99);
INSERT INTO `iweb_areas` VALUES (1701, 1692, '昆山市', 99);
INSERT INTO `iweb_areas` VALUES (1702, 1692, '吴江市', 99);
INSERT INTO `iweb_areas` VALUES (1703, 1692, '太仓市', 99);
INSERT INTO `iweb_areas` VALUES (1704, 1643, '宿迁市', 99);
INSERT INTO `iweb_areas` VALUES (1705, 1704, '宿城区', 99);
INSERT INTO `iweb_areas` VALUES (1706, 1704, '宿豫区', 99);
INSERT INTO `iweb_areas` VALUES (1707, 1704, '沭阳县', 99);
INSERT INTO `iweb_areas` VALUES (1708, 1704, '泗阳县', 99);
INSERT INTO `iweb_areas` VALUES (1709, 1704, '泗洪县', 99);
INSERT INTO `iweb_areas` VALUES (1710, 1643, '泰州市', 99);
INSERT INTO `iweb_areas` VALUES (1711, 1710, '海陵区', 99);
INSERT INTO `iweb_areas` VALUES (1712, 1710, '高港区', 99);
INSERT INTO `iweb_areas` VALUES (1713, 1710, '兴化市', 99);
INSERT INTO `iweb_areas` VALUES (1714, 1710, '靖江市', 99);
INSERT INTO `iweb_areas` VALUES (1715, 1710, '泰兴市', 99);
INSERT INTO `iweb_areas` VALUES (1716, 1710, '姜堰市', 99);
INSERT INTO `iweb_areas` VALUES (1717, 1643, '无锡市', 99);
INSERT INTO `iweb_areas` VALUES (1718, 1717, '崇安区', 99);
INSERT INTO `iweb_areas` VALUES (1719, 1717, '南长区', 99);
INSERT INTO `iweb_areas` VALUES (1720, 1717, '北塘区', 99);
INSERT INTO `iweb_areas` VALUES (1721, 1717, '锡山区', 99);
INSERT INTO `iweb_areas` VALUES (1722, 1717, '惠山区', 99);
INSERT INTO `iweb_areas` VALUES (1723, 1717, '滨湖区', 99);
INSERT INTO `iweb_areas` VALUES (1724, 1717, '江阴市', 99);
INSERT INTO `iweb_areas` VALUES (1725, 1717, '宜兴市', 99);
INSERT INTO `iweb_areas` VALUES (1726, 1643, '徐州市', 99);
INSERT INTO `iweb_areas` VALUES (1727, 1726, '鼓楼区', 99);
INSERT INTO `iweb_areas` VALUES (1728, 1726, '云龙区', 99);
INSERT INTO `iweb_areas` VALUES (1729, 1726, '九里区', 99);
INSERT INTO `iweb_areas` VALUES (1730, 1726, '贾汪区', 99);
INSERT INTO `iweb_areas` VALUES (1731, 1726, '泉山区', 99);
INSERT INTO `iweb_areas` VALUES (1732, 1726, '丰县', 99);
INSERT INTO `iweb_areas` VALUES (1733, 1726, '沛县', 99);
INSERT INTO `iweb_areas` VALUES (1734, 1726, '铜山县', 99);
INSERT INTO `iweb_areas` VALUES (1735, 1726, '睢宁县', 99);
INSERT INTO `iweb_areas` VALUES (1736, 1726, '新沂市', 99);
INSERT INTO `iweb_areas` VALUES (1737, 1726, '邳州市', 99);
INSERT INTO `iweb_areas` VALUES (1738, 1643, '盐城市', 99);
INSERT INTO `iweb_areas` VALUES (1739, 1738, '亭湖区', 99);
INSERT INTO `iweb_areas` VALUES (1740, 1738, '盐都区', 99);
INSERT INTO `iweb_areas` VALUES (1741, 1738, '响水县', 99);
INSERT INTO `iweb_areas` VALUES (1742, 1738, '滨海县', 99);
INSERT INTO `iweb_areas` VALUES (1743, 1738, '阜宁县', 99);
INSERT INTO `iweb_areas` VALUES (1744, 1738, '射阳县', 99);
INSERT INTO `iweb_areas` VALUES (1745, 1738, '建湖县', 99);
INSERT INTO `iweb_areas` VALUES (1746, 1738, '东台市', 99);
INSERT INTO `iweb_areas` VALUES (1747, 1738, '大丰市', 99);
INSERT INTO `iweb_areas` VALUES (1748, 1643, '扬州市', 99);
INSERT INTO `iweb_areas` VALUES (1749, 1748, '广陵区', 99);
INSERT INTO `iweb_areas` VALUES (1750, 1748, '邗江区', 99);
INSERT INTO `iweb_areas` VALUES (1751, 1748, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (1752, 1748, '宝应县', 99);
INSERT INTO `iweb_areas` VALUES (1753, 1748, '仪征市', 99);
INSERT INTO `iweb_areas` VALUES (1754, 1748, '高邮市', 99);
INSERT INTO `iweb_areas` VALUES (1755, 1748, '江都市', 99);
INSERT INTO `iweb_areas` VALUES (1756, 1643, '镇江市', 99);
INSERT INTO `iweb_areas` VALUES (1757, 1756, '京口区', 99);
INSERT INTO `iweb_areas` VALUES (1758, 1756, '润州区', 99);
INSERT INTO `iweb_areas` VALUES (1759, 1756, '丹徒区', 99);
INSERT INTO `iweb_areas` VALUES (1760, 1756, '丹阳市', 99);
INSERT INTO `iweb_areas` VALUES (1761, 1756, '扬中市', 99);
INSERT INTO `iweb_areas` VALUES (1762, 1756, '句容市', 99);
INSERT INTO `iweb_areas` VALUES (1763, 0, '江西', 99);
INSERT INTO `iweb_areas` VALUES (1764, 1763, '南昌市', 99);
INSERT INTO `iweb_areas` VALUES (1765, 1764, '东湖区', 99);
INSERT INTO `iweb_areas` VALUES (1766, 1764, '西湖区', 99);
INSERT INTO `iweb_areas` VALUES (1767, 1764, '青云谱区', 99);
INSERT INTO `iweb_areas` VALUES (1768, 1764, '湾里区', 99);
INSERT INTO `iweb_areas` VALUES (1769, 1764, '青山湖区', 99);
INSERT INTO `iweb_areas` VALUES (1770, 1764, '南昌县', 99);
INSERT INTO `iweb_areas` VALUES (1771, 1764, '新建县', 99);
INSERT INTO `iweb_areas` VALUES (1772, 1764, '安义县', 99);
INSERT INTO `iweb_areas` VALUES (1773, 1764, '进贤县', 99);
INSERT INTO `iweb_areas` VALUES (1774, 1763, '抚州市', 99);
INSERT INTO `iweb_areas` VALUES (1775, 1774, '临川区', 99);
INSERT INTO `iweb_areas` VALUES (1776, 1774, '南城县', 99);
INSERT INTO `iweb_areas` VALUES (1777, 1774, '黎川县', 99);
INSERT INTO `iweb_areas` VALUES (1778, 1774, '南丰县', 99);
INSERT INTO `iweb_areas` VALUES (1779, 1774, '崇仁县', 99);
INSERT INTO `iweb_areas` VALUES (1780, 1774, '乐安县', 99);
INSERT INTO `iweb_areas` VALUES (1781, 1774, '宜黄县', 99);
INSERT INTO `iweb_areas` VALUES (1782, 1774, '金溪县', 99);
INSERT INTO `iweb_areas` VALUES (1783, 1774, '资溪县', 99);
INSERT INTO `iweb_areas` VALUES (1784, 1774, '东乡县', 99);
INSERT INTO `iweb_areas` VALUES (1785, 1774, '广昌县', 99);
INSERT INTO `iweb_areas` VALUES (1786, 1763, '赣州市', 99);
INSERT INTO `iweb_areas` VALUES (1787, 1786, '章贡区', 99);
INSERT INTO `iweb_areas` VALUES (1788, 1786, '赣县', 99);
INSERT INTO `iweb_areas` VALUES (1789, 1786, '信丰县', 99);
INSERT INTO `iweb_areas` VALUES (1790, 1786, '大余县', 99);
INSERT INTO `iweb_areas` VALUES (1791, 1786, '上犹县', 99);
INSERT INTO `iweb_areas` VALUES (1792, 1786, '崇义县', 99);
INSERT INTO `iweb_areas` VALUES (1793, 1786, '安远县', 99);
INSERT INTO `iweb_areas` VALUES (1794, 1786, '龙南县', 99);
INSERT INTO `iweb_areas` VALUES (1795, 1786, '定南县', 99);
INSERT INTO `iweb_areas` VALUES (1796, 1786, '全南县', 99);
INSERT INTO `iweb_areas` VALUES (1797, 1786, '宁都县', 99);
INSERT INTO `iweb_areas` VALUES (1798, 1786, '于都县', 99);
INSERT INTO `iweb_areas` VALUES (1799, 1786, '兴国县', 99);
INSERT INTO `iweb_areas` VALUES (1800, 1786, '会昌县', 99);
INSERT INTO `iweb_areas` VALUES (1801, 1786, '寻乌县', 99);
INSERT INTO `iweb_areas` VALUES (1802, 1786, '石城县', 99);
INSERT INTO `iweb_areas` VALUES (1803, 1786, '瑞金市', 99);
INSERT INTO `iweb_areas` VALUES (1804, 1786, '南康市', 99);
INSERT INTO `iweb_areas` VALUES (1805, 1763, '吉安市', 99);
INSERT INTO `iweb_areas` VALUES (1806, 1805, '吉州区', 99);
INSERT INTO `iweb_areas` VALUES (1807, 1805, '青原区', 99);
INSERT INTO `iweb_areas` VALUES (1808, 1805, '吉安县', 99);
INSERT INTO `iweb_areas` VALUES (1809, 1805, '吉水县', 99);
INSERT INTO `iweb_areas` VALUES (1810, 1805, '峡江县', 99);
INSERT INTO `iweb_areas` VALUES (1811, 1805, '新干县', 99);
INSERT INTO `iweb_areas` VALUES (1812, 1805, '永丰县', 99);
INSERT INTO `iweb_areas` VALUES (1813, 1805, '泰和县', 99);
INSERT INTO `iweb_areas` VALUES (1814, 1805, '遂川县', 99);
INSERT INTO `iweb_areas` VALUES (1815, 1805, '万安县', 99);
INSERT INTO `iweb_areas` VALUES (1816, 1805, '安福县', 99);
INSERT INTO `iweb_areas` VALUES (1817, 1805, '永新县', 99);
INSERT INTO `iweb_areas` VALUES (1818, 1805, '井冈山市', 99);
INSERT INTO `iweb_areas` VALUES (1819, 1763, '景德镇市', 99);
INSERT INTO `iweb_areas` VALUES (1820, 1819, '昌江区', 99);
INSERT INTO `iweb_areas` VALUES (1821, 1819, '珠山区', 99);
INSERT INTO `iweb_areas` VALUES (1822, 1819, '浮梁县', 99);
INSERT INTO `iweb_areas` VALUES (1823, 1819, '乐平市', 99);
INSERT INTO `iweb_areas` VALUES (1824, 1763, '九江市', 99);
INSERT INTO `iweb_areas` VALUES (1825, 1824, '庐山区', 99);
INSERT INTO `iweb_areas` VALUES (1826, 1824, '浔阳区', 99);
INSERT INTO `iweb_areas` VALUES (1827, 1824, '九江县', 99);
INSERT INTO `iweb_areas` VALUES (1828, 1824, '武宁县', 99);
INSERT INTO `iweb_areas` VALUES (1829, 1824, '修水县', 99);
INSERT INTO `iweb_areas` VALUES (1830, 1824, '永修县', 99);
INSERT INTO `iweb_areas` VALUES (1831, 1824, '德安县', 99);
INSERT INTO `iweb_areas` VALUES (1832, 1824, '星子县', 99);
INSERT INTO `iweb_areas` VALUES (1833, 1824, '都昌县', 99);
INSERT INTO `iweb_areas` VALUES (1834, 1824, '湖口县', 99);
INSERT INTO `iweb_areas` VALUES (1835, 1824, '彭泽县', 99);
INSERT INTO `iweb_areas` VALUES (1836, 1824, '瑞昌市', 99);
INSERT INTO `iweb_areas` VALUES (1837, 1763, '萍乡市', 99);
INSERT INTO `iweb_areas` VALUES (1838, 1837, '安源区', 99);
INSERT INTO `iweb_areas` VALUES (1839, 1837, '湘东区', 99);
INSERT INTO `iweb_areas` VALUES (1840, 1837, '莲花县', 99);
INSERT INTO `iweb_areas` VALUES (1841, 1837, '上栗县', 99);
INSERT INTO `iweb_areas` VALUES (1842, 1837, '芦溪县', 99);
INSERT INTO `iweb_areas` VALUES (1843, 1763, '上饶市', 99);
INSERT INTO `iweb_areas` VALUES (1844, 1843, '信州区', 99);
INSERT INTO `iweb_areas` VALUES (1845, 1843, '上饶县', 99);
INSERT INTO `iweb_areas` VALUES (1846, 1843, '广丰县', 99);
INSERT INTO `iweb_areas` VALUES (1847, 1843, '玉山县', 99);
INSERT INTO `iweb_areas` VALUES (1848, 1843, '铅山县', 99);
INSERT INTO `iweb_areas` VALUES (1849, 1843, '横峰县', 99);
INSERT INTO `iweb_areas` VALUES (1850, 1843, '弋阳县', 99);
INSERT INTO `iweb_areas` VALUES (1851, 1843, '余干县', 99);
INSERT INTO `iweb_areas` VALUES (1852, 1843, '鄱阳县', 99);
INSERT INTO `iweb_areas` VALUES (1853, 1843, '万年县', 99);
INSERT INTO `iweb_areas` VALUES (1854, 1843, '婺源县', 99);
INSERT INTO `iweb_areas` VALUES (1855, 1843, '德兴市', 99);
INSERT INTO `iweb_areas` VALUES (1856, 1763, '新余市', 99);
INSERT INTO `iweb_areas` VALUES (1857, 1856, '渝水区', 99);
INSERT INTO `iweb_areas` VALUES (1858, 1856, '分宜县', 99);
INSERT INTO `iweb_areas` VALUES (1859, 1763, '宜春市', 99);
INSERT INTO `iweb_areas` VALUES (1860, 1859, '袁州区', 99);
INSERT INTO `iweb_areas` VALUES (1861, 1859, '奉新县', 99);
INSERT INTO `iweb_areas` VALUES (1862, 1859, '万载县', 99);
INSERT INTO `iweb_areas` VALUES (1863, 1859, '上高县', 99);
INSERT INTO `iweb_areas` VALUES (1864, 1859, '宜丰县', 99);
INSERT INTO `iweb_areas` VALUES (1865, 1859, '靖安县', 99);
INSERT INTO `iweb_areas` VALUES (1866, 1859, '铜鼓县', 99);
INSERT INTO `iweb_areas` VALUES (1867, 1859, '丰城市', 99);
INSERT INTO `iweb_areas` VALUES (1868, 1859, '樟树市', 99);
INSERT INTO `iweb_areas` VALUES (1869, 1859, '高安市', 99);
INSERT INTO `iweb_areas` VALUES (1870, 1763, '鹰潭市', 99);
INSERT INTO `iweb_areas` VALUES (1871, 1870, '月湖区', 99);
INSERT INTO `iweb_areas` VALUES (1872, 1870, '余江县', 99);
INSERT INTO `iweb_areas` VALUES (1873, 1870, '贵溪市', 99);
INSERT INTO `iweb_areas` VALUES (1874, 0, '辽宁', 99);
INSERT INTO `iweb_areas` VALUES (1875, 1874, '沈阳市', 99);
INSERT INTO `iweb_areas` VALUES (1876, 1875, '和平区', 99);
INSERT INTO `iweb_areas` VALUES (1877, 1875, '沈河区', 99);
INSERT INTO `iweb_areas` VALUES (1878, 1875, '大东区', 99);
INSERT INTO `iweb_areas` VALUES (1879, 1875, '皇姑区', 99);
INSERT INTO `iweb_areas` VALUES (1880, 1875, '铁西区', 99);
INSERT INTO `iweb_areas` VALUES (1881, 1875, '苏家屯区', 99);
INSERT INTO `iweb_areas` VALUES (1882, 1875, '东陵区', 99);
INSERT INTO `iweb_areas` VALUES (1883, 1875, '新城子区', 99);
INSERT INTO `iweb_areas` VALUES (1884, 1875, '于洪区', 99);
INSERT INTO `iweb_areas` VALUES (1885, 1875, '辽中县', 99);
INSERT INTO `iweb_areas` VALUES (1886, 1875, '康平县', 99);
INSERT INTO `iweb_areas` VALUES (1887, 1875, '法库县', 99);
INSERT INTO `iweb_areas` VALUES (1888, 1875, '新民市', 99);
INSERT INTO `iweb_areas` VALUES (1889, 1874, '鞍山市', 99);
INSERT INTO `iweb_areas` VALUES (1890, 1889, '铁东区', 99);
INSERT INTO `iweb_areas` VALUES (1891, 1889, '铁西区', 99);
INSERT INTO `iweb_areas` VALUES (1892, 1889, '立山区', 99);
INSERT INTO `iweb_areas` VALUES (1893, 1889, '千山区', 99);
INSERT INTO `iweb_areas` VALUES (1894, 1889, '台安县', 99);
INSERT INTO `iweb_areas` VALUES (1895, 1889, '岫岩满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1896, 1889, '海城市', 99);
INSERT INTO `iweb_areas` VALUES (1897, 1874, '本溪市', 99);
INSERT INTO `iweb_areas` VALUES (1898, 1897, '平山区', 99);
INSERT INTO `iweb_areas` VALUES (1899, 1897, '溪湖区', 99);
INSERT INTO `iweb_areas` VALUES (1900, 1897, '明山区', 99);
INSERT INTO `iweb_areas` VALUES (1901, 1897, '南芬区', 99);
INSERT INTO `iweb_areas` VALUES (1902, 1897, '本溪满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1903, 1897, '桓仁满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1904, 1874, '朝阳市', 99);
INSERT INTO `iweb_areas` VALUES (1905, 1904, '双塔区', 99);
INSERT INTO `iweb_areas` VALUES (1906, 1904, '龙城区', 99);
INSERT INTO `iweb_areas` VALUES (1907, 1904, '朝阳县', 99);
INSERT INTO `iweb_areas` VALUES (1908, 1904, '建平县', 99);
INSERT INTO `iweb_areas` VALUES (1909, 1904, '喀喇沁左翼蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1910, 1904, '北票市', 99);
INSERT INTO `iweb_areas` VALUES (1911, 1904, '凌源市', 99);
INSERT INTO `iweb_areas` VALUES (1912, 1874, '大连市', 99);
INSERT INTO `iweb_areas` VALUES (1913, 1912, '中山区', 99);
INSERT INTO `iweb_areas` VALUES (1914, 1912, '西岗区', 99);
INSERT INTO `iweb_areas` VALUES (1915, 1912, '沙河口区', 99);
INSERT INTO `iweb_areas` VALUES (1916, 1912, '甘井子区', 99);
INSERT INTO `iweb_areas` VALUES (1917, 1912, '旅顺口区', 99);
INSERT INTO `iweb_areas` VALUES (1918, 1912, '金州区', 99);
INSERT INTO `iweb_areas` VALUES (1919, 1912, '长海县', 99);
INSERT INTO `iweb_areas` VALUES (1920, 1912, '瓦房店市', 99);
INSERT INTO `iweb_areas` VALUES (1921, 1912, '普兰店市', 99);
INSERT INTO `iweb_areas` VALUES (1922, 1912, '庄河市', 99);
INSERT INTO `iweb_areas` VALUES (1923, 1874, '丹东市', 99);
INSERT INTO `iweb_areas` VALUES (1924, 1923, '元宝区', 99);
INSERT INTO `iweb_areas` VALUES (1925, 1923, '振兴区', 99);
INSERT INTO `iweb_areas` VALUES (1926, 1923, '振安区', 99);
INSERT INTO `iweb_areas` VALUES (1927, 1923, '宽甸满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1928, 1923, '东港市', 99);
INSERT INTO `iweb_areas` VALUES (1929, 1923, '凤城市', 99);
INSERT INTO `iweb_areas` VALUES (1930, 1874, '抚顺市', 99);
INSERT INTO `iweb_areas` VALUES (1931, 1930, '新抚区', 99);
INSERT INTO `iweb_areas` VALUES (1932, 1930, '东洲区', 99);
INSERT INTO `iweb_areas` VALUES (1933, 1930, '望花区', 99);
INSERT INTO `iweb_areas` VALUES (1934, 1930, '顺城区', 99);
INSERT INTO `iweb_areas` VALUES (1935, 1930, '抚顺县', 99);
INSERT INTO `iweb_areas` VALUES (1936, 1930, '新宾满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1937, 1930, '清原满族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1938, 1874, '阜新市', 99);
INSERT INTO `iweb_areas` VALUES (1939, 1938, '海州区', 99);
INSERT INTO `iweb_areas` VALUES (1940, 1938, '新邱区', 99);
INSERT INTO `iweb_areas` VALUES (1941, 1938, '太平区', 99);
INSERT INTO `iweb_areas` VALUES (1942, 1938, '清河门区', 99);
INSERT INTO `iweb_areas` VALUES (1943, 1938, '细河区', 99);
INSERT INTO `iweb_areas` VALUES (1944, 1938, '阜新蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (1945, 1938, '彰武县', 99);
INSERT INTO `iweb_areas` VALUES (1946, 1874, '葫芦岛市', 99);
INSERT INTO `iweb_areas` VALUES (1947, 1946, '连山区', 99);
INSERT INTO `iweb_areas` VALUES (1948, 1946, '龙港区', 99);
INSERT INTO `iweb_areas` VALUES (1949, 1946, '南票区', 99);
INSERT INTO `iweb_areas` VALUES (1950, 1946, '绥中县', 99);
INSERT INTO `iweb_areas` VALUES (1951, 1946, '建昌县', 99);
INSERT INTO `iweb_areas` VALUES (1952, 1946, '兴城市', 99);
INSERT INTO `iweb_areas` VALUES (1953, 1874, '锦州市', 99);
INSERT INTO `iweb_areas` VALUES (1954, 1953, '古塔区', 99);
INSERT INTO `iweb_areas` VALUES (1955, 1953, '凌河区', 99);
INSERT INTO `iweb_areas` VALUES (1956, 1953, '太和区', 99);
INSERT INTO `iweb_areas` VALUES (1957, 1953, '黑山县', 99);
INSERT INTO `iweb_areas` VALUES (1958, 1953, '义县', 99);
INSERT INTO `iweb_areas` VALUES (1959, 1953, '凌海市', 99);
INSERT INTO `iweb_areas` VALUES (1960, 1953, '北宁市', 99);
INSERT INTO `iweb_areas` VALUES (1961, 1874, '辽阳市', 99);
INSERT INTO `iweb_areas` VALUES (1962, 1961, '白塔区', 99);
INSERT INTO `iweb_areas` VALUES (1963, 1961, '文圣区', 99);
INSERT INTO `iweb_areas` VALUES (1964, 1961, '宏伟区', 99);
INSERT INTO `iweb_areas` VALUES (1965, 1961, '弓长岭区', 99);
INSERT INTO `iweb_areas` VALUES (1966, 1961, '太子河区', 99);
INSERT INTO `iweb_areas` VALUES (1967, 1961, '辽阳县', 99);
INSERT INTO `iweb_areas` VALUES (1968, 1961, '灯塔市', 99);
INSERT INTO `iweb_areas` VALUES (1969, 1874, '盘锦市', 99);
INSERT INTO `iweb_areas` VALUES (1970, 1969, '双台子区', 99);
INSERT INTO `iweb_areas` VALUES (1971, 1969, '兴隆台区', 99);
INSERT INTO `iweb_areas` VALUES (1972, 1969, '大洼县', 99);
INSERT INTO `iweb_areas` VALUES (1973, 1969, '盘山县', 99);
INSERT INTO `iweb_areas` VALUES (1974, 1874, '铁岭市', 99);
INSERT INTO `iweb_areas` VALUES (1975, 1974, '银州区', 99);
INSERT INTO `iweb_areas` VALUES (1976, 1974, '清河区', 99);
INSERT INTO `iweb_areas` VALUES (1977, 1974, '铁岭县', 99);
INSERT INTO `iweb_areas` VALUES (1978, 1974, '西丰县', 99);
INSERT INTO `iweb_areas` VALUES (1979, 1974, '昌图县', 99);
INSERT INTO `iweb_areas` VALUES (1980, 1974, '调兵山市', 99);
INSERT INTO `iweb_areas` VALUES (1981, 1974, '开原市', 99);
INSERT INTO `iweb_areas` VALUES (1982, 1874, '营口市', 99);
INSERT INTO `iweb_areas` VALUES (1983, 1982, '站前区', 99);
INSERT INTO `iweb_areas` VALUES (1984, 1982, '西市区', 99);
INSERT INTO `iweb_areas` VALUES (1985, 1982, '鲅鱼圈区', 99);
INSERT INTO `iweb_areas` VALUES (1986, 1982, '老边区', 99);
INSERT INTO `iweb_areas` VALUES (1987, 1982, '盖州市', 99);
INSERT INTO `iweb_areas` VALUES (1988, 1982, '大石桥市', 99);
INSERT INTO `iweb_areas` VALUES (1989, 0, '内蒙古', 99);
INSERT INTO `iweb_areas` VALUES (1990, 1989, '呼和浩特市', 99);
INSERT INTO `iweb_areas` VALUES (1991, 1990, '新城区', 99);
INSERT INTO `iweb_areas` VALUES (1992, 1990, '回民区', 99);
INSERT INTO `iweb_areas` VALUES (1993, 1990, '玉泉区', 99);
INSERT INTO `iweb_areas` VALUES (1994, 1990, '赛罕区', 99);
INSERT INTO `iweb_areas` VALUES (1995, 1990, '土默特左旗', 99);
INSERT INTO `iweb_areas` VALUES (1996, 1990, '托克托县', 99);
INSERT INTO `iweb_areas` VALUES (1997, 1990, '和林格尔县', 99);
INSERT INTO `iweb_areas` VALUES (1998, 1990, '清水河县', 99);
INSERT INTO `iweb_areas` VALUES (1999, 1990, '武川县', 99);
INSERT INTO `iweb_areas` VALUES (2000, 1989, '阿拉善盟', 99);
INSERT INTO `iweb_areas` VALUES (2001, 2000, '阿拉善左旗', 99);
INSERT INTO `iweb_areas` VALUES (2002, 2000, '阿拉善右旗', 99);
INSERT INTO `iweb_areas` VALUES (2003, 2000, '额济纳旗', 99);
INSERT INTO `iweb_areas` VALUES (2004, 1989, '巴彦淖尔市', 99);
INSERT INTO `iweb_areas` VALUES (2005, 2004, '临河区', 99);
INSERT INTO `iweb_areas` VALUES (2006, 2004, '五原县', 99);
INSERT INTO `iweb_areas` VALUES (2007, 2004, '磴口县', 99);
INSERT INTO `iweb_areas` VALUES (2008, 2004, '乌拉特前旗', 99);
INSERT INTO `iweb_areas` VALUES (2009, 2004, '乌拉特中旗', 99);
INSERT INTO `iweb_areas` VALUES (2010, 2004, '乌拉特后旗', 99);
INSERT INTO `iweb_areas` VALUES (2011, 2004, '杭锦后旗', 99);
INSERT INTO `iweb_areas` VALUES (2012, 1989, '包头市', 99);
INSERT INTO `iweb_areas` VALUES (2013, 2012, '东河区', 99);
INSERT INTO `iweb_areas` VALUES (2014, 2012, '昆都仑区', 99);
INSERT INTO `iweb_areas` VALUES (2015, 2012, '青山区', 99);
INSERT INTO `iweb_areas` VALUES (2016, 2012, '石拐区', 99);
INSERT INTO `iweb_areas` VALUES (2017, 2012, '白云矿区', 99);
INSERT INTO `iweb_areas` VALUES (2018, 2012, '九原区', 99);
INSERT INTO `iweb_areas` VALUES (2019, 2012, '土默特右旗', 99);
INSERT INTO `iweb_areas` VALUES (2020, 2012, '固阳县', 99);
INSERT INTO `iweb_areas` VALUES (2021, 2012, '达尔罕茂明安联合旗', 99);
INSERT INTO `iweb_areas` VALUES (2022, 1989, '赤峰市', 99);
INSERT INTO `iweb_areas` VALUES (2023, 2022, '红山区', 99);
INSERT INTO `iweb_areas` VALUES (2024, 2022, '元宝山区', 99);
INSERT INTO `iweb_areas` VALUES (2025, 2022, '松山区', 99);
INSERT INTO `iweb_areas` VALUES (2026, 2022, '阿鲁科尔沁旗', 99);
INSERT INTO `iweb_areas` VALUES (2027, 2022, '巴林左旗', 99);
INSERT INTO `iweb_areas` VALUES (2028, 2022, '巴林右旗', 99);
INSERT INTO `iweb_areas` VALUES (2029, 2022, '林西县', 99);
INSERT INTO `iweb_areas` VALUES (2030, 2022, '克什克腾旗', 99);
INSERT INTO `iweb_areas` VALUES (2031, 2022, '翁牛特旗', 99);
INSERT INTO `iweb_areas` VALUES (2032, 2022, '喀喇沁旗', 99);
INSERT INTO `iweb_areas` VALUES (2033, 2022, '宁城县', 99);
INSERT INTO `iweb_areas` VALUES (2034, 2022, '敖汉旗', 99);
INSERT INTO `iweb_areas` VALUES (2035, 1989, '鄂尔多斯市', 99);
INSERT INTO `iweb_areas` VALUES (2036, 2035, '东胜区', 99);
INSERT INTO `iweb_areas` VALUES (2037, 2035, '达拉特旗', 99);
INSERT INTO `iweb_areas` VALUES (2038, 2035, '准格尔旗', 99);
INSERT INTO `iweb_areas` VALUES (2039, 2035, '鄂托克前旗', 99);
INSERT INTO `iweb_areas` VALUES (2040, 2035, '鄂托克旗', 99);
INSERT INTO `iweb_areas` VALUES (2041, 2035, '杭锦旗', 99);
INSERT INTO `iweb_areas` VALUES (2042, 2035, '乌审旗', 99);
INSERT INTO `iweb_areas` VALUES (2043, 2035, '伊金霍洛旗', 99);
INSERT INTO `iweb_areas` VALUES (2044, 1989, '呼伦贝尔市', 99);
INSERT INTO `iweb_areas` VALUES (2045, 2044, '海拉尔区', 99);
INSERT INTO `iweb_areas` VALUES (2046, 2044, '阿荣旗', 99);
INSERT INTO `iweb_areas` VALUES (2047, 2044, '莫力达瓦达斡尔族自治旗', 99);
INSERT INTO `iweb_areas` VALUES (2048, 2044, '鄂伦春自治旗', 99);
INSERT INTO `iweb_areas` VALUES (2049, 2044, '鄂温克族自治旗', 99);
INSERT INTO `iweb_areas` VALUES (2050, 2044, '陈巴尔虎旗', 99);
INSERT INTO `iweb_areas` VALUES (2051, 2044, '新巴尔虎左旗', 99);
INSERT INTO `iweb_areas` VALUES (2052, 2044, '新巴尔虎右旗', 99);
INSERT INTO `iweb_areas` VALUES (2053, 2044, '满洲里市', 99);
INSERT INTO `iweb_areas` VALUES (2054, 2044, '牙克石市', 99);
INSERT INTO `iweb_areas` VALUES (2055, 2044, '扎兰屯市', 99);
INSERT INTO `iweb_areas` VALUES (2056, 2044, '额尔古纳市', 99);
INSERT INTO `iweb_areas` VALUES (2057, 2044, '根河市', 99);
INSERT INTO `iweb_areas` VALUES (2058, 1989, '通辽市', 99);
INSERT INTO `iweb_areas` VALUES (2059, 2058, '科尔沁区', 99);
INSERT INTO `iweb_areas` VALUES (2060, 2058, '科尔沁左翼中旗', 99);
INSERT INTO `iweb_areas` VALUES (2061, 2058, '科尔沁左翼后旗', 99);
INSERT INTO `iweb_areas` VALUES (2062, 2058, '开鲁县', 99);
INSERT INTO `iweb_areas` VALUES (2063, 2058, '库伦旗', 99);
INSERT INTO `iweb_areas` VALUES (2064, 2058, '奈曼旗', 99);
INSERT INTO `iweb_areas` VALUES (2065, 2058, '扎鲁特旗', 99);
INSERT INTO `iweb_areas` VALUES (2066, 2058, '霍林郭勒市', 99);
INSERT INTO `iweb_areas` VALUES (2067, 1989, '乌海市', 99);
INSERT INTO `iweb_areas` VALUES (2068, 2067, '海勃湾区', 99);
INSERT INTO `iweb_areas` VALUES (2069, 2067, '海南区', 99);
INSERT INTO `iweb_areas` VALUES (2070, 2067, '乌达区', 99);
INSERT INTO `iweb_areas` VALUES (2071, 1989, '乌兰察布市', 99);
INSERT INTO `iweb_areas` VALUES (2072, 2071, '集宁区', 99);
INSERT INTO `iweb_areas` VALUES (2073, 2071, '卓资县', 99);
INSERT INTO `iweb_areas` VALUES (2074, 2071, '化德县', 99);
INSERT INTO `iweb_areas` VALUES (2075, 2071, '商都县', 99);
INSERT INTO `iweb_areas` VALUES (2076, 2071, '兴和县', 99);
INSERT INTO `iweb_areas` VALUES (2077, 2071, '凉城县', 99);
INSERT INTO `iweb_areas` VALUES (2078, 2071, '察哈尔右翼前旗', 99);
INSERT INTO `iweb_areas` VALUES (2079, 2071, '察哈尔右翼中旗', 99);
INSERT INTO `iweb_areas` VALUES (2080, 2071, '察哈尔右翼后旗', 99);
INSERT INTO `iweb_areas` VALUES (2081, 2071, '四子王旗', 99);
INSERT INTO `iweb_areas` VALUES (2082, 2071, '丰镇市', 99);
INSERT INTO `iweb_areas` VALUES (2083, 1989, '锡林郭勒盟', 99);
INSERT INTO `iweb_areas` VALUES (2084, 2083, '二连浩特市', 99);
INSERT INTO `iweb_areas` VALUES (2085, 2083, '锡林浩特市', 99);
INSERT INTO `iweb_areas` VALUES (2086, 2083, '阿巴嘎旗', 99);
INSERT INTO `iweb_areas` VALUES (2087, 2083, '苏尼特左旗', 99);
INSERT INTO `iweb_areas` VALUES (2088, 2083, '苏尼特右旗', 99);
INSERT INTO `iweb_areas` VALUES (2089, 2083, '东乌珠穆沁旗', 99);
INSERT INTO `iweb_areas` VALUES (2090, 2083, '西乌珠穆沁旗', 99);
INSERT INTO `iweb_areas` VALUES (2091, 2083, '太仆寺旗', 99);
INSERT INTO `iweb_areas` VALUES (2092, 2083, '镶黄旗', 99);
INSERT INTO `iweb_areas` VALUES (2093, 2083, '正镶白旗', 99);
INSERT INTO `iweb_areas` VALUES (2094, 2083, '正蓝旗', 99);
INSERT INTO `iweb_areas` VALUES (2095, 2083, '多伦县', 99);
INSERT INTO `iweb_areas` VALUES (2096, 1989, '兴安盟', 99);
INSERT INTO `iweb_areas` VALUES (2097, 2096, '乌兰浩特市', 99);
INSERT INTO `iweb_areas` VALUES (2098, 2096, '阿尔山市', 99);
INSERT INTO `iweb_areas` VALUES (2099, 2096, '科尔沁右翼前旗', 99);
INSERT INTO `iweb_areas` VALUES (2100, 2096, '科尔沁右翼中旗', 99);
INSERT INTO `iweb_areas` VALUES (2101, 2096, '扎赉特旗', 99);
INSERT INTO `iweb_areas` VALUES (2102, 2096, '突泉县', 99);
INSERT INTO `iweb_areas` VALUES (2103, 0, '宁夏', 99);
INSERT INTO `iweb_areas` VALUES (2104, 2103, '银川市', 99);
INSERT INTO `iweb_areas` VALUES (2105, 2104, '兴庆区', 99);
INSERT INTO `iweb_areas` VALUES (2106, 2104, '西夏区', 99);
INSERT INTO `iweb_areas` VALUES (2107, 2104, '金凤区', 99);
INSERT INTO `iweb_areas` VALUES (2108, 2104, '永宁县', 99);
INSERT INTO `iweb_areas` VALUES (2109, 2104, '贺兰县', 99);
INSERT INTO `iweb_areas` VALUES (2110, 2104, '灵武市', 99);
INSERT INTO `iweb_areas` VALUES (2111, 2103, '固原市', 99);
INSERT INTO `iweb_areas` VALUES (2112, 2111, '原州区', 99);
INSERT INTO `iweb_areas` VALUES (2113, 2111, '西吉县', 99);
INSERT INTO `iweb_areas` VALUES (2114, 2111, '隆德县', 99);
INSERT INTO `iweb_areas` VALUES (2115, 2111, '泾源县', 99);
INSERT INTO `iweb_areas` VALUES (2116, 2111, '彭阳县', 99);
INSERT INTO `iweb_areas` VALUES (2117, 2103, '石嘴山市', 99);
INSERT INTO `iweb_areas` VALUES (2118, 2117, '大武口区', 99);
INSERT INTO `iweb_areas` VALUES (2119, 2117, '惠农区', 99);
INSERT INTO `iweb_areas` VALUES (2120, 2117, '平罗县', 99);
INSERT INTO `iweb_areas` VALUES (2121, 2103, '吴忠市', 99);
INSERT INTO `iweb_areas` VALUES (2122, 2121, '利通区', 99);
INSERT INTO `iweb_areas` VALUES (2123, 2121, '盐池县', 99);
INSERT INTO `iweb_areas` VALUES (2124, 2121, '同心县', 99);
INSERT INTO `iweb_areas` VALUES (2125, 2121, '青铜峡市', 99);
INSERT INTO `iweb_areas` VALUES (2126, 2103, '中卫市', 99);
INSERT INTO `iweb_areas` VALUES (2127, 2126, '沙坡头区', 99);
INSERT INTO `iweb_areas` VALUES (2128, 2126, '中宁县', 99);
INSERT INTO `iweb_areas` VALUES (2129, 2126, '海原县', 99);
INSERT INTO `iweb_areas` VALUES (2130, 0, '青海', 99);
INSERT INTO `iweb_areas` VALUES (2131, 2130, '西宁市', 99);
INSERT INTO `iweb_areas` VALUES (2132, 2131, '城东区', 99);
INSERT INTO `iweb_areas` VALUES (2133, 2131, '城中区', 99);
INSERT INTO `iweb_areas` VALUES (2134, 2131, '城西区', 99);
INSERT INTO `iweb_areas` VALUES (2135, 2131, '城北区', 99);
INSERT INTO `iweb_areas` VALUES (2136, 2131, '大通回族土族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2137, 2131, '湟中县', 99);
INSERT INTO `iweb_areas` VALUES (2138, 2131, '湟源县', 99);
INSERT INTO `iweb_areas` VALUES (2139, 2130, '果洛藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2140, 2139, '玛沁县', 99);
INSERT INTO `iweb_areas` VALUES (2141, 2139, '班玛县', 99);
INSERT INTO `iweb_areas` VALUES (2142, 2139, '甘德县', 99);
INSERT INTO `iweb_areas` VALUES (2143, 2139, '达日县', 99);
INSERT INTO `iweb_areas` VALUES (2144, 2139, '久治县', 99);
INSERT INTO `iweb_areas` VALUES (2145, 2139, '玛多县', 99);
INSERT INTO `iweb_areas` VALUES (2146, 2130, '海北藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2147, 2146, '门源回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2148, 2146, '祁连县', 99);
INSERT INTO `iweb_areas` VALUES (2149, 2146, '海晏县', 99);
INSERT INTO `iweb_areas` VALUES (2150, 2146, '刚察县', 99);
INSERT INTO `iweb_areas` VALUES (2151, 2130, '海东地区', 99);
INSERT INTO `iweb_areas` VALUES (2152, 2151, '平安县', 99);
INSERT INTO `iweb_areas` VALUES (2153, 2151, '民和回族土族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2154, 2151, '乐都县', 99);
INSERT INTO `iweb_areas` VALUES (2155, 2151, '互助土族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2156, 2151, '化隆回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2157, 2151, '循化撒拉族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2158, 2130, '海南藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2159, 2158, '共和县', 99);
INSERT INTO `iweb_areas` VALUES (2160, 2158, '同德县', 99);
INSERT INTO `iweb_areas` VALUES (2161, 2158, '贵德县', 99);
INSERT INTO `iweb_areas` VALUES (2162, 2158, '兴海县', 99);
INSERT INTO `iweb_areas` VALUES (2163, 2158, '贵南县', 99);
INSERT INTO `iweb_areas` VALUES (2164, 2130, '海西蒙古族藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2165, 2164, '格尔木市', 99);
INSERT INTO `iweb_areas` VALUES (2166, 2164, '德令哈市', 99);
INSERT INTO `iweb_areas` VALUES (2167, 2164, '乌兰县', 99);
INSERT INTO `iweb_areas` VALUES (2168, 2164, '都兰县', 99);
INSERT INTO `iweb_areas` VALUES (2169, 2164, '天峻县', 99);
INSERT INTO `iweb_areas` VALUES (2170, 2130, '黄南藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2171, 2170, '同仁县', 99);
INSERT INTO `iweb_areas` VALUES (2172, 2170, '尖扎县', 99);
INSERT INTO `iweb_areas` VALUES (2173, 2170, '泽库县', 99);
INSERT INTO `iweb_areas` VALUES (2174, 2170, '河南蒙古族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2175, 2130, '玉树藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2176, 2175, '玉树县', 99);
INSERT INTO `iweb_areas` VALUES (2177, 2175, '杂多县', 99);
INSERT INTO `iweb_areas` VALUES (2178, 2175, '称多县', 99);
INSERT INTO `iweb_areas` VALUES (2179, 2175, '治多县', 99);
INSERT INTO `iweb_areas` VALUES (2180, 2175, '囊谦县', 99);
INSERT INTO `iweb_areas` VALUES (2181, 2175, '曲麻莱县', 99);
INSERT INTO `iweb_areas` VALUES (2182, 0, '山东', 99);
INSERT INTO `iweb_areas` VALUES (2183, 2182, '济南市', 99);
INSERT INTO `iweb_areas` VALUES (2184, 2183, '历下区', 99);
INSERT INTO `iweb_areas` VALUES (2185, 2183, '市中区', 99);
INSERT INTO `iweb_areas` VALUES (2186, 2183, '槐荫区', 99);
INSERT INTO `iweb_areas` VALUES (2187, 2183, '天桥区', 99);
INSERT INTO `iweb_areas` VALUES (2188, 2183, '历城区', 99);
INSERT INTO `iweb_areas` VALUES (2189, 2183, '长清区', 99);
INSERT INTO `iweb_areas` VALUES (2190, 2183, '平阴县', 99);
INSERT INTO `iweb_areas` VALUES (2191, 2183, '济阳县', 99);
INSERT INTO `iweb_areas` VALUES (2192, 2183, '商河县', 99);
INSERT INTO `iweb_areas` VALUES (2193, 2183, '章丘市', 99);
INSERT INTO `iweb_areas` VALUES (2194, 2182, '滨州市', 99);
INSERT INTO `iweb_areas` VALUES (2195, 2194, '滨城区', 99);
INSERT INTO `iweb_areas` VALUES (2196, 2194, '惠民县', 99);
INSERT INTO `iweb_areas` VALUES (2197, 2194, '阳信县', 99);
INSERT INTO `iweb_areas` VALUES (2198, 2194, '无棣县', 99);
INSERT INTO `iweb_areas` VALUES (2199, 2194, '沾化县', 99);
INSERT INTO `iweb_areas` VALUES (2200, 2194, '博兴县', 99);
INSERT INTO `iweb_areas` VALUES (2201, 2194, '邹平县', 99);
INSERT INTO `iweb_areas` VALUES (2202, 2182, '德州市', 99);
INSERT INTO `iweb_areas` VALUES (2203, 2202, '德城区', 99);
INSERT INTO `iweb_areas` VALUES (2204, 2202, '陵县', 99);
INSERT INTO `iweb_areas` VALUES (2205, 2202, '宁津县', 99);
INSERT INTO `iweb_areas` VALUES (2206, 2202, '庆云县', 99);
INSERT INTO `iweb_areas` VALUES (2207, 2202, '临邑县', 99);
INSERT INTO `iweb_areas` VALUES (2208, 2202, '齐河县', 99);
INSERT INTO `iweb_areas` VALUES (2209, 2202, '平原县', 99);
INSERT INTO `iweb_areas` VALUES (2210, 2202, '夏津县', 99);
INSERT INTO `iweb_areas` VALUES (2211, 2202, '武城县', 99);
INSERT INTO `iweb_areas` VALUES (2212, 2202, '乐陵市', 99);
INSERT INTO `iweb_areas` VALUES (2213, 2202, '禹城市', 99);
INSERT INTO `iweb_areas` VALUES (2214, 2182, '东营市', 99);
INSERT INTO `iweb_areas` VALUES (2215, 2214, '东营区', 99);
INSERT INTO `iweb_areas` VALUES (2216, 2214, '河口区', 99);
INSERT INTO `iweb_areas` VALUES (2217, 2214, '垦利县', 99);
INSERT INTO `iweb_areas` VALUES (2218, 2214, '利津县', 99);
INSERT INTO `iweb_areas` VALUES (2219, 2214, '广饶县', 99);
INSERT INTO `iweb_areas` VALUES (2220, 2182, '菏泽市', 99);
INSERT INTO `iweb_areas` VALUES (2221, 2220, '牡丹区', 99);
INSERT INTO `iweb_areas` VALUES (2222, 2220, '曹县', 99);
INSERT INTO `iweb_areas` VALUES (2223, 2220, '单县', 99);
INSERT INTO `iweb_areas` VALUES (2224, 2220, '成武县', 99);
INSERT INTO `iweb_areas` VALUES (2225, 2220, '巨野县', 99);
INSERT INTO `iweb_areas` VALUES (2226, 2220, '郓城县', 99);
INSERT INTO `iweb_areas` VALUES (2227, 2220, '鄄城县', 99);
INSERT INTO `iweb_areas` VALUES (2228, 2220, '定陶县', 99);
INSERT INTO `iweb_areas` VALUES (2229, 2220, '东明县', 99);
INSERT INTO `iweb_areas` VALUES (2230, 2182, '济宁市', 99);
INSERT INTO `iweb_areas` VALUES (2231, 2230, '市中区', 99);
INSERT INTO `iweb_areas` VALUES (2232, 2230, '任城区', 99);
INSERT INTO `iweb_areas` VALUES (2233, 2230, '微山县', 99);
INSERT INTO `iweb_areas` VALUES (2234, 2230, '鱼台县', 99);
INSERT INTO `iweb_areas` VALUES (2235, 2230, '金乡县', 99);
INSERT INTO `iweb_areas` VALUES (2236, 2230, '嘉祥县', 99);
INSERT INTO `iweb_areas` VALUES (2237, 2230, '汶上县', 99);
INSERT INTO `iweb_areas` VALUES (2238, 2230, '泗水县', 99);
INSERT INTO `iweb_areas` VALUES (2239, 2230, '梁山县', 99);
INSERT INTO `iweb_areas` VALUES (2240, 2230, '曲阜市', 99);
INSERT INTO `iweb_areas` VALUES (2241, 2230, '兖州市', 99);
INSERT INTO `iweb_areas` VALUES (2242, 2230, '邹城市', 99);
INSERT INTO `iweb_areas` VALUES (2243, 2182, '莱芜市', 99);
INSERT INTO `iweb_areas` VALUES (2244, 2243, '莱城区', 99);
INSERT INTO `iweb_areas` VALUES (2245, 2243, '钢城区', 99);
INSERT INTO `iweb_areas` VALUES (2246, 2182, '聊城市', 99);
INSERT INTO `iweb_areas` VALUES (2247, 2246, '东昌府区', 99);
INSERT INTO `iweb_areas` VALUES (2248, 2246, '阳谷县', 99);
INSERT INTO `iweb_areas` VALUES (2249, 2246, '莘县', 99);
INSERT INTO `iweb_areas` VALUES (2250, 2246, '茌平县', 99);
INSERT INTO `iweb_areas` VALUES (2251, 2246, '东阿县', 99);
INSERT INTO `iweb_areas` VALUES (2252, 2246, '冠县', 99);
INSERT INTO `iweb_areas` VALUES (2253, 2246, '高唐县', 99);
INSERT INTO `iweb_areas` VALUES (2254, 2246, '临清市', 99);
INSERT INTO `iweb_areas` VALUES (2255, 2182, '临沂市', 99);
INSERT INTO `iweb_areas` VALUES (2256, 2255, '兰山区', 99);
INSERT INTO `iweb_areas` VALUES (2257, 2255, '罗庄区', 99);
INSERT INTO `iweb_areas` VALUES (2258, 2255, '河东区', 99);
INSERT INTO `iweb_areas` VALUES (2259, 2255, '沂南县', 99);
INSERT INTO `iweb_areas` VALUES (2260, 2255, '郯城县', 99);
INSERT INTO `iweb_areas` VALUES (2261, 2255, '沂水县', 99);
INSERT INTO `iweb_areas` VALUES (2262, 2255, '苍山县', 99);
INSERT INTO `iweb_areas` VALUES (2263, 2255, '费县', 99);
INSERT INTO `iweb_areas` VALUES (2264, 2255, '平邑县', 99);
INSERT INTO `iweb_areas` VALUES (2265, 2255, '莒南县', 99);
INSERT INTO `iweb_areas` VALUES (2266, 2255, '蒙阴县', 99);
INSERT INTO `iweb_areas` VALUES (2267, 2255, '临沭县', 99);
INSERT INTO `iweb_areas` VALUES (2268, 2182, '青岛市', 99);
INSERT INTO `iweb_areas` VALUES (2269, 2268, '市南区', 99);
INSERT INTO `iweb_areas` VALUES (2270, 2268, '市北区', 99);
INSERT INTO `iweb_areas` VALUES (2271, 2268, '四方区', 99);
INSERT INTO `iweb_areas` VALUES (2272, 2268, '黄岛区', 99);
INSERT INTO `iweb_areas` VALUES (2273, 2268, '崂山区', 99);
INSERT INTO `iweb_areas` VALUES (2274, 2268, '李沧区', 99);
INSERT INTO `iweb_areas` VALUES (2275, 2268, '城阳区', 99);
INSERT INTO `iweb_areas` VALUES (2276, 2268, '胶州市', 99);
INSERT INTO `iweb_areas` VALUES (2277, 2268, '即墨市', 99);
INSERT INTO `iweb_areas` VALUES (2278, 2268, '平度市', 99);
INSERT INTO `iweb_areas` VALUES (2279, 2268, '胶南市', 99);
INSERT INTO `iweb_areas` VALUES (2280, 2268, '莱西市', 99);
INSERT INTO `iweb_areas` VALUES (2281, 2182, '日照市', 99);
INSERT INTO `iweb_areas` VALUES (2282, 2281, '东港区', 99);
INSERT INTO `iweb_areas` VALUES (2283, 2281, '岚山区', 99);
INSERT INTO `iweb_areas` VALUES (2284, 2281, '五莲县', 99);
INSERT INTO `iweb_areas` VALUES (2285, 2281, '莒县', 99);
INSERT INTO `iweb_areas` VALUES (2286, 2182, '泰安市', 99);
INSERT INTO `iweb_areas` VALUES (2287, 2286, '泰山区', 99);
INSERT INTO `iweb_areas` VALUES (2288, 2286, '岱岳区', 99);
INSERT INTO `iweb_areas` VALUES (2289, 2286, '宁阳县', 99);
INSERT INTO `iweb_areas` VALUES (2290, 2286, '东平县', 99);
INSERT INTO `iweb_areas` VALUES (2291, 2286, '新泰市', 99);
INSERT INTO `iweb_areas` VALUES (2292, 2286, '肥城市', 99);
INSERT INTO `iweb_areas` VALUES (2293, 2182, '威海市', 99);
INSERT INTO `iweb_areas` VALUES (2294, 2293, '环翠区', 99);
INSERT INTO `iweb_areas` VALUES (2295, 2293, '文登市', 99);
INSERT INTO `iweb_areas` VALUES (2296, 2293, '荣成市', 99);
INSERT INTO `iweb_areas` VALUES (2297, 2293, '乳山市', 99);
INSERT INTO `iweb_areas` VALUES (2298, 2182, '潍坊市', 99);
INSERT INTO `iweb_areas` VALUES (2299, 2298, '潍城区', 99);
INSERT INTO `iweb_areas` VALUES (2300, 2298, '寒亭区', 99);
INSERT INTO `iweb_areas` VALUES (2301, 2298, '坊子区', 99);
INSERT INTO `iweb_areas` VALUES (2302, 2298, '奎文区', 99);
INSERT INTO `iweb_areas` VALUES (2303, 2298, '临朐县', 99);
INSERT INTO `iweb_areas` VALUES (2304, 2298, '昌乐县', 99);
INSERT INTO `iweb_areas` VALUES (2305, 2298, '青州市', 99);
INSERT INTO `iweb_areas` VALUES (2306, 2298, '诸城市', 99);
INSERT INTO `iweb_areas` VALUES (2307, 2298, '寿光市', 99);
INSERT INTO `iweb_areas` VALUES (2308, 2298, '安丘市', 99);
INSERT INTO `iweb_areas` VALUES (2309, 2298, '高密市', 99);
INSERT INTO `iweb_areas` VALUES (2310, 2298, '昌邑市', 99);
INSERT INTO `iweb_areas` VALUES (2311, 2182, '烟台市', 99);
INSERT INTO `iweb_areas` VALUES (2312, 2311, '芝罘区', 99);
INSERT INTO `iweb_areas` VALUES (2313, 2311, '福山区', 99);
INSERT INTO `iweb_areas` VALUES (2314, 2311, '牟平区', 99);
INSERT INTO `iweb_areas` VALUES (2315, 2311, '莱山区', 99);
INSERT INTO `iweb_areas` VALUES (2316, 2311, '长岛县', 99);
INSERT INTO `iweb_areas` VALUES (2317, 2311, '龙口市', 99);
INSERT INTO `iweb_areas` VALUES (2318, 2311, '莱阳市', 99);
INSERT INTO `iweb_areas` VALUES (2319, 2311, '莱州市', 99);
INSERT INTO `iweb_areas` VALUES (2320, 2311, '蓬莱市', 99);
INSERT INTO `iweb_areas` VALUES (2321, 2311, '招远市', 99);
INSERT INTO `iweb_areas` VALUES (2322, 2311, '栖霞市', 99);
INSERT INTO `iweb_areas` VALUES (2323, 2311, '海阳市', 99);
INSERT INTO `iweb_areas` VALUES (2324, 2182, '枣庄市', 99);
INSERT INTO `iweb_areas` VALUES (2325, 2324, '市中区', 99);
INSERT INTO `iweb_areas` VALUES (2326, 2324, '薛城区', 99);
INSERT INTO `iweb_areas` VALUES (2327, 2324, '峄城区', 99);
INSERT INTO `iweb_areas` VALUES (2328, 2324, '台儿庄区', 99);
INSERT INTO `iweb_areas` VALUES (2329, 2324, '山亭区', 99);
INSERT INTO `iweb_areas` VALUES (2330, 2324, '滕州市', 99);
INSERT INTO `iweb_areas` VALUES (2331, 2182, '淄博市', 99);
INSERT INTO `iweb_areas` VALUES (2332, 2331, '淄川区', 99);
INSERT INTO `iweb_areas` VALUES (2333, 2331, '张店区', 99);
INSERT INTO `iweb_areas` VALUES (2334, 2331, '博山区', 99);
INSERT INTO `iweb_areas` VALUES (2335, 2331, '临淄区', 99);
INSERT INTO `iweb_areas` VALUES (2336, 2331, '周村区', 99);
INSERT INTO `iweb_areas` VALUES (2337, 2331, '桓台县', 99);
INSERT INTO `iweb_areas` VALUES (2338, 2331, '高青县', 99);
INSERT INTO `iweb_areas` VALUES (2339, 2331, '沂源县', 99);
INSERT INTO `iweb_areas` VALUES (2340, 0, '山西', 99);
INSERT INTO `iweb_areas` VALUES (2341, 2340, '太原市', 99);
INSERT INTO `iweb_areas` VALUES (2342, 2341, '小店区', 99);
INSERT INTO `iweb_areas` VALUES (2343, 2341, '迎泽区', 99);
INSERT INTO `iweb_areas` VALUES (2344, 2341, '杏花岭区', 99);
INSERT INTO `iweb_areas` VALUES (2345, 2341, '尖草坪区', 99);
INSERT INTO `iweb_areas` VALUES (2346, 2341, '万柏林区', 99);
INSERT INTO `iweb_areas` VALUES (2347, 2341, '晋源区', 99);
INSERT INTO `iweb_areas` VALUES (2348, 2341, '清徐县', 99);
INSERT INTO `iweb_areas` VALUES (2349, 2341, '阳曲县', 99);
INSERT INTO `iweb_areas` VALUES (2350, 2341, '娄烦县', 99);
INSERT INTO `iweb_areas` VALUES (2351, 2341, '古交市', 99);
INSERT INTO `iweb_areas` VALUES (2352, 2340, '长治市', 99);
INSERT INTO `iweb_areas` VALUES (2353, 2352, '城区', 99);
INSERT INTO `iweb_areas` VALUES (2354, 2352, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (2355, 2352, '长治县', 99);
INSERT INTO `iweb_areas` VALUES (2356, 2352, '襄垣县', 99);
INSERT INTO `iweb_areas` VALUES (2357, 2352, '屯留县', 99);
INSERT INTO `iweb_areas` VALUES (2358, 2352, '平顺县', 99);
INSERT INTO `iweb_areas` VALUES (2359, 2352, '黎城县', 99);
INSERT INTO `iweb_areas` VALUES (2360, 2352, '壶关县', 99);
INSERT INTO `iweb_areas` VALUES (2361, 2352, '长子县', 99);
INSERT INTO `iweb_areas` VALUES (2362, 2352, '武乡县', 99);
INSERT INTO `iweb_areas` VALUES (2363, 2352, '沁县', 99);
INSERT INTO `iweb_areas` VALUES (2364, 2352, '沁源县', 99);
INSERT INTO `iweb_areas` VALUES (2365, 2352, '潞城市', 99);
INSERT INTO `iweb_areas` VALUES (2366, 2340, '大同市', 99);
INSERT INTO `iweb_areas` VALUES (2367, 2366, '城区', 99);
INSERT INTO `iweb_areas` VALUES (2368, 2366, '矿区', 99);
INSERT INTO `iweb_areas` VALUES (2369, 2366, '南郊区', 99);
INSERT INTO `iweb_areas` VALUES (2370, 2366, '新荣区', 99);
INSERT INTO `iweb_areas` VALUES (2371, 2366, '阳高县', 99);
INSERT INTO `iweb_areas` VALUES (2372, 2366, '天镇县', 99);
INSERT INTO `iweb_areas` VALUES (2373, 2366, '广灵县', 99);
INSERT INTO `iweb_areas` VALUES (2374, 2366, '灵丘县', 99);
INSERT INTO `iweb_areas` VALUES (2375, 2366, '浑源县', 99);
INSERT INTO `iweb_areas` VALUES (2376, 2366, '左云县', 99);
INSERT INTO `iweb_areas` VALUES (2377, 2366, '大同县', 99);
INSERT INTO `iweb_areas` VALUES (2378, 2340, '晋城市', 99);
INSERT INTO `iweb_areas` VALUES (2379, 2378, '城区', 99);
INSERT INTO `iweb_areas` VALUES (2380, 2378, '沁水县', 99);
INSERT INTO `iweb_areas` VALUES (2381, 2378, '阳城县', 99);
INSERT INTO `iweb_areas` VALUES (2382, 2378, '陵川县', 99);
INSERT INTO `iweb_areas` VALUES (2383, 2378, '泽州县', 99);
INSERT INTO `iweb_areas` VALUES (2384, 2378, '高平市', 99);
INSERT INTO `iweb_areas` VALUES (2385, 2340, '晋中市', 99);
INSERT INTO `iweb_areas` VALUES (2386, 2385, '榆次区', 99);
INSERT INTO `iweb_areas` VALUES (2387, 2385, '榆社县', 99);
INSERT INTO `iweb_areas` VALUES (2388, 2385, '左权县', 99);
INSERT INTO `iweb_areas` VALUES (2389, 2385, '和顺县', 99);
INSERT INTO `iweb_areas` VALUES (2390, 2385, '昔阳县', 99);
INSERT INTO `iweb_areas` VALUES (2391, 2385, '寿阳县', 99);
INSERT INTO `iweb_areas` VALUES (2392, 2385, '太谷县', 99);
INSERT INTO `iweb_areas` VALUES (2393, 2385, '祁县', 99);
INSERT INTO `iweb_areas` VALUES (2394, 2385, '平遥县', 99);
INSERT INTO `iweb_areas` VALUES (2395, 2385, '灵石县', 99);
INSERT INTO `iweb_areas` VALUES (2396, 2385, '介休市', 99);
INSERT INTO `iweb_areas` VALUES (2397, 2340, '临汾市', 99);
INSERT INTO `iweb_areas` VALUES (2398, 2397, '尧都区', 99);
INSERT INTO `iweb_areas` VALUES (2399, 2397, '曲沃县', 99);
INSERT INTO `iweb_areas` VALUES (2400, 2397, '翼城县', 99);
INSERT INTO `iweb_areas` VALUES (2401, 2397, '襄汾县', 99);
INSERT INTO `iweb_areas` VALUES (2402, 2397, '洪洞县', 99);
INSERT INTO `iweb_areas` VALUES (2403, 2397, '古县', 99);
INSERT INTO `iweb_areas` VALUES (2404, 2397, '安泽县', 99);
INSERT INTO `iweb_areas` VALUES (2405, 2397, '浮山县', 99);
INSERT INTO `iweb_areas` VALUES (2406, 2397, '吉县', 99);
INSERT INTO `iweb_areas` VALUES (2407, 2397, '乡宁县', 99);
INSERT INTO `iweb_areas` VALUES (2408, 2397, '大宁县', 99);
INSERT INTO `iweb_areas` VALUES (2409, 2397, '隰县', 99);
INSERT INTO `iweb_areas` VALUES (2410, 2397, '永和县', 99);
INSERT INTO `iweb_areas` VALUES (2411, 2397, '蒲县', 99);
INSERT INTO `iweb_areas` VALUES (2412, 2397, '汾西县', 99);
INSERT INTO `iweb_areas` VALUES (2413, 2397, '侯马市', 99);
INSERT INTO `iweb_areas` VALUES (2414, 2397, '霍州市', 99);
INSERT INTO `iweb_areas` VALUES (2415, 2340, '吕梁市', 99);
INSERT INTO `iweb_areas` VALUES (2416, 2415, '离石区', 99);
INSERT INTO `iweb_areas` VALUES (2417, 2415, '文水县', 99);
INSERT INTO `iweb_areas` VALUES (2418, 2415, '交城县', 99);
INSERT INTO `iweb_areas` VALUES (2419, 2415, '兴县', 99);
INSERT INTO `iweb_areas` VALUES (2420, 2415, '临县', 99);
INSERT INTO `iweb_areas` VALUES (2421, 2415, '柳林县', 99);
INSERT INTO `iweb_areas` VALUES (2422, 2415, '石楼县', 99);
INSERT INTO `iweb_areas` VALUES (2423, 2415, '岚县', 99);
INSERT INTO `iweb_areas` VALUES (2424, 2415, '方山县', 99);
INSERT INTO `iweb_areas` VALUES (2425, 2415, '中阳县', 99);
INSERT INTO `iweb_areas` VALUES (2426, 2415, '交口县', 99);
INSERT INTO `iweb_areas` VALUES (2427, 2415, '孝义市', 99);
INSERT INTO `iweb_areas` VALUES (2428, 2415, '汾阳市', 99);
INSERT INTO `iweb_areas` VALUES (2429, 2340, '朔州市', 99);
INSERT INTO `iweb_areas` VALUES (2430, 2429, '朔城区', 99);
INSERT INTO `iweb_areas` VALUES (2431, 2429, '平鲁区', 99);
INSERT INTO `iweb_areas` VALUES (2432, 2429, '山阴县', 99);
INSERT INTO `iweb_areas` VALUES (2433, 2429, '应县', 99);
INSERT INTO `iweb_areas` VALUES (2434, 2429, '右玉县', 99);
INSERT INTO `iweb_areas` VALUES (2435, 2429, '怀仁县', 99);
INSERT INTO `iweb_areas` VALUES (2436, 2340, '忻州市', 99);
INSERT INTO `iweb_areas` VALUES (2437, 2436, '忻府区', 99);
INSERT INTO `iweb_areas` VALUES (2438, 2436, '定襄县', 99);
INSERT INTO `iweb_areas` VALUES (2439, 2436, '五台县', 99);
INSERT INTO `iweb_areas` VALUES (2440, 2436, '代县', 99);
INSERT INTO `iweb_areas` VALUES (2441, 2436, '繁峙县', 99);
INSERT INTO `iweb_areas` VALUES (2442, 2436, '宁武县', 99);
INSERT INTO `iweb_areas` VALUES (2443, 2436, '静乐县', 99);
INSERT INTO `iweb_areas` VALUES (2444, 2436, '神池县', 99);
INSERT INTO `iweb_areas` VALUES (2445, 2436, '五寨县', 99);
INSERT INTO `iweb_areas` VALUES (2446, 2436, '岢岚县', 99);
INSERT INTO `iweb_areas` VALUES (2447, 2436, '河曲县', 99);
INSERT INTO `iweb_areas` VALUES (2448, 2436, '保德县', 99);
INSERT INTO `iweb_areas` VALUES (2449, 2436, '偏关县', 99);
INSERT INTO `iweb_areas` VALUES (2450, 2436, '原平市', 99);
INSERT INTO `iweb_areas` VALUES (2451, 2340, '阳泉市', 99);
INSERT INTO `iweb_areas` VALUES (2452, 2451, '城区', 99);
INSERT INTO `iweb_areas` VALUES (2453, 2451, '矿区', 99);
INSERT INTO `iweb_areas` VALUES (2454, 2451, '郊区', 99);
INSERT INTO `iweb_areas` VALUES (2455, 2451, '平定县', 99);
INSERT INTO `iweb_areas` VALUES (2456, 2451, '盂县', 99);
INSERT INTO `iweb_areas` VALUES (2457, 2340, '运城市', 99);
INSERT INTO `iweb_areas` VALUES (2458, 2457, '盐湖区', 99);
INSERT INTO `iweb_areas` VALUES (2459, 2457, '临猗县', 99);
INSERT INTO `iweb_areas` VALUES (2460, 2457, '万荣县', 99);
INSERT INTO `iweb_areas` VALUES (2461, 2457, '闻喜县', 99);
INSERT INTO `iweb_areas` VALUES (2462, 2457, '稷山县', 99);
INSERT INTO `iweb_areas` VALUES (2463, 2457, '新绛县', 99);
INSERT INTO `iweb_areas` VALUES (2464, 2457, '绛县', 99);
INSERT INTO `iweb_areas` VALUES (2465, 2457, '垣曲县', 99);
INSERT INTO `iweb_areas` VALUES (2466, 2457, '夏县', 99);
INSERT INTO `iweb_areas` VALUES (2467, 2457, '平陆县', 99);
INSERT INTO `iweb_areas` VALUES (2468, 2457, '芮城县', 99);
INSERT INTO `iweb_areas` VALUES (2469, 2457, '永济市', 99);
INSERT INTO `iweb_areas` VALUES (2470, 2457, '河津市', 99);
INSERT INTO `iweb_areas` VALUES (2471, 0, '陕西', 99);
INSERT INTO `iweb_areas` VALUES (2472, 2471, '西安市', 99);
INSERT INTO `iweb_areas` VALUES (2473, 2472, '新城区', 99);
INSERT INTO `iweb_areas` VALUES (2474, 2472, '碑林区', 99);
INSERT INTO `iweb_areas` VALUES (2475, 2472, '莲湖区', 99);
INSERT INTO `iweb_areas` VALUES (2476, 2472, '灞桥区', 99);
INSERT INTO `iweb_areas` VALUES (2477, 2472, '未央区', 99);
INSERT INTO `iweb_areas` VALUES (2478, 2472, '雁塔区', 99);
INSERT INTO `iweb_areas` VALUES (2479, 2472, '阎良区', 99);
INSERT INTO `iweb_areas` VALUES (2480, 2472, '临潼区', 99);
INSERT INTO `iweb_areas` VALUES (2481, 2472, '长安区', 99);
INSERT INTO `iweb_areas` VALUES (2482, 2472, '蓝田县', 99);
INSERT INTO `iweb_areas` VALUES (2483, 2472, '周至县', 99);
INSERT INTO `iweb_areas` VALUES (2484, 2472, '户县', 99);
INSERT INTO `iweb_areas` VALUES (2485, 2472, '高陵县', 99);
INSERT INTO `iweb_areas` VALUES (2486, 2471, '安康市', 99);
INSERT INTO `iweb_areas` VALUES (2487, 2486, '汉滨区', 99);
INSERT INTO `iweb_areas` VALUES (2488, 2486, '汉阴县', 99);
INSERT INTO `iweb_areas` VALUES (2489, 2486, '石泉县', 99);
INSERT INTO `iweb_areas` VALUES (2490, 2486, '宁陕县', 99);
INSERT INTO `iweb_areas` VALUES (2491, 2486, '紫阳县', 99);
INSERT INTO `iweb_areas` VALUES (2492, 2486, '岚皋县', 99);
INSERT INTO `iweb_areas` VALUES (2493, 2486, '平利县', 99);
INSERT INTO `iweb_areas` VALUES (2494, 2486, '镇坪县', 99);
INSERT INTO `iweb_areas` VALUES (2495, 2486, '旬阳县', 99);
INSERT INTO `iweb_areas` VALUES (2496, 2486, '白河县', 99);
INSERT INTO `iweb_areas` VALUES (2497, 2471, '宝鸡市', 99);
INSERT INTO `iweb_areas` VALUES (2498, 2497, '渭滨区', 99);
INSERT INTO `iweb_areas` VALUES (2499, 2497, '金台区', 99);
INSERT INTO `iweb_areas` VALUES (2500, 2497, '陈仓区', 99);
INSERT INTO `iweb_areas` VALUES (2501, 2497, '凤翔县', 99);
INSERT INTO `iweb_areas` VALUES (2502, 2497, '岐山县', 99);
INSERT INTO `iweb_areas` VALUES (2503, 2497, '扶风县', 99);
INSERT INTO `iweb_areas` VALUES (2504, 2497, '眉县', 99);
INSERT INTO `iweb_areas` VALUES (2505, 2497, '陇县', 99);
INSERT INTO `iweb_areas` VALUES (2506, 2497, '千阳县', 99);
INSERT INTO `iweb_areas` VALUES (2507, 2497, '麟游县', 99);
INSERT INTO `iweb_areas` VALUES (2508, 2497, '凤县', 99);
INSERT INTO `iweb_areas` VALUES (2509, 2497, '太白县', 99);
INSERT INTO `iweb_areas` VALUES (2510, 2471, '汉中市', 99);
INSERT INTO `iweb_areas` VALUES (2511, 2510, '汉台区', 99);
INSERT INTO `iweb_areas` VALUES (2512, 2510, '南郑县', 99);
INSERT INTO `iweb_areas` VALUES (2513, 2510, '城固县', 99);
INSERT INTO `iweb_areas` VALUES (2514, 2510, '洋县', 99);
INSERT INTO `iweb_areas` VALUES (2515, 2510, '西乡县', 99);
INSERT INTO `iweb_areas` VALUES (2516, 2510, '勉县', 99);
INSERT INTO `iweb_areas` VALUES (2517, 2510, '宁强县', 99);
INSERT INTO `iweb_areas` VALUES (2518, 2510, '略阳县', 99);
INSERT INTO `iweb_areas` VALUES (2519, 2510, '镇巴县', 99);
INSERT INTO `iweb_areas` VALUES (2520, 2510, '留坝县', 99);
INSERT INTO `iweb_areas` VALUES (2521, 2510, '佛坪县', 99);
INSERT INTO `iweb_areas` VALUES (2522, 2471, '商洛市', 99);
INSERT INTO `iweb_areas` VALUES (2523, 2522, '商州区', 99);
INSERT INTO `iweb_areas` VALUES (2524, 2522, '洛南县', 99);
INSERT INTO `iweb_areas` VALUES (2525, 2522, '丹凤县', 99);
INSERT INTO `iweb_areas` VALUES (2526, 2522, '商南县', 99);
INSERT INTO `iweb_areas` VALUES (2527, 2522, '山阳县', 99);
INSERT INTO `iweb_areas` VALUES (2528, 2522, '镇安县', 99);
INSERT INTO `iweb_areas` VALUES (2529, 2522, '柞水县', 99);
INSERT INTO `iweb_areas` VALUES (2530, 2471, '铜川市', 99);
INSERT INTO `iweb_areas` VALUES (2531, 2530, '王益区', 99);
INSERT INTO `iweb_areas` VALUES (2532, 2530, '印台区', 99);
INSERT INTO `iweb_areas` VALUES (2533, 2530, '耀州区', 99);
INSERT INTO `iweb_areas` VALUES (2534, 2530, '宜君县', 99);
INSERT INTO `iweb_areas` VALUES (2535, 2471, '渭南市', 99);
INSERT INTO `iweb_areas` VALUES (2536, 2535, '临渭区', 99);
INSERT INTO `iweb_areas` VALUES (2537, 2535, '华县', 99);
INSERT INTO `iweb_areas` VALUES (2538, 2535, '潼关县', 99);
INSERT INTO `iweb_areas` VALUES (2539, 2535, '大荔县', 99);
INSERT INTO `iweb_areas` VALUES (2540, 2535, '合阳县', 99);
INSERT INTO `iweb_areas` VALUES (2541, 2535, '澄城县', 99);
INSERT INTO `iweb_areas` VALUES (2542, 2535, '蒲城县', 99);
INSERT INTO `iweb_areas` VALUES (2543, 2535, '白水县', 99);
INSERT INTO `iweb_areas` VALUES (2544, 2535, '富平县', 99);
INSERT INTO `iweb_areas` VALUES (2545, 2535, '韩城市', 99);
INSERT INTO `iweb_areas` VALUES (2546, 2535, '华阴市', 99);
INSERT INTO `iweb_areas` VALUES (2547, 2471, '咸阳市', 99);
INSERT INTO `iweb_areas` VALUES (2548, 2547, '秦都区', 99);
INSERT INTO `iweb_areas` VALUES (2549, 2547, '杨凌区', 99);
INSERT INTO `iweb_areas` VALUES (2550, 2547, '渭城区', 99);
INSERT INTO `iweb_areas` VALUES (2551, 2547, '三原县', 99);
INSERT INTO `iweb_areas` VALUES (2552, 2547, '泾阳县', 99);
INSERT INTO `iweb_areas` VALUES (2553, 2547, '乾县', 99);
INSERT INTO `iweb_areas` VALUES (2554, 2547, '礼泉县', 99);
INSERT INTO `iweb_areas` VALUES (2555, 2547, '永寿县', 99);
INSERT INTO `iweb_areas` VALUES (2556, 2547, '彬县', 99);
INSERT INTO `iweb_areas` VALUES (2557, 2547, '长武县', 99);
INSERT INTO `iweb_areas` VALUES (2558, 2547, '旬邑县', 99);
INSERT INTO `iweb_areas` VALUES (2559, 2547, '淳化县', 99);
INSERT INTO `iweb_areas` VALUES (2560, 2547, '武功县', 99);
INSERT INTO `iweb_areas` VALUES (2561, 2547, '兴平市', 99);
INSERT INTO `iweb_areas` VALUES (2562, 2471, '延安市', 99);
INSERT INTO `iweb_areas` VALUES (2563, 2562, '宝塔区', 99);
INSERT INTO `iweb_areas` VALUES (2564, 2562, '延长县', 99);
INSERT INTO `iweb_areas` VALUES (2565, 2562, '延川县', 99);
INSERT INTO `iweb_areas` VALUES (2566, 2562, '子长县', 99);
INSERT INTO `iweb_areas` VALUES (2567, 2562, '安塞县', 99);
INSERT INTO `iweb_areas` VALUES (2568, 2562, '志丹县', 99);
INSERT INTO `iweb_areas` VALUES (2569, 2562, '吴旗县', 99);
INSERT INTO `iweb_areas` VALUES (2570, 2562, '甘泉县', 99);
INSERT INTO `iweb_areas` VALUES (2571, 2562, '富县', 99);
INSERT INTO `iweb_areas` VALUES (2572, 2562, '洛川县', 99);
INSERT INTO `iweb_areas` VALUES (2573, 2562, '宜川县', 99);
INSERT INTO `iweb_areas` VALUES (2574, 2562, '黄龙县', 99);
INSERT INTO `iweb_areas` VALUES (2575, 2562, '黄陵县', 99);
INSERT INTO `iweb_areas` VALUES (2576, 2471, '榆林市', 99);
INSERT INTO `iweb_areas` VALUES (2577, 2576, '榆阳区', 99);
INSERT INTO `iweb_areas` VALUES (2578, 2576, '神木县', 99);
INSERT INTO `iweb_areas` VALUES (2579, 2576, '府谷县', 99);
INSERT INTO `iweb_areas` VALUES (2580, 2576, '横山县', 99);
INSERT INTO `iweb_areas` VALUES (2581, 2576, '靖边县', 99);
INSERT INTO `iweb_areas` VALUES (2582, 2576, '定边县', 99);
INSERT INTO `iweb_areas` VALUES (2583, 2576, '绥德县', 99);
INSERT INTO `iweb_areas` VALUES (2584, 2576, '米脂县', 99);
INSERT INTO `iweb_areas` VALUES (2585, 2576, '佳县', 99);
INSERT INTO `iweb_areas` VALUES (2586, 2576, '吴堡县', 99);
INSERT INTO `iweb_areas` VALUES (2587, 2576, '清涧县', 99);
INSERT INTO `iweb_areas` VALUES (2588, 2576, '子洲县', 99);
INSERT INTO `iweb_areas` VALUES (2589, 0, '四川', 99);
INSERT INTO `iweb_areas` VALUES (2590, 2589, '成都市', 99);
INSERT INTO `iweb_areas` VALUES (2591, 2590, '锦江区', 99);
INSERT INTO `iweb_areas` VALUES (2592, 2590, '青羊区', 99);
INSERT INTO `iweb_areas` VALUES (2593, 2590, '金牛区', 99);
INSERT INTO `iweb_areas` VALUES (2594, 2590, '武侯区', 99);
INSERT INTO `iweb_areas` VALUES (2595, 2590, '成华区', 99);
INSERT INTO `iweb_areas` VALUES (2596, 2590, '龙泉驿区', 99);
INSERT INTO `iweb_areas` VALUES (2597, 2590, '青白江区', 99);
INSERT INTO `iweb_areas` VALUES (2598, 2590, '新都区', 99);
INSERT INTO `iweb_areas` VALUES (2599, 2590, '温江区', 99);
INSERT INTO `iweb_areas` VALUES (2600, 2590, '金堂县', 99);
INSERT INTO `iweb_areas` VALUES (2601, 2590, '双流县', 99);
INSERT INTO `iweb_areas` VALUES (2602, 2590, '郫县', 99);
INSERT INTO `iweb_areas` VALUES (2603, 2590, '大邑县', 99);
INSERT INTO `iweb_areas` VALUES (2604, 2590, '蒲江县', 99);
INSERT INTO `iweb_areas` VALUES (2605, 2590, '新津县', 99);
INSERT INTO `iweb_areas` VALUES (2606, 2590, '都江堰市', 99);
INSERT INTO `iweb_areas` VALUES (2607, 2590, '彭州市', 99);
INSERT INTO `iweb_areas` VALUES (2608, 2590, '邛崃市', 99);
INSERT INTO `iweb_areas` VALUES (2609, 2590, '崇州市', 99);
INSERT INTO `iweb_areas` VALUES (2610, 2589, '阿坝藏族羌族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2611, 2610, '汶川县', 99);
INSERT INTO `iweb_areas` VALUES (2612, 2610, '理县', 99);
INSERT INTO `iweb_areas` VALUES (2613, 2610, '茂县', 99);
INSERT INTO `iweb_areas` VALUES (2614, 2610, '松潘县', 99);
INSERT INTO `iweb_areas` VALUES (2615, 2610, '九寨沟县', 99);
INSERT INTO `iweb_areas` VALUES (2616, 2610, '金川县', 99);
INSERT INTO `iweb_areas` VALUES (2617, 2610, '小金县', 99);
INSERT INTO `iweb_areas` VALUES (2618, 2610, '黑水县', 99);
INSERT INTO `iweb_areas` VALUES (2619, 2610, '马尔康县', 99);
INSERT INTO `iweb_areas` VALUES (2620, 2610, '壤塘县', 99);
INSERT INTO `iweb_areas` VALUES (2621, 2610, '阿坝县', 99);
INSERT INTO `iweb_areas` VALUES (2622, 2610, '若尔盖县', 99);
INSERT INTO `iweb_areas` VALUES (2623, 2610, '红原县', 99);
INSERT INTO `iweb_areas` VALUES (2624, 2589, '巴中市', 99);
INSERT INTO `iweb_areas` VALUES (2625, 2624, '巴州区', 99);
INSERT INTO `iweb_areas` VALUES (2626, 2624, '通江县', 99);
INSERT INTO `iweb_areas` VALUES (2627, 2624, '南江县', 99);
INSERT INTO `iweb_areas` VALUES (2628, 2624, '平昌县', 99);
INSERT INTO `iweb_areas` VALUES (2629, 2589, '达州市', 99);
INSERT INTO `iweb_areas` VALUES (2630, 2629, '通川区', 99);
INSERT INTO `iweb_areas` VALUES (2631, 2629, '达县', 99);
INSERT INTO `iweb_areas` VALUES (2632, 2629, '宣汉县', 99);
INSERT INTO `iweb_areas` VALUES (2633, 2629, '开江县', 99);
INSERT INTO `iweb_areas` VALUES (2634, 2629, '大竹县', 99);
INSERT INTO `iweb_areas` VALUES (2635, 2629, '渠县', 99);
INSERT INTO `iweb_areas` VALUES (2636, 2629, '万源市', 99);
INSERT INTO `iweb_areas` VALUES (2637, 2589, '德阳市', 99);
INSERT INTO `iweb_areas` VALUES (2638, 2637, '旌阳区', 99);
INSERT INTO `iweb_areas` VALUES (2639, 2637, '中江县', 99);
INSERT INTO `iweb_areas` VALUES (2640, 2637, '罗江县', 99);
INSERT INTO `iweb_areas` VALUES (2641, 2637, '广汉市', 99);
INSERT INTO `iweb_areas` VALUES (2642, 2637, '什邡市', 99);
INSERT INTO `iweb_areas` VALUES (2643, 2637, '绵竹市', 99);
INSERT INTO `iweb_areas` VALUES (2644, 2589, '甘孜藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2645, 2644, '康定县', 99);
INSERT INTO `iweb_areas` VALUES (2646, 2644, '泸定县', 99);
INSERT INTO `iweb_areas` VALUES (2647, 2644, '丹巴县', 99);
INSERT INTO `iweb_areas` VALUES (2648, 2644, '九龙县', 99);
INSERT INTO `iweb_areas` VALUES (2649, 2644, '雅江县', 99);
INSERT INTO `iweb_areas` VALUES (2650, 2644, '道孚县', 99);
INSERT INTO `iweb_areas` VALUES (2651, 2644, '炉霍县', 99);
INSERT INTO `iweb_areas` VALUES (2652, 2644, '甘孜县', 99);
INSERT INTO `iweb_areas` VALUES (2653, 2644, '新龙县', 99);
INSERT INTO `iweb_areas` VALUES (2654, 2644, '德格县', 99);
INSERT INTO `iweb_areas` VALUES (2655, 2644, '白玉县', 99);
INSERT INTO `iweb_areas` VALUES (2656, 2644, '石渠县', 99);
INSERT INTO `iweb_areas` VALUES (2657, 2644, '色达县', 99);
INSERT INTO `iweb_areas` VALUES (2658, 2644, '理塘县', 99);
INSERT INTO `iweb_areas` VALUES (2659, 2644, '巴塘县', 99);
INSERT INTO `iweb_areas` VALUES (2660, 2644, '乡城县', 99);
INSERT INTO `iweb_areas` VALUES (2661, 2644, '稻城县', 99);
INSERT INTO `iweb_areas` VALUES (2662, 2644, '得荣县', 99);
INSERT INTO `iweb_areas` VALUES (2663, 2589, '广安市', 99);
INSERT INTO `iweb_areas` VALUES (2664, 2663, '广安区', 99);
INSERT INTO `iweb_areas` VALUES (2665, 2663, '岳池县', 99);
INSERT INTO `iweb_areas` VALUES (2666, 2663, '武胜县', 99);
INSERT INTO `iweb_areas` VALUES (2667, 2663, '邻水县', 99);
INSERT INTO `iweb_areas` VALUES (2668, 2663, '华莹市', 99);
INSERT INTO `iweb_areas` VALUES (2669, 2589, '广元市', 99);
INSERT INTO `iweb_areas` VALUES (2670, 2669, '市中区', 99);
INSERT INTO `iweb_areas` VALUES (2671, 2669, '元坝区', 99);
INSERT INTO `iweb_areas` VALUES (2672, 2669, '朝天区', 99);
INSERT INTO `iweb_areas` VALUES (2673, 2669, '旺苍县', 99);
INSERT INTO `iweb_areas` VALUES (2674, 2669, '青川县', 99);
INSERT INTO `iweb_areas` VALUES (2675, 2669, '剑阁县', 99);
INSERT INTO `iweb_areas` VALUES (2676, 2669, '苍溪县', 99);
INSERT INTO `iweb_areas` VALUES (2677, 2589, '乐山市', 99);
INSERT INTO `iweb_areas` VALUES (2678, 2677, '市中区', 99);
INSERT INTO `iweb_areas` VALUES (2679, 2677, '沙湾区', 99);
INSERT INTO `iweb_areas` VALUES (2680, 2677, '五通桥区', 99);
INSERT INTO `iweb_areas` VALUES (2681, 2677, '金口河区', 99);
INSERT INTO `iweb_areas` VALUES (2682, 2677, '犍为县', 99);
INSERT INTO `iweb_areas` VALUES (2683, 2677, '井研县', 99);
INSERT INTO `iweb_areas` VALUES (2684, 2677, '夹江县', 99);
INSERT INTO `iweb_areas` VALUES (2685, 2677, '沐川县', 99);
INSERT INTO `iweb_areas` VALUES (2686, 2677, '峨边彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2687, 2677, '马边彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2688, 2677, '峨眉山市', 99);
INSERT INTO `iweb_areas` VALUES (2689, 2589, '凉山彝族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2690, 2689, '西昌市', 99);
INSERT INTO `iweb_areas` VALUES (2691, 2689, '木里藏族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2692, 2689, '盐源县', 99);
INSERT INTO `iweb_areas` VALUES (2693, 2689, '德昌县', 99);
INSERT INTO `iweb_areas` VALUES (2694, 2689, '会理县', 99);
INSERT INTO `iweb_areas` VALUES (2695, 2689, '会东县', 99);
INSERT INTO `iweb_areas` VALUES (2696, 2689, '宁南县', 99);
INSERT INTO `iweb_areas` VALUES (2697, 2689, '普格县', 99);
INSERT INTO `iweb_areas` VALUES (2698, 2689, '布拖县', 99);
INSERT INTO `iweb_areas` VALUES (2699, 2689, '金阳县', 99);
INSERT INTO `iweb_areas` VALUES (2700, 2689, '昭觉县', 99);
INSERT INTO `iweb_areas` VALUES (2701, 2689, '喜德县', 99);
INSERT INTO `iweb_areas` VALUES (2702, 2689, '冕宁县', 99);
INSERT INTO `iweb_areas` VALUES (2703, 2689, '越西县', 99);
INSERT INTO `iweb_areas` VALUES (2704, 2689, '甘洛县', 99);
INSERT INTO `iweb_areas` VALUES (2705, 2689, '美姑县', 99);
INSERT INTO `iweb_areas` VALUES (2706, 2689, '雷波县', 99);
INSERT INTO `iweb_areas` VALUES (2707, 2589, '泸州市', 99);
INSERT INTO `iweb_areas` VALUES (2708, 2707, '江阳区', 99);
INSERT INTO `iweb_areas` VALUES (2709, 2707, '纳溪区', 99);
INSERT INTO `iweb_areas` VALUES (2710, 2707, '龙马潭区', 99);
INSERT INTO `iweb_areas` VALUES (2711, 2707, '泸县', 99);
INSERT INTO `iweb_areas` VALUES (2712, 2707, '合江县', 99);
INSERT INTO `iweb_areas` VALUES (2713, 2707, '叙永县', 99);
INSERT INTO `iweb_areas` VALUES (2714, 2707, '古蔺县', 99);
INSERT INTO `iweb_areas` VALUES (2715, 2589, '眉山市', 99);
INSERT INTO `iweb_areas` VALUES (2716, 2715, '东坡区', 99);
INSERT INTO `iweb_areas` VALUES (2717, 2715, '仁寿县', 99);
INSERT INTO `iweb_areas` VALUES (2718, 2715, '彭山县', 99);
INSERT INTO `iweb_areas` VALUES (2719, 2715, '洪雅县', 99);
INSERT INTO `iweb_areas` VALUES (2720, 2715, '丹棱县', 99);
INSERT INTO `iweb_areas` VALUES (2721, 2715, '青神县', 99);
INSERT INTO `iweb_areas` VALUES (2722, 2589, '绵阳市', 99);
INSERT INTO `iweb_areas` VALUES (2723, 2722, '涪城区', 99);
INSERT INTO `iweb_areas` VALUES (2724, 2722, '游仙区', 99);
INSERT INTO `iweb_areas` VALUES (2725, 2722, '三台县', 99);
INSERT INTO `iweb_areas` VALUES (2726, 2722, '盐亭县', 99);
INSERT INTO `iweb_areas` VALUES (2727, 2722, '安县', 99);
INSERT INTO `iweb_areas` VALUES (2728, 2722, '梓潼县', 99);
INSERT INTO `iweb_areas` VALUES (2729, 2722, '北川羌族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2730, 2722, '平武县', 99);
INSERT INTO `iweb_areas` VALUES (2731, 2722, '江油市', 99);
INSERT INTO `iweb_areas` VALUES (2732, 2589, '内江市', 99);
INSERT INTO `iweb_areas` VALUES (2733, 2732, '市中区', 99);
INSERT INTO `iweb_areas` VALUES (2734, 2732, '东兴区', 99);
INSERT INTO `iweb_areas` VALUES (2735, 2732, '威远县', 99);
INSERT INTO `iweb_areas` VALUES (2736, 2732, '资中县', 99);
INSERT INTO `iweb_areas` VALUES (2737, 2732, '隆昌县', 99);
INSERT INTO `iweb_areas` VALUES (2738, 2589, '南充市', 99);
INSERT INTO `iweb_areas` VALUES (2739, 2738, '顺庆区', 99);
INSERT INTO `iweb_areas` VALUES (2740, 2738, '高坪区', 99);
INSERT INTO `iweb_areas` VALUES (2741, 2738, '嘉陵区', 99);
INSERT INTO `iweb_areas` VALUES (2742, 2738, '南部县', 99);
INSERT INTO `iweb_areas` VALUES (2743, 2738, '营山县', 99);
INSERT INTO `iweb_areas` VALUES (2744, 2738, '蓬安县', 99);
INSERT INTO `iweb_areas` VALUES (2745, 2738, '仪陇县', 99);
INSERT INTO `iweb_areas` VALUES (2746, 2738, '西充县', 99);
INSERT INTO `iweb_areas` VALUES (2747, 2738, '阆中市', 99);
INSERT INTO `iweb_areas` VALUES (2748, 2589, '攀枝花市', 99);
INSERT INTO `iweb_areas` VALUES (2749, 2748, '东区', 99);
INSERT INTO `iweb_areas` VALUES (2750, 2748, '西区', 99);
INSERT INTO `iweb_areas` VALUES (2751, 2748, '仁和区', 99);
INSERT INTO `iweb_areas` VALUES (2752, 2748, '米易县', 99);
INSERT INTO `iweb_areas` VALUES (2753, 2748, '盐边县', 99);
INSERT INTO `iweb_areas` VALUES (2754, 2589, '遂宁市', 99);
INSERT INTO `iweb_areas` VALUES (2755, 2754, '船山区', 99);
INSERT INTO `iweb_areas` VALUES (2756, 2754, '安居区', 99);
INSERT INTO `iweb_areas` VALUES (2757, 2754, '蓬溪县', 99);
INSERT INTO `iweb_areas` VALUES (2758, 2754, '射洪县', 99);
INSERT INTO `iweb_areas` VALUES (2759, 2754, '大英县', 99);
INSERT INTO `iweb_areas` VALUES (2760, 2589, '雅安市', 99);
INSERT INTO `iweb_areas` VALUES (2761, 2760, '雨城区', 99);
INSERT INTO `iweb_areas` VALUES (2762, 2760, '名山县', 99);
INSERT INTO `iweb_areas` VALUES (2763, 2760, '荥经县', 99);
INSERT INTO `iweb_areas` VALUES (2764, 2760, '汉源县', 99);
INSERT INTO `iweb_areas` VALUES (2765, 2760, '石棉县', 99);
INSERT INTO `iweb_areas` VALUES (2766, 2760, '天全县', 99);
INSERT INTO `iweb_areas` VALUES (2767, 2760, '芦山县', 99);
INSERT INTO `iweb_areas` VALUES (2768, 2760, '宝兴县', 99);
INSERT INTO `iweb_areas` VALUES (2769, 2589, '宜宾市', 99);
INSERT INTO `iweb_areas` VALUES (2770, 2769, '翠屏区', 99);
INSERT INTO `iweb_areas` VALUES (2771, 2769, '宜宾县', 99);
INSERT INTO `iweb_areas` VALUES (2772, 2769, '南溪县', 99);
INSERT INTO `iweb_areas` VALUES (2773, 2769, '江安县', 99);
INSERT INTO `iweb_areas` VALUES (2774, 2769, '长宁县', 99);
INSERT INTO `iweb_areas` VALUES (2775, 2769, '高县', 99);
INSERT INTO `iweb_areas` VALUES (2776, 2769, '珙县', 99);
INSERT INTO `iweb_areas` VALUES (2777, 2769, '筠连县', 99);
INSERT INTO `iweb_areas` VALUES (2778, 2769, '兴文县', 99);
INSERT INTO `iweb_areas` VALUES (2779, 2769, '屏山县', 99);
INSERT INTO `iweb_areas` VALUES (2780, 2589, '资阳市', 99);
INSERT INTO `iweb_areas` VALUES (2781, 2780, '雁江区', 99);
INSERT INTO `iweb_areas` VALUES (2782, 2780, '安岳县', 99);
INSERT INTO `iweb_areas` VALUES (2783, 2780, '乐至县', 99);
INSERT INTO `iweb_areas` VALUES (2784, 2780, '简阳市', 99);
INSERT INTO `iweb_areas` VALUES (2785, 2589, '自贡市', 99);
INSERT INTO `iweb_areas` VALUES (2786, 2785, '自流井区', 99);
INSERT INTO `iweb_areas` VALUES (2787, 2785, '贡井区', 99);
INSERT INTO `iweb_areas` VALUES (2788, 2785, '大安区', 99);
INSERT INTO `iweb_areas` VALUES (2789, 2785, '沿滩区', 99);
INSERT INTO `iweb_areas` VALUES (2790, 2785, '荣县', 99);
INSERT INTO `iweb_areas` VALUES (2791, 2785, '富顺县', 99);
INSERT INTO `iweb_areas` VALUES (2792, 0, '西藏', 99);
INSERT INTO `iweb_areas` VALUES (2793, 2792, '拉萨市', 99);
INSERT INTO `iweb_areas` VALUES (2794, 2793, '城关区', 99);
INSERT INTO `iweb_areas` VALUES (2795, 2793, '林周县', 99);
INSERT INTO `iweb_areas` VALUES (2796, 2793, '当雄县', 99);
INSERT INTO `iweb_areas` VALUES (2797, 2793, '尼木县', 99);
INSERT INTO `iweb_areas` VALUES (2798, 2793, '曲水县', 99);
INSERT INTO `iweb_areas` VALUES (2799, 2793, '堆龙德庆县', 99);
INSERT INTO `iweb_areas` VALUES (2800, 2793, '达孜县', 99);
INSERT INTO `iweb_areas` VALUES (2801, 2793, '墨竹工卡县', 99);
INSERT INTO `iweb_areas` VALUES (2802, 2792, '阿里地区', 99);
INSERT INTO `iweb_areas` VALUES (2803, 2802, '普兰县', 99);
INSERT INTO `iweb_areas` VALUES (2804, 2802, '札达县', 99);
INSERT INTO `iweb_areas` VALUES (2805, 2802, '噶尔县', 99);
INSERT INTO `iweb_areas` VALUES (2806, 2802, '日土县', 99);
INSERT INTO `iweb_areas` VALUES (2807, 2802, '革吉县', 99);
INSERT INTO `iweb_areas` VALUES (2808, 2802, '改则县', 99);
INSERT INTO `iweb_areas` VALUES (2809, 2802, '措勤县', 99);
INSERT INTO `iweb_areas` VALUES (2810, 2792, '昌都地区', 99);
INSERT INTO `iweb_areas` VALUES (2811, 2810, '昌都县', 99);
INSERT INTO `iweb_areas` VALUES (2812, 2810, '江达县', 99);
INSERT INTO `iweb_areas` VALUES (2813, 2810, '贡觉县', 99);
INSERT INTO `iweb_areas` VALUES (2814, 2810, '类乌齐县', 99);
INSERT INTO `iweb_areas` VALUES (2815, 2810, '丁青县', 99);
INSERT INTO `iweb_areas` VALUES (2816, 2810, '察雅县', 99);
INSERT INTO `iweb_areas` VALUES (2817, 2810, '八宿县', 99);
INSERT INTO `iweb_areas` VALUES (2818, 2810, '左贡县', 99);
INSERT INTO `iweb_areas` VALUES (2819, 2810, '芒康县', 99);
INSERT INTO `iweb_areas` VALUES (2820, 2810, '洛隆县', 99);
INSERT INTO `iweb_areas` VALUES (2821, 2810, '边坝县', 99);
INSERT INTO `iweb_areas` VALUES (2822, 2792, '林芝地区', 99);
INSERT INTO `iweb_areas` VALUES (2823, 2822, '林芝县', 99);
INSERT INTO `iweb_areas` VALUES (2824, 2822, '工布江达县', 99);
INSERT INTO `iweb_areas` VALUES (2825, 2822, '米林县', 99);
INSERT INTO `iweb_areas` VALUES (2826, 2822, '墨脱县', 99);
INSERT INTO `iweb_areas` VALUES (2827, 2822, '波密县', 99);
INSERT INTO `iweb_areas` VALUES (2828, 2822, '察隅县', 99);
INSERT INTO `iweb_areas` VALUES (2829, 2822, '朗县', 99);
INSERT INTO `iweb_areas` VALUES (2830, 2792, '那曲地区', 99);
INSERT INTO `iweb_areas` VALUES (2831, 2830, '那曲县', 99);
INSERT INTO `iweb_areas` VALUES (2832, 2830, '嘉黎县', 99);
INSERT INTO `iweb_areas` VALUES (2833, 2830, '比如县', 99);
INSERT INTO `iweb_areas` VALUES (2834, 2830, '聂荣县', 99);
INSERT INTO `iweb_areas` VALUES (2835, 2830, '安多县', 99);
INSERT INTO `iweb_areas` VALUES (2836, 2830, '申扎县', 99);
INSERT INTO `iweb_areas` VALUES (2837, 2830, '索县', 99);
INSERT INTO `iweb_areas` VALUES (2838, 2830, '班戈县', 99);
INSERT INTO `iweb_areas` VALUES (2839, 2830, '巴青县', 99);
INSERT INTO `iweb_areas` VALUES (2840, 2830, '尼玛县', 99);
INSERT INTO `iweb_areas` VALUES (2841, 2792, '日喀则地区', 99);
INSERT INTO `iweb_areas` VALUES (2842, 2841, '日喀则市', 99);
INSERT INTO `iweb_areas` VALUES (2843, 2841, '南木林县', 99);
INSERT INTO `iweb_areas` VALUES (2844, 2841, '江孜县', 99);
INSERT INTO `iweb_areas` VALUES (2845, 2841, '定日县', 99);
INSERT INTO `iweb_areas` VALUES (2846, 2841, '萨迦县', 99);
INSERT INTO `iweb_areas` VALUES (2847, 2841, '拉孜县', 99);
INSERT INTO `iweb_areas` VALUES (2848, 2841, '昂仁县', 99);
INSERT INTO `iweb_areas` VALUES (2849, 2841, '谢通门县', 99);
INSERT INTO `iweb_areas` VALUES (2850, 2841, '白朗县', 99);
INSERT INTO `iweb_areas` VALUES (2851, 2841, '仁布县', 99);
INSERT INTO `iweb_areas` VALUES (2852, 2841, '康马县', 99);
INSERT INTO `iweb_areas` VALUES (2853, 2841, '定结县', 99);
INSERT INTO `iweb_areas` VALUES (2854, 2841, '仲巴县', 99);
INSERT INTO `iweb_areas` VALUES (2855, 2841, '亚东县', 99);
INSERT INTO `iweb_areas` VALUES (2856, 2841, '吉隆县', 99);
INSERT INTO `iweb_areas` VALUES (2857, 2841, '聂拉木县', 99);
INSERT INTO `iweb_areas` VALUES (2858, 2841, '萨嘎县', 99);
INSERT INTO `iweb_areas` VALUES (2859, 2841, '岗巴县', 99);
INSERT INTO `iweb_areas` VALUES (2860, 2792, '山南地区', 99);
INSERT INTO `iweb_areas` VALUES (2861, 2860, '乃东县', 99);
INSERT INTO `iweb_areas` VALUES (2862, 2860, '扎囊县', 99);
INSERT INTO `iweb_areas` VALUES (2863, 2860, '贡嘎县', 99);
INSERT INTO `iweb_areas` VALUES (2864, 2860, '桑日县', 99);
INSERT INTO `iweb_areas` VALUES (2865, 2860, '琼结县', 99);
INSERT INTO `iweb_areas` VALUES (2866, 2860, '曲松县', 99);
INSERT INTO `iweb_areas` VALUES (2867, 2860, '措美县', 99);
INSERT INTO `iweb_areas` VALUES (2868, 2860, '洛扎县', 99);
INSERT INTO `iweb_areas` VALUES (2869, 2860, '加查县', 99);
INSERT INTO `iweb_areas` VALUES (2870, 2860, '隆子县', 99);
INSERT INTO `iweb_areas` VALUES (2871, 2860, '错那县', 99);
INSERT INTO `iweb_areas` VALUES (2872, 2860, '浪卡子县', 99);
INSERT INTO `iweb_areas` VALUES (2873, 0, '新疆', 99);
INSERT INTO `iweb_areas` VALUES (2874, 2873, '乌鲁木齐市', 99);
INSERT INTO `iweb_areas` VALUES (2875, 2874, '天山区', 99);
INSERT INTO `iweb_areas` VALUES (2876, 2874, '沙依巴克区', 99);
INSERT INTO `iweb_areas` VALUES (2877, 2874, '新市区', 99);
INSERT INTO `iweb_areas` VALUES (2878, 2874, '水磨沟区', 99);
INSERT INTO `iweb_areas` VALUES (2879, 2874, '头屯河区', 99);
INSERT INTO `iweb_areas` VALUES (2880, 2874, '达坂城区', 99);
INSERT INTO `iweb_areas` VALUES (2881, 2874, '东山区', 99);
INSERT INTO `iweb_areas` VALUES (2882, 2874, '乌鲁木齐县', 99);
INSERT INTO `iweb_areas` VALUES (2883, 2873, '阿克苏地区', 99);
INSERT INTO `iweb_areas` VALUES (2884, 2883, '阿克苏市', 99);
INSERT INTO `iweb_areas` VALUES (2885, 2883, '温宿县', 99);
INSERT INTO `iweb_areas` VALUES (2886, 2883, '库车县', 99);
INSERT INTO `iweb_areas` VALUES (2887, 2883, '沙雅县', 99);
INSERT INTO `iweb_areas` VALUES (2888, 2883, '新和县', 99);
INSERT INTO `iweb_areas` VALUES (2889, 2883, '拜城县', 99);
INSERT INTO `iweb_areas` VALUES (2890, 2883, '乌什县', 99);
INSERT INTO `iweb_areas` VALUES (2891, 2883, '阿瓦提县', 99);
INSERT INTO `iweb_areas` VALUES (2892, 2883, '柯坪县', 99);
INSERT INTO `iweb_areas` VALUES (2893, 2873, '阿拉尔市', 99);
INSERT INTO `iweb_areas` VALUES (2894, 2873, '阿勒泰地区', 99);
INSERT INTO `iweb_areas` VALUES (2895, 2894, '阿勒泰市', 99);
INSERT INTO `iweb_areas` VALUES (2896, 2894, '布尔津县', 99);
INSERT INTO `iweb_areas` VALUES (2897, 2894, '富蕴县', 99);
INSERT INTO `iweb_areas` VALUES (2898, 2894, '福海县', 99);
INSERT INTO `iweb_areas` VALUES (2899, 2894, '哈巴河县', 99);
INSERT INTO `iweb_areas` VALUES (2900, 2894, '青河县', 99);
INSERT INTO `iweb_areas` VALUES (2901, 2894, '吉木乃县', 99);
INSERT INTO `iweb_areas` VALUES (2902, 2873, '巴音郭楞蒙古自治州', 99);
INSERT INTO `iweb_areas` VALUES (2903, 2902, '库尔勒市', 99);
INSERT INTO `iweb_areas` VALUES (2904, 2902, '轮台县', 99);
INSERT INTO `iweb_areas` VALUES (2905, 2902, '尉犁县', 99);
INSERT INTO `iweb_areas` VALUES (2906, 2902, '若羌县', 99);
INSERT INTO `iweb_areas` VALUES (2907, 2902, '且末县', 99);
INSERT INTO `iweb_areas` VALUES (2908, 2902, '焉耆回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2909, 2902, '和静县', 99);
INSERT INTO `iweb_areas` VALUES (2910, 2902, '和硕县', 99);
INSERT INTO `iweb_areas` VALUES (2911, 2902, '博湖县', 99);
INSERT INTO `iweb_areas` VALUES (2912, 2873, '博尔塔拉蒙古自治州', 99);
INSERT INTO `iweb_areas` VALUES (2913, 2912, '博乐市', 99);
INSERT INTO `iweb_areas` VALUES (2914, 2912, '精河县', 99);
INSERT INTO `iweb_areas` VALUES (2915, 2912, '温泉县', 99);
INSERT INTO `iweb_areas` VALUES (2916, 2873, '昌吉回族自治州', 99);
INSERT INTO `iweb_areas` VALUES (2917, 2916, '昌吉市', 99);
INSERT INTO `iweb_areas` VALUES (2918, 2916, '阜康市', 99);
INSERT INTO `iweb_areas` VALUES (2919, 2916, '米泉市', 99);
INSERT INTO `iweb_areas` VALUES (2920, 2916, '呼图壁县', 99);
INSERT INTO `iweb_areas` VALUES (2921, 2916, '玛纳斯县', 99);
INSERT INTO `iweb_areas` VALUES (2922, 2916, '奇台县', 99);
INSERT INTO `iweb_areas` VALUES (2923, 2916, '吉木萨尔县', 99);
INSERT INTO `iweb_areas` VALUES (2924, 2916, '木垒哈萨克自治县', 99);
INSERT INTO `iweb_areas` VALUES (2925, 2873, '哈密地区', 99);
INSERT INTO `iweb_areas` VALUES (2926, 2925, '哈密市', 99);
INSERT INTO `iweb_areas` VALUES (2927, 2925, '巴里坤哈萨克自治县', 99);
INSERT INTO `iweb_areas` VALUES (2928, 2925, '伊吾县', 99);
INSERT INTO `iweb_areas` VALUES (2929, 2873, '和田地区', 99);
INSERT INTO `iweb_areas` VALUES (2930, 2929, '和田市', 99);
INSERT INTO `iweb_areas` VALUES (2931, 2929, '和田县', 99);
INSERT INTO `iweb_areas` VALUES (2932, 2929, '墨玉县', 99);
INSERT INTO `iweb_areas` VALUES (2933, 2929, '皮山县', 99);
INSERT INTO `iweb_areas` VALUES (2934, 2929, '洛浦县', 99);
INSERT INTO `iweb_areas` VALUES (2935, 2929, '策勒县', 99);
INSERT INTO `iweb_areas` VALUES (2936, 2929, '于田县', 99);
INSERT INTO `iweb_areas` VALUES (2937, 2929, '民丰县', 99);
INSERT INTO `iweb_areas` VALUES (2938, 2873, '喀什地区', 99);
INSERT INTO `iweb_areas` VALUES (2939, 2938, '喀什市', 99);
INSERT INTO `iweb_areas` VALUES (2940, 2938, '疏附县', 99);
INSERT INTO `iweb_areas` VALUES (2941, 2938, '疏勒县', 99);
INSERT INTO `iweb_areas` VALUES (2942, 2938, '英吉沙县', 99);
INSERT INTO `iweb_areas` VALUES (2943, 2938, '泽普县', 99);
INSERT INTO `iweb_areas` VALUES (2944, 2938, '莎车县', 99);
INSERT INTO `iweb_areas` VALUES (2945, 2938, '叶城县', 99);
INSERT INTO `iweb_areas` VALUES (2946, 2938, '麦盖提县', 99);
INSERT INTO `iweb_areas` VALUES (2947, 2938, '岳普湖县', 99);
INSERT INTO `iweb_areas` VALUES (2948, 2938, '伽师县', 99);
INSERT INTO `iweb_areas` VALUES (2949, 2938, '巴楚县', 99);
INSERT INTO `iweb_areas` VALUES (2950, 2938, '塔什库尔干塔吉克自治县', 99);
INSERT INTO `iweb_areas` VALUES (2951, 2873, '克拉玛依市', 99);
INSERT INTO `iweb_areas` VALUES (2952, 2951, '独山子区', 99);
INSERT INTO `iweb_areas` VALUES (2953, 2951, '克拉玛依区', 99);
INSERT INTO `iweb_areas` VALUES (2954, 2951, '白碱滩区', 99);
INSERT INTO `iweb_areas` VALUES (2955, 2951, '乌尔禾区', 99);
INSERT INTO `iweb_areas` VALUES (2956, 2873, '克孜勒苏柯尔克孜自治州', 99);
INSERT INTO `iweb_areas` VALUES (2957, 2956, '阿图什市', 99);
INSERT INTO `iweb_areas` VALUES (2958, 2956, '阿克陶县', 99);
INSERT INTO `iweb_areas` VALUES (2959, 2956, '阿合奇县', 99);
INSERT INTO `iweb_areas` VALUES (2960, 2956, '乌恰县', 99);
INSERT INTO `iweb_areas` VALUES (2961, 2873, '石河子市', 99);
INSERT INTO `iweb_areas` VALUES (2962, 2873, '塔城地区', 99);
INSERT INTO `iweb_areas` VALUES (2963, 2962, '塔城市', 99);
INSERT INTO `iweb_areas` VALUES (2964, 2962, '乌苏市', 99);
INSERT INTO `iweb_areas` VALUES (2965, 2962, '额敏县', 99);
INSERT INTO `iweb_areas` VALUES (2966, 2962, '沙湾县', 99);
INSERT INTO `iweb_areas` VALUES (2967, 2962, '托里县', 99);
INSERT INTO `iweb_areas` VALUES (2968, 2962, '裕民县', 99);
INSERT INTO `iweb_areas` VALUES (2969, 2962, '和布克赛尔蒙古自治县', 99);
INSERT INTO `iweb_areas` VALUES (2970, 2873, '图木舒克市', 99);
INSERT INTO `iweb_areas` VALUES (2971, 2873, '吐鲁番地区', 99);
INSERT INTO `iweb_areas` VALUES (2972, 2971, '吐鲁番市', 99);
INSERT INTO `iweb_areas` VALUES (2973, 2971, '鄯善县', 99);
INSERT INTO `iweb_areas` VALUES (2974, 2971, '托克逊县', 99);
INSERT INTO `iweb_areas` VALUES (2975, 2873, '五家渠市', 99);
INSERT INTO `iweb_areas` VALUES (2976, 2873, '伊犁哈萨克自治州', 99);
INSERT INTO `iweb_areas` VALUES (2977, 2976, '伊宁市', 99);
INSERT INTO `iweb_areas` VALUES (2978, 2976, '奎屯市', 99);
INSERT INTO `iweb_areas` VALUES (2979, 2976, '伊宁县', 99);
INSERT INTO `iweb_areas` VALUES (2980, 2976, '察布查尔锡伯自治县', 99);
INSERT INTO `iweb_areas` VALUES (2981, 2976, '霍城县', 99);
INSERT INTO `iweb_areas` VALUES (2982, 2976, '巩留县', 99);
INSERT INTO `iweb_areas` VALUES (2983, 2976, '新源县', 99);
INSERT INTO `iweb_areas` VALUES (2984, 2976, '昭苏县', 99);
INSERT INTO `iweb_areas` VALUES (2985, 2976, '特克斯县', 99);
INSERT INTO `iweb_areas` VALUES (2986, 2976, '尼勒克县', 99);
INSERT INTO `iweb_areas` VALUES (2987, 0, '云南', 99);
INSERT INTO `iweb_areas` VALUES (2988, 2987, '昆明市', 99);
INSERT INTO `iweb_areas` VALUES (2989, 2988, '五华区', 99);
INSERT INTO `iweb_areas` VALUES (2990, 2988, '盘龙区', 99);
INSERT INTO `iweb_areas` VALUES (2991, 2988, '官渡区', 99);
INSERT INTO `iweb_areas` VALUES (2992, 2988, '西山区', 99);
INSERT INTO `iweb_areas` VALUES (2993, 2988, '东川区', 99);
INSERT INTO `iweb_areas` VALUES (2994, 2988, '呈贡县', 99);
INSERT INTO `iweb_areas` VALUES (2995, 2988, '晋宁县', 99);
INSERT INTO `iweb_areas` VALUES (2996, 2988, '富民县', 99);
INSERT INTO `iweb_areas` VALUES (2997, 2988, '宜良县', 99);
INSERT INTO `iweb_areas` VALUES (2998, 2988, '石林彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (2999, 2988, '嵩明县', 99);
INSERT INTO `iweb_areas` VALUES (3000, 2988, '禄劝彝族苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3001, 2988, '寻甸回族彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3002, 2988, '安宁市', 99);
INSERT INTO `iweb_areas` VALUES (3003, 2987, '保山市', 99);
INSERT INTO `iweb_areas` VALUES (3004, 3003, '隆阳区', 99);
INSERT INTO `iweb_areas` VALUES (3005, 3003, '施甸县', 99);
INSERT INTO `iweb_areas` VALUES (3006, 3003, '腾冲县', 99);
INSERT INTO `iweb_areas` VALUES (3007, 3003, '龙陵县', 99);
INSERT INTO `iweb_areas` VALUES (3008, 3003, '昌宁县', 99);
INSERT INTO `iweb_areas` VALUES (3009, 2987, '楚雄彝族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3010, 3009, '楚雄市', 99);
INSERT INTO `iweb_areas` VALUES (3011, 3009, '双柏县', 99);
INSERT INTO `iweb_areas` VALUES (3012, 3009, '牟定县', 99);
INSERT INTO `iweb_areas` VALUES (3013, 3009, '南华县', 99);
INSERT INTO `iweb_areas` VALUES (3014, 3009, '姚安县', 99);
INSERT INTO `iweb_areas` VALUES (3015, 3009, '大姚县', 99);
INSERT INTO `iweb_areas` VALUES (3016, 3009, '永仁县', 99);
INSERT INTO `iweb_areas` VALUES (3017, 3009, '元谋县', 99);
INSERT INTO `iweb_areas` VALUES (3018, 3009, '武定县', 99);
INSERT INTO `iweb_areas` VALUES (3019, 3009, '禄丰县', 99);
INSERT INTO `iweb_areas` VALUES (3020, 2987, '大理白族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3021, 3020, '大理市', 99);
INSERT INTO `iweb_areas` VALUES (3022, 3020, '漾濞彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3023, 3020, '祥云县', 99);
INSERT INTO `iweb_areas` VALUES (3024, 3020, '宾川县', 99);
INSERT INTO `iweb_areas` VALUES (3025, 3020, '弥渡县', 99);
INSERT INTO `iweb_areas` VALUES (3026, 3020, '南涧彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3027, 3020, '巍山彝族回族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3028, 3020, '永平县', 99);
INSERT INTO `iweb_areas` VALUES (3029, 3020, '云龙县', 99);
INSERT INTO `iweb_areas` VALUES (3030, 3020, '洱源县', 99);
INSERT INTO `iweb_areas` VALUES (3031, 3020, '剑川县', 99);
INSERT INTO `iweb_areas` VALUES (3032, 3020, '鹤庆县', 99);
INSERT INTO `iweb_areas` VALUES (3033, 2987, '德宏傣族景颇族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3034, 3033, '瑞丽市', 99);
INSERT INTO `iweb_areas` VALUES (3035, 3033, '潞西市', 99);
INSERT INTO `iweb_areas` VALUES (3036, 3033, '梁河县', 99);
INSERT INTO `iweb_areas` VALUES (3037, 3033, '盈江县', 99);
INSERT INTO `iweb_areas` VALUES (3038, 3033, '陇川县', 99);
INSERT INTO `iweb_areas` VALUES (3039, 2987, '迪庆藏族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3040, 3039, '香格里拉县', 99);
INSERT INTO `iweb_areas` VALUES (3041, 3039, '德钦县', 99);
INSERT INTO `iweb_areas` VALUES (3042, 3039, '维西傈僳族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3043, 2987, '红河哈尼族彝族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3044, 3043, '个旧市', 99);
INSERT INTO `iweb_areas` VALUES (3045, 3043, '开远市', 99);
INSERT INTO `iweb_areas` VALUES (3046, 3043, '蒙自县', 99);
INSERT INTO `iweb_areas` VALUES (3047, 3043, '屏边苗族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3048, 3043, '建水县', 99);
INSERT INTO `iweb_areas` VALUES (3049, 3043, '石屏县', 99);
INSERT INTO `iweb_areas` VALUES (3050, 3043, '弥勒县', 99);
INSERT INTO `iweb_areas` VALUES (3051, 3043, '泸西县', 99);
INSERT INTO `iweb_areas` VALUES (3052, 3043, '元阳县', 99);
INSERT INTO `iweb_areas` VALUES (3053, 3043, '红河县', 99);
INSERT INTO `iweb_areas` VALUES (3054, 3043, '金平苗族瑶族傣族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3055, 3043, '绿春县', 99);
INSERT INTO `iweb_areas` VALUES (3056, 3043, '河口瑶族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3057, 2987, '丽江市', 99);
INSERT INTO `iweb_areas` VALUES (3058, 3057, '古城区', 99);
INSERT INTO `iweb_areas` VALUES (3059, 3057, '玉龙纳西族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3060, 3057, '永胜县', 99);
INSERT INTO `iweb_areas` VALUES (3061, 3057, '华坪县', 99);
INSERT INTO `iweb_areas` VALUES (3062, 3057, '宁蒗彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3063, 2987, '临沧市', 99);
INSERT INTO `iweb_areas` VALUES (3064, 3063, '临翔区', 99);
INSERT INTO `iweb_areas` VALUES (3065, 3063, '凤庆县', 99);
INSERT INTO `iweb_areas` VALUES (3066, 3063, '云县', 99);
INSERT INTO `iweb_areas` VALUES (3067, 3063, '永德县', 99);
INSERT INTO `iweb_areas` VALUES (3068, 3063, '镇康县', 99);
INSERT INTO `iweb_areas` VALUES (3069, 3063, '双江拉祜族佤族布朗族傣族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3070, 3063, '耿马傣族佤族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3071, 3063, '沧源佤族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3072, 2987, '怒江傈僳族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3073, 3072, '泸水县', 99);
INSERT INTO `iweb_areas` VALUES (3074, 3072, '福贡县', 99);
INSERT INTO `iweb_areas` VALUES (3075, 3072, '贡山独龙族怒族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3076, 3072, '兰坪白族普米族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3077, 2987, '曲靖市', 99);
INSERT INTO `iweb_areas` VALUES (3078, 3077, '麒麟区', 99);
INSERT INTO `iweb_areas` VALUES (3079, 3077, '马龙县', 99);
INSERT INTO `iweb_areas` VALUES (3080, 3077, '陆良县', 99);
INSERT INTO `iweb_areas` VALUES (3081, 3077, '师宗县', 99);
INSERT INTO `iweb_areas` VALUES (3082, 3077, '罗平县', 99);
INSERT INTO `iweb_areas` VALUES (3083, 3077, '富源县', 99);
INSERT INTO `iweb_areas` VALUES (3084, 3077, '会泽县', 99);
INSERT INTO `iweb_areas` VALUES (3085, 3077, '沾益县', 99);
INSERT INTO `iweb_areas` VALUES (3086, 3077, '宣威市', 99);
INSERT INTO `iweb_areas` VALUES (3087, 2987, '思茅市', 99);
INSERT INTO `iweb_areas` VALUES (3088, 3087, '翠云区', 99);
INSERT INTO `iweb_areas` VALUES (3089, 3087, '普洱哈尼族彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3090, 3087, '墨江哈尼族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3091, 3087, '景东彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3092, 3087, '景谷傣族彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3093, 3087, '镇沅彝族哈尼族拉祜族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3094, 3087, '江城哈尼族彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3095, 3087, '孟连傣族拉祜族佤族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3096, 3087, '澜沧拉祜族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3097, 3087, '西盟佤族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3098, 2987, '文山壮族苗族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3099, 3098, '文山县', 99);
INSERT INTO `iweb_areas` VALUES (3100, 3098, '砚山县', 99);
INSERT INTO `iweb_areas` VALUES (3101, 3098, '西畴县', 99);
INSERT INTO `iweb_areas` VALUES (3102, 3098, '麻栗坡县', 99);
INSERT INTO `iweb_areas` VALUES (3103, 3098, '马关县', 99);
INSERT INTO `iweb_areas` VALUES (3104, 3098, '丘北县', 99);
INSERT INTO `iweb_areas` VALUES (3105, 3098, '广南县', 99);
INSERT INTO `iweb_areas` VALUES (3106, 3098, '富宁县', 99);
INSERT INTO `iweb_areas` VALUES (3107, 2987, '西双版纳傣族自治州', 99);
INSERT INTO `iweb_areas` VALUES (3108, 3107, '景洪市', 99);
INSERT INTO `iweb_areas` VALUES (3109, 3107, '勐海县', 99);
INSERT INTO `iweb_areas` VALUES (3110, 3107, '勐腊县', 99);
INSERT INTO `iweb_areas` VALUES (3111, 2987, '玉溪市', 99);
INSERT INTO `iweb_areas` VALUES (3112, 3111, '红塔区', 99);
INSERT INTO `iweb_areas` VALUES (3113, 3111, '江川县', 99);
INSERT INTO `iweb_areas` VALUES (3114, 3111, '澄江县', 99);
INSERT INTO `iweb_areas` VALUES (3115, 3111, '通海县', 99);
INSERT INTO `iweb_areas` VALUES (3116, 3111, '华宁县', 99);
INSERT INTO `iweb_areas` VALUES (3117, 3111, '易门县', 99);
INSERT INTO `iweb_areas` VALUES (3118, 3111, '峨山彝族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3119, 3111, '新平彝族傣族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3120, 3111, '元江哈尼族彝族傣族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3121, 2987, '昭通市', 99);
INSERT INTO `iweb_areas` VALUES (3122, 3121, '昭阳区', 99);
INSERT INTO `iweb_areas` VALUES (3123, 3121, '鲁甸县', 99);
INSERT INTO `iweb_areas` VALUES (3124, 3121, '巧家县', 99);
INSERT INTO `iweb_areas` VALUES (3125, 3121, '盐津县', 99);
INSERT INTO `iweb_areas` VALUES (3126, 3121, '大关县', 99);
INSERT INTO `iweb_areas` VALUES (3127, 3121, '永善县', 99);
INSERT INTO `iweb_areas` VALUES (3128, 3121, '绥江县', 99);
INSERT INTO `iweb_areas` VALUES (3129, 3121, '镇雄县', 99);
INSERT INTO `iweb_areas` VALUES (3130, 3121, '彝良县', 99);
INSERT INTO `iweb_areas` VALUES (3131, 3121, '威信县', 99);
INSERT INTO `iweb_areas` VALUES (3132, 3121, '水富县', 99);
INSERT INTO `iweb_areas` VALUES (3133, 0, '浙江', 99);
INSERT INTO `iweb_areas` VALUES (3134, 3133, '杭州市', 99);
INSERT INTO `iweb_areas` VALUES (3135, 3134, '上城区', 99);
INSERT INTO `iweb_areas` VALUES (3136, 3134, '下城区', 99);
INSERT INTO `iweb_areas` VALUES (3137, 3134, '江干区', 99);
INSERT INTO `iweb_areas` VALUES (3138, 3134, '拱墅区', 99);
INSERT INTO `iweb_areas` VALUES (3139, 3134, '西湖区', 99);
INSERT INTO `iweb_areas` VALUES (3140, 3134, '滨江区', 99);
INSERT INTO `iweb_areas` VALUES (3141, 3134, '萧山区', 99);
INSERT INTO `iweb_areas` VALUES (3142, 3134, '余杭区', 99);
INSERT INTO `iweb_areas` VALUES (3143, 3134, '桐庐县', 99);
INSERT INTO `iweb_areas` VALUES (3144, 3134, '淳安县', 99);
INSERT INTO `iweb_areas` VALUES (3145, 3134, '建德市', 99);
INSERT INTO `iweb_areas` VALUES (3146, 3134, '富阳市', 99);
INSERT INTO `iweb_areas` VALUES (3147, 3134, '临安市', 99);
INSERT INTO `iweb_areas` VALUES (3148, 3133, '湖州市', 99);
INSERT INTO `iweb_areas` VALUES (3149, 3148, '吴兴区', 99);
INSERT INTO `iweb_areas` VALUES (3150, 3148, '南浔区', 99);
INSERT INTO `iweb_areas` VALUES (3151, 3148, '德清县', 99);
INSERT INTO `iweb_areas` VALUES (3152, 3148, '长兴县', 99);
INSERT INTO `iweb_areas` VALUES (3153, 3148, '安吉县', 99);
INSERT INTO `iweb_areas` VALUES (3154, 3133, '嘉兴市', 99);
INSERT INTO `iweb_areas` VALUES (3155, 3154, '秀城区', 99);
INSERT INTO `iweb_areas` VALUES (3156, 3154, '秀洲区', 99);
INSERT INTO `iweb_areas` VALUES (3157, 3154, '嘉善县', 99);
INSERT INTO `iweb_areas` VALUES (3158, 3154, '海盐县', 99);
INSERT INTO `iweb_areas` VALUES (3159, 3154, '海宁市', 99);
INSERT INTO `iweb_areas` VALUES (3160, 3154, '平湖市', 99);
INSERT INTO `iweb_areas` VALUES (3161, 3154, '桐乡市', 99);
INSERT INTO `iweb_areas` VALUES (3162, 3133, '金华市', 99);
INSERT INTO `iweb_areas` VALUES (3163, 3162, '婺城区', 99);
INSERT INTO `iweb_areas` VALUES (3164, 3162, '金东区', 99);
INSERT INTO `iweb_areas` VALUES (3165, 3162, '武义县', 99);
INSERT INTO `iweb_areas` VALUES (3166, 3162, '浦江县', 99);
INSERT INTO `iweb_areas` VALUES (3167, 3162, '磐安县', 99);
INSERT INTO `iweb_areas` VALUES (3168, 3162, '兰溪市', 99);
INSERT INTO `iweb_areas` VALUES (3169, 3162, '义乌市', 99);
INSERT INTO `iweb_areas` VALUES (3170, 3162, '东阳市', 99);
INSERT INTO `iweb_areas` VALUES (3171, 3162, '永康市', 99);
INSERT INTO `iweb_areas` VALUES (3172, 3133, '丽水市', 99);
INSERT INTO `iweb_areas` VALUES (3173, 3172, '莲都区', 99);
INSERT INTO `iweb_areas` VALUES (3174, 3172, '青田县', 99);
INSERT INTO `iweb_areas` VALUES (3175, 3172, '缙云县', 99);
INSERT INTO `iweb_areas` VALUES (3176, 3172, '遂昌县', 99);
INSERT INTO `iweb_areas` VALUES (3177, 3172, '松阳县', 99);
INSERT INTO `iweb_areas` VALUES (3178, 3172, '云和县', 99);
INSERT INTO `iweb_areas` VALUES (3179, 3172, '庆元县', 99);
INSERT INTO `iweb_areas` VALUES (3180, 3172, '景宁畲族自治县', 99);
INSERT INTO `iweb_areas` VALUES (3181, 3172, '龙泉市', 99);
INSERT INTO `iweb_areas` VALUES (3182, 3133, '宁波市', 99);
INSERT INTO `iweb_areas` VALUES (3183, 3182, '海曙区', 99);
INSERT INTO `iweb_areas` VALUES (3184, 3182, '江东区', 99);
INSERT INTO `iweb_areas` VALUES (3185, 3182, '江北区', 99);
INSERT INTO `iweb_areas` VALUES (3186, 3182, '北仑区', 99);
INSERT INTO `iweb_areas` VALUES (3187, 3182, '镇海区', 99);
INSERT INTO `iweb_areas` VALUES (3188, 3182, '鄞州区', 99);
INSERT INTO `iweb_areas` VALUES (3189, 3182, '象山县', 99);
INSERT INTO `iweb_areas` VALUES (3190, 3182, '宁海县', 99);
INSERT INTO `iweb_areas` VALUES (3191, 3182, '余姚市', 99);
INSERT INTO `iweb_areas` VALUES (3192, 3182, '慈溪市', 99);
INSERT INTO `iweb_areas` VALUES (3193, 3182, '奉化市', 99);
INSERT INTO `iweb_areas` VALUES (3194, 3133, '衢州市', 99);
INSERT INTO `iweb_areas` VALUES (3195, 3194, '柯城区', 99);
INSERT INTO `iweb_areas` VALUES (3196, 3194, '衢江区', 99);
INSERT INTO `iweb_areas` VALUES (3197, 3194, '常山县', 99);
INSERT INTO `iweb_areas` VALUES (3198, 3194, '开化县', 99);
INSERT INTO `iweb_areas` VALUES (3199, 3194, '龙游县', 99);
INSERT INTO `iweb_areas` VALUES (3200, 3194, '江山市', 99);
INSERT INTO `iweb_areas` VALUES (3201, 3133, '绍兴市', 99);
INSERT INTO `iweb_areas` VALUES (3202, 3201, '越城区', 99);
INSERT INTO `iweb_areas` VALUES (3203, 3201, '绍兴县', 99);
INSERT INTO `iweb_areas` VALUES (3204, 3201, '新昌县', 99);
INSERT INTO `iweb_areas` VALUES (3205, 3201, '诸暨市', 99);
INSERT INTO `iweb_areas` VALUES (3206, 3201, '上虞市', 99);
INSERT INTO `iweb_areas` VALUES (3207, 3201, '嵊州市', 99);
INSERT INTO `iweb_areas` VALUES (3208, 3133, '台州市', 99);
INSERT INTO `iweb_areas` VALUES (3209, 3208, '椒江区', 99);
INSERT INTO `iweb_areas` VALUES (3210, 3208, '黄岩区', 99);
INSERT INTO `iweb_areas` VALUES (3211, 3208, '路桥区', 99);
INSERT INTO `iweb_areas` VALUES (3212, 3208, '玉环县', 99);
INSERT INTO `iweb_areas` VALUES (3213, 3208, '三门县', 99);
INSERT INTO `iweb_areas` VALUES (3214, 3208, '天台县', 99);
INSERT INTO `iweb_areas` VALUES (3215, 3208, '仙居县', 99);
INSERT INTO `iweb_areas` VALUES (3216, 3208, '温岭市', 99);
INSERT INTO `iweb_areas` VALUES (3217, 3208, '临海市', 99);
INSERT INTO `iweb_areas` VALUES (3218, 3133, '温州市', 99);
INSERT INTO `iweb_areas` VALUES (3219, 3218, '鹿城区', 99);
INSERT INTO `iweb_areas` VALUES (3220, 3218, '龙湾区', 99);
INSERT INTO `iweb_areas` VALUES (3221, 3218, '瓯海区', 99);
INSERT INTO `iweb_areas` VALUES (3222, 3218, '洞头县', 99);
INSERT INTO `iweb_areas` VALUES (3223, 3218, '永嘉县', 99);
INSERT INTO `iweb_areas` VALUES (3224, 3218, '平阳县', 99);
INSERT INTO `iweb_areas` VALUES (3225, 3218, '苍南县', 99);
INSERT INTO `iweb_areas` VALUES (3226, 3218, '文成县', 99);
INSERT INTO `iweb_areas` VALUES (3227, 3218, '泰顺县', 99);
INSERT INTO `iweb_areas` VALUES (3228, 3218, '瑞安市', 99);
INSERT INTO `iweb_areas` VALUES (3229, 3218, '乐清市', 99);
INSERT INTO `iweb_areas` VALUES (3230, 3133, '舟山市', 99);
INSERT INTO `iweb_areas` VALUES (3231, 3230, '定海区', 99);
INSERT INTO `iweb_areas` VALUES (3232, 3230, '普陀区', 99);
INSERT INTO `iweb_areas` VALUES (3233, 3230, '岱山县', 99);
INSERT INTO `iweb_areas` VALUES (3234, 3230, '嵊泗县', 99);
INSERT INTO `iweb_areas` VALUES (3235, 0, '香港', 99);
INSERT INTO `iweb_areas` VALUES (3236, 3235, '九龙', 99);
INSERT INTO `iweb_areas` VALUES (3237, 3235, '香港岛', 99);
INSERT INTO `iweb_areas` VALUES (3238, 3235, '新界', 99);
INSERT INTO `iweb_areas` VALUES (3239, 0, '澳门', 99);
INSERT INTO `iweb_areas` VALUES (3240, 3239, '澳门半岛', 99);
INSERT INTO `iweb_areas` VALUES (3241, 3239, '离岛', 99);
INSERT INTO `iweb_areas` VALUES (3242, 0, '台湾', 99);
INSERT INTO `iweb_areas` VALUES (3243, 3242, '台北市', 99);
INSERT INTO `iweb_areas` VALUES (3244, 3242, '高雄市', 99);
INSERT INTO `iweb_areas` VALUES (3245, 3242, '高雄县', 99);
INSERT INTO `iweb_areas` VALUES (3246, 3242, '花莲县', 99);
INSERT INTO `iweb_areas` VALUES (3247, 3242, '基隆市', 99);
INSERT INTO `iweb_areas` VALUES (3248, 3242, '嘉义市', 99);
INSERT INTO `iweb_areas` VALUES (3249, 3242, '嘉义县', 99);
INSERT INTO `iweb_areas` VALUES (3250, 3242, '金门县', 99);
INSERT INTO `iweb_areas` VALUES (3251, 3242, '苗栗县', 99);
INSERT INTO `iweb_areas` VALUES (3252, 3242, '南投县', 99);
INSERT INTO `iweb_areas` VALUES (3253, 3242, '澎湖县', 99);
INSERT INTO `iweb_areas` VALUES (3254, 3242, '屏东县', 99);
INSERT INTO `iweb_areas` VALUES (3255, 3242, '台北县', 99);
INSERT INTO `iweb_areas` VALUES (3256, 3242, '台东县', 99);
INSERT INTO `iweb_areas` VALUES (3257, 3242, '台南市', 99);
INSERT INTO `iweb_areas` VALUES (3258, 3242, '台南县', 99);
INSERT INTO `iweb_areas` VALUES (3259, 3242, '台中市', 99);
INSERT INTO `iweb_areas` VALUES (3260, 3242, '台中县', 99);
INSERT INTO `iweb_areas` VALUES (3261, 3242, '桃园县', 99);
INSERT INTO `iweb_areas` VALUES (3262, 3242, '新竹市', 99);
INSERT INTO `iweb_areas` VALUES (3263, 3242, '新竹县', 99);
INSERT INTO `iweb_areas` VALUES (3264, 3242, '宜兰县', 99);
INSERT INTO `iweb_areas` VALUES (3265, 3242, '云林县', 99);
INSERT INTO `iweb_areas` VALUES (3266, 3242, '彰化县', 99);
--
-- 导出表中的数据 `iweb_help`
--

INSERT INTO `iweb_help` VALUES (4, 3, 0, '购物流程', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、搜索商品</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为您提供了方便快捷的商品搜索功能：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）您可以通过在首页输入关键字的方法来搜索您想要购买的商品</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）您还可以通过</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的分类导航栏来找到您想要购买的商品分类，根据分类找到您的商品</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）观看搜索商品演示</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、放入购物车在您想要购买的商品的详情页点击“购买”，商品会添加到您的购物车中；您还可以继续挑选商品放入购物车，一起结算。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）在购物车中，系统默认每件商品的订购数量为一件，如果您想购买多件商品，可修改购买数量</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）在购物车中，您可以将商品移至收藏，或是选择删除</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）在购物车中，您可以直接查看到商品的优惠折和参加促销活动的商品名称、促销主题</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）购物车页面下方的商品是</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">根据您挑选的商品为您作出的推荐，若有您喜爱的商品，点击“放入购物车”即可</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）商品价格会不定期调整，最终价格以您提交订单后订单中的价格为准</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）优惠政策、配送时间、运费收取标准等都有可能进行调整，最终成交信息以您提交订单时网站公布的最新信息为准</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、选择订单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">和商家的商品需要分别提交订单订购</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）不同商家的商品需要分别提交订单订购</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、注册登陆</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）老顾客：请在“登陆”页面输入</span><span lang=\\"EN-US\\">Email</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">地址或昵称、注册密码进行登陆</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）新顾客：请在“新用户注册”页面按照提示完成注册</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、填写收货人信息</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）请填写正确完整的收货人姓名、收货人联系方式、详细的收货地址和邮编，否则将会影响您订单的处理或配送</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）您可以进入“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">—帐户管理—收货地址簿”编辑常用收货地址，保存成功后，再订购时，可以直接选择使用</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、选择收货方式</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">提供多种收货方式：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）普通快递送货上门</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）加急快递送货上门</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）普通邮递</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）邮政特快专递</span><span lang=\\"EN-US\\">(EMS)</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">详情请点击查看配送范围、时间及运费</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、选择支付方式</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">提供多种支付方式，订购过程中您可以选择：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）货到付款</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）网上支付</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）银行转帐</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）邮局汇款</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">点击查看各种支付方式订单的支付期限</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、索取发票</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">请点击“索取发票”，填写正确的发票抬头、选择正确的发票内容，发票选择成功后，将于订单货物一起送达</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">点击查看发票制度</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">&nbsp;</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、提交订单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）以上信息核实无误后，请点击“提交订单”，系统生成一个订单号，就说明您已经成功提交订单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）订单提交成功后，您可以登陆“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">”查看订单信息或为订单进行网上支付</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">特别提示</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、若您帐户中有礼品卡，可以在“支付方式”处选择使用礼品卡支付，详情请点击查看</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">礼品卡</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、若您帐户中有符合支付该订单的礼券，在结算页面会有“使用礼券”按钮，您点击选择礼券即可，点击查看礼券使用规则</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">当您选择了礼券并点击“确定使用”后，便无法再取消使用该礼券</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、在订单提交高峰时段，新订单可能一段时间之后才会在“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">”中显示。如果您在“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;\\">”中暂未找到这张订单，请您耐心等待</span></p>\r\n<p class=\\"MsoNormal\\"><br />\r\n</p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;\\"><br />\r\n</span></p>', 0);
INSERT INTO `iweb_help` VALUES (27, 3, 0, '积分说明', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">所有会员在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">购物均可获得积分，积分可以用来参与兑换活动。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">会不定期推出各类积分兑换活动，请随时关注关于积分的活动告知。详情请点击查看以下各项说明。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">积分获得</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、每一张成功交易的订单，所付现金部分（含</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">礼品卡）都可获得积分，不同商品积分标准不同，获得积分以订单提交时所注明的积分为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、贵宾会员购物时，将额外获得相应级别的级别赠分。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、阶段性的积分促销活动，也会给您带来额外的促销赠分，详见积分活动。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、促销商品不能获得积分。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">积分有效期</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">积分有效期：获得之日起到次年年底。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">查询积分</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">积分有效期：获得之日起到次年年底。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您可以在</span><span lang=\\"EN-US\\">\\"</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">我的</span><span lang=\\"EN-US\\">iWebShop-</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">我的积分</span><span lang=\\"EN-US\\">\\"</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">中，查看您的累计积分。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">积分活动</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">会不定期地推出各种积分活动，请随时关注关于积分促销的告知。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、会员可以用积分参与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">指定的各种活动，参与后会扣减相应的积分。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、积分不可用于兑换现金，仅限参加</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">指定兑换物品、参与抽奖等各种活动。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">会员积分计划细则</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不同帐户积分不可合并使用；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">·本计划只适用于个人用途而进行的购物，不适用于团体购物、以营利或销售为目的的购买行为、其它非个人用途购买行为。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">·会员积分计划及原</span><span lang=\\"EN-US\\">VIP</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">制度的最终解释权归</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">所有。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">…………………………………………………………………………………………</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">免责条款</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">感谢您访问</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的会员积分计划，本计划由</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">或其关联企业提供。以上计划条款和条件，连同计划有关的任何促销内容的相应条款和条件，构成本计划会员与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">之间关于制度的完整协议。如果您使用</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">，您就参加了本计划并接受了这些条款、条件、限制和要求。请注意，您对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">站的使用以及您的会员资格还受制于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">站上时常更新的所有条款、条件、限制和要求，请仔细阅读这些条款和条件。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">协议的变更</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">可以在没有特殊通知的情况下自行变更本条款、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的任何其它条款和条件、或您的计划会员资格的任何方面。对这些条款的任何修改将被包含在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的更新的条款中。如果任何变更被认定为无效、废止或因任何原因不可执行，则该变更是可分割的，且不影响其它变更或条件的有效性或可执行性。在我们变更这些条款后，您对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的继续使用，构成您对变更的接受。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">终止</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">可以不经通知而自行决定终止全部或部分计划，或终止您的计划会员资格。即使</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">没有要求或强制您严格遵守这些条款，也并不构成对属于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的任何权利的放弃。如果您在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的客户帐户被关闭，那么您也将丧失您的会员资格。对于该会员资格的丧失，您对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">不能主张任何权利或为此索赔。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">责任限制</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">除了</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的使用条件中规定的其它限制和除外情况之外，在中国法律法规所允许的限度内，对于因会员积分计划而引起的或与之有关的任何直接的、间接的、特殊的、附带的、后果性的或惩罚性的损害，或任何其它性质的损害，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的董事、管理人员、雇员、代理或其它代表在任何情况下都不承担责任。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的全部责任，不论是合同、保证、侵权（包括过失）项下的还是其它的责任，均不超过您所购买的与该索赔有关的商品价值额。这些责任排除和限制条款将在法律所允许的最大限度内适用，并在您的计划会员资格被撤销或终止后仍继续有效。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\"><br />\r\n</span></p>', 1303975443);
INSERT INTO `iweb_help` VALUES (26, 3, 0, '会员制度', '<div>会员级别共分七级，具体为：注册会员、铁牌会员、铜牌会员、银牌会员、金牌会员、钻石会员、双钻石会员，级别升降均由系统自动实现，无需申请。</div>\r\n<div><br />\r\n</div>\r\n<div>注册会员：</div>\r\n<div>申请条件：任何愿意到iWebShop购物的用户都可以免费注册。</div>\r\n<div>待　　遇：可以享受注册会员所能购买的产品及服务。</div>\r\n<div>铁牌会员：</div>\r\n<div>申请条件：一年内有过成功消费的会员，金额不限。</div>\r\n<div>待　　遇：可以享受铁牌会员级别所能购买的产品及服务。</div>\r\n<div>铜牌会员：</div>\r\n<div>申请条件：一年内消费金额超过2000元（含）的会员。</div>\r\n<div>待　　遇：可以享受铜牌会员级别所能购买的产品及服务。</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。</div>\r\n<div>银牌会员：</div>\r\n<div>申请条件：一年内消费金额超过5000元（含），需填写本人真实的身份证号码进行升级</div>\r\n<div>待　　遇：可以享受银牌会员级别所能购买的产品及服务。</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。</div>\r\n<div>金牌会员：</div>\r\n<div>申请条件： 一年内累计消费金额超过10000 元（含）。</div>\r\n<div>待　　遇：</div>\r\n<div>享有优先购物权 —— 对国内少见的优秀产品或者其它比较紧俏的产品具有优先购买权。</div>\r\n<div>享受运费优惠政策（详见这里）</div>\r\n<div>享有一年两次的特别针对金牌会员抽奖的权利</div>\r\n<div>不定期举办个别产品针对金牌会员的优惠活动。</div>\r\n<div>享有支付66元DIY装机服务费的权利。</div>\r\n<div>其它相关要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在2500元（含）——5000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为银牌会员；如消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。　</div>\r\n<div>钻石会员：</div>\r\n<div>申请条件：一年内累计消费金额达到 30000 元（含）</div>\r\n<div>享受金牌会员全部待遇。</div>\r\n<div>享受运费优惠政策（详见这里）</div>\r\n<div>享有支付30元DIY装机服务费的权利。</div>\r\n<div>享受一定范围内免返修品快递运费的服务。（详情请查看售后返修品运费规定）</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在5000元（含）——15000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为金牌会员；如消费金额在2500元（含）——5000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为银牌会员；如消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。&nbsp;</div>\r\n<div>双钻石会员：</div>\r\n<div>申请条件：个人用户，年消费金额在10万元（含）以上。</div>\r\n<div>待　　遇：</div>\r\n<div>钻石会员的全部待遇都可以享受。</div>\r\n<div>享有iWebShop网站高管定期提供的沟通服务。</div>\r\n<div>享有不需审核，只需报名，即可参加iWebShop网站举办的网友见面会等网友活动。</div>\r\n<div>享有客服专员定期回访征询意见服务。</div>\r\n<div>其它要求：</div>\r\n<div>身份有效期为一年，一年有效期满后，如在该年度内累计消费金额在15000元（含）——50000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为钻石会员；如消费金额在5000元（含）——15000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为金牌会员；如消费金额在2500元（含）——5000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为银牌会员；如消费金额在1000元（含）——2500元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铜牌会员；如消费金额不满1000元或一年内未完成10个（含）以上不同日期的订单，则系统自动将身份降为铁牌会员。&nbsp;</div>\r\n<div><br />\r\n</div>\r\n<div>注：针对各个级别会员特别声明：</div>\r\n<div>会员账号禁止转借或转让他人使用，如因转借或转让他人使用所带来的一切后果，iWebShop网站概不负责，如被iWebShop网站发现有转借或转让使用情况，iWebShop网站则有权立即取消此会员账号的相应级别资格。</div>\r\n<div>如iWebShop网站发现相应的级别中有经销商，则iWebShop网站有权立即取消此会员帐号的相应级别资格。</div>\r\n<div><br />\r\n</div>', 1303972391);
INSERT INTO `iweb_help` VALUES (28, 3, 0, '交易条款', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站交易条款</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站和您之间的契约</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1.iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站将尽最大努力保证您所购商品与网站上公布的价格一致，但价目表和声明并不构成要约。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站有权在发现了其网站上显现的产品及订单的明显错误或缺货的情况下，单方面撤回。</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">参见下面相关条款</span><span lang=\\"EN-US\\">)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站保留对产品订购的数量的限制权。</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">在下订单的同时，您也同时承认了您拥有购买这些产品的权利能力和行为能力，并且您对您在订单中提供的所有信息的真实性负责。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2. </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">价格变化和缺货</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">产品的价格和可获性都在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站上指明。这类信息将随时更改且不发任何通知。商品的价格都包含了增值税。送货费将另外结算，费用根据您选择的送货方式的不同而异。如果发生了意外情况，在确认了您的订单后，由于供应商提价，税额变化引起的价格变化，或是由于网站的错误等造成商品价格变化，您有权取消您的订单，并希望您能及时通过电子邮件或电话通知</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">客户服务部。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您所订购的商品，如果发生缺货，您有权取消订单。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3. </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮件</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">短信服务</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站保留通过邮件和短信的形式，对本网站注册、购物用户发送订单信息、促销活动等告知服务的权利。如果您在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站注册、购物，表明您已默示同意接受此项服务。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">若您不希望接收</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的邮件，请在邮件下方输入您的</span><span lang=\\"EN-US\\">E-mail</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">地址自助完成退阅；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">若您不希望接收</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的短信，请提供您的手机号码</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">联系客服</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">处理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4. </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">送货</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站将会把产品送到您所指定的送货地址。所有在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站上列出的送货时间为参考时间，参考时间的计算是根据库存状况、正常的处理过程和送货时间、送货地点的基础上估计得出的。参考时间不代表等同于到货时间。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退款政策</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货或换货商品缺货时产生的现金款项，退回方式视支付方式的不同而不同：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网上支付的订单，退款退回至原支付卡；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">银行转帐或邮局汇款支付的订单，退款退回至下订单账户的账户余额中。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6. </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">条款的修正</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">这些交易条件的条款适用于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站为您提供的产品销售服务。这些条款将有可能不时的被修正。任何修正条款的发生，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站都将会及时公布。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7. </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">条款的可执行性</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果出于任何原因，这些条款及其条件的部分不能得以执行，其他条款及其条件的有效性将不受影响。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8. </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">适用的法律和管辖权</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您和</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站之间的契约将适用中华人民共和国的法律，所有的争端将诉诸于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站所在地的人民法院。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站会员制计划（</span><span lang=\\"EN-US\\">VIP</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">计划）协议的变更</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">终止</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">责任限制</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的会员制计划（</span><span lang=\\"EN-US\\">VIP</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">计划），本计划由</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">或其关联企业提供。以上计划条款和条件，连同计划有关的任何促销内容的相应条款和条件，构成本计划会员与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">之间关于制度的完整协议。如果您参加计划，您就接受了这些条款、条件、限制和要求。请注意，您对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的使用以及您的会员资格还受制于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站上时常更新的所有条款、条件、限制和要求，请仔细阅读这些条款和条件。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">协议的变更</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站可以在没有特殊通知的情况下自行变更本条款、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的任何其它条款和条件、或您的计划会员资格的任何方面。</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">对这些条款的任何修改将被包含在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的更新的条款中。如果任何变更被认定为无效、废止或因任何原因不可执行，则该变更是可分割的，且不影响其它变更或条件的有效性或可执行性。在我们变更这些条款后，您对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的继续使用，构成您对变更的接受。如果您不同意本使用交易条款中的任何一条，您可以不使用</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的帐户余额自助提现功能</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站为您提供了帐户余额自助提现功能，在提交提现申请单时，您也同时承认了您拥有提现账户余额的权利能力和行为能力，并且将对您在申请单中提供的所有信息的真实性负责。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">用户在申请使用</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站网络服务时，必须准确提供必要的资料，如资料有任何变动</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">，请在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站产品网站上及时更新。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">用户注册成功后，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站将为其开通一个账户，为用户在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站交易及使用</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站服务时的唯一身份标识，该账户的登录名和密码由用户负责保管；用户应当对以其账户进行的所有活动和事件负法律责任。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">终止</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站可以不经通知而自行决定终止全部或部分计划，或终止您的计划会员资格。即使</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站没有要求或强制您严格遵守这些条款，也并不构成对属于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的任何权利的放弃。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的客户账户被关闭，那么您也将丧失您的会员资格。对于该会员资格的丧失，您对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站不能主张任何权利或为此索赔。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">责任限制</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">除了</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的使用条件中规定的其它限制和除外情况之外，在中国法律法规所允许的限度内，对于因</span><span lang=\\"EN-US\\">VIP</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">计划而引起的或与之有关的任何直接的、间接的、特殊的、附带的、后果性的或惩罚性的损害，或任何其它性质的损害，</span><span lang=\\"EN-US\\"> iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的董事、管理人员、雇员、代理或其它代表在任何情况下都不承担责任。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的全部责任</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，不论是合同、保证、侵权（包括过失）项下的还是其它的责任，均不超过您所购买的与该索赔有关的商品价值额。这些责任排除和限制条款将在法律所允许的最大限度内适用，并在您的计划会员资格被撤销或终止后仍继续有效。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">隐私声明</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">电子通讯</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">当您访问</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站或给我们发送电子邮件时，您与我们用电子方式进行联系。您同意以电子方式接受我们的信息。我们将用电子邮件或通过在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站上发布通知的方式与您进行联系。您同意我们用电子方式提供给您的所有协议、通知、披露和其他信息是符合此类通讯必须是书面形式的法定要求的。如果</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站能够证明以电子形式的信息已经发送给您或者</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站立即在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站上张贴这样的通知，将被视为您已收到所有协议、声明、披露和其他信息</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">版权声明</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站上的所有内容诸如文字、图表、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件、商标都是</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站或其关联公司或其内容提供者的财产，受中国和国际版权法的保护。未经</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站书面授权或许可</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，不得以任何目的对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站或其任何部分进行复制、复印、仿造、出售、转售、访问、或以其他方式加以利用。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您的账户</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您使用</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站，您有责任对您的账户和密码保守秘密并对进入您的计算机作出限制，并且您同意对在您的账户和密码下发生的所有活动承担责任。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的确销售供儿童使用的产品，但只将它们销售给成年人。如果您在</span><span lang=\\"EN-US\\">18</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">岁以下，您只能在父母或监护人的参与下才能使用</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站及其关联公司保留在中华人民共和国法律允许的范围内独自决定拒绝服务、关闭账户、清除或编辑内容或取消订单的权利。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">评论、意见、消息和其他内容</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">访问者可以张贴评论、意见及其他内容，以及提出建议、主意、意见、问题或其他信息，只要内容不是非法、淫秽、威胁、诽谤、侵犯隐私、侵犯知识产权或以其他形式对第三者构成伤害或侵犯或令公众讨厌，也不包含软件病毒、政治宣传、商业招揽、连锁信、大宗邮件或任何形式的</span><span lang=\\"EN-US\\">\\"</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">垃圾邮件</span><span lang=\\"EN-US\\">\\"</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">。您不可以使用虚假的电子邮件地址、冒充任何他人或实体或以其它方式对卡片或其他内容的来源进行误导。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站保留清除或编辑这些内容的权利（但非义务），但不对所张贴的内容进行经常性的审查。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您确实张贴了内容或提交了材料，除非我们有相反指示，您授予</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站及其关联公司非排他的、免费的、永久的、不可撤销的和完全的再许可权而在全世界范围内任何媒体上使用、复制、修改、改写、出版、翻译、创作衍生作品、分发和展示这样的内容。您授予</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站及其关联公司和被转许可人使用您所提交的与这些内容有关的名字的权利，如果他们选择这样做的话。您声明并担保您拥有或以其它方式控制您所张贴内容的权利，内容是准确的，对您所提供内容的使用不违反本政策并不会对任何人和实体造成伤害。您声明并保证对于因您所提供的内容引起的对</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站或其关联公司的损害进行赔偿。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站有权（但非义务）监控和编辑或清除任何活动或内容。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站对您或任何第三方所张贴的内容不承担责任。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">合同缔结</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您通过我们网站订购产品，您的订单就成为一种购买产品的申请或要约。我们将发送给您一封确认收到订单的电子邮件，其中载明订单的细节。但是只有当我们向您发出送货确认的电子邮件通知您我们已将产品发出时，我们对您合同申请的批准与接受才成立。如果您在一份订单里订购了多种产品并且我们只给您发出了关于其中一部分的发货确认电子邮件，那么直到我们发出关于其他产品的发货确认电子邮件，关于那部分产品的合同才成立。当您所购买的商品离开了</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站或其关联公司的库房时，该物品的所有权和灭失风险即转移到您这一方。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">产品说明</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站及其关联公司努力使产品说明尽可能准确。不过，我们并不保证产品说明或</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站上的其他内容是准确的、完整的、可靠的、最新的或无错误的。如果</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站提供的产品本身并非如说明所说，您唯一的救济是将该未经使用过的产品退还我们。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">价格</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">直到您发出订单，我们才能确认商品的价格。尽管我们做出最大的努力，我们的商品目录里的一小部分商品可能会有定价错误。如果我们发现错误定价，我们将采取下列之一措施：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">i</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">如果某一商品的正确定价低于我们的错误定价，我们将按照较低的定价向您销售交付该商品。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">ii</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">如果某一商品的正确定价高于我们的错误定价，我们会根据我们的情况决定</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">是否在交付前联系您寻求您的指示</span><span lang=\\"EN-US\\">, </span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">或者取消订单并通知您。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">其他企业</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站及其关联企业之外的其他人可能在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站上经营商店、提供服务或者销售产品。另外，我们提供与关联公司和其他企业的链接。我们不负责审查和评估也不担保任何这些企业或个人的待售商品及它们网站的内容。我们对所有这些企业或任何其他第三人或其网站的行为、产品和内容不承担责任。您应仔细阅读它们自己的隐私政策及使用条件。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975478);
INSERT INTO `iweb_help` VALUES (29, 3, 0, '订单状态', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">一个</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的新订单从下单到订单完成，会经历各种状态，我们会将各种状态显示在订单详情页面，希望以此种方式让您更好的了解订单情况，及时跟踪订单状态，打消疑虑并顺利完成购物。以下是订单状态的简单说明：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">等待付款：如果您选择“在线支付”“银行卡转账”“邮局汇款”“公司转账”“分期付款”“高校</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自己支付”“高校</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">代理垫付”这几种支付方式，在成功支付且得到财务确认之前，订单状态会显示为等待付款；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">正在配货：该状态说明</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站正在为您的订单进行配货，包括</span><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个子状态</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）打印：将您订购的商品打印成单，便于出库员取货</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）出库：出库员找到您订购的商品并出库</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）扫描：扫描员扫描您订购的商品并确认商品成功出库</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）打包：打包员将您订购的商品放入包裹以便运输</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）发货：发货员将您的包裹发货运输</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站送货：您订购的商品已经发货，正在运送途中</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">收货并确认：货物已发出一段时间，如果您已收到货物可以点击确认按钮进行确认</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">上门自提：该状态说明您订购的商品已经送至相应自提点，请您尽快到自提点提货</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">已完成：此次交易已经完成，希望能得到您的满意</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">已锁定：如果您修改了订单但没有修改成功，则系统会自动锁定您的订单，您可以在订单列表页面点击操作栏中的“解锁订单”使订单恢复正常</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">订单待审核：该状态说明您订购的某类商品缺货，需要</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站将货物备齐后订单才会恢复正常状态，此状态下请您不要进行付款操作，以免货物无法备齐而占用您的货款</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">修改订单常见问题：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、什么时候允许修改订单？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站下单后，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站后台程序会通过一系列算法来判断您的订单是否可以修改，如果可以修改，您在订单操作一列可以看到“修改订单”链接，此时说明订单可以修改。如果没有此链接，说明该订单不可修改。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">一般来说，在您选购的商品没有打印完毕之前，都是可以修改订单的。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、我能修改订单的哪些内容？</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">修改购物车内的商品数量，增加或删除商品；（暂不支持添加套装）</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">修改收货人信息、配送方式、发票信息、订单备注；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">添加优惠券或删除已使用的优惠券；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：由于目前暂不支持修改支付方式，所以一些与支付方式相关联的收货地址可能也无法修改。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、修改订单时，订单为什么会被锁定？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为了避免您在修改订单的同时，您的订单继续被程序处理和执行，我们会在您修改订单过程中锁定您的订单，直到您完成修改并点击了“提交订单”按钮。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您在修改过程当中放弃了修改，建议您返回订单列表页面点击操作栏中的“解锁订单”，否则您的订单将在</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个小时后解锁，将影响您订单的生产时间和收货时间。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、如果购物车里某一款商品下单时的价格和修改订单当时的价格不一致，按哪个来算商品价格呢？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您不修改该商品的购买数量，那么价格和赠品都会维持您下单时的状态不变；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您修改了该商品购买数量或者添加了新商品，那么价格和赠品都会与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站最新显示的价格和赠品一致。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果您添加了新商品，那么新商品的价格与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站最新显示的价格和赠品一致。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、可以先申请价保后再修改订单吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不可以，如果你对某商品申请了价保，那么该商品将不能进行修改和删除，除非您删除整个订单。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975502);
INSERT INTO `iweb_help` VALUES (30, 4, 0, '货到付款', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">货到付款：货物送到订单指定的收货地址后，由收货人支付货款给送货人员</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">货到付款适用于加急快递、普通快递送货上门的订单。请您在订购过程的“付款方式”处，选择货到付款</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、货到付款仅限支付现金</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、签收时，请您仔细核兑款项、务必作到货款两清，若事后发现款项错误，我们将无法再核实确认点击查看当当网签收验货政策</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、部分商店街的商家不支持货到付款，请您通过网上支付、邮局汇款、银行转帐方式支付</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975553);
INSERT INTO `iweb_help` VALUES (31, 4, 0, '在线支付', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站提供的在线支付方式</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站目前有以下支付平台可供选择：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）工商银行网上银行支付平台，支持工商银行银行卡网上在线支付</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）招商银行网上银行支付平台，支持招商银行银行卡网上在线支付</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）建设银行网上银行支付平台，支持建设银行银行卡网上在线支付</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）农业银行网上银行支付平台，支持</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">农业银行银行卡网上在线支付</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）支付宝支付平台，关于支付宝的支付帮助请查看</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）财付通支付平台，关于财付通的支付帮助请查看</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">7</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）快钱</span><span lang=\\"EN-US\\">99Bill</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">支付平台，关于快钱支付平台的支付帮助请查看</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">8</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）环迅</span><span lang=\\"EN-US\\">IPS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，关于环迅支付平台的支付帮助请查看</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">9</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站虚拟账户支付</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、如您是第一次进行网上在线支付，建议事先拨打银行卡所属发卡银行的热线电话，详细咨询可在其网上进行在线支付的银行卡种类及相关开通手续。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975582);
INSERT INTO `iweb_help` VALUES (32, 4, 0, '银行电汇', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">请在电汇单“汇款用途”一栏处注明您的订单号，银行汇款到账通常需要</span><span lang=\\"EN-US\\">2~3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个工作日的时间，我们将在款到后当日为您发货。否则我们无法及时核对审核，这将延误您的发货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">使用银行电汇支付，请务必在</span><span lang=\\"EN-US\\">3*24</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">小时之内支付，逾时订单将会自动作废。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果有些银行网点不能提供填写订单号，请汇款后联系我们。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">银行电汇账户信息：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">银行</span><span lang=\\"EN-US\\"> <span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">账户信息</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">工商银行</span><span lang=\\"EN-US\\"> <span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">户</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">名：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">有限公司</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">开户行：工商银行</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">支行</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">账</span> <span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">号：</span><span lang=\\"EN-US\\">1001*****</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">建设银行</span><span lang=\\"EN-US\\"> <span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">户</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">名：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">有限公司</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">开户行：建设银行</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">支行</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">账</span> <span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">号：</span><span lang=\\"EN-US\\">3100*****</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">招商银行</span><span lang=\\"EN-US\\"> <span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">户</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">名：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">有限公司</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">开户行：招商银行</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">支行</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">账</span> <span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">号：</span><span lang=\\"EN-US\\">1219*****</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">交通银行</span><span lang=\\"EN-US\\"> <span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">户</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">名：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">有限公司</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">开户行：交通银行</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">支行</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">账</span> <span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">号：</span><span lang=\\"EN-US\\">3100*****</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">汇单范例</span></p>', 1303975610);
INSERT INTO `iweb_help` VALUES (33, 4, 0, '余额支付', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">用户还可以通过使用账户中心中的余额来对订单进行支付</span></p>', 1303975628);
INSERT INTO `iweb_help` VALUES (34, 6, 0, '配送范围及运费', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站购物满</span><span lang=\\"EN-US\\">29</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元免运费，查看详情</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">普通快递送货上门</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">覆盖全国</span><span lang=\\"EN-US\\">800</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">多个城市，运费</span><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">包裹，购物满</span><span lang=\\"EN-US\\">29</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元免运费</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">加急快递送货上门</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">支持北京、天津、上海、广州、深圳、廊坊，限当地发货订单，运费</span><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">包裹</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">圆通快递</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">北京地区：运费</span><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">普通邮递</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">大陆地区：运费</span><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">包裹，购物满</span><span lang=\\"EN-US\\">29</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元免运费</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">港澳地区：运费为商品原价总金额的</span><span lang=\\"EN-US\\">30%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，最低</span><span lang=\\"EN-US\\">20</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">海外地区：运费为商品原价总金额的</span><span lang=\\"EN-US\\">50%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，最低</span><span lang=\\"EN-US\\">50</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政特快专递</span><span lang=\\"EN-US\\">(EMS)</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">北京地区：运费为订单总金额的</span><span lang=\\"EN-US\\">50%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，最低</span><span lang=\\"EN-US\\">20</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">大陆其它地区：运费为订单总金额的</span><span lang=\\"EN-US\\">100%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，最低</span><span lang=\\"EN-US\\">20</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">港澳台地区：运费为商品原价总金额的</span><span lang=\\"EN-US\\">70%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，最低</span><span lang=\\"EN-US\\">60</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975661);
INSERT INTO `iweb_help` VALUES (35, 6, 0, '上门自提', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注意事项：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提时间：周一至周日，</span><span lang=\\"EN-US\\">09:00</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">－</span><span lang=\\"EN-US\\">19:00</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（如遇国家法定节假日，则以</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站新闻发布放假时间为准，请大家届时关注）</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品到达自提点后，我们将为您保留三天，超过三天不上门提货，则视为默认取消订单；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">钱、货需客户当面点清，离开提货前台后</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站将不再对钱、货数量负责；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">货物价保需客户在自提当场提出，离开提货前台后</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站不再对自提货物提供价保服务；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">普通发票：每张订单需在自提当日开具发票，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站不提供累计开具发票的服务；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">增值税发票：选择</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机刷卡，不能开具增票；增票当日无法开具，需订单完成后三个工作日左右</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站按订单地址将增票快递给客户，如订单中地址有误请及时通知</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服人员。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">特殊说明：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">上门自提的订单，请在规定的时间内到自提点提取货物。上门自提订单原则上免收配送费用，但如果一个</span><span lang=\\"EN-US\\">ID</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">帐号在一个月内有过</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">次以上或一年内有过</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">次以上，在规定的时间内无理由不履约提货，我司将在相应的</span><span lang=\\"EN-US\\">ID</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">帐户里每单扣除</span><span lang=\\"EN-US\\">50</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个积分做为运费；时间计算方法为：成功提交订单后向前推算</span><span lang=\\"EN-US\\">30</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天为一个月，成功提交订单后向前推算</span><span lang=\\"EN-US\\">365</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天为一年，不以自然月和自然年计算；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">对于上门自提的客户，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站可以接受现金、支票（北京和上海的自提点支持，其他城市的自提点不支持）和</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机刷卡三种付款方式。选择支票支付方式，需要客户自行将支票内容填写完整（货款在</span><span lang=\\"EN-US\\">5000</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元或</span><span lang=\\"EN-US\\">5000</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元以上，需要款到帐后方可提货）；</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机刷卡只支持带有银联标识的银行卡。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">信用卡</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机刷卡消费超过</span><span lang=\\"EN-US\\">4500</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元时，发卡银行按照相关规定有可能不向您赠送积分，具体信息请致电发卡行确认。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提点</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提点适用范围：以下地区用户均可到相应自提点付款提货，无需支付运费（大家电产品限物流中心自提点）。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以下各自提点均不接收由于各种原因被客户邮寄退回的商品，否则出现的一切后果</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站概不负责。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">友好提示</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">下单之后可以更换自提点或更换配送方式吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">可以更换自提点但无法更换配送方式。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">方法：我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">订单中心</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">点“查看”</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">进入订单详细页面</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">订单操作</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">修改订单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">一般来说，在您选购的商品没有打印完毕之前，都是可以修改订单的。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提时验货发现问题，可以当场换货吗？如何处理？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不可以。自提时如果发现货品有问题请当场反映给</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站工作人员，由工作人员帮您处理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提价格和其它配送方式价格是否一样？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不管您选用哪种配送方式，商品的价格是一样的。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">可以到自提点付款，贵公司工作人员送货到家吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不可以，自提点采用的是上门付款提货方式。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为何结算时找不到某某自提点？</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）可能是您所下订单的收货地址与该自提点不在一个省市；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）或者该自提点已经更换名称、地址；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）或者是您所购买的商品是大家电，该分类下部分商品只支持部分地区物流总部自提。详情以下单时所支持配送方式为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提点可以先验货后付款吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不可以，我司不管哪种配送方式都是采取先付款后验货的方式。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">任何商品都可以自提吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">除了虚拟商品和服务类商品（如网络版杀毒软件）及部分大家电无法自提外，其它都可以自提。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">上门自提能用支付宝支付吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不可以。对于上门自提的客户，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站可以接受现金、支票和</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机刷卡三种付款方式。选择支票支付方式，需要客户自行将支票内容填写完整（货款在</span><span lang=\\"EN-US\\">5000</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元或</span><span lang=\\"EN-US\\">5000</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元以上，需要款到帐后方可提货）；</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机刷卡只支持带有银联标识的银行卡。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提点装机需要自带什么，比如：系统盘等等</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提点装机服务负责仅配置单里的散件组装，如您希望安装系统请自带系统盘，我们会指导您安装。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">购买配件，上门自提时可以提供安装服务吗？（比如内存条）</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">购买配件，自提时不提供安装服务，希望您能理解。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975686);
INSERT INTO `iweb_help` VALUES (36, 6, 0, '加急快递', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如何正确选择加急配送服务</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">北京、天津、上海、广州、深圳、廊坊</span><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个城市地区的用户，并且为当地发货订单，用户可在结算中心“送货方式”部分选择加急快递送货上门服务。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">常见问题解答：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">我的订单什么时候可以送到？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">具体配送时间根据不同城市略有不同，请查看配送范围及运费</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2.\\"</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">加急快递送货上门</span><span lang=\\"EN-US\\">\\"</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的费收取标准？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">北京、天津、上海、广州、深圳、廊坊</span><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个城市的“加急快递送货上门”配送费为</span><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975706);
INSERT INTO `iweb_help` VALUES (37, 6, 0, '商品验货与签收', '<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">快递送货上门、圆通快递的订单</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">1</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、签收时仔细核对：商品及配件、商品数量、</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">iWebShop</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">网站的发货清单、发票（如有）、三包凭证（如有）等</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">2</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、若存在包装破损、商品错误、商品少发、商品有表面质量问题等影响签收的因素，请您一定要当面向送货员说明情况并当场整单退货</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">邮局邮寄的订单</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">1</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、请您一定要小心开包，以免尖锐物件损伤到包裹内的商品</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">2</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、签收时仔细核对：商品及配件、商品数量、</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">iWebShop</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">网站的发货清单、发票（如有）、三包凭证（如有）等</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">3</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、若包装破损、商品错误、商品少发、商品存在表面质量问题等，您可以选择整单退货；或是求邮局开具相关证明后签收，然后登陆</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">iWebShop</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">网站申请退货或申请换货</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">温馨提示</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">1</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、货到付款的订单送达时，请您当面与送货员核兑商品与款项，确保货款两清；若事后发现款项有误，</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">iWebShop</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">网站将无法为您处理</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">2</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、请收货时务必认真核对，若您或您的委托人已签收，则说明订单商品正确无误且不存在影响使用的因素，</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">iWebShop</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">网站有权不受理因包装或商品破损、商品错漏发、商品表面质量问题、商品附带品及赠品少发为由的退换货申请</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">3</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">、部分商品由商店街的商家提供</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">,</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">这部分商品的验货验收不在</span><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\">iWebShop</span><span style=\\"\\\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\\\&quot;\\">网站承诺的范围内</span></p>\r\n<p class=\\"\\\\&quot;MsoNormal\\\\&quot;\\"><span lang=\\"\\\\&quot;EN-US\\\\&quot;\\"><o:p>&nbsp;</o:p></span></p>', 1303975725);
INSERT INTO `iweb_help` VALUES (38, 6, 0, 'EMS/邮政普包', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站目前除提供</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站快递以及上门自提服务以外，还提供了更多样的配送方式，支持更多地区的配送服务。目前开通的快递有圆通快递、宅急送、邮政普包和邮政</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（邮政特快专递）等。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政普包运费标准</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">区域</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">省</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">市</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count: 1\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">运费</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">一区</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">北京、上海、广东、江苏、浙江、山东、湖北、陕西、四川</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">二区</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天津、重庆、黑龙江、吉林、辽宁、河北、河南、山西、安徽、江西、湖南、福建、广西、海南</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">公斤以下：</span><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（含）公斤以上：</span><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">三区</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">内蒙古、甘肃、宁夏、云南、贵州、青海、新疆、西藏</span><span lang=\\"EN-US\\"><span style=\\"mso-tab-count:1;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">公斤以下：</span><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（含）公斤以上：</span><span lang=\\"EN-US\\">15</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">单</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政普包到货时间</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">根据邮政系统服务时限，邮政普包的货物到货（到客户所在地邮政局）时间为</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">～</span><span lang=\\"EN-US\\">15</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个工作日，在到货后需要凭包裹单据去包裹所在邮政局领取。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政普包跟踪查询</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政普包跟踪查询请点击此处</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">http://yjcx.chinapost.com.cn/queryMail.do?action=batchQueryMail</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">运费标准</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">按优惠资费起重</span><span lang=\\"EN-US\\">500</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">克以内</span><span lang=\\"EN-US\\">16</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元，续重不同省市资费会有所不同。以</span><span lang=\\"EN-US\\">500</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">克为计算资费单位，即每件包裹重量尾数不满</span><span lang=\\"EN-US\\">500</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">克的，应进整按</span><span lang=\\"EN-US\\">500</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">克计算资费。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">到货时间</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">根据邮政系统服务时限，邮政</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的货物到货时间为</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">～</span><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个工作日（节假日除外）。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">跟踪查询</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">跟踪查询请点击此处</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">http://www.ems.com.cn/qcgzOutQueryNewAction.do?reqCode=gotoSearch</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">由于第三方物流公司配送区域变动频繁，请您采用以上配送方式时先行查阅配送公司的配送范围，以保证您的订单可以及时到达。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">在您成功提交订单后，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站在确认到款的情况下会尽快安排商品的出库，您的货物运单号也会在货物出库后的第二至三个工作日添加到您的帐户中心</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您可以登陆帐户中心的订单查询页面进行查询跟踪您的货物情况。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">音响设备江浙沪地区以外的地方需要空运，请选择</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，选择圆通可能会造成不必要的延误和退件。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">关于送货时间</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">货物如未在您选定送货方式规定的最长送货时间内送达，您可以选择以下方式处理；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您可以进入</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站网帐户中心，选择“订单管理”，根据您的订单号码查询到自己的运单号，然后直接进入圆通快递公司网站</span><span lang=\\"EN-US\\">http://www.yto.net.cn/</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">，输入运单号，在线查询配送状况；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您可以进入相应快递公司网站，查询您所在地的快递公司分部联系电话，拨打查询；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您可以点击网站首页右侧的在线客服给我们留言，告知订单号，我们将为您及时处理；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您可以拨打服务电话</span><span lang=\\"EN-US\\">400-820-4400</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">通知我们，我们将为您及时处理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">选择邮政配送方式的客户在收到产品后可在邮局工作人员的面前拆包，如产品损坏，可直接在签收单上注明：内件损坏，本人拒收字样，由邮局再返回</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站和邮局协商赔偿事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如签收后未当面开封，产品出现问题，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站很难和邮局协商赔偿，为了客户的利益，希望客户能够执行并理解。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">选择其他方式的客户在收到货物时，请您认真检查外包装。如有明显损坏迹象，您可以拒收该货品，并及时通知我们。我们会处理并承担由此而产生的运输费用，请客户不必担心。如您签收有明显损坏迹象的外包装后再投诉货物有误或有损坏，恕我们不能受理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975760);
INSERT INTO `iweb_help` VALUES (39, 5, 0, '换货说明', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站承诺自顾客收到商品之日起</span><span lang=\\"EN-US\\">15</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">日内（以发票日期为准，如无发票以</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站发货清单的日期为准），如符合以下条件，我们提供换货服务：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、商品及商品本身的外包装没有损坏，保持</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站出售时的原质原样；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、注明换货原因，如果商品存在质量问题，请务必说明；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、确保商品及配件、附带品或者赠品、保修卡、三包凭证、发票、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站发货清单齐全；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、如果成套商品中有部分商品存在质量问题，在办理换货时，必须提供成套商品；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站中的部分商品是由与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站签订合同的商家提供的，这些商品的换货请与商家联系</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以下情况不予办理换货：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、任何非由</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站出售的商品；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、任何已使用过的商品，但有质量问题除外；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、任何因非正常使用及保管导致出现质量问题的商品。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、所有未经客服确认擅自退回的商品，换货申请无法受理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">特殊说明：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、食品、保健食品类：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">食品类商品不予换货，但有质量问题除外；如商品过期或距离保质期结束不到</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个月。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、美妆个护类：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">化妆品及个人护理用品属于特殊商品不予换货，但有质量问题除外，如商品包装破损，商品过期或离过期不到</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个月。我们保证商品的进货渠道和质量，如果您在使用时对商品质量表示置疑，请出具书面鉴定，我们会按照国家法律规定予以处理。因个人喜好（气味，色泽、型号，外观）和个人肤质不同要求的换货将无法受理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、母婴用品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品签收后不予换货，但有质量问题除外，洗涤方法参考说明，正常缩水</span><span lang=\\"EN-US\\">10%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以内正常，不属于质量问题。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、服装类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">内衣类商品，如内衣裤，袜子，文胸类商品，除质量问题除外，不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、鞋帽箱包类：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品配件（如配饰挂坠等）、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、玩具类：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品签收后不予换货，但有质量问题除外。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、家居类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤），不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品配件、说明书、保修单、标签等丢失，不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、手表类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">手表类商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以下情况不予办理换货：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果商品自身携带的产品序列号与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站售出的不符；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">缺少随商品附带的保修卡、发票、配件等；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品已打开塑封包装或撕开开箱即损贴纸者，但有质量问题除外；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">将商品存储、暴露在超出商品适宜的环境中；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">未经授权的修理、误用、疏忽、滥用、事故、改动、不正确的安装；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">食物或液体溅落造成损坏；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品使用中出现的磨损，非质量问题。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">手表表带经过调整，但有质量问题除外。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">非质量问题。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、珠宝首饰类及礼品类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">对于附带国家级宝玉石鉴定中心出具的鉴定证书的，非质量问题不予换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客在收到商品之日起（以发票日期为准）</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个月内，如果出现质量问题，请到当地的质量监督部门</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">珠宝玉石质量检验中心进行检测，如检测报告确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货时，请您务必将商品的外包装、内带附件、鉴定证书、说明书等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">对于高档首饰都附带国家级宝玉石鉴定中心出具的鉴定证书，如果您对此有任何质疑，请到出具该证书的鉴定机构进行复检。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">瑞士军刀、</span><span lang=\\"EN-US\\">zippo</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">打火机、钻石、</span><span lang=\\"EN-US\\">18K</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">金，如无质量问题不换货，有质量问题请出示检测报告，方可换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为了保证您的利益，请您在收到商品时，仔细检查，如果您发现有任何问题，请您当时指出，并办理换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、软件类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">软件类商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如出现质量问题请您直接按照说明书上的联系方式与厂家的售后部门联系解决；已打开塑封包装，不予退换货，但有质量问题除外。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">11</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、手机、数码相机、数码摄像机、笔记本电脑等商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客收到商品之日起（以发票日期为准）七日内，有非人为质量问题凭有效检测报告可选择退换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客收到商品之日起（以发票日期为准）八至十五日内，有非人为质量问题凭有效检测报告可选择更换同型号商品。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客收到商品之日起（以发票日期为准）十六日至一年内，有非人为质量问题可在当地保修点免费保修。配件保修请参阅保修卡。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为了您的自身权益请妥善保存发票和保修卡，如有发生质量问题请携带发票和保修卡及时到当地检测点检测，以免给您造成不必要的损失。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退换货要求：保修卡、发票、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站发货清单、有效检测报告一律齐全，并且配件完整，包装盒完好，否则将不予受理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">全国各地检测、保修点请在保修卡中查找。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不接受无检测报告</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">并且不在规定时间内的退换货要求。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换机产生的邮费由买卖双方各自承担。换货商品一律以邮寄的方式发出。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货地址及联系电话详见各商品页面“售后服务”。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如需换货请您先联系</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服，在客服人员指导下，一律以邮寄方式完成换货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">12</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、数码类（手机、数码相机、数码摄像机、笔记本电脑除外）</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">13</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、电脑办公类</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">14</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、家电类</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系，如果确认属于质量问题，持厂家出具质量问题检测报告与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">15</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、康体保健器材类商品</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">16</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、汽车用品类</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">汽车养护用品、汽车耗材开封后不换货。（例如车蜡、防护贴膜、清洗剂、车内空气净化、车用油品等）</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品换货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理换货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>', 1303975802);
INSERT INTO `iweb_help` VALUES (40, 5, 0, '退货说明', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站承诺自顾客收到商品之日起</span><span lang=\\"EN-US\\">7</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">日内（以发票日期为准，如无发票以</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站发货清单的日期为准），如符合以下条件，我们将提供全款退货的服务：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、商品及商品本身的外包装没有损坏，保持</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站出售时的原质原样；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、注明退货原因，如果商品存在质量问题，请务必说明；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、确保商品及配件、附带品或者赠品、保修卡、三包凭证、发票、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站发货清单齐全；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、如果成套商品中有部分商品存在质量问题，在办理退货时，必须提供成套商品；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站中的部分商品是由与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站签订合同的商家提供的，这些商品的退货请与商家联系</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以下情况不予办理退货：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、任何非由</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站出售的商品；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、任何已使用过的商品，但有质量问题除外；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、任何因非正常使用及保管导致出现质量问题的商品。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">特殊说明：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、食品、保健食品类：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">食品类商品不予退货，但有质量问题除外；如商品过期或距离保质期结束不到</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个月。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、美妆个护类：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">化妆品及个人护理用品属于特殊商品不予退货，但有质量问题除外，如商品包装破损，商品过期或离过期不到</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个月。我们保证商品的进货渠道和质量，如果您在使用时对商品质量表示置疑，请出具书面鉴定，我们会按照国家法律规定予以处理。因个人喜好（气味，色泽、型号，外观）和个人肤质不同要求的退货将无法受理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、母婴用品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品签收后不予退货，但有质量问题除外，洗涤方法参考说明，正常缩水</span><span lang=\\"EN-US\\">10%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以内正常，不属于质量问题。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、服装类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">内衣类商品，如内衣裤，袜子，文胸类商品，除质量问题除外，不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤，长时间穿着等），不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品附件（如纽扣等）、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、鞋帽箱包类：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品配件（如配饰挂坠等）、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、玩具类：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品签收后不予退货，但有质量问题除外。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、家居类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">因个人原因造成的商品损坏（如自行修改尺寸，洗涤），不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品吊牌，包装破损，发货单、商品配件、说明书、保修单、标签等丢失，不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：图片及信息仅供参考，不属质量问题。因拍摄灯光、显示器分辨率等原因可能会造成轻微色差，在网购中属于正常现象，一切以实物为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：品牌商品按其三包约定执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、手表类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">手表类商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">以下情况不予办理退货：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果商品自身携带的产品序列号与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站售出的不符；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">缺少随商品附带的保修卡、发票、配件等；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品已打开塑封包装或撕开开箱即损贴纸者，但有质量问题除外；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">将商品存储、暴露在超出商品适宜的环境中；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">未经授权的修理、误用、疏忽、滥用、事故、改动、不正确的安装；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">食物或液体溅落造成损坏；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品使用中出现的磨损，非质量问题。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">手表表带经过调整，但有质量问题除外。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">非质量问题。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、珠宝首饰类及礼品类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">对于附带国家级宝玉石鉴定中心出具的鉴定证书的，非质量问题不予退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客在收到商品之日起（以发票日期为准）</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个月内，如果出现质量问题，请到当地的质量监督部门</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">珠宝玉石质量检验中心进行检测，如检测报告确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货时，请您务必将商品的外包装、内带附件、鉴定证书、说明书等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">对于高档首饰都附带国家级宝玉石鉴定中心出具的鉴定证书，如果您对此有任何质疑，请到出具该证书的鉴定机构进行复检。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">瑞士军刀、</span><span lang=\\"EN-US\\">zippo</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">打火机、钻石、</span><span lang=\\"EN-US\\">18K</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">金，如无质量问题不退货，有质量问题请出示检测报告，方可退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为了保证您的利益，请您在收到商品时，仔细检查，如果您发现有任何问题，请您当时指出，并办理退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、软件类商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">软件类商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如出现质量问题请您直接按照说明书上的联系方式与厂家的售后部门联系解决；已打开塑封包装，不予退换货，但有质量问题除外。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">11</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、手机、数码相机、数码摄像机、笔记本电脑等商品：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客收到商品之日起（以发票日期为准）七日内，有非人为质量问题凭有效检测报告可选择退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客收到商品之日起（以发票日期为准）八至十五日内，有非人为质量问题凭有效检测报告可选择更换同型号商品。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">顾客收到商品之日起（以发票日期为准）十六日至一年内，有非人为质量问题可在当地保修点免费保修。配件保修请参阅保修卡。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为了您的自身权益请妥善保存发票和保修卡，如有发生质量问题请携带发票和保修卡及时到当地检测点检测，以免给您造成不必要的损失。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退换货要求：保修卡、发票、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站发货清单、有效检测报告一律齐全，并且配件完整，包装盒完好，否则将不予受理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">6)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">全国各地检测、保修点请在保修卡中查找。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">7)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不接受无检测报告</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">并且不在规定时间内的退换货要求。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">8)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换机产生的邮费由买卖双方各自承担。换货商品一律以邮寄的方式发出。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">9)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货地址及联系电话详见各商品页面“售后服务”。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">10)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如需退货请您先联系</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服，在客服人员指导下，一律以邮寄方式完成退货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">12</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、数码类（手机、数码相机、数码摄像机、笔记本电脑除外）</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">13</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、电脑办公类</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">14</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、家电类</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系，如果确认属于质量问题，持厂家出具质量问题检测报告与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">15</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、康体保健器材类商品</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">16</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、汽车用品类</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">汽车养护用品、汽车耗材开封后不予退货。（例如车蜡、防护贴膜、清洗剂、车内空气净化、车用油品等）</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品退货说明请您以商品的单品页面说明为准；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">商品如出现质量问题，请先行按照说明书上的联系方式与厂家的售后部门联系。如果确认属于质量问题，请与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站客服中心联系办理退货事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">退货时，请您务必将商品的外包装、内带附件、保修卡、说明书、发票等随同商品一起退回。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：平邮客户以包裹单上的签收日期为主。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\"><br />\r\n</span></p>', 1303975837);
INSERT INTO `iweb_help` VALUES (41, 5, 0, '退/换货注意事项', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、邮寄时请认真填写以下信息，否则将影响您的退</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货办理：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　·您的姓名</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　·收货地址、</span><span lang=\\"EN-US\\">Email</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　·订单号、商品名称和型号</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">　·退</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货原因</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、如需检验报告的商品</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">您还需要提供检验报告，查看退货说明、换货说明；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、请您在收到商品后尽快进行“确认收货”操作，否则将会影响您的退</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货的办理；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的部分商品是由与</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站合作的商家提供的，此商品的退</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换货流程请直接与商家联系。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975866);
INSERT INTO `iweb_help` VALUES (42, 5, 0, '余额的使用与提现', '<p class="\\&quot;MsoNormal\\&quot;"><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">一、账户余额支付：</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">1</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、“我的</span><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;">网站</span><span lang="\\&quot;EN-US\\&quot;">-</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">账户管理”是您在</span><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;">网站上的专用帐户。</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">2</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、账户内的金额是顾客在</span><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;">网站购物后余下的现金或通过邮局、银行多余汇款的总和，如下图：</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">3</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、您可登录“我的</span><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;">网站”查询余额。</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">4</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、在订单结算时，系统将自动使用您的账户余额，您只需支付其余货款：</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">5</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、如果您的账户余额足以支付订单，您仍需选择一种支付方式，否则将无法提交订单。</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">二、账户余额提现</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">网站为您提供了账户余额提现功能，您可以将您在</span><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;">网站账户余额中的可用余额提取为现金，我们会已邮局汇款的方式退给您。</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">账户余额提现的流程：</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">温馨提示：</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">1</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、账户余额内的现金只能以邮局汇款方式提现；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">2</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、每日提现次数不超过</span><span lang="\\&quot;EN-US\\&quot;">1</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">次；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">3</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、提现账户余额，需向邮局支付一定比例的手续费：</span><span lang="\\&quot;EN-US\\&quot;">200</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">元以下</span><span lang="\\&quot;EN-US\\&quot;">2</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">元，</span><span lang="\\&quot;EN-US\\&quot;">200</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">元以上</span><span lang="\\&quot;EN-US\\&quot;">1%</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">，最高不超过</span><span lang="\\&quot;EN-US\\&quot;">50</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">元；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">4</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、账户余额提现服务暂不支持国外和港澳台地区；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">5</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、若您提现失败，邮局不退回相应的手续费；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">6</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、提现金额不可大于可用余额；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">7</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、申请提现后，</span><span lang="\\&quot;EN-US\\&quot;">iWebShop</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\&quot;">网站处理时限是</span><span lang="\\&quot;EN-US\\&quot;">3</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">个工作日，邮局处理时限是</span><span lang="\\&quot;EN-US\\&quot;">14</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">个工作日；</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;">8</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">、常见提现失败原因：</span><span lang="\\&quot;EN-US\\&quot;">1</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">）逾期退汇；</span><span lang="\\&quot;EN-US\\&quot;">2</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">）地址不详；</span><span lang="\\&quot;EN-US\\&quot;">3</span><span style="\\&quot;font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\&quot;">）原地址查无此人</span></p>\r\n<p class="\\&quot;MsoNormal\\&quot;"><span lang="\\&quot;EN-US\\&quot;"><o:p>&nbsp;</o:p></span></p>', 1303975894);
INSERT INTO `iweb_help` VALUES (43, 5, 0, '发票制度', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">发票政策</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、发票性质</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站提供的是“</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">公司销售商品专用发票”或“</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">有限公司销售商品专用发票”</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、发票信息</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">发票抬头：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）发票抬头不能为空；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）您可填写：“个人”、您的姓名、或您的单位名称</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">发票内容：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站可开具的发票内容：图书、音像、游戏、软件、资料、办公用品、</span><span lang=\\"EN-US\\">IT</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">数码、通讯器材、体育休闲、礼品、饰品、汽车用品、化妆品、家用电器、玩具、箱包皮具，请您根据需要选择</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）数码、手机、家电类商品的发票内容只能开具商品名称和型号，无法开具其它内容</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">发票金额：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站仅开具现金购物金额的发票，不含运费、礼券、礼品卡金额</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）请您在收货时向送货员索取运费发票</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）此政策仅适用于</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站自营，若您订购商店街的商品，请与商家联系确认</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">索取发票</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">请在提交订单时的结算页面，选择“索取发票”，按照提示填写发票抬头、选择发票内容，发票将会随您的订单商品一起送达：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">若您订购了数码、手机、家电类商品，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站只能将发票内容开具商品的名称和型号</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）补开</span><span lang=\\"EN-US\\">/</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">换开发票期限：订单发货后一年以内</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）若您提交订单时未选择发票，请接收到商品后在补开发票期限内</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">发邮件至客服邮箱</span><span lang=\\"EN-US\\">service@cs.dangdang.com</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，并注明您的订单号、发票抬头、发票内容、邮寄地址、邮编及收件人，我们会在五个工作日内为您开具发票并以平信方式为您寄出</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）若您接收到的发票信息有误，请在换开发票期限内，将原发票寄至以下地址，同时请务必注明您的订单号、正确的发票抬头、内容、新发票的邮寄地址、邮编、收件人，我们收到后，会在五个工作日内为您重新开具发票以平信方式寄出</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮寄地址：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">信箱</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮编：</span><span lang=\\"EN-US\\">000000</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）若您订购的是数码、手机、家电类商品，发票内容只能开具商品名称和型号，无法开具其他内容</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（</span><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）若您订购商店街的商品，请与商家联系索取发票</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975926);
INSERT INTO `iweb_help` VALUES (44, 7, 0, '关于我们', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">Jooyea</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">技术团队</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">济南聚易信息技术有限公司（</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">）专注于基于开源协作的云计算及云服务技术，其高负载高扩展能力的分布式计算与服务技术体系，已成为开源社区软件领域领先的云计算技术平台，该平台通用产品化的名称为</span><span lang=\\"EN-US\\">iWeb SuperInteraction</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">，简称</span><span lang=\\"EN-US\\">iWebSI</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">。</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">的云计算技术框架可涵盖</span><span lang=\\"EN-US\\">Internet</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">和移动互联网。依托具有自主知识产权的云技术平台，</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">发起了一系列高负载高度交互类的开源软件产品，其产品线由社会化网络服务</span><span lang=\\"EN-US\\">(iWebSNS)</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">、社区电子商务</span><span lang=\\"EN-US\\">(iWebShop&amp;Mall)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、即时通讯服务</span><span lang=\\"EN-US\\">(iWebIM)</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">等产品构成。由于领先的高负载技术体系和先进的产品理念，</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">从一开始运作就得到天使投资人的注资。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的产品愿景和团队理念是“开放、分享、共赢、丰富互联网”。</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">提倡互联网的开放、创新和共创机遇，而不单单像盈利或者商业组织那样只强调商业利益。并且，</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">把成功定义为丰富、繁荣的互联网市场面貌。在这种环境下，互联网上的众多站点应该呈现出不同的形态、风貌，体现出个性化，真正塑造每一个站点的“性格”，让每一个站点“</span><span lang=\\"EN-US\\">Live</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">起来”，避免同质化。从而真正做到用技术实现创意，用创意丰富生活，使人们的网络生活变得更加丰富多彩。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">JooyeaTech</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">遵循开源社区互动提升产品的原则，不闭门造车。这也是开源软件的精髓所在。所以和</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">在一起，即便是个人站长，也可以自信的说：“我不是一个人！”做永远的</span><span lang=\\"EN-US\\">Beta</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">版，</span><span lang=\\"EN-US\\">Jooyea Tech</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">正在、也会一直这样：通过与用户构建良好互动，倾听用户的意见和批评，吸取大众的智慧，来改善产品，形成产品发布</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">用户使用</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">用户反馈</span><span lang=\\"EN-US\\">-</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">产品改进的良性循环。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">Jooyea</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的团队宗旨</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">致力于帮助在线企业平滑实现规模化。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">Jooyea</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">的服务口号</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">用我们领先的技术，服务于您的全球客户。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975962);
INSERT INTO `iweb_help` VALUES (45, 7, 0, '常见问题', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站所售商品都是正品行货吗？有售后保修吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站所售商品都是正品行货，均自带机打发票。凭</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站发票，所有商品都可以享受生产厂家的全国联保服务。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站将严格按照国家三包政策，针对所售商品履行保修、换货和退货的义务。您也可以到</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站任一分公司售后部享受售后服务。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：购买的商品能开发票？如果是公司购买，可以开增值税发票吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站所售商品都是正品行货，每张订单均自带中文机打的“商品专用发票”，此发票可用作单位报销凭证。发票会随包裹一同发出，发票金额含配送费金额。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">企业客户在提供《一般纳税人证书》、《营业执照》、《税务登记证》、《开户许可证》四类证件复印件后，可向</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站开取增值税发票，开好后，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站会以快递方式为您寄出。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：各种库存状态是什么意思？下单多久后可以发货？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：现货：库存有货，下单后会尽快发货，您可以立即下单；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">在途：商品正在内部配货，一般</span><span lang=\\"EN-US\\">1-2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天有货，您可立即下单；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">预订：商品正在备货，一般下单后</span><span lang=\\"EN-US\\">2-20</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天可发货，您可立即下单；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">无货：商品已售完，相应物流中心覆盖地区内的用户不能下单购买。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：无货商品什么时候能到货？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：无货商品的到货时间根据配货情况而不同，无法准确估计，但您可以使用“到货通知”功能，一旦商品有货，我们会通过电子邮件等方式通知您。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：下单后何时可以收到货？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：在商品有现货的情况下，下单后一般</span><span lang=\\"EN-US\\">24</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">小时内可收到货（郊区县配送时间可能会更长一些）；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">其它地区用户，将根据您的收货地址及所选择的配送方式而不同，一般到货时间在</span><span lang=\\"EN-US\\">1-7</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天（极偏远地区配送时间可能会更长一些）；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果商品处于预订或在途状态，那么还应加上调配货时间。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：快递费是多少？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：凡选用“</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站快递”或“快递运输”的会员即可享受免运费优惠。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：在线支付支持哪些银行卡？支持大额支付吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：我们为您提供几乎全部银行的银行卡及信用卡在线支付，只要您开通了“网上支付”功能，即可进行在线支付，无需手续费，实时到帐，方便快捷。（如客户原因取消订单退款，则需要客户承担</span><span lang=\\"EN-US\\">1%</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">平台手续费）如您订单金额较大，可以使用快钱支付中的招行、工行、建行、农行、广发进行一次性大额支付（一万元以下）。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站购物支持信用卡分期付款吗？如何申请？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站目前支持中国银行、招商银行两家银行的信用卡分期付款，只要商品单价在</span><span lang=\\"EN-US\\">500</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">元以上，您即可点击“信用卡分期付款”按钮申请分期付款</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：上门提货、货到付款支持刷卡吗？周末可以自提吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站全部自提点均支持现金及刷卡支付，绝大部分货到付款地区支持现金及刷卡支付</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站自提点营业时间一律为：周一至周日，</span><span lang=\\"EN-US\\">09:00</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">－</span><span lang=\\"EN-US\\">19:00</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">（如遇法定假日，以商城新闻公告为准）。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：下单时可以指定送货时间吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：可以，您下单时可以选择“只工作日送货</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">双休日、假日不用送</span><span lang=\\"EN-US\\">)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">”、“工作日、双休日与假日均可送货”、“只双休日、假日送货</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">工作日不用送</span><span lang=\\"EN-US\\">)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">”等时间类型，并选择是否提前电话确认。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">另外，您还可以在订单备注里填写更具体的需求，我们会尽量满足您的要求。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：哪些地区支持货到付款？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站已在多个省市开通了货到付款</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">其它城市正陆续开通</span><span lang=\\"EN-US\\">)</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，您可使用现金、移动</span><span lang=\\"EN-US\\">POS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">机当面付款收货</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：收货时发现问题可以拒收吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：在签收货物时如发现货物有损坏，请直接拒收退回我公司，相关人员将为您重新安排发货。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：如果我刚刚下单商品就降价了，能给我补偿吗？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的商品价格随市场价格的波动每日都会有涨价、降价或者优惠等变化。如果下完订单后价格发生了变化，可到“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站”自主申请价格保护</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：下单后，我能做什么？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：如果是在线支付方式，请您尽快完成付款，待付款被确认后我们会立即为您发货，</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如果选择自提或货到付款，您可以进入“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站”，在“订单列表”中找到您的订单，然后可随时查看订单处理状态，做好收货或者上门自提的准备。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">在您成功购物后，您还可以发表商品评价，向其他用户分享商品使用心得。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：为什么我无法登陆商城？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：首先要检查您的用户名、密码是否正确，确认您的浏览器是否支持</span><span lang=\\"EN-US\\">COOKIE</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：产品如何保修？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站销售的商品都以商品说明中的保修承诺为准。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：订单得到确认后我该做什么？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：按照订单所提示的实际应汇款金额，汇款至该订单所在的公司账号内，汇款交易成功后，登陆“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站”查看您的订单，在订单中的“汇款备注”中输入您的相关汇款信息</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">例如：汇入行、汇入我司银行账号的实际金额、汇款日期和汇入账号、订单号等），等待我司财务人员确认汇款。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：汇款确认后多久能够将货物发出？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：正常情况下会在工作时间</span><span lang=\\"EN-US\\">24-48</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">小时内可以将您的货物发出。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：非商品自身质量问题是否可以退货？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：部分商品在不影响二次销售的情况下，加收一定的退货手续费，是可以办理退货的，详情请查看“退换货政策”</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：在哪能填写汇款信息？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：首先要在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站”，点击左侧的“订单中心”，即可查看到您所有的订单，点击汇款订单后面的“查看”，打开后下拉页面，有“付款信息未完成</span><span lang=\\"EN-US\\">,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">请您尽快填写</span><span lang=\\"EN-US\\">.</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">”一项，直接在里面填写汇款信息，然后提交即可，相关人员在查收到您的汇款信息后会进行核实，无异议的汇款会在三个工作小时内确认完毕，如有问题，相关人员会电话与您联系。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：怎样咨询商品的详细信息？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：请您在该商品页面下方“购买咨询”处进行提问，相关商品管理员会为您回复。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：在哪进行在线支付？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站”，进入后点击左侧的“在线支付”，点击进入后就可以进行在线支付了。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：工作时间？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：客服中心受理热线电话及订单处理时间为</span><span lang=\\"EN-US\\">7x24</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">小时全天候服务；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">自提接待时间为周一至周日</span><span lang=\\"EN-US\\">9</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：</span><span lang=\\"EN-US\\">00-19</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">：</span><span lang=\\"EN-US\\">00</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注：如遇国家法定节假日，则以</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站新闻发布放假时间为准，请大家届时关注。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：如何将退款打回银行卡？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：在投诉中心留言相关信息，如银行卡的开户行</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">详细到支行）、开户姓名、卡号，相关人员会为您处理，退款周期视您的货物是否发出而定，如果货物未出库发出，退款会在三个工作日内完成；如果货物已发出，则需货物返回我司物流中心后为您办理退款。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：商品包装问题？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：我司所发送商品均由专人进行打包，商品在未签收前都由我司负责，如在收到商品时发现包装有破损或是其它方面问题，请直接致电我司客服</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">，客服人员会帮您解决。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：怎样申请高校代理送货？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站”，进入后点击左侧的“个人资料”，在“所在学校”一栏中选择您所在的院校，</span><span lang=\\"EN-US\\">(</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">如没有您所在的院校，则说明您的学校暂未开通高校代理，您将无法选择高校代理送货），然后点击底部的“修改”，我司相关人员在收到申请后的</span><span lang=\\"EN-US\\">24</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">个工作小时内进行审核，审核通过后，您下单时就可以选择高校代理送货了，高校代理订单的运费按照钻石（双钻）会员普通快递运费标准收取，具体请您参照帮助中心中快递运输页面的“普通快递收取标准一览表”，货物由代理直接送达，货款由高校代理收取。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：拍卖成功后如何转成订单？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站首页的“会员登录”中输入用户名和密码进行登陆，登陆后点击“我的</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站”，进入后点击左侧的“我的拍卖”，在“操作”处有一个“转成订单”按钮，点击该按钮就可以转成订单了，在左侧“订单中心”处可查询到该订单，和商品订单一样，您可以直接进行支付。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：订单付款后，如果长时间未收到货，我是否可以申请办理退款？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：非</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站快递覆盖区域内，由第三方快递公司负责直接送达的订单，如圆通快递，自发货时间算起超过</span><span lang=\\"EN-US\\">10</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天仍未收到货或收货地址超出第三方快递覆盖的区域，由第三方快递转邮政，如圆通转</span><span lang=\\"EN-US\\">EMS</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">等，自发货时间算起超过</span><span lang=\\"EN-US\\">20</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">天仍未收到货，可致电客服中心，由客服人员为您申请办理退款事宜。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">问：如果我有问题或建议是否可以通过邮件向你们反馈？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">答：可以。</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站受理建议或投诉的邮箱是：</span><span lang=\\"EN-US\\">service@iwebshop.com</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303975993);
INSERT INTO `iweb_help` VALUES (46, 7, 0, '找回密码', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">忘记了帐户密码？</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">不用担心，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站提供找回密码服务，您点击</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">忘记密码</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">按照系统提示操作即可。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">操作步骤详解如下：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站登陆页面，点击</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">忘记密码</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、按照提示，填写您在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站的注册邮箱及验证码</span><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、系统提示成功发送“密码重置”邮件，若您长时间未收到，可以点击“重新发送”</span><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、登陆您的个人邮箱，找到“</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站新密码重置确认信</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站新密码重置确认信”点击“设置新密码”</span><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、按照系统提示，设置新密码即可</span><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">温馨提示：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">为了确保顾客注册信息的安全，</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站只提供网上找回密码服务，若您忘记</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站注册邮箱或是忘记注册邮箱的登陆密码，请</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">注册新用户</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303976019);
INSERT INTO `iweb_help` VALUES (47, 7, 0, '退订邮件/短信', '<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站保留通过邮件和短信的形式，对本网站注册、购物用户发送订单信息、促销活动等告知服务的权利。如果您在</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:calibri;mso-hansi-font-family:Calibri;\\">网站注册、购物，表明您已默示接受此项服务。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">若您不希望接收</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的邮件，请在邮件下方输入您的</span><span lang=\\"EN-US\\">E-mail</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">地址自助完成退阅；</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">若您不希望接收</span><span lang=\\"EN-US\\">iWebShop</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">网站的短信，请提供您的手机号码</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">联系客服</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">处理。</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303976040);
INSERT INTO `iweb_help` VALUES (48, 7, 0, '联系客服', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮件联系</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">Kefu@jooyea.net</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">电话联系</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">客服中心电话热线工作时间：</span><span lang=\\"EN-US\\">24</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">小时全天候</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">客服热线：</span><span lang=\\"EN-US\\">*****</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">客服传真：</span><span lang=\\"EN-US\\">*****</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮局汇款地址：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">信箱</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">邮编：</span><span lang=\\"EN-US\\">*****</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">邮政信箱地址：</span><span lang=\\"EN-US\\">*****</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">分箱</span> <span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family: Calibri\\">邮编：</span><span lang=\\"EN-US\\">*****</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">在线问答</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\">iWebIM</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">在线客服</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303976070);
INSERT INTO `iweb_help` VALUES (49, 7, 0, '诚聘英才', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">测试工程师</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">岗位职责：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、负责公司互联网产品和项目的测试工作，搭建测试环境，确保产品和项目质量；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、编写测试计划，测试大纲和测试用例；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、对测试过程中发现的问题进行跟踪分析和报告并推动问题及时合理地解决；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、按照测试计划编写测试脚本和测试程序对产品进行功能、强度、性能测试；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、通过对产品的测试，保证产品质量达到指定质量目标，并能够提出进一步改进的要求并依照执行。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">岗位要求：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、相关专业专科以上学历，至少</span><span lang=\\"EN-US\\">1</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">年以上测试经验；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>2</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、熟悉测试流程，测试用例与测试计划的编写；熟悉各种</span><span lang=\\"EN-US\\">Bug</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">管理和测试管理工具；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>3</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、较强的发现问题，分析问题的能力；较强的语言表达和文档撰写能力，能根据产品需求编写测试用例；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>4</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、工作责任心强，细致，耐心；</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><span style=\\"mso-spacerun:yes;\\">&nbsp;&nbsp;&nbsp; </span>5</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">、能承受较大的工作压力。</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">联系人：</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">联系方式：</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303976088);
INSERT INTO `iweb_help` VALUES (50, 7, 0, '友情链接', '<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">申请友链</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">链接显示的顺序以提交的先后顺序为准</span><span lang=\\"EN-US\\">.</span></p>\r\n<p class=\\"MsoNormal\\"><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">申请链接请将你的网站名称</span><span lang=\\"EN-US\\">\\\\logo\\\\</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">链接地址</span><span lang=\\"EN-US\\">\\\\</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">联系人等信息发至信箱：</span><span lang=\\"EN-US\\">admin@iwebshop.com,</span><span style=\\"font-family:宋体;mso-ascii-font-family:Calibri;mso-hansi-font-family:Calibri;\\">经我们网站管理员审核后再更新上线</span></p>\r\n<p class=\\"MsoNormal\\"><span lang=\\"EN-US\\"><o:p>&nbsp;</o:p></span></p>', 1303976108);
INSERT INTO `iweb_help` VALUES (52, 5, 0, '售后服务', '<div style="display:block;" class="mc tabcon hide">\r\n                    本产品全国联保，享受三包服务，质保期为：十五天质保<br />\r\n				</div>\r\n				\r\n				\r\n				<div id="promises">\r\n					<strong>Iweb商城服务承诺：</strong><br />\r\n<strong>Iweb</strong>商城向您保证所售商品均为正品行货，自带机打发票，与商品一起寄送。凭质保证书及<strong>Iweb</strong>商城发票，可享受全国联保服务，与您亲临商场选购的商品享受相同的质量保证。<br />\r\n<strong>Iweb</strong>商城还为您提供具有竞争力的商品价格和免运费政策，请您放心购买！ \r\n				</div>\r\n				<div id="state"><strong>声明:</strong>因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</div>', 1305696881);
INSERT INTO `iweb_help` VALUES (53, 4, 0, '支付帮助', 'Iweb商城为您提供以下7种支付方式<br />\r\n货到付款： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n我们在以下省市开通了货到付款(其他城市正陆续开通)，您可使用现金、移动POS机（部分地区支持刷卡）当面付款收货，点击城市名可查看详细配送范围及运费：<br />\r\n北京&nbsp;&nbsp; 上海&nbsp;&nbsp; 广州&nbsp;&nbsp; 广东（不含广州）&nbsp;&nbsp; 天津&nbsp;&nbsp; 杭州&nbsp;&nbsp; 山东&nbsp;&nbsp; 厦门&nbsp;&nbsp; 武汉&nbsp;&nbsp; 成都&nbsp;&nbsp; 深圳&nbsp;&nbsp; 西安&nbsp;&nbsp; 宁波&nbsp;&nbsp; 东莞&nbsp;&nbsp; 沈阳&nbsp;&nbsp; 福州&nbsp;&nbsp; 重庆&nbsp;&nbsp; 温州&nbsp;&nbsp; 长沙&nbsp;&nbsp; 哈尔滨&nbsp;&nbsp; 佛山&nbsp;&nbsp; 郑州&nbsp;&nbsp; 嘉兴&nbsp;&nbsp; 廊坊&nbsp;&nbsp; 绍兴&nbsp;&nbsp; 金华&nbsp;&nbsp; 珠海&nbsp;&nbsp; 太原&nbsp;&nbsp; 大连&nbsp;&nbsp; 长春&nbsp;&nbsp; 南昌&nbsp;&nbsp; 合肥&nbsp;&nbsp; 昆明&nbsp;&nbsp; 石家庄&nbsp;&nbsp; 浙江&nbsp;&nbsp; 贵州&nbsp;&nbsp; 兰州&nbsp;&nbsp; 南宁&nbsp;&nbsp; 呼和浩特&nbsp;&nbsp; 江苏&nbsp;&nbsp; 四川&nbsp;&nbsp; 惠州&nbsp;&nbsp; 烟台<br />\r\n在线支付： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n我们为您提供几乎全部银行的银行卡及信用卡在线支付，只要您开通了"网上支付"功能，即可进行在线支付，无需手续费，实时到帐，方便快捷，支付限额说明&gt;&gt;<br />\r\n<br />\r\n您还可以使用以下支付平台进行在线支付及帐户余额付款：<br />\r\n来Iweb自提： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n我们在以下城市开通了自提点(其他城市正陆续开通)，您可就近选择自提点当面付款提货，无需支付运费，点击城市名可查看详细地点及公交线路：<br />\r\n北京&nbsp;&nbsp; 上海&nbsp;&nbsp; 广州&nbsp;&nbsp; 深圳&nbsp;&nbsp; 东莞&nbsp;&nbsp; 佛山&nbsp;&nbsp; 珠海&nbsp;&nbsp; 惠州&nbsp;&nbsp; 天津&nbsp;&nbsp; 苏州&nbsp;&nbsp; 无锡&nbsp;&nbsp; 南京&nbsp;&nbsp; 宿迁&nbsp;&nbsp; 昆山&nbsp;&nbsp; 南通&nbsp;&nbsp; 常州&nbsp;&nbsp; 常熟&nbsp;&nbsp; 杭州&nbsp;&nbsp; 宁波&nbsp;&nbsp; 温州&nbsp;&nbsp; 嘉兴&nbsp;&nbsp; 绍兴&nbsp;&nbsp; 金华&nbsp;&nbsp; 济南&nbsp;&nbsp; 青岛&nbsp;&nbsp; 烟台&nbsp;&nbsp; 厦门&nbsp;&nbsp; 福州&nbsp;&nbsp; 武汉&nbsp;&nbsp; 成都&nbsp;&nbsp; 绵阳&nbsp;&nbsp; 西安&nbsp;&nbsp; 沈阳&nbsp;&nbsp; 大连&nbsp;&nbsp; 重庆&nbsp;&nbsp; 长沙&nbsp;&nbsp; 哈尔滨&nbsp;&nbsp; 郑州&nbsp;&nbsp; 廊坊&nbsp;&nbsp; 太原&nbsp;&nbsp; 长春&nbsp;&nbsp; 南昌&nbsp;&nbsp; 合肥&nbsp;&nbsp; 昆明&nbsp;&nbsp; 石家庄&nbsp;&nbsp; 贵阳&nbsp;&nbsp; 兰州&nbsp;&nbsp; 南宁&nbsp;&nbsp; 呼和浩特<br />\r\n分期付款： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n单个商品价格在500元以上，可使用中国银行、招商银行发行的信用卡申请分期付款，支持3期、6期、12期付款，查看详细说明&gt;&gt;<br />\r\n公司转帐： &nbsp;&nbsp;&nbsp; <br />\r\n<br />\r\n您可以向Iweb公司的三个公司帐户汇款，到帐时间一般为款汇出后的1-5个工作日，查看公司帐户&gt;&gt;<br />\r\n邮局汇款： &nbsp;&nbsp;&nbsp; 您可通过邮局向Iweb商城付款，到帐时间一般为款汇出后的1-5个工作日，查看汇款地址&gt;&gt;<br />', 1305697182);

--
-- 导出表中的数据 `iweb_help_category`
--

INSERT INTO `iweb_help_category` VALUES (4, '支付帮助', 2, 0, 1);
INSERT INTO `iweb_help_category` VALUES (3, '购物指南', 1, 0, 1);
INSERT INTO `iweb_help_category` VALUES (5, '售后服务', 4, 1, 1);
INSERT INTO `iweb_help_category` VALUES (6, '配送帮助', 3, 0, 1);
INSERT INTO `iweb_help_category` VALUES (7, '帮助信息', 5, 0, 1);

--
-- 导出表中的数据 `iweb_msg_template`
--

INSERT INTO `iweb_msg_template` VALUES (1, '到货通知', '最近到货通知', '<p>dear：{$user_name}你关注的商品：{$goods_name}已到货，由于此商品近期销售火爆，请及时购买！</p>\n<p>-------IWeb商场</p>', '用户名 {$user_name} 商品名 {$goods_name}');
INSERT INTO `iweb_msg_template` VALUES (2, '网站订阅', '2011年1月最新上架商品', '2011年1月最新上架商品', NULL);
INSERT INTO `iweb_msg_template` VALUES (3, '找回密码', 'IWeb密码找回','<p>dear：{$user_name}：</p><br /><p>您的新密码为{$password},请您尽快登陆用户中心，修改为您常用的密码！</p><br /><p>-------IWeb商场</p><br />','用户名 {$user_name} 新密码 {$password}');


--
-- 导出表中的数据 `iweb_pay_plugin`
--

INSERT INTO `iweb_pay_plugin` VALUES (3, '八佰付在线支付', '支持币种：人民币，美元，韩元', '/payments/logos/pay_enets.gif', 'enets', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (9, '天天付在线支付（汇付天下）', '汇付天下（ www.chinapnr.com）是中国最具创新支付公司，注册资本过亿。', '/payments/logos/pay_chinapnr.gif', 'chinapnr', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (10, '招商银行', '中国第一家由企业创办的商业银行。', '/payments/logos/pay_cmbc.gif', 'cmbc', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (15, 'eNETS Payment esb_payments', '支持币种：美元, 新加坡元', '/payments/logos/pay_enets.gif', 'enets', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (16, 'EPAY网上支付', '支持币种：新台币', '/payments/logos/pay_epay.gif', 'epay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (20, '和讯在线支付', '支持币种：人民币', '/payments/logos/pay_homeway.gif', 'homeway', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (21, '广州银联网付通', '广州银联网络支付有限公司是银联体系内专业从事银行卡跨行网上支付、公共支付技术服务的高新技术企业。', '/payments/logos/pay_hyl.gif', 'hyl', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (22, '中国工商银行[1.0.0.3版]', '中国工商银行网上银行B2C支付网关可以使用在windows主机和linux主机，请在申请工行网关接口时申请1.0.0.3版。', '/payments/logos/pay_icbc.gif', 'icbc', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (23, 'IEPAY', '支持币种：新台币', '/payments/logos/pay_iepay.gif', 'iepay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (24, 'IPAY在线支付', '支持币种：人民币', '/payments/logos/pay_ipay.gif', 'ipay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (26, 'MOBILE88', '支持币种：马元', '/payments/logos/pay_mobile88.gif', 'mobile88', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (28, 'NOCHEX在线支付', '支持币种：英镑', '/payments/logos/pay_nochek.gif', 'nochek', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (30, 'NPS网上支付－内卡', '支持币种：人民币', '/payments/logos/pay_nps.gif', 'nps', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (31, 'NPS网上支付－外卡', '支持币种：人民币, 港币, 美元, 欧元', '/payments/logos/pay_nps_out.gif', 'nps_out', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (36, 'PayPal贝宝', '全球最大的在线支付平台，同时也是目前全球贸易网上支付标准.', '/payments/logos/pay_paypal.gif', 'paypal_cn', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (37, '首信易在线支付', '支持币种：人民币, 美元，是中国首家实现跨银行跨地域提供多种银行卡在线交易的网上支付服务平台', '/payments/logos/pay_shouxin.gif', 'shouxin', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (38, '我付了储值卡支付(OK卡等)', '我付了储值卡支付网关支持了如百联OK卡等在内的国内主流预付费卡（消费储值卡）的支付。', '/payments/logos/pay_skypay.gif', 'skypay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (40, 'SMSe在线支付', '支持币种：人民币，新台币', '/payments/logos/pay_smilepay.gif', 'smilepay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (42, '台湾里网上支付', '支持币种：新台币', '/payments/logos/pay_twv.gif', 'twv', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (43, '网汇通在线支付', '中国率先提供互联网现金汇款、支付的服务提供商， 提供“网汇通”业务的数据处理和经营。', '/payments/logos/pay_udpay.gif', 'udpay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (44, '银生支付', '支持币种：人民币', '/payments/logos/pay_unspay.gif', 'unspay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (47, '易宝支付 (在线支付接口)', '首批通过国家信息安全系统认证、获得企业信用等级AAA级证书、注册资本1亿元。', '/payments/logos/pay_yeepay.gif', 'yeepay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (50, '康辉商融彩虹平台', '康辉商融彩虹平台', '/payments/logos/pay_iris.gif', 'iris', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (17, 'Google Checkout', '支持币种：美元、欧元、英磅、马元', '/payments/logos/pay_epay.gif', 'epay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (32, '线下支付', '您可以通过现金付款或银行转帐的方式进行收款', '/payments/logos/pay_offline.gif', 'offline', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (46, '网银在线支付（内卡）', '网银在线是中国领先的电子支付解决方案提供商之一。', '/payments/logos/pay_wangjin.gif', 'wangjin', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (2, '2CHECKOUT', '支持币种：澳元, 加拿大元, 欧元, 英磅, 港币, 日元, 韩元, 新加坡元, 美元', '/payments/logos/pay_2checkout.gif', '2checkout', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (11, '云网在线支付', '北京云网无限网络技术有限公司成立于1999年12月，是国内首家实现在线实时交易的电子商务公司。', '/payments/logos/pay_cncard.gif', 'cncard', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (12, '预存款支付', '预存款是客户在您网站上的虚拟资金帐户。', '/payments/logos/pay_deposit.gif', 'balance', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (45, '网银在线支付（外卡）', '网银在线支付（外卡），网银网上支付是独立的安全支付平台。', '/payments/logos/pay_wangjin_out.gif', 'wangjin_out', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (8, '上海银联电子支付ChinaPay', '银联电子支付服务有限公司（ChinaPay）主要从事以互联网等新兴渠道为基础的网上支付。', '/payments/logos/pay_chinapay.gif', 'chinapay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (34, 'PayDollar', '领先的世界级电子付款及解决方案和技术供应商；支持币种：人民币、港币、美元、新加坡元、日元、新台币、澳元、欧元、英磅、加拿大元', '/payments/logos/pay_paydollar.gif', 'paydollar', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (41, '腾讯财付通[担保交易]', '财付通担保交易，由财付通做担保，买家确认才付款。 <a style="color:blue" href="http://union.tenpay.com/mch/mch_register_1.shtml?sp_suggestuser=2289480\r\n" target="_blank" >申请财付通担保账户</a>', '/payments/logos/pay_tenpaytrad.gif', 'tenpaytrad', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (19, '运筹宝', '上海运筹宝电子商务有限公司（运筹宝Haipay ）是亚洲领先的在线支付服务提供商。', '/payments/logos/pay_google.gif', 'google', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (27, 'MONEYBOOKERS', '支持币种：澳元、加拿大元、欧元、英磅、港币、日元、韩元、新台币、新加坡元、美元', '/payments/logos/pay_moneybookers.gif', 'moneybookers', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (39, '腾讯财付通[即时到账]', '费率最低至<span style="color: #FF0000;font-weight: bold;">0.61%</span>，并赠送价值千元企业QQ', '/payments/logos/pay_tenpay.gif', 'tenpay', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (4, '快钱网上支付', '快钱是国内领先的独立第三方支付企业，旨在为各类企业及个人提供安全、便捷和保密的支付清算与账务服务。', '/payments/logos/pay_99bill.gif', '99bill', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (6, '支付宝[担保交易]', ' <a style="color:blue" href="https://www.alipay.com/himalayas/practicality_customer.htm?customer_external_id=C433530444855584111X&market_type=from_agent_contract&pro_codes=61F99645EC0DC4380ADE569DD132AD7A" target="_blank">立即申请</a>', '/payments/logos/pay_alipaytrad.gif', 'alipaytrad', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (49, '中国移动手机支付', '仅对企业用户开放，年末超低费率<span style="color: #FF0000;font-weight: bold;">0.3%</span>签约，精准营销覆盖6.7亿用户', '/payments/logos/pay_cmpay.gif', 'cmpay', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (7, '支付宝[即时到帐]', '支付宝即时到帐，付款后立即到账，无预付/年费，单笔费率阶梯最低<span style="color: #FF0000;font-weight: bold;">0.7%</span>，无流量限制。  <a style="color:blue" href="https://www.alipay.com/himalayas/practicality_customer.htm?customer_external_id=C433530444855584111X&market_type=from_agent_contract&pro_codes=61F99645EC0DC4380ADE569DD132AD7A" target="_blank">立即申请</a>', '/payments/logos/pay_alipay.gif', 'alipay', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (25, '环讯IPS网上支付3.0', '上海环迅电子商务有限公司（以下简称：环迅支付 ）成立于2000年，是国内最早的支付公司之一。', '/payments/logos/pay_ips3.gif', 'ips3', '0.6', 0);
INSERT INTO `iweb_pay_plugin` VALUES (35, 'PayPal（外卡）', 'PayPal 是全球最大的在线支付平台，同时也是目前全球贸易网上支付标准。', '/payments/logos/pay_paypal.gif', 'paypal', '0.6', 1);
INSERT INTO `iweb_pay_plugin` VALUES (48, '拉卡拉支付', '不用网银也能支付！支持所有银行卡，刷卡付款', '/payments/logos/pay_lakala.gif', 'lakala', '0.6', 0);

INSERT INTO `iweb_payment` VALUES (1, '预存款支付', 1, '预存款是客户在您网站上的虚拟资金帐户', 0.00, 0, '12', 'a:2:{s:10:"PrivateKey";s:8:"iwebshop";s:11:"real_method";s:1:"1";}', 1, 1, '');

--
-- 导出表中的数据 `iweb_right`
--

INSERT INTO `iwebshop_right` VALUES (1, '[商品]商品列表', 'goods@goods_list,goods@goods_sort,goods@goods_stats', 0);
INSERT INTO `iwebshop_right` VALUES (2, '[商品]商品添加', 'goods@goods_img_upload,goods@goods_add,goods@goods_save,goods@word_seg,goods@member_price,goods@member_price_edit,goods@model_init,goods@attribute_init,goods@search_spec', 0);
INSERT INTO `iwebshop_right` VALUES (3, '[商品]商品修改', 'goods@goods_img_upload,goods@goods_edit,goods@goods_update,goods@word_seg,goods@member_price,goods@member_price_edit,goods@model_init,goods@attribute_init,goods@search_spec', 0);
INSERT INTO `iwebshop_right` VALUES (4, '[商品]商品删除', 'goods@goods_del', 0);
INSERT INTO `iwebshop_right` VALUES (5, '[商品]商品回收站', 'goods@goods_recycle_del,goods@goods_recycle_restore,goods@goods_recycle_list', 0);
INSERT INTO `iwebshop_right` VALUES (6, '[商品]商品导入导出', 'goods@upload_csv,goods@export_csv,goods@import_csv,goods@output_csv', 0);
INSERT INTO `iwebshop_right` VALUES (7, '[商品]商品分类列表', 'goods@category_list,goods@category_sort', 0);
INSERT INTO `iwebshop_right` VALUES (8, '[商品]商品分类添加修改', 'goods@category_edit,goods@category_save', 0);
INSERT INTO `iwebshop_right` VALUES (9, '[商品]商品分类删除', 'goods@category_del', 0);
INSERT INTO `iwebshop_right` VALUES (10, '[商品]品牌列表', 'brand@brand_list,goods@brand_sort', 0);
INSERT INTO `iwebshop_right` VALUES (11, '[商品]品牌添加修改', 'brand@brand_save,brand@brand_edit', 0);
INSERT INTO `iwebshop_right` VALUES (12, '[商品]品牌删除', 'brand@brand_del', 0);
INSERT INTO `iwebshop_right` VALUES (13, '[商品]品牌分类列表', 'brand@category_list', 0);
INSERT INTO `iwebshop_right` VALUES (14, '[商品]品牌分类添加修改', 'brand@category_save,brand@category_edit', 0);
INSERT INTO `iwebshop_right` VALUES (15, '[商品]品牌分类删除', 'brand@category_del', 0);
INSERT INTO `iwebshop_right` VALUES (16, '[商品]模型列表', 'goods@model_list', 0);
INSERT INTO `iwebshop_right` VALUES (17, '[商品]模型添加修改', 'goods@search_spec,goods@model_update,goods@model_edit', 0);
INSERT INTO `iwebshop_right` VALUES (18, '[商品]模型删除', 'goods@model_del', 0);
INSERT INTO `iwebshop_right` VALUES (19, '[商品]规格列表', 'goods@spec_list', 0);
INSERT INTO `iwebshop_right` VALUES (20, '[商品]规格添加修改', 'goods@spec_edit,goods@spec_update', 0);
INSERT INTO `iwebshop_right` VALUES (21, '[商品]规格删除', 'goods@spec_del', 0);
INSERT INTO `iwebshop_right` VALUES (22, '[商品]规格图库', 'goods@spec_photo,goods@spec_photo_del', 0);
INSERT INTO `iwebshop_right` VALUES (23, '[商品]规格回收站', 'goods@spec_recycle_list,goods@spec_recycle_restore,goods@spec_recycle_del,goods@spec_del', 0);
INSERT INTO `iwebshop_right` VALUES (24, '[会员]会员列表', 'member@member_list,member@member_filter', 0);
INSERT INTO `iwebshop_right` VALUES (25, '[会员]会员添加修改', 'member@member_edit,member@member_save', 0);
INSERT INTO `iwebshop_right` VALUES (26, '[会员]会员删除', 'member@member_reclaim', 0);
INSERT INTO `iwebshop_right` VALUES (27, '[会员]会员回收站', 'member@member_del,member@member_restore,member@recycling', 0);
INSERT INTO `iwebshop_right` VALUES (28, '[会员]会员预付款操作', 'member@member_recharge', 0);
INSERT INTO `iwebshop_right` VALUES (29, '[会员]会员等级积分操作', 'member@member_remove', 0);
INSERT INTO `iwebshop_right` VALUES (30, '[会员]会员组列表', 'member@group_list', 0);
INSERT INTO `iwebshop_right` VALUES (31, '[会员]会员组添加修改', 'member@group_edit,member@group_save', 0);
INSERT INTO `iwebshop_right` VALUES (32, '[会员]会员组删除', 'member@group_del', 0);
INSERT INTO `iwebshop_right` VALUES (33, '[会员]会员提现列表', 'member@withdraw_list', 0);
INSERT INTO `iwebshop_right` VALUES (34, '[会员]会员提现删除', 'member@withdraw_del', 0);
INSERT INTO `iwebshop_right` VALUES (35, '[会员]会员提现回收站', 'member@withdraw_update,member@withdraw_recycle', 0);
INSERT INTO `iwebshop_right` VALUES (36, '[会员]会员提现状态修改', 'member@withdraw_status', 0);
INSERT INTO `iwebshop_right` VALUES (37, '[会员]会员提现详情', 'member@withdraw_detail', 0);
INSERT INTO `iwebshop_right` VALUES (38, '[会员]建议列表', 'comment@suggestion_list', 0);
INSERT INTO `iwebshop_right` VALUES (39, '[会员]建议详情', 'comment@suggestion_edit', 0);
INSERT INTO `iwebshop_right` VALUES (40, '[会员]建议回复', 'comment@suggestion_edit_act', 0);
INSERT INTO `iwebshop_right` VALUES (41, '[会员]建议删除', 'comment@suggestion_del', 0);
INSERT INTO `iwebshop_right` VALUES (42, '[会员]咨询列表', 'comment@refer_list', 0);
INSERT INTO `iwebshop_right` VALUES (43, '[会员]咨询详情', 'comment@refer_edit', 0);
INSERT INTO `iwebshop_right` VALUES (44, '[会员]咨询回复', 'comment@refer_reply', 0);
INSERT INTO `iwebshop_right` VALUES (45, '[会员]咨询删除', 'comment@refer_del', 0);
INSERT INTO `iwebshop_right` VALUES (46, '[会员]讨论列表', 'comment@discussion_list', 0);
INSERT INTO `iwebshop_right` VALUES (47, '[会员]讨论详情', 'comment@discussion_edit', 0);
INSERT INTO `iwebshop_right` VALUES (48, '[会员]讨论删除', 'comment@discussion_del', 0);
INSERT INTO `iwebshop_right` VALUES (49, '[会员]评价列表', 'comment@comment_list', 0);
INSERT INTO `iwebshop_right` VALUES (50, '[会员]评价详情', 'comment@comment_edit', 0);
INSERT INTO `iwebshop_right` VALUES (51, '[会员]评价删除', 'comment@comment_del', 0);
INSERT INTO `iwebshop_right` VALUES (52, '[会员]站内消息列表', 'comment@message_list', 0);
INSERT INTO `iwebshop_right` VALUES (53, '[会员]站内消息发送', 'comment@message_send', 0);
INSERT INTO `iwebshop_right` VALUES (54, '[会员]站内消息删除', 'comment@message_del', 0);
INSERT INTO `iwebshop_right` VALUES (55, '[会员]到货通知列表', 'message@notify_list,message@notify_filter', 0);
INSERT INTO `iwebshop_right` VALUES (56, '[会员]到货通知删除', 'message@notify_del', 0);
INSERT INTO `iwebshop_right` VALUES (57, '[会员]到货通知发送Email', 'message@notify_send', 0);
INSERT INTO `iwebshop_right` VALUES (58, '[会员]到货通知导出CSV', 'message@notify_export', 0);
INSERT INTO `iwebshop_right` VALUES (59, '[会员]消息模板展示', 'message@tpl_list', 0);
INSERT INTO `iwebshop_right` VALUES (60, '[会员]邮件订阅列表', 'message@registry_list', 0);
INSERT INTO `iwebshop_right` VALUES (61, '[会员]邮件订阅发送', 'message@registry_message_send', 0);
INSERT INTO `iwebshop_right` VALUES (62, '[会员]邮件订阅删除', 'message@registry_del', 0);
INSERT INTO `iwebshop_right` VALUES (63, '[会员]邮件订阅导出CSV', 'message@registry_export', 0);
INSERT INTO `iwebshop_right` VALUES (64, '[订单]订单列表', 'order@order_list', 0);
INSERT INTO `iwebshop_right` VALUES (65, '[订单]订单添加', 'order@search_goods,order@search_user,order@getAmount,order@gePay_fee,order@order_pri_num,order@order_pri_num_del,order@order_note,order@order_save,order@order_add', 0);
INSERT INTO `iwebshop_right` VALUES (66, '[订单]订单内容修改', 'order@search_goods,order@search_user,order@getAmount,order@gePay_fee,order@order_pri_num,order@order_pri_num_del,order@order_note,order@order_update,order@order_edit,order@order_message', 0);
INSERT INTO `iwebshop_right` VALUES (67, '[订单]订单详情', 'order@order_show', 0);
INSERT INTO `iwebshop_right` VALUES (68, '[订单]订单回收站', 'order@order_recycle_restore,order@order_recycle_del,order@order_recycle_list', 0);
INSERT INTO `iwebshop_right` VALUES (69, '[订单]订单打印', 'order@merge_template,order@pick_template,order@shop_template,order@template,order@print_template_update,order@print_template', 0);
INSERT INTO `iwebshop_right` VALUES (70, '[订单]订单删除', 'order@order_del', 0);
INSERT INTO `iwebshop_right` VALUES (71, '[订单]订单状态修改', 'order@order_complete,order@order_refundment,order@order_collection,order@order_deliver,order@order_return', 0);
INSERT INTO `iwebshop_right` VALUES (72, '[订单]收款单列表', 'order@order_collection_list', 0);
INSERT INTO `iwebshop_right` VALUES (73, '[订单]收款单详情', 'order@order_collection,order@collection_show', 0);
INSERT INTO `iwebshop_right` VALUES (74, '[订单]收款单删除', 'order@collection_del', 0);
INSERT INTO `iwebshop_right` VALUES (75, '[订单]收款单回收站', 'order@collection_recycle_restore,order@collection_recycle_del,order@collection_recycle_list', 0);
INSERT INTO `iwebshop_right` VALUES (76, '[订单]退款单列表', 'order@order_refundment_list', 0);
INSERT INTO `iwebshop_right` VALUES (77, '[订单]退款单删除', 'order@order_refundment_del', 0);
INSERT INTO `iwebshop_right` VALUES (78, '[订单]退款单回收站', 'order@refundment_recycle_list,order@refundment_recycle_restore,order@refundment_recycle_del', 0);
INSERT INTO `iwebshop_right` VALUES (79, '[订单]退款单详情', 'order@refundment_show,order@order_refundment_form,order@order_refundment', 0);
INSERT INTO `iwebshop_right` VALUES (80, '[订单]配货单列表', 'order@order_delivery_list', 0);
INSERT INTO `iwebshop_right` VALUES (81, '[订单]配货单删除', 'order@delivery_del', 0);
INSERT INTO `iwebshop_right` VALUES (82, '[订单]配货单回收站', 'order@delivery_recycle_list,order@delivery_recycle_restore,order@delivery_recycle_del', 0);
INSERT INTO `iwebshop_right` VALUES (83, '[订单]退货单列表', 'order@order_returns_list', 0);
INSERT INTO `iwebshop_right` VALUES (84, '[订单]退货单删除', 'order@returns_del', 0);
INSERT INTO `iwebshop_right` VALUES (85, '[订单]退货单详情', 'order@returns_show', 0);
INSERT INTO `iwebshop_right` VALUES (86, '[订单]退货单回收站', 'order@returns_recycle_list,order@returns_recycle_restore,order@returns_recycle_del,order@returns_del', 0);
INSERT INTO `iwebshop_right` VALUES (87, '[订单]退款申请单列表', 'order@refundment_list', 0);
INSERT INTO `iwebshop_right` VALUES (88, '[订单]退款申请单详情', 'order@refundment_doc_show', 0);
INSERT INTO `iwebshop_right` VALUES (89, '[订单]退款申请单删除', 'order@refundment_doc_del', 0);
INSERT INTO `iwebshop_right` VALUES (90, '[订单]退款申请单修改', 'order@order_refundment_form,order@refundment_doc_show_save', 0);
INSERT INTO `iwebshop_right` VALUES (91, '[营销]促销规则列表', 'market@pro_rule_list', 0);
INSERT INTO `iwebshop_right` VALUES (92, '[营销]促销规则添加修改', 'market@pro_rule_edit_act,market@pro_rule_edit,market@getTicketList', 0);
INSERT INTO `iwebshop_right` VALUES (93, '[营销]促销规则删除', 'market@pro_rule_del', 0);
INSERT INTO `iwebshop_right` VALUES (94, '[营销]限时抢购列表', 'market@pro_speed_list', 0);
INSERT INTO `iwebshop_right` VALUES (95, '[营销]限时抢购删除', 'market@pro_speed_del', 0);
INSERT INTO `iwebshop_right` VALUES (96, '[营销]限时抢购添加修改', 'market@pro_speed_edit,market@pro_speed_edit_act', 0);
INSERT INTO `iwebshop_right` VALUES (97, '[营销]团购列表', 'market@regiment_list', 0);
INSERT INTO `iwebshop_right` VALUES (98, '[营销]团购添加修改', 'market@regiment_edit_act,market@regiment_edit', 0);
INSERT INTO `iwebshop_right` VALUES (99, '[营销]团购删除', 'market@regiment_del', 0);
INSERT INTO `iwebshop_right` VALUES (100, '[营销]代金券列表', 'market@ticket_list', 0);
INSERT INTO `iwebshop_right` VALUES (101, '[营销]代金券文件列表', 'market@ticket_excel_list', 0);
INSERT INTO `iwebshop_right` VALUES (102, '[营销]代金券添加修改', 'market@ticket_edit_act,market@ticket_edit', 0);
INSERT INTO `iwebshop_right` VALUES (103, '[营销]代金券文件详情', 'market@ticket_more_list', 0);
INSERT INTO `iwebshop_right` VALUES (104, '[营销]代金券删除', 'market@ticket_more_del,market@ticket_del', 0);
INSERT INTO `iwebshop_right` VALUES (105, '[营销]代金券文件删除', 'market@ticket_excel_del', 0);
INSERT INTO `iwebshop_right` VALUES (106, '[营销]代金券批量生成', 'market@ticket_create', 0);
INSERT INTO `iwebshop_right` VALUES (107, '[营销]代金券EXCEL导出', 'market@ticket_excel_pack,market@ticket_excel', 0);
INSERT INTO `iwebshop_right` VALUES (108, '[营销]代金券文件打包下载', 'market@ticket_excel_pack', 0);
INSERT INTO `iwebshop_right` VALUES (109, '[营销]代金券文件下载', 'market@ticket_excel_download', 0);
INSERT INTO `iwebshop_right` VALUES (110, '[营销]代金券状态修改', 'market@ticket_status', 0);
INSERT INTO `iwebshop_right` VALUES (111, '[统计]基础数据统计', 'market@init_count,market@spanding_avg,market@amount,market@user_reg', 0);
INSERT INTO `iwebshop_right` VALUES (112, '[统计]资金操作记录', 'market@operation_list', 0);
INSERT INTO `iwebshop_right` VALUES (113, '[统计]后台操作记录', 'market@account_list', 0);
INSERT INTO `iwebshop_right` VALUES (114, '[统计]资金和后台操作记录删除', 'market@clear_log', 0);
INSERT INTO `iwebshop_right` VALUES (115, '[系统]网站设置', 'system@test_sendmail,system@clearCache,system@conf_skin,system@getSitePlan,system@save_conf,system@conf_base', 0);
INSERT INTO `iwebshop_right` VALUES (116, '[系统]主题设置', 'system@applySkin,system@applyTheme,system@conf_skin,system@getSitePlan', 0);
INSERT INTO `iwebshop_right` VALUES (117, '[系统]支付管理', 'system@payment_update,system@payment_enable,system@payment_del,system@payment_edit,system@payment_list', 0);
INSERT INTO `iwebshop_right` VALUES (118, '[系统]配送管理', 'system@express_update,system@freight_recycle_del,system@freight_recycle_restore,system@freight_recycle,system@freight_del,system@freight_update,system@area_del,system@area_save,system@area_edit,system@area_sort,system@area_sub_child,system@area_name_child,system@delivery_update,system@delivery_operate,system@delivery_edit,system@express,system@freight_edit,system@freight_list,system@area,system@delivery,system@delivery_recycle', 0);
INSERT INTO `iwebshop_right` VALUES (119, '[工具]数据库备份', 'tools@db_act_bak,tools@get_table,tools@db_bak', 0);
INSERT INTO `iwebshop_right` VALUES (120, '[工具]数据库还原', 'tools@download_pack,tools@localUpload,tools@res_act,tools@backup_del,tools@download,tools@db_res', 0);
INSERT INTO `iwebshop_right` VALUES (121, '[工具]文章管理', 'tools@cat_del,tools@cat_edit,tools@cat_edit_act,tools@article_edit_act,tools@article_del,tools@article_list,tools@article_cat_list,tools@article_edit,tools@article_cat_edit', 0);
INSERT INTO `iwebshop_right` VALUES (122, '[工具]帮助管理', 'tools@help_cat_del,tools@help_cat_position,tools@help_cat_edit_act,tools@help_del,tools@help_edit_act,tools@help_list,tools@help_cat_list,tools@help_edit,tools@help_cat_edit', 0);
INSERT INTO `iwebshop_right` VALUES (123, '[工具]广告管理', 'tools@ad_edit_act,tools@ad_del,tools@ad_position_edit_act,tools@ad_position_del,tools@ad_position_list,tools@ad_list,tools@ad_position_edit,tools@ad_edit', 0);
INSERT INTO `iwebshop_right` VALUES (124, '[工具]公告管理', 'tools@notice_del,tools@notice_edit_act,tools@notice_list,tools@notice_edit', 0);
INSERT INTO `iwebshop_right` VALUES (125, '[订单]快递单添加修改', 'order@expresswaybill_edit,order@expresswaybill_edit_act,order@expresswaybill_upload,order@expresswaybill_template', 0);
INSERT INTO `iwebshop_right` VALUES (126, '[订单]快递单删除', 'order@expresswaybill_del', 0);
INSERT INTO `iwebshop_right` VALUES (127, '[订单]订单退款操作', 'order@order_refundment_doc', 0);
INSERT INTO `iwebshop_right` VALUES (128, '[订单]配货单详情', 'order@delivery_show', 0);
INSERT INTO `iwebshop_right` VALUES (129, '[会员]消息模板修改', 'message@tpl_edit,message@tpl_save', 0);

DROP TABLE IF EXISTS `iweb_expresswaybill`;
CREATE TABLE `iweb_expresswaybill` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL COMMENT '快递单模板名字',
  `config` text COMMENT '序列化的快递单结构数据',
  `background` varchar(255) default NULL COMMENT '背景图片路径',
  `width` mediumint(5) UNSIGNED default 900 COMMENT '背景图片路径',
  `height` mediumint(5) UNSIGNED default 600 COMMENT '背景图片路径',
  `is_close` tinyint(1) NOT NULL default '0' COMMENT '状态 1关闭,0正常',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='快递单模板';

INSERT INTO `iwebshop_expresswaybill` VALUES (1, 'EMS特快专递', 'a:12:{i:1;s:222:"{"x":461,"y":350,"typeId":"date_y","typeText":"当前日期-年","width":33,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":18}";i:5;s:227:"{"x":70,"y":184,"typeId":"dly_address","typeText":"发货人-地址","width":318,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":54}";i:6;s:224:"{"x":271,"y":117,"typeId":"dly_tel","typeText":"发货人-电话","width":119,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":20}";i:10;s:225:"{"x":642,"y":237,"typeId":"ship_zip","typeText":"收货人-邮编","width":109,"styleSheet":{"trackingLeft":"9","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":19}";i:11;s:228:"{"x":625,"y":117,"typeId":"ship_mobile","typeText":"收货人-手机","width":126,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":21}";i:0;s:222:"{"x":510,"y":348,"typeId":"date_m","typeText":"当前日期-月","width":29,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":21}";i:9;s:224:"{"x":458,"y":370,"typeId":"order_memo","typeText":"订单-备注","width":292,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":30}";i:4;s:224:"{"x":122,"y":120,"typeId":"dly_name","typeText":"发货人-姓名","width":94,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":24}";i:8;s:223:"{"x":301,"y":238,"typeId":"dly_zip","typeText":"发货人-邮编","width":99,"styleSheet":{"trackingLeft":"9","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":19}";i:3;s:246:"{"x":409,"y":184,"typeId":"ship_detail_addr","typeText":"收货人-地区+详细地址","width":343,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":55}";i:2;s:226:"{"x":462,"y":117,"typeId":"ship_name","typeText":"收货人-姓名","width":104,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":27}";i:7;s:222:"{"x":559,"y":348,"typeId":"date_d","typeText":"当前日期-日","width":30,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":21}";}', 'upload/2011/11/30/20111130103004185.jpg', 900, 500, 0);
INSERT INTO `iwebshop_expresswaybill` VALUES (2, '顺丰速运', 'a:12:{i:1;s:224:"{"x":265,"y":104,"typeId":"dly_name","typeText":"发货人-姓名","width":74,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":22}";i:3;s:222:"{"x":549,"y":314,"typeId":"date_m","typeText":"当前日期-月","width":32,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":22}";i:0;s:224:"{"x":522,"y":426,"typeId":"order_memo","typeText":"订单-备注","width":182,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":35}";i:6;s:224:"{"x":54,"y":337,"typeId":"ship_tel","typeText":"收货人-电话","width":143,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":17}";i:11;s:227:"{"x":207,"y":188,"typeId":"dly_mobile","typeText":"发货人-手机","width":129,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":18}";i:4;s:245:"{"x":55,"y":271,"typeId":"ship_detail_addr","typeText":"收货人-地区+详细地址","width":284,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":56}";i:5;s:228:"{"x":376,"y":118,"typeId":"ship_time","typeText":"订单-送货时间","width":52,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":22}";i:10;s:228:"{"x":207,"y":336,"typeId":"ship_mobile","typeText":"收货人-手机","width":132,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":18}";i:7;s:227:"{"x":82,"y":132,"typeId":"dly_address","typeText":"发货人-地址","width":255,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":52}";i:8;s:225:"{"x":267,"y":219,"typeId":"ship_name","typeText":"收货人-姓名","width":72,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":23}";i:2;s:223:"{"x":51,"y":190,"typeId":"dly_tel","typeText":"发货人-电话","width":152,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":18}";i:9;s:222:"{"x":585,"y":314,"typeId":"date_d","typeText":"当前日期-日","width":33,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":20}";}', 'upload/2011/11/30/20111130110521690.jpg', 900, 550, 0);
INSERT INTO `iwebshop_expresswaybill` VALUES (3, '申通快递', 'a:9:{i:1;s:222:"{"typeId":"date_d","x":153,"typeText":"当前日期-日","y":389,"width":22,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":20}";i:6;s:221:"{"typeId":"date_y","x":67,"typeText":"当前日期-年","y":391,"width":35,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":22}";i:8;s:224:"{"typeId":"dly_name","x":121,"typeText":"发货人-姓名","y":97,"width":114,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":28}";i:3;s:228:"{"typeId":"dly_address","x":114,"typeText":"发货人-地址","y":167,"width":296,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":75}";i:2;s:227:"{"typeId":"dly_mobile","x":140,"typeText":"发货人-手机","y":240,"width":270,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":24}";i:4;s:222:"{"typeId":"date_m","x":113,"typeText":"当前日期-月","y":391,"width":24,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":18}";i:5;s:228:"{"typeId":"ship_mobile","x":508,"typeText":"收货人-手机","y":241,"width":274,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":21}";i:0;s:225:"{"typeId":"ship_name","x":487,"typeText":"收货人-姓名","y":95,"width":115,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":29}";i:7;s:246:"{"typeId":"ship_detail_addr","x":474,"typeText":"收货人-地区+详细地址","y":167,"width":310,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":72}";}', 'upload/2011/11/30/20111130111842435.jpg', 900, 520, 0);
INSERT INTO `iwebshop_expresswaybill` VALUES (4, '宅急送', 'a:13:{i:2;s:225:"{"typeId":"ship_tel","x":429,"typeText":"收货人-电话","y":234,"width":139,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":24}";i:8;s:226:"{"typeId":"ship_name","x":456,"typeText":"收货人-姓名","y":120,"width":123,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":31}";i:1;s:227:"{"typeId":"dly_mobile","x":254,"typeText":"发货人-手机","y":237,"width":130,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":25}";i:11;s:225:"{"typeId":"dly_name","x":114,"typeText":"发货人-姓名","y":123,"width":120,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":28}";i:10;s:222:"{"typeId":"date_d","x":120,"typeText":"当前日期-日","y":438,"width":23,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":16}";i:6;s:223:"{"typeId":"dly_tel","x":90,"typeText":"发货人-电话","y":235,"width":132,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":26}";i:9;s:231:"{"typeId":"dly_area_1","x":255,"typeText":"发货人-地区2级","y":123,"width":127,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":27}";i:12;s:246:"{"typeId":"ship_detail_addr","x":428,"typeText":"收货人-地区+详细地址","y":151,"width":294,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":57}";i:3;s:231:"{"typeId":"dly_area_1","x":599,"typeText":"发货人-地区2级","y":122,"width":123,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":29}";i:5;s:221:"{"typeId":"date_m","x":90,"typeText":"当前日期-月","y":438,"width":27,"styleSheet":{"fontWeight":"normal","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","trackingLeft":"0"},"height":17}";i:4;s:224:"{"typeId":"order_memo","x":445,"typeText":"订单-备注","y":364,"width":166,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":32}";i:7;s:228:"{"typeId":"ship_mobile","x":585,"typeText":"收货人-手机","y":234,"width":136,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":22}";i:0;s:227:"{"typeId":"dly_address","x":86,"typeText":"发货人-地址","y":154,"width":286,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":55}";}', 'upload/2011/11/30/20111130112722985.jpg', 900, 520, 0);
INSERT INTO `iwebshop_expresswaybill` VALUES (5, '中通速递', 'a:11:{i:2;s:224:"{"typeId":"order_memo","x":372,"typeText":"订单-备注","y":369,"width":145,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":34}";i:10;s:222:"{"typeId":"date_d","x":159,"typeText":"当前日期-日","y":379,"width":24,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":17}";i:7;s:228:"{"typeId":"dly_address","x":130,"typeText":"发货人-地址","y":137,"width":259,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":59}";i:4;s:222:"{"typeId":"date_m","x":118,"typeText":"当前日期-月","y":379,"width":34,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":19}";i:0;s:225:"{"typeId":"dly_name","x":129,"typeText":"发货人-姓名","y":103,"width":101,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":25}";i:8;s:226:"{"typeId":"ship_name","x":476,"typeText":"收货人-姓名","y":103,"width":110,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":22}";i:6;s:224:"{"typeId":"dly_tel","x":122,"typeText":"发货人-电话","y":242,"width":125,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":27}";i:9;s:225:"{"typeId":"ship_zip","x":642,"typeText":"收货人-邮编","y":244,"width":106,"styleSheet":{"trackingLeft":"9","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":23}";i:1;s:246:"{"typeId":"ship_detail_addr","x":476,"typeText":"收货人-地区+详细地址","y":134,"width":262,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":61}";i:5;s:224:"{"typeId":"dly_zip","x":291,"typeText":"发货人-邮编","y":243,"width":103,"styleSheet":{"trackingLeft":"9","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":27}";i:3;s:228:"{"typeId":"ship_mobile","x":464,"typeText":"收货人-手机","y":241,"width":142,"styleSheet":{"trackingLeft":"0","fontSize":"12","fontStyle":"normal","fontFamily":"宋体","textAlign":"left","fontWeight":"normal"},"height":30}";}', 'upload/2011/11/30/20111130113535527.jpg', 900, 520, 0);
