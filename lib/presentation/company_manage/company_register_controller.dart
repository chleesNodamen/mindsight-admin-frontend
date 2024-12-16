import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_repository.dart';
import 'package:mindsight_admin_page/data/admin_signin/admin_signin_req_post.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/company_register/company_register_repository.dart';
import 'package:mindsight_admin_page/data/company_register/company_register_req_post.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class CompanyRegisterController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController representativeController = TextEditingController();
  TextEditingController businessNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await initData();
  }

  @override
  Future<void> onClose() async {
    super.onClose();

    companyNameController.dispose();
    representativeController.dispose();
    businessNumberController.dispose();
    phoneController.dispose();
    contactNameController.dispose();
    contactEmailController.dispose();
    contactPhoneController.dispose();
    addressController.dispose();
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
    BaseModel model = await CompanyRegisterRepository().post(
        CompanyRegisterReqPost(
            companyName: companyNameController.text,
            representative: representativeController.text,
            businessNumber: businessNumberController.text,
            phone: phoneController.text,
            contactName: contactNameController.text,
            contactEmail: contactEmailController.text,
            contactPhone: contactPhoneController.text,
            address: addressController.text));

    if (model.isSuccess) {
      showSimpleMessage("저장 되었습니다");
    } else {
      showSimpleMessage("저장에 실패 하였습니다. ${model.getErrorMessage().tr}");
    }
  }
}
