import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_repository.dart';
import 'dart:html' as html;

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
    if (AppConstant.chleesTest) {
      contentDetailsModel = await ContentDetailsRepository().get(id);
    }
    if (contentDetailsModel.isSuccess) {
      ccLink.value = contentDetailsModel.cc!;
      thumbnailLink.value = contentDetailsModel.thumbnail!;
      videoLink.value = contentDetailsModel.video!;
    }
    print(contentDetailsModel.video);
    print(contentDetailsModel.thumbnail);
    print(contentDetailsModel.cc);

    isLoading.value = false;
    isInited.value = true;
  }

  void goToEdit() {
    Get.toNamed(AppRoutes.contentEdit, arguments: {
      RouteArguments.id: contentDetailsModel.id,
    });

    var numbers = List.generate(30, (index) => index + 1).obs;
    var contents = <String>[
      "Sunrise 10-Minute Morning Yoga A",
      "Sunrise 10-Minute Morning Yoga B",
      "Sunrise 10-Minute Morning Yoga C"
    ].obs;
  }

  void downloadFile(String url) {
    // url = Uri.parse(url);
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}
