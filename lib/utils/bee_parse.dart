class BeeParse {
  static int getEstateNameId(String estateName) {
    if (estateName.isEmpty) {
      return -1;
    } else {
      int a = int.parse(estateName.split('|')[0]);

      return a;
    }
  }

  static String getEstateName(String estateNmae) {
    if (estateNmae.isEmpty) {
      return '';
    } else {
      return estateNmae.split('|')[1];
    }
  }

  static String getCustomYears(int year) {
    int dif = year - DateTime.now().year;
    switch (dif) {
      case -1:
        return '去年';
        break;
      case 0:
        return '今年';
      case 1:
        return '明年';
      default:
        if (dif < 0) return '${-dif}年前';
        // } else {
        return '$dif年后';
      // }
    }
  }
}
