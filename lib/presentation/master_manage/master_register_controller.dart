import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/content_language.dart';
import 'package:mindsight_admin_page/constants/enum/contry.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_register/master_register_repository.dart';
import 'package:mindsight_admin_page/data/master_register/master_register_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:universal_html/html.dart';

class MasterRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  List<Contry> contryLabels = [Contry.us, Contry.korea, Contry.japan];
  List<ContentLanguage> languageLabels = [
    ContentLanguage.english,
    ContentLanguage.korean,
    ContentLanguage.japanese
  ];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCofirmController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController introController = TextEditingController();

  Rx<Contry?> selectedContry = Rx<Contry?>(null);
  Rx<ContentLanguage?> selectedPrimaryLanguage = Rx<ContentLanguage?>(null);
  Rx<ContentLanguage?> selectedSecondaryLanguage = Rx<ContentLanguage?>(null);
  Rx<Map<String, String>?> selectedCompany = Rx<Map<String, String>?>(null);

  File? photoFile;
  File? idPhotoFile;
  Rx<String?> photoUrl = Rx<String?>(null);
  Rx<String?> idPhotoUrl = Rx<String?>(null);

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    nicknameController.dispose();
    passwordController.dispose();
    passwordCofirmController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    introController.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    if (photoFile != null) {
      photoUrl.value = (await UploadRepository().uploadFile(photoFile!)).url;
    }
    if (idPhotoFile != null) {
      idPhotoUrl.value =
          (await UploadRepository().uploadFile(idPhotoFile!)).url;
    }

    BaseModel model =
        await MasterRegisterRepository().post(MasterRegisterReqPost(
      email: emailController.text,
      nickname: nicknameController.text,
      password: passwordController.text,
      name: nameController.text,
      phoneNumber: phoneNumberController.text,
      country: selectedContry.value?.keywordName,
      address: addressController.text,
      primaryLanguage: selectedPrimaryLanguage.value?.keywordName,
      secondaryLanguage: selectedSecondaryLanguage.value?.keywordName,
      intro: introController.text,
      companyId: selectedCompany.value?["id"],
      photoUrl: photoUrl.value,
      idPhotoUrl: idPhotoUrl.value,
    ));

    if (model.isSuccess) {
      showSimpleMessage(
          "승인 요청 되었습니다. 최대 2영업일이 소요 됩니다.\n승인이 완료 되면 메일과 푸쉬메세지로 알림 드리겠습니다.");
      Get.offAllNamed(AppRoutes.masterManage);
    } else {
      showSimpleMessage("저장에 실패 하였습니다. ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  Future<void> onPickPhoto(File? pickedFile) async {
    if (pickedFile != null) {
      photoFile = pickedFile;
      photoUrl.value = idPhotoFile?.name;

      Logger.info("onPickPhoto 파일 픽 완료");
    }
  }

  // Future<void> onPickIdPhoto() async {
  //   isLoading.value = true;

  //   PlatformFile? file = await pickFile(FileExtension.jpg);

  //   if (file != null) {
  //     idPhotoFile = File([file.bytes!], file.name);
  //     idPhotoUrl.value = idPhotoFile?.name;
  //   }

  //   isLoading.value = false;

  //   Logger.info(file?.name);
  // }

  Future<void> onPickIdPhoto(File? pickedFile) async {
    if (pickedFile != null) {
      idPhotoFile = pickedFile;
      idPhotoUrl.value = idPhotoFile?.name;

      Logger.info("onPickIdPhoto 파일 픽 완료");
    }
  }
}
