import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:mindsight_admin_page/presentation/content_manage/content_edit/content_edit_controller.dart';

class ContentDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;
  RxString ccLink = "".obs;
  RxString thumbnailLink = "".obs;
  RxString videoLink = "".obs;
  late ContentDetailsModel contentDetailsModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;
    isInited.value = false;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    contentDetailsModel = await ContentDetailsRepository().get(id);

    if (contentDetailsModel.isSuccess) {
      ccLink.value = contentDetailsModel.cc ?? "";
      thumbnailLink.value = contentDetailsModel.thumbnail ?? "";
      videoLink.value = contentDetailsModel.video ?? "";
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void goToEdit() {
    Get.offAllNamed(AppRoutes.contentEdit, arguments: {
      RouteArguments.id: contentDetailsModel.id,
    });
  }

  void downloadFile(String url) {
    // url = Uri.parse(url);
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}
