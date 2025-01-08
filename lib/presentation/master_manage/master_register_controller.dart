import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/contry.dart';
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

  List<Contry> contryLabels =
      Contry.values; // [Contry.unitedStates, Contry.korea, Contry.japan];
  List<ContentLanguage> languageLabels = ContentLanguage.values;
  // List<ContentLanguage> languageLabels = [
  //   ContentLanguage.english,
  //   ContentLanguage.korean,
  //   ContentLanguage.japanese
  // ];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCofirmController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController introController = TextEditingController();

  Rx<Contry?> selectedContry = Rx<Contry?>(Contry.korea);
  Rx<ContentLanguage?> selectedPrimaryLanguage =
      Rx<ContentLanguage?>(ContentLanguage.english);
  Rx<ContentLanguage?> selectedSecondaryLanguage = Rx<ContentLanguage?>(null);
  Rx<Map<String, String>?> selectedCompany = Rx<Map<String, String>?>(null);

  File? photoFile;
  File? idPhotoFile;
  Rx<String?> photoUrl = Rx<String?>(null);
  Rx<String?> idPhotoUrl = Rx<String?>(null);
  RxBool photoFileError = false.obs;
  RxBool idPhotoFileError = false.obs;

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
    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

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
      await showSimpleMessage(
          "Approval requested. It may take up to 2 business days.\nYou will be notified by email upon approval.");

      if (Account.isLogined) {
        Get.offAllNamed(AppRoutes.inactiveMasterManage);
      } else {
        Get.offAllNamed(AppRoutes.auth);
      }
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  Future<void> onPickPhoto(File? pickedFile) async {
    if (pickedFile != null) {
      photoFile = pickedFile;
      photoUrl.value = idPhotoFile?.name;

      Logger.info("onPickPhoto File 픽 Complete");
    }
  }

  Future<void> onPickIdPhoto(File? pickedFile) async {
    if (pickedFile != null) {
      idPhotoFile = pickedFile;
      idPhotoUrl.value = idPhotoFile?.name;

      Logger.info("onPickIdPhoto File 픽 Complete");
    }
  }
}
