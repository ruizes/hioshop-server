-- ----------------------------
-- Table structure for hiolabs_user_behavior
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_user_behavior`;
CREATE TABLE `hiolabs_user_behavior` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `behavior_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1:浏览, 2:收藏, 3:加入购物车, 4:购买',
  `behavior_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `behavior_time` (`behavior_time`) USING BTREE,
  KEY `behavior_type` (`behavior_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户行为表';

-- ----------------------------
-- Table structure for hiolabs_recommend_history
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_recommend_history`;
CREATE TABLE `hiolabs_recommend_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `recommend_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '推荐商品列表，JSON格式',
  `recommend_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户推荐历史表';

-- ----------------------------
-- Table structure for hiolabs_recommend_rank
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_recommend_rank`;
CREATE TABLE `hiolabs_recommend_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1:销量榜, 2:热门榜, 3:新品榜, 4:推荐榜',
  `rank_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '排名数据，JSON格式',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `rank_type` (`rank_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品推荐排名表';

-- ----------------------------
-- Table structure for hiolabs_message_center
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_message_center`;
CREATE TABLE `hiolabs_message_center` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1:订单通知, 2:促销活动, 3:系统通知',
  `message_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `message_channel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1:微信模板消息, 2:短信, 3:站内信',
  `message_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0:未发送, 1:已发送, 2:发送失败',
  `send_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `message_status` (`message_status`) USING BTREE,
  KEY `message_channel` (`message_channel`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='消息中心表';

-- ----------------------------
-- Table structure for hiolabs_user_notify_setting
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_user_notify_setting`;
CREATE TABLE `hiolabs_user_notify_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `order_notify` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '订单通知开关',
  `promotion_notify` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '促销通知开关',
  `system_notify` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '系统通知开关',
  `notify_priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '通知优先级: 1:微信模板消息, 2:短信, 3:站内信',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户通知设置表';

-- ----------------------------
-- Table structure for hiolabs_seckill_goods
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_seckill_goods`;
CREATE TABLE `hiolabs_seckill_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `seckill_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `seckill_stock` int(11) NOT NULL DEFAULT '0',
  `seckill_sold` int(11) NOT NULL DEFAULT '0',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0:未开始, 1:进行中, 2:已结束',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `start_time` (`start_time`) USING BTREE,
  KEY `end_time` (`end_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='秒杀商品表';

-- ----------------------------
-- Table structure for hiolabs_seckill_order
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_seckill_order`;
CREATE TABLE `hiolabs_seckill_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `seckill_id` int(11) NOT NULL DEFAULT '0',
  `seckill_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `order_id` (`order_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `seckill_id` (`seckill_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='秒杀订单表';

-- ----------------------------
-- Table structure for hiolabs_user_analysis
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_user_analysis`;
CREATE TABLE `hiolabs_user_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `analysis_date` date NOT NULL,
  `user_count` int(11) NOT NULL DEFAULT '0' COMMENT '用户总数',
  `new_user_count` int(11) NOT NULL DEFAULT '0' COMMENT '新增用户数',
  `active_user_count` int(11) NOT NULL DEFAULT '0' COMMENT '活跃用户数',
  `session_count` int(11) NOT NULL DEFAULT '0' COMMENT '会话数',
  `page_view_count` int(11) NOT NULL DEFAULT '0' COMMENT '页面浏览量',
  `avg_session_duration` float NOT NULL DEFAULT '0' COMMENT '平均会话时长(秒)',
  `conversion_rate` float NOT NULL DEFAULT '0' COMMENT '转化率',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `analysis_date` (`analysis_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户分析表';

-- ----------------------------
-- Table structure for hiolabs_goods_analysis
-- ----------------------------
DROP TABLE IF EXISTS `hiolabs_goods_analysis`;
CREATE TABLE `hiolabs_goods_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `analysis_date` date NOT NULL,
  `view_count` int(11) NOT NULL DEFAULT '0' COMMENT '浏览量',
  `collect_count` int(11) NOT NULL DEFAULT '0' COMMENT '收藏量',
  `cart_count` int(11) NOT NULL DEFAULT '0' COMMENT '加入购物车量',
  `order_count` int(11) NOT NULL DEFAULT '0' COMMENT '订单量',
  `sales_volume` int(11) NOT NULL DEFAULT '0' COMMENT '销售量',
  `conversion_rate` float NOT NULL DEFAULT '0' COMMENT '转化率',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `goods_id` (`goods_id`) USING BTREE,
  KEY `analysis_date` (`analysis_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品分析表';