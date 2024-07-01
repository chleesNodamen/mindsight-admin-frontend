import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_model.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_repository.dart';
import 'package:mindsight_admin_page/data/activity_details/activity_details_req_get.dart';

class PracticeDetailsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  var numbers = List.generate(30, (index) => index + 1).obs;
  var activeNumber = 1.obs;

  void setActiveNumber(int number) {
    activeNumber.value = number;
  }

  late ActivityDetailsModel activityDetailsModel;
  final id = "";
  final type = "Practice plan";

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AppConstant.chleesTest) {
      activityDetailsModel = await ActivityDetailsRepository()
          .get(id, ActivityDetailsReqGet(type: type).toJson());
    } else {
      activityDetailsModel = ActivityDetailsModel().copyWith(
          id: "",
          email: 'akdlsemtkdlxm@nodamen.com',
          username: 'dbwjspdla',
          // "registrationDate": '2023-04-01T12:00:00.000Z',
          registrationDate: '2023-04-01',
          level: '36회차',
          body: 'Sunrise 10-Minute Morning Yoga A',
          breath: 'Sunrise 10-Minute Morning Yoga B',
          title: '30-Day Challenge to Strengthen Your Legs',
          goal: 'Improve health',
          days: '30일',
          intro:
              'This is a 30-Day challenge to Strengthen your legs.Strengthen your legs will increase muscle mass throughout the body, which helps boost metabolism such as breathing and blood circulation.',
          type: "Practice plan",
          recordOne: 'Stressed',
          recordTwo: 'Feeling fatigued, Distracted mind',
          sessionStartDate: '2024-03-13-10:09:34',
          sessionEndDate: '2024-03-13-10:09:34',
          chatbot: 'chatbot',
          expertMessage:
              'You are shining a bit brighter now! We\'re so happy to see the positive changes in your mood! Let\'s keep this beautiful journey and uncover even more wonderful insights.',
          expertMessageDate: '2024-03-13-10:09:34');
    }
    isLoading.value = false;
    isInited.value = true;
  }

  void onPracticeTap() {
    Get.toNamed(AppRoutes.practiceEdit);
  }
}
