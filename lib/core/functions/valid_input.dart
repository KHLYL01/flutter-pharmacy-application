import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  switch (type) {
    case 'username':
      return !GetUtils.isUsername(val) || val.isEmpty
          ? '  not valid username  '
          : null;
    case 'email':
      return !GetUtils.isEmail(val) || val.isEmpty
          ? '  not valid email  '
          : null;
    case 'password':
      return min > val.length
          ? '  can\'t be less than $min letter  '
          // : max < val.length
          //     ? 'can\'t be larger than $max'
          : null;
  }
}
