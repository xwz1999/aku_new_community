class AkuShopModel {
  String activityType;
  String activityid;
  String couponCondition;
  String couponexplain;
  String couponurl;
  String deposit;
  String depositDeduct;
  String discount;
  String generalIndex;
  String guideArticle;
  String isBrand;
  String isExplosion;
  String isLive;
  String isShipping;
  String isquality;
  String itemdesc;
  String itemendprice;
  String itemid;
  String itempic;
  String itempicCopy;
  String itemprice;
  String itemsale;
  String itemsale2;
  String itemshorttitle;
  String itemtitle;
  String me;
  String onlineUsers;
  String originalArticle;
  String originalImg;
  String planlink;
  String reportStatus;
  String sellerId;
  String sellerName;
  String sellernick;
  String shopid;
  String shopname;
  String shoptype;
  String sonCategory;
  String startTime;
  String starttime;
  String taobaoImage;
  String tkmoney;
  String tkrates;
  String tktype;
  String todaycouponreceive;
  String todaysale;
  String userid;
  String videoid;
  String xid;
  String couponreceive;
  String fqcat;
  String endTime;
  String downType;
  String cuntao;
  String couponsurplus;
  String couponstarttime;
  String couponreceive2;
  String couponnum;
  String couponmoney;
  String couponendtime;
  String productId;
  int count;
  bool isCheck;

  AkuShopModel(
      {this.activityType,
      this.activityid,
      this.couponCondition,
      this.couponexplain,
      this.couponurl,
      this.deposit,
      this.depositDeduct,
      this.discount,
      this.generalIndex,
      this.guideArticle,
      this.isBrand,
      this.isExplosion,
      this.isLive,
      this.isShipping,
      this.isquality,
      this.itemdesc,
      this.itemendprice,
      this.itemid,
      this.itempic,
      this.itempicCopy,
      this.itemprice,
      this.itemsale,
      this.itemsale2,
      this.itemshorttitle,
      this.itemtitle,
      this.me,
      this.onlineUsers,
      this.originalArticle,
      this.originalImg,
      this.planlink,
      this.reportStatus,
      this.sellerId,
      this.sellerName,
      this.sellernick,
      this.shopid,
      this.shopname,
      this.shoptype,
      this.sonCategory,
      this.startTime,
      this.starttime,
      this.taobaoImage,
      this.tkmoney,
      this.tkrates,
      this.tktype,
      this.todaycouponreceive,
      this.todaysale,
      this.userid,
      this.videoid,
      this.xid,
      this.couponreceive,
      this.fqcat,
      this.endTime,
      this.downType,
      this.cuntao,
      this.couponsurplus,
      this.couponstarttime,
      this.couponreceive2,
      this.couponnum,
      this.couponmoney,
      this.couponendtime,
      this.productId,
      this.count,
      this.isCheck});

  AkuShopModel.fromJson(Map<String, dynamic> json) {
    activityType = json['activity_type'];
    activityid = json['activityid'];
    couponCondition = json['coupon_condition'];
    couponexplain = json['couponexplain'];
    couponurl = json['couponurl'];
    deposit = json['deposit'];
    depositDeduct = json['deposit_deduct'];
    discount = json['discount'];
    generalIndex = json['general_index'];
    guideArticle = json['guide_article'];
    isBrand = json['is_brand'];
    isExplosion = json['is_explosion'];
    isLive = json['is_live'];
    isShipping = json['is_shipping'];
    isquality = json['isquality'];
    itemdesc = json['itemdesc'];
    itemendprice = json['itemendprice'];
    itemid = json['itemid'];
    itempic = json['itempic'];
    itempicCopy = json['itempic_copy'];
    itemprice = json['itemprice'];
    itemsale = json['itemsale'];
    itemsale2 = json['itemsale2'];
    itemshorttitle = json['itemshorttitle'];
    itemtitle = json['itemtitle'];
    me = json['me'];
    onlineUsers = json['online_users'];
    originalArticle = json['original_article'];
    originalImg = json['original_img'];
    planlink = json['planlink'];
    reportStatus = json['report_status'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    sellernick = json['sellernick'];
    shopid = json['shopid'];
    shopname = json['shopname'];
    shoptype = json['shoptype'];
    sonCategory = json['son_category'];
    startTime = json['start_time'];
    starttime = json['starttime'];
    taobaoImage = json['taobao_image'];
    tkmoney = json['tkmoney'];
    tkrates = json['tkrates'];
    tktype = json['tktype'];
    todaycouponreceive = json['todaycouponreceive'];
    todaysale = json['todaysale'];
    userid = json['userid'];
    videoid = json['videoid'];
    xid = json['xid'];
    couponreceive = json['couponreceive'];
    fqcat = json['fqcat'];
    endTime = json['end_time'];
    downType = json['down_type'];
    cuntao = json['cuntao'];
    couponsurplus = json['couponsurplus'];
    couponstarttime = json['couponstarttime'];
    couponreceive2 = json['couponreceive2'];
    couponnum = json['couponnum'];
    couponmoney = json['couponmoney'];
    couponendtime = json['couponendtime'];
    productId = json['product_id'];
    count = json['count'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_type'] = this.activityType;
    data['activityid'] = this.activityid;
    data['coupon_condition'] = this.couponCondition;
    data['couponexplain'] = this.couponexplain;
    data['couponurl'] = this.couponurl;
    data['deposit'] = this.deposit;
    data['deposit_deduct'] = this.depositDeduct;
    data['discount'] = this.discount;
    data['general_index'] = this.generalIndex;
    data['guide_article'] = this.guideArticle;
    data['is_brand'] = this.isBrand;
    data['is_explosion'] = this.isExplosion;
    data['is_live'] = this.isLive;
    data['is_shipping'] = this.isShipping;
    data['isquality'] = this.isquality;
    data['itemdesc'] = this.itemdesc;
    data['itemendprice'] = this.itemendprice;
    data['itemid'] = this.itemid;
    data['itempic'] = this.itempic;
    data['itempic_copy'] = this.itempicCopy;
    data['itemprice'] = this.itemprice;
    data['itemsale'] = this.itemsale;
    data['itemsale2'] = this.itemsale2;
    data['itemshorttitle'] = this.itemshorttitle;
    data['itemtitle'] = this.itemtitle;
    data['me'] = this.me;
    data['online_users'] = this.onlineUsers;
    data['original_article'] = this.originalArticle;
    data['original_img'] = this.originalImg;
    data['planlink'] = this.planlink;
    data['report_status'] = this.reportStatus;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['sellernick'] = this.sellernick;
    data['shopid'] = this.shopid;
    data['shopname'] = this.shopname;
    data['shoptype'] = this.shoptype;
    data['son_category'] = this.sonCategory;
    data['start_time'] = this.startTime;
    data['starttime'] = this.starttime;
    data['taobao_image'] = this.taobaoImage;
    data['tkmoney'] = this.tkmoney;
    data['tkrates'] = this.tkrates;
    data['tktype'] = this.tktype;
    data['todaycouponreceive'] = this.todaycouponreceive;
    data['todaysale'] = this.todaysale;
    data['userid'] = this.userid;
    data['videoid'] = this.videoid;
    data['xid'] = this.xid;
    data['couponreceive'] = this.couponreceive;
    data['fqcat'] = this.fqcat;
    data['end_time'] = this.endTime;
    data['down_type'] = this.downType;
    data['cuntao'] = this.cuntao;
    data['couponsurplus'] = this.couponsurplus;
    data['couponstarttime'] = this.couponstarttime;
    data['couponreceive2'] = this.couponreceive2;
    data['couponnum'] = this.couponnum;
    data['couponmoney'] = this.couponmoney;
    data['couponendtime'] = this.couponendtime;
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
