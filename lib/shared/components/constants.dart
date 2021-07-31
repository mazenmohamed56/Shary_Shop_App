import 'package:shop_app/shared/Network/local/sharedPreferences.dart';
import 'components.dart';
import 'package:shop_app/modules/LoginScreen/login_screen.dart';

String token = '';
void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinsh(
        context,
        LoginScreen(),
      );
    }
  });
}
