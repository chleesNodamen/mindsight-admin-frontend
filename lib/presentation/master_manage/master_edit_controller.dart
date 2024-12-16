import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/content_language.dart';
import 'package:mindsight_admin_page/constants/enum/contry.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_model.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_repository.dart';
import 'package:mindsight_admin_page/data/master_edit/master_edit_repository.dart';
import 'package:mindsight_admin_page/data/master_edit/master_edit_req_put.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';
import 'package:mindsight_admin_page/data/upload/upload_repository.dart';
import 'package:universal_html/html.dart';

class MasterEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late MasterDetailModel masterDetailModel;

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

  Rx<String?> photoUrl = Rx<String?>(null);
  Rx<String?> idPhotoUrl = Rx<String?>(null);

  File? photoFile;
  File? idPhotoFile;
  Rx<Map<String, String>?> selectedCompany = Rx<Map<String, String>?>(null);

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
    isLoading.value = true;

    if (AppConstant.test) {
      await MasterSigninRepository().post(MasterSigninReqPost(
          email: AppConstant.testEmail, password: AppConstant.testPassword));
    }

    masterDetailModel = await MasterDetailRepository().get(id);

    emailController.text = masterDetailModel.email;
    nicknameController.text = masterDetailModel.nickname;
    nameController.text = masterDetailModel.name;
    phoneNumberController.text = masterDetailModel.phoneNumber;
    addressController.text = masterDetailModel.address;
    introController.text = masterDetailModel.intro;

    selectedContry.value = Contry.fromKeyword(masterDetailModel.country);
    selectedPrimaryLanguage.value =
        ContentLanguage.fromKeyword(masterDetailModel.primaryLanguage);
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
      photoUrl.value = (await UploadRepository().uploadFile(photoFile!)).url;
    }
    if (idPhotoFile != null) {
      idPhotoUrl.value =
          (await UploadRepository().uploadFile(idPhotoFile!)).url;
    }

    String? password;

    if (passwordController.text.isNotEmpty) {
      if (passwordController.text != passwordCofirmController.text) {
        isLoading.value = false;
        showSimpleMessage("비밀번호가 일치 하지 않습니다");
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
      showSimpleMessage("저장 되었습니다");
    } else {
      showSimpleMessage("저장에 실패 하였습니다. ${model.getErrorMessage().tr}");
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
