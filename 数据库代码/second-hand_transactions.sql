/*
 Navicat Premium Data Transfer

 Source Server         : locahost
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : second-hand_transactions

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 11/12/2021 03:28:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `fromId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `toId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES ('20202000', '20202001', '你好\n');
INSERT INTO `chat` VALUES ('20202000', '20202001', '手机多少钱');
INSERT INTO `chat` VALUES ('20202001', '20202000', '12000');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int NULL DEFAULT NULL COMMENT '商品id',
  `username` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `price` int NULL DEFAULT NULL COMMENT '商品价格',
  `collect_time` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收藏时间',
  `label` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品标签',
  `described` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  `file` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (2, '20202001', 6000, '2021-12-11 01:58:44', '[\"电子产品\",\"手机\"]', '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论编号',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论的用户id',
  `goods_id` int NOT NULL COMMENT '评论的商品id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论的内容',
  `comment_time` datetime NOT NULL COMMENT '评论的时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (55, '20202001', 57, '123', '2021-12-11 01:24:03');
INSERT INTO `comments` VALUES (56, '20202001', 57, '***', '2021-12-11 01:24:14');
INSERT INTO `comments` VALUES (57, '20202001', 2, 'hi', '2021-12-11 01:40:44');
INSERT INTO `comments` VALUES (58, '20202001', 2, '***', '2021-12-11 01:40:51');
INSERT INTO `comments` VALUES (59, '20202001', 2, '1231', '2021-12-11 01:51:42');
INSERT INTO `comments` VALUES (60, '20202001', 2, '***', '2021-12-11 01:51:51');
INSERT INTO `comments` VALUES (61, '20202001', 1, '23123', '2021-12-11 01:58:59');
INSERT INTO `comments` VALUES (62, '20202001', 1, '23213', '2021-12-11 01:59:05');

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`  (
  `id` int NULL DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `described` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `label` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of history
-- ----------------------------
INSERT INTO `history` VALUES (49, '20202000', '2021-12-11 01:58:37', 277, '这款卡西欧手表，采用军绿色系外观设计，散发着沉稳而又时尚的光芒。', '[\"电子产品\",\"其他电子产品\"]', 'productImg/ee50f65e37ad48608dd68bce9748efae.jpg', '卡西欧手表');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 01:58:42', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (1, '20202001', '2021-12-11 01:58:53', 4000, '99新二手苹果 iPhone 12 无磕碰无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b86a3789e9c5450996daeb241acb454e.jpg', '二手iPhone 12');
INSERT INTO `history` VALUES (60, '20202001', '2021-12-11 02:01:38', 11, '11', '[\"生活用品\",\"家具类\"]', 'productImg/775aff252a054319af2fd8d9d086ade9.jpg', '11');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 02:01:43', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 02:14:27', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (1, '20202001', '2021-12-11 02:19:59', 4000, '99新二手苹果 iPhone 12 无磕碰无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b86a3789e9c5450996daeb241acb454e.jpg', '二手iPhone 12');
INSERT INTO `history` VALUES (4, '20202001', '2021-12-11 02:20:01', 846, '二手Apple AirPods 配无线充电盒 Apple蓝牙耳机 适用iPhone/iPad/Apple Watch', '[\"电子产品\",\"其他电子产品\"]', 'productImg/a15ffd5d7e7c4f2caab77594fc390c77.jpg', 'AirPods');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 02:20:04', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (1, '20202001', '2021-12-11 03:05:29', 4000, '99新二手苹果 iPhone 12 无磕碰无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b86a3789e9c5450996daeb241acb454e.jpg', '二手iPhone 12');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 03:07:26', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 03:07:42', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (2, '20202001', '2021-12-11 03:07:57', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', '二手华为mate 40 pro');
INSERT INTO `history` VALUES (1, '20202001', '2021-12-11 03:08:03', 4000, '99新二手苹果 iPhone 12 无磕碰无划痕', '[\"电子产品\",\"手机\"]', 'productImg/b86a3789e9c5450996daeb241acb454e.jpg', '二手iPhone 12');
INSERT INTO `history` VALUES (3, '20202001', '2021-12-11 03:08:06', 279, 'Apple 15W MagSafe iPhone 磁吸充电器 支持iPhone 12/iPhone 13 15W手机便捷快速充电', '[\"电子产品\",\"其他电子产品\"]', 'productImg/ddc6c910321e4c9a8015da6e6a6cd5a5.jpg', '磁吸充电器');
INSERT INTO `history` VALUES (4, '20202001', '2021-12-11 03:08:09', 846, '二手Apple AirPods 配无线充电盒 Apple蓝牙耳机 适用iPhone/iPad/Apple Watch', '[\"电子产品\",\"其他电子产品\"]', 'productImg/a15ffd5d7e7c4f2caab77594fc390c77.jpg', 'AirPods');

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '日志表编号',
  `writer_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '写入时间',
  `operation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (15, '2021-12-11 02:01:32', '商品11通过了审核');
INSERT INTO `log` VALUES (16, '2021-12-11 03:11:26', '删除了用户：20202000');
INSERT INTO `log` VALUES (17, '2021-12-11 03:11:41', '删除了11');

-- ----------------------------
-- Table structure for mainmenu
-- ----------------------------
DROP TABLE IF EXISTS `mainmenu`;
CREATE TABLE `mainmenu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主菜单编号',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `path` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '一级路由路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1300 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of mainmenu
-- ----------------------------
INSERT INTO `mainmenu` VALUES (1000, '用户管理', '/admin');
INSERT INTO `mainmenu` VALUES (1100, '商品管理', '/admin');
INSERT INTO `mainmenu` VALUES (1200, '日志管理', '/admin');
INSERT INTO `mainmenu` VALUES (1300, '秒杀商品', '/admin');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` int NULL DEFAULT NULL,
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creat_time` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1, '20202001', '2021-12-09 14:43:52', 3799, '魅族18 pro');

-- ----------------------------
-- Table structure for product_img
-- ----------------------------
DROP TABLE IF EXISTS `product_img`;
CREATE TABLE `product_img`  (
  `picture_file01` blob NULL COMMENT '商品图片1',
  `picture_file02` blob NULL COMMENT '商品图片2',
  `picture_file03` blob NULL COMMENT '商品图片3',
  `picture_file04` blob NULL COMMENT '商品图片4',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_img
-- ----------------------------

-- ----------------------------
-- Table structure for publish
-- ----------------------------
DROP TABLE IF EXISTS `publish`;
CREATE TABLE `publish`  (
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名字',
  `price` int NULL DEFAULT NULL COMMENT '价格',
  `described` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  `file01` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布图片1',
  `file02` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布图片2',
  `file03` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布图片3',
  `file04` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布图片4',
  `label` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品标签',
  `time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布时间',
  `quantity` int NULL DEFAULT NULL COMMENT '商品数量',
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `status` int NOT NULL DEFAULT 2 COMMENT '状态',
  `collect_num` int NULL DEFAULT NULL COMMENT '收藏数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of publish
-- ----------------------------
INSERT INTO `publish` VALUES ('20202001', '二手iPhone 12', 4000, '99新二手苹果 iPhone 12 无磕碰无划痕', 'productImg/b86a3789e9c5450996daeb241acb454e.jpg', 'productImg/a883a4f7be594bc6955d1f8a17658a2f.jpg', 'productImg/4a0233cf8d2048159e605ee5890d7d74.jpg', NULL, '[\"电子产品\",\"手机\"]', '', 1, 1, 1, 0);
INSERT INTO `publish` VALUES ('20202001', '二手华为mate 40 pro', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', 'productImg/b908145f471b4c90bc431cda7fe82dd5.jpg', 'productImg/b3ec4a32a3a649b581a8a790b298131e.jpg', 'productImg/9bbccbd3a3c24c78b23b6593e8e24015.jpg', NULL, '[\"电子产品\",\"手机\"]', '', 1, 2, 1, 7);
INSERT INTO `publish` VALUES ('20202001', '磁吸充电器', 279, 'Apple 15W MagSafe iPhone 磁吸充电器 支持iPhone 12/iPhone 13 15W手机便捷快速充电', 'productImg/ddc6c910321e4c9a8015da6e6a6cd5a5.jpg', 'productImg/0ef80295c3874fdba2ffb666b58b96cc.jpg', 'productImg/99562210af6f4a63a9093a395c5568bb.jpg', NULL, '[\"电子产品\",\"其他电子产品\"]', '', 1, 3, 1, 0);
INSERT INTO `publish` VALUES ('20202001', 'AirPods', 846, '二手Apple AirPods 配无线充电盒 Apple蓝牙耳机 适用iPhone/iPad/Apple Watch', 'productImg/a15ffd5d7e7c4f2caab77594fc390c77.jpg', 'productImg/b9c0a4c936254c1283fbe69205d774ca.jpg', NULL, NULL, '[\"电子产品\",\"其他电子产品\"]', '', 1, 4, 1, 0);
INSERT INTO `publish` VALUES ('20202001', 'c语言', 42, '', 'productImg/09952a3baaf54e0e9e1a2a4ece7816fc.jpg', NULL, NULL, NULL, '[\"书籍产品\",\"编程书籍\"]', '', 1, 18, 1, 1);
INSERT INTO `publish` VALUES ('20202000', '瓦尔登湖', 12, '二手书籍，刚刚看完。感觉还不错', 'productImg/9f94a982ea414c9f943eef834aeb753f.jpg', NULL, NULL, NULL, '[\"书籍产品\",\"小说\"]', '', 1, 44, 1, 0);
INSERT INTO `publish` VALUES ('20202000', '从你的全世界路过', 20, '一本不错的文学书籍', 'productImg/f02fbe7145b34861a2c298a5fc8a680f.jpg', NULL, NULL, NULL, '[\"书籍产品\",\"文学艺术\"]', '', 1, 45, 1, 0);
INSERT INTO `publish` VALUES ('20202000', '解忧杂货铺', 17, '何以解忧？这本书描绘了一个有趣的故事', 'productImg/5d40009b3f954eea80482019f376af6f.jpg', NULL, NULL, NULL, '[\"书籍产品\",\"小说\"]', '', 6, 46, 1, 0);
INSERT INTO `publish` VALUES ('20202000', 'DURGOD 三模 机械键盘', 170, '哑光喷漆机身，全按键无冲突，3设备切换。', 'productImg/60f87d0fb4da42dab3213f3abf77b932.jpg', NULL, NULL, NULL, '[\"电子产品\",\"其他电子产品\"]', '', 1, 47, 1, 0);
INSERT INTO `publish` VALUES ('20202000', '二手小牛', 1700, '小巧紧凑设计，可拆卸电池盒。车身小巧紧凑', 'productImg/b2c3cf49cf204183bbcace4d02e7456b.jpg', NULL, NULL, NULL, '[\"生活用品\",\"其他生活物品\"]', '', 1, 48, 1, 0);
INSERT INTO `publish` VALUES ('20202000', '卡西欧手表', 277, '这款卡西欧手表，采用军绿色系外观设计，散发着沉稳而又时尚的光芒。', 'productImg/ee50f65e37ad48608dd68bce9748efae.jpg', NULL, NULL, NULL, '[\"电子产品\",\"其他电子产品\"]', '', 1, 49, 1, 0);
INSERT INTO `publish` VALUES ('20202000', '万代 拼插 模型', 40, '这款高达模型采用了优质的塑料材质，具有很好的耐摔性。', 'productImg/5bbfc8dff3b342f3b22368e491fb6dfd.jpg', NULL, NULL, NULL, '[\"娱乐手办\",\"手办\"]', '', 1, 50, 1, 0);
INSERT INTO `publish` VALUES ('888888', '书籍', 22, '', 'productImg/5301e5b860434a008eb11048b4250e80.jpg', NULL, NULL, NULL, '[\"书籍产品\",\"其他书籍\"]', '2021-12-11 03:13:05', 2, 61, 2, 0);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` int NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comment_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `reply_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (0, '20202001', '爱德华关于jar', '2021-12-10 21:41:05', 40);

-- ----------------------------
-- Table structure for second_label
-- ----------------------------
DROP TABLE IF EXISTS `second_label`;
CREATE TABLE `second_label`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '二级标签编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二级标签',
  `main_id` int NOT NULL COMMENT '对应一级标签编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of second_label
-- ----------------------------

-- ----------------------------
-- Table structure for shopping
-- ----------------------------
DROP TABLE IF EXISTS `shopping`;
CREATE TABLE `shopping`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `price` int NULL DEFAULT NULL COMMENT '价格',
  `described` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  `file` blob NULL COMMENT '图片',
  `quantity` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopping
-- ----------------------------
INSERT INTO `shopping` VALUES (2, '20202001', 6000, '9新 华为 HUAWEI Mate 40 Pro  8GB+256GB釉白色华为手机【搭载HarmonyOS 2】 无磕碰 无划痕', 0x70726F64756374496D672F62393038313435663437316234633930626334333163646137666538326464352E6A7067, 1);
INSERT INTO `shopping` VALUES (4, '20202001', 846, '二手Apple AirPods 配无线充电盒 Apple蓝牙耳机 适用iPhone/iPad/Apple Watch', 0x70726F64756374496D672F61313566666435643765376334663263616162373735393466633339306337372E6A7067, 1);
INSERT INTO `shopping` VALUES (18, '20202001', 42, '', 0x70726F64756374496D672F30393935326133626161663534653065396531613261346563653738313666632E6A7067, 1);
INSERT INTO `shopping` VALUES (44, '20202001', 12, '二手书籍，刚刚看完。感觉还不错', 0x70726F64756374496D672F39663934613938326561343134633966393433656566383334616562373533662E6A7067, 1);
INSERT INTO `shopping` VALUES (45, '20202001', 20, '一本不错的文学书籍', 0x70726F64756374496D672F66303266626537313435623334383631613263323938613566633861363830662E6A7067, 1);
INSERT INTO `shopping` VALUES (48, '20202001', 1700, '小巧紧凑设计，可拆卸电池盒。车身小巧紧凑', 0x70726F64756374496D672F62326333636634396366323034313833626263616365346430326537343536622E6A7067, 1);
INSERT INTO `shopping` VALUES (49, '20202001', 277, '这款卡西欧手表，采用军绿色系外观设计，散发着沉稳而又时尚的光芒。', 0x70726F64756374496D672F65653530663635653337616434383630386464363862636539373438656661652E6A7067, 1);

-- ----------------------------
-- Table structure for spike
-- ----------------------------
DROP TABLE IF EXISTS `spike`;
CREATE TABLE `spike`  (
  `id` int NULL DEFAULT NULL COMMENT '秒杀id',
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `described` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` int NULL DEFAULT 1
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spike
-- ----------------------------
INSERT INTO `spike` VALUES (1, '魅族18 pro', 4, '99新 8+128GB 飞雪流光', '3799', 'productImg/807983e62d114463bba0016005adc4c1.jpg', 0);
INSERT INTO `spike` VALUES (2, 'Bose QC30降噪耳机 ', 1, 'Bose QC30降噪耳机 无颈挂式', '1099', 'productImg/86733977322a4c59ab8ead814fd649c6.jpg', 0);
INSERT INTO `spike` VALUES (3, 'IQOO Neo5', 1, '买来未开封 IQOO Neo5 冰封白8+128G', '1899', 'productImg/28bc646f2f4e4412a483c02aaf3dffc5.jpg', 0);
INSERT INTO `spike` VALUES (4, '乐高', 1, '乐高典藏瓶中船', '649', 'productImg/3b6a5b870b03455ebdc1c9ca9d975d08.jpg', 0);
INSERT INTO `spike` VALUES (5, '长条小夜灯', 4, 'Deamak长条小夜灯', '8', 'productImg/470ea4b4232240288cab88db11f7d6d4.jpg', 0);
INSERT INTO `spike` VALUES (6, '全六册自律法则', 1, '全六册自律法则励志书', '17', 'productImg/715054372bc9442e8ec4cb03c9e9057a.jpg', 0);
INSERT INTO `spike` VALUES (7, '不锈钢削皮刀', 5, '精品不锈钢削皮刀', '5', 'productImg/e1c612d9ebb94f9695309392bddf6812.jpg', 0);
INSERT INTO `spike` VALUES (8, '男性板鞋', 1, '全新未穿过', '99', 'productImg/db73ef8b947644f59c83bd1145a5951f.jpg', 0);
INSERT INTO `spike` VALUES (9, '啊一波蛋花汤', 4, '啊一波蛋花汤整箱，宵夜好伙伴', '35', 'productImg/072f2db277eb40c385aa7238f8cb80ac.jpg', 0);

-- ----------------------------
-- Table structure for submenu
-- ----------------------------
DROP TABLE IF EXISTS `submenu`;
CREATE TABLE `submenu`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '子菜单编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '路径',
  `main_id` int NOT NULL COMMENT '对应主菜单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1066 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of submenu
-- ----------------------------
INSERT INTO `submenu` VALUES (1001, '查看用户', '/userInfo', 1000);
INSERT INTO `submenu` VALUES (1002, '账号管理', '/userPower', 1000);
INSERT INTO `submenu` VALUES (1003, '发布商品审核', '/issueAudit', 1100);
INSERT INTO `submenu` VALUES (1004, '查看商品', '/allProduct', 1100);
INSERT INTO `submenu` VALUES (1005, '查看日志', '/viewLog', 1200);
INSERT INTO `submenu` VALUES (1066, '秒杀管理', '/publishspick', 1300);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` int NOT NULL DEFAULT 1 COMMENT '用户类型（1普通 2管理员）',
  `status` int NULL DEFAULT 1 COMMENT '状态（1正常  0冻结）',
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('20202001', '123456789', 1, 1);
INSERT INTO `user` VALUES ('20202002', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1);
INSERT INTO `user` VALUES ('20202008', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1);
INSERT INTO `user` VALUES ('20202010', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1);
INSERT INTO `user` VALUES ('888888', '1f82c942befda29b6ed487a51da199f78fce7f05', 2, 1);

-- ----------------------------
-- Table structure for user_infor
-- ----------------------------
DROP TABLE IF EXISTS `user_infor`;
CREATE TABLE `user_infor`  (
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号（学号）',
  `nickname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货地址',
  `qq` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `img` blob NULL COMMENT '头像'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_infor
-- ----------------------------
INSERT INTO `user_infor` VALUES ('20202001', '小梦', '15970320438', '青山湖区庐山中大道888号', '2320842611', 18, '女', 0x70726F64756374496D672F61313338623338626537663634656663396638343937636566313435643032392E6A7067);
INSERT INTO `user_infor` VALUES ('20202002', '小孙', '19880212493', '希望大街3号', '3185612473', 20, '男', NULL);
INSERT INTO `user_infor` VALUES ('20202010', '小周', '15986425684', '希望大街5号', '2320842611', 20, '男', NULL);
INSERT INTO `user_infor` VALUES ('20202010', '小李', NULL, NULL, '2320842611', 0, NULL, NULL);
INSERT INTO `user_infor` VALUES ('20202020', '小王', NULL, NULL, '2320842611', 0, NULL, NULL);
INSERT INTO `user_infor` VALUES ('20202008', '小梅', '15970320438', '青山湖区庐山中大道888号', '2320842611', 20, '女', 0x70726F64756374496D672F38643433336239303733646634643437393964633738316361636330316435382E6A7067);

SET FOREIGN_KEY_CHECKS = 1;
