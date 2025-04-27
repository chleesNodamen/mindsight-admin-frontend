import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/contry.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_model.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_repository.dart';
import 'package:mindsight_admin_page/data/master_edit/master_edit_repository.dart';
import 'package:mindsight_admin_page/data/master_edit/master_edit_req_put.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:mindsight_admin_page/enum/gender.dart';
import 'package:universal_html/html.dart';

class MasterEditController extends GetxController {
  final String id = Get.arguments[RouteArguments.id];
  // final bool isSettingPage = Get.arguments[RouteArguments.isSettingPage];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterDetailModel masterDetailModel;

  List<Contry> contryLabels =
      Contry.values; // [Contry.unitedStates, Contry.korea, Contry.japan];
  List<ContentLanguage> languageLabels = ContentLanguage.values;
  // [
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
  final TextEditingController yearOfBirthController = TextEditingController();

  Rx<Contry?> selectedContry = Rx<Contry?>(null);
  Rx<ContentLanguage?> selectedPrimaryLanguage = Rx<ContentLanguage?>(null);
  Rx<ContentLanguage?> selectedSecondaryLanguage = Rx<ContentLanguage?>(null);

  Rx<String?> photoUrl = Rx<String?>(null);
  Rx<String?> idPhotoUrl = Rx<String?>(null);

  File? photoFile;
  File? idPhotoFile;
  Rx<Map<String, String>?> selectedCompany = Rx<Map<String, String>?>(null);

  Rx<Gender?> gender = Rx<Gender?>(null);

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
    yearOfBirthController.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  Future<void> initData() async {
    isLoading.value = true;

    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    masterDetailModel = await MasterDetailRepository().get(id);

    emailController.text = masterDetailModel.email!;
    nicknameController.text = masterDetailModel.nickname!;
    nameController.text = masterDetailModel.name!;
    phoneNumberController.text = masterDetailModel.phoneNumber ?? "-";
    addressController.text = masterDetailModel.address ?? "-";
    introController.text = masterDetailModel.intro!;

    selectedContry.value = Contry.fromKeyword(masterDetailModel.country!);
    selectedPrimaryLanguage.value =
        ContentLanguage.fromKeyword(masterDetailModel.primaryLanguage!);
    if (masterDetailModel.secondaryLanguage != null) {
      selectedSecondaryLanguage.value =
          ContentLanguage.fromKeyword(masterDetailModel.secondaryLanguage!);
    }

    photoUrl.value = masterDetailModel.photoUrl;
    idPhotoUrl.value = masterDetailModel.idPhotoUrl;

    if (masterDetailModel.companyName?.isNotEmpty ?? false) {
      selectedCompany.value = {
        "name": masterDetailModel.companyName!,
      };
    }

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

    String? password;

    if (passwordController.text.isNotEmpty) {
      if (passwordController.text != passwordCofirmController.text) {
        isLoading.value = false;
        showSimpleMessage("The password does not match.".tr);
        return;
      } else {
        password = passwordController.text;
      }
    }

    BaseModel model = await MasterEditRepository().put(
        id,
        MasterEditReqPut(
          name: nameController.text,
          nickname: nicknameController.text,
          password: password,
          photoUrl: photoUrl.value,
          phoneNumber: phoneNumberController.text,
          idPhotoUrl: idPhotoUrl.value,
          country: selectedContry.value?.keywordName,
          address: addressController.text,
          primaryLanguage: selectedPrimaryLanguage.value?.keywordName,
          secondaryLanguage: selectedSecondaryLanguage.value?.keywordName,
          intro: introController.text,
          companyId: selectedCompany.value?["id"],
        ));

    if (model.isSuccess) {
      if (photoFile != null) {
        await UploadRepository()
            .uploadFile(photoFile!, blobName: photoUrl.value);
      }
      if (idPhotoFile != null) {
        await UploadRepository()
            .uploadFile(idPhotoFile!, blobName: idPhotoUrl.value);
      }

      await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.masterDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  void onMemberDatail() {
    Get.offAllNamed(AppRoutes.masterDetails,
        arguments: {RouteArguments.id: id});
  }

  void onCancel() {
    Get.offAllNamed(AppRoutes.masterDetails,
        arguments: {RouteArguments.id: id});
  }

  Future<void> onPickPhoto(File? pickedFile) async {
    if (pickedFile != null) {
      photoFile = pickedFile;
      photoUrl.value = photoFile?.name;
    }
  }

  Future<void> onPickIdPhoto(File? pickedFile) async {
    if (pickedFile != null) {
      idPhotoFile = pickedFile;
      idPhotoUrl.value = idPhotoFile?.name;
    }
  }
}
