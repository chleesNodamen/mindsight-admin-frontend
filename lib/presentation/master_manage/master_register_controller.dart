import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/content_language.dart';
import 'package:mindsight_admin_page/constants/nation.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';

class MasterRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  List<Nation> nationLabels = [Nation.us, Nation.korea, Nation.japan];
  List<ContentLanguage> languageLabels = [
    ContentLanguage.english,
    ContentLanguage.korean,
    ContentLanguage.japanese
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    isLoading.value = false;
  }
}
