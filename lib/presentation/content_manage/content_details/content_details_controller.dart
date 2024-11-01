import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/auth/auth_repository.dart';
import 'package:mindsight_admin_page/data/auth/auth_req_post.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';

class ContentDetailsController extends GetxController {
  final id = Get.arguments[RouteArguments.id];
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late ContentDetailsModel contentDetailsModel;

  // RxString ccLink = "".obs;
  // RxString thumbnailLink = "".obs;
  // RxString videoLink = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    if (AppConstant.test) {
      await AuthRepository().post(AuthReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    contentDetailsModel = await ContentDetailsRepository().get(id);

    // if (contentDetailsModel.isSuccess) {
    //   ccLink.value = contentDetailsModel.cc ?? "";
    //   thumbnailLink.value = contentDetailsModel.thumbnail ?? "";
    //   videoLink.value = contentDetailsModel.video ?? "";
    // }

    isLoading.value = false;
    isInited.value = true;
  }

  void onEdit() {
    Get.offAllNamed(AppRoutes.contentEdit, arguments: {
      RouteArguments.id: contentDetailsModel.id,
    });
  }

  Future<void> onViewThumbnail() async {
    final Uri url = Uri.parse(contentDetailsModel.thumbnail ?? "");

    // URL이 유효한지 확인
    if (await canLaunchUrl(url)) {
      // 외부 브라우저에서 URL 열기
      await launchUrl(
        url,
      );
    } else {
      // URL을 열 수 없는 경우 사용자에게 알림
      showSimpleMessage(Get.context!, "해당 URL을 열 수 없습니다");
    }
  }
}
