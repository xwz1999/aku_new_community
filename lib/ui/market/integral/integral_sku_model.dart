class IntegralSkuModel {
  final String imgPath;
  final String skuName;
  final int integral;
  final int sold;
  final int skuId;
  final int goodId;

  static List<IntegralSkuModel> get examples => [
        IntegralSkuModel(
            imgPath: 'http://oss.jcook.com.cn/file5/1509704/1509704_0.jpg',
            skuName: '3M 耳塞 降噪睡眠 弹性舒适1100耳塞一副',
            integral: 1050,
            skuId: 1509704,
            goodId: 438052,
            sold: 89),
        IntegralSkuModel(
            imgPath: 'http://oss.jcook.com.cn/file5/5059614/5059614_0.jpg',
            skuName: '一品巷子 休闲零食 泡面搭档 卤蛋32g/个',
            integral: 1060,
            skuId: 5059614,
            goodId: 451850,
            sold: 156),
        IntegralSkuModel(
            imgPath: 'http://oss.jcook.com.cn/file5/1146553/1146553_0.jpg',
            skuName: '齐心(Comix)美工刀/裁纸刀/壁纸刀工具 小号9mm 颜色随机',
            integral: 1750,
            skuId: 1146553,
            goodId: 435913,
            sold: 34),
        IntegralSkuModel(
            imgPath:
                'http://oss.jcook.com.cn/file5/100014750256/100014750256_0.jpg',
            skuName: '公牛(BULL)118型开关插座布线盒 六孔插座暗盒墙插底盒2位暗盒H14（适用120mm面板）',
            integral: 1910,
            skuId: 100014750256,
            goodId: 562798,
            sold: 49),
        IntegralSkuModel(
            imgPath: 'http://oss.jcook.com.cn/file5/1033528/1033528_0.jpg',
            skuName: '广博（GuangBo）0.5mm黑色中性笔 经典子弹头签字笔 水笔 12支装',
            integral: 6250,
            skuId: 1033528,
            goodId: 435216,
            sold: 298),
        IntegralSkuModel(
            imgPath:
                'http://oss.jcook.com.cn/file5/100017573108/100017573108_0.jpg',
            skuName: '惠寻 100ml小白鞋清洁剂擦洗鞋清洗剂 1瓶',
            integral: 6250,
            skuId: 100017573108,
            goodId: 572690,
            sold: 74),
        IntegralSkuModel(
            imgPath:
                'http://oss.jcook.com.cn/file4/100009789209/100009789209_0.jpg',
            skuName: '东园(TONGGARDEN)蚕豆 泰国进口 兰花豆盐焗味每日坚果炒货休闲零食非油炸',
            integral: 6250,
            skuId: 10009789209,
            goodId: 535330,
            sold: 330),
        IntegralSkuModel(
            imgPath:
                'http://oss.jcook.com.cn/file5/100010670794/100010670794_0.jpg',
            skuName: '伊利 优酸乳 蓝莓味 250g*24盒/箱 乳饮料 聚会乐享 春节年货礼盒装早餐伴侣',
            integral: 35680,
            skuId: 100010670794,
            goodId: 539334,
            sold: 25),
      ];

  const IntegralSkuModel({
    required this.imgPath,
    required this.skuName,
    required this.integral,
    required this.sold,
    required this.skuId,
    required this.goodId,
  });
}
