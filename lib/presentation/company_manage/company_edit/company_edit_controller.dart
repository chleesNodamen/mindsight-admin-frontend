import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/company_detail/company_detail_model.dart';
import 'package:mindsight_admin_page/data/company_detail/company_detail_repository.dart';
import 'package:mindsight_admin_page/data/company_edit/company_edit_repository.dart';
import 'package:mindsight_admin_page/data/company_edit/company_edit_req_put.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_repository.dart';
import 'package:mindsight_admin_page/data/master_signin/master_signin_req_post.dart';

class CompanyEditController extends GetxController {
  final id = Get.arguments[RouteArguments.id];

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  late CompanyDetailModel companyDataModel;

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
    // if (AppConstant.test) {
    //   await MasterSigninRepository().post(MasterSigninReqPost(
    //       email: AppConstant.testEmail, password: AppConstant.testPassword));
    // }

    companyDataModel = await CompanyDetailRepository().get(id);

    companyNameController.text = companyDataModel.companyName ?? "";
    representativeController.text = companyDataModel.representative ?? "";
    businessNumberController.text = companyDataModel.businessNumber ?? "";
    phoneController.text = companyDataModel.phone ?? "";
    contactNameController.text = companyDataModel.contactName ?? "";
    contactEmailController.text = companyDataModel.contactEmail ?? "";
    contactPhoneController.text = companyDataModel.contactPhone ?? "";
    addressController.text = companyDataModel.address ?? "";

    isInited.value = true;
    isLoading.value = false;
  }

  Future<void> onSave() async {
    isLoading.value = true;

    BaseModel model = await CompanyEditRepository().put(
        id,
        CompanyEditReqPut(
          companyName: companyNameController.text,
          representative: representativeController.text,
          businessNumber: businessNumberController.text,
          phone: phoneController.text,
          contactName: contactNameController.text,
          contactEmail: contactEmailController.text,
          contactPhone: contactPhoneController.text,
          address: addressController.text,
        ));

    if (model.isSuccess) {
      await showSimpleMessage("Saved successfully");
      Get.offAllNamed(AppRoutes.companyDetails,
          arguments: {RouteArguments.id: id});
    } else {
      showSimpleMessage("Save failed ${model.getErrorMessage().tr}");
    }

    isLoading.value = false;
  }

  void onCompanyDatail() {
    Get.offAllNamed(AppRoutes.companyDetails,
        arguments: {RouteArguments.id: id});
  }
}
