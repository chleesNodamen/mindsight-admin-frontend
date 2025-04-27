import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/contry.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_register/master_register_repository.dart';
import 'package:mindsight_admin_page/data/master_register/master_register_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/enum/gender.dart';
import 'package:mindsight_admin_page/utils/blob_name_generator.dart';
import 'package:universal_html/html.dart';

class MasterRegisterArgs {
  final String email;

  MasterRegisterArgs({required this.email});
}

class MasterRegisterController extends GetxController {
  late MasterRegisterArgs args;

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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController yearOfBirthController = TextEditingController();

  Rx<Contry?> selectedContry = Rx<Contry?>(Contry.unitedStates);
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

  Rx<Gender?> gender = Rx<Gender?>(null);

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    nicknameController.dispose();
    passwordController.dispose();
    passwordCofirmController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    introController.dispose();
    yearOfBirthController.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    // args = Get.arguments;
    // emailController.text = args.email;

    emailController.text = "chlee@nodamen.com";

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    if (photoFile != null) {
      photoUrl.value = BlobNameGenerator.generateBlobName(photoFile!);
    }
    if (idPhotoFile != null) {
      idPhotoUrl.value = BlobNameGenerator.generateBlobName(idPhotoFile!);
    }

    BaseModel model =
        await MasterRegisterRepository().post(MasterRegisterReqPost(
      email: emailController.text,
      nickname: nicknameController.text,
      password: passwordController.text,
      name: "${firstNameController.text} ${lastNameController.text}",
      // phoneNumber: phoneNumberController.text,
      country: selectedContry.value?.keywordName,
      address: addressController.text,
      primaryLanguage: selectedPrimaryLanguage.value?.keywordName,
      secondaryLanguage: selectedSecondaryLanguage.value?.keywordName,
      intro: introController.text,
      // companyId: selectedCompany.value?["id"],
      photoUrl: photoUrl.value,
      // idPhotoUrl: idPhotoUrl.value,
    ));

    if (model.isSuccess) {
      if (photoFile != null) {
        await UploadRepository()
            .uploadFile(photoFile!, blobName: photoUrl.value!);
      }
      if (idPhotoFile != null) {
        await UploadRepository()
            .uploadFile(idPhotoFile!, blobName: idPhotoUrl.value!);
      }

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
