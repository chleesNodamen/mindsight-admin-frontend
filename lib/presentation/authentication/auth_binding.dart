import 'package:get/get.dart';
import 'package:mindsight_admin_page/data/custom_http_client.dart';
import 'package:mindsight_admin_page/presentation/authentication/auth_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut(() => CustomHttpClient());
  }
}
