class ShopCarFunc {
  static GoodStatus getGoodsStatus(int jcook, int bee) {
    if (jcook == 0) {
      return GoodStatus.unSell;
    } else {
      if (bee == 0) {
        return GoodStatus.unSell;
      } else {
        return GoodStatus.onSell;
      }
    }
  }
}

enum GoodStatus {
  onSell,
  unSell,
}
