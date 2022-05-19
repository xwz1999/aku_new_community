
enum BraceletBrand {
  aqg(1, '爱牵挂','assets/bracelet/x5.png');

  final int typeNum;
  final String name;
  final String imgPath;

  static BraceletBrand getValue(int value) =>
      BraceletBrand.values.firstWhere((element) => element.typeNum == value);

  const BraceletBrand(this.typeNum, this.name,this.imgPath);
}
