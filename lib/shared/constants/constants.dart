// Placeholder Image
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

const imagePlaceholder =
    'https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=';

void signOut(context) => CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });

String? token;