class BeeParse{
  static int getEstateNameId(String estateName) {
    int a = int.parse(estateName.split('|')[0]);
    return a;
  }
  static String getEstateName(String estateNmae) {
    return estateNmae.split('|')[1];
  }
}