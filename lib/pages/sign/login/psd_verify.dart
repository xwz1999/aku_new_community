import 'package:common_utils/common_utils.dart';

enum PSDVERIFY { shorLength, Insufficient, different, correct, empty }

class PsdVerify {
  //检测含有字母、数字、符号中两种的正则表达式
  static String reg = r'^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).*';
  static PSDVERIFY check(String psd, String confirmPsd) {
    if (psd.isEmpty || confirmPsd.isEmpty) {
      return PSDVERIFY.empty;
    } else if (psd != confirmPsd) {
      return PSDVERIFY.different;
    } else if (psd.length < 6) {
      return PSDVERIFY.shorLength;
    } else if (!RegexUtil.matches(reg, psd)) {
      return PSDVERIFY.Insufficient;
    } else {
      return PSDVERIFY.correct;
    }
  }

  static String checkString(PSDVERIFY enu) {
    switch (enu) {
      case PSDVERIFY.shorLength:
        return '密码不能小于6位';
      case PSDVERIFY.Insufficient:
        return '密码至少由两种类型组成';
      case PSDVERIFY.different:
        return '您输入的确认密码和新密码不一致，请检查后重新输入';
      case PSDVERIFY.correct:
        return '';
      case PSDVERIFY.empty:
        return '';
    }
  }
}
