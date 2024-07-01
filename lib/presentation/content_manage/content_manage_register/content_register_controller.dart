import 'package:mindsight_admin_page/app_export.dart';

class ContentRegisterController extends GetxController {
  final List<String> categories = ["Body", "Breath", "Mindfulness"];

  final Map<String, List<String>> types = {
    "Body": ["Basic body", "Intermediate body", "Advance body"],
    "Breath": [
      'Relaxing breath',
      'Focus breath',
      'Energy breathing',
      'Nature breathing',
      'Guided meditation'
    ],
    'Mindfulness': ['Mindful art', 'Art with music', 'Nature', 'K-ASMR']
  };

  final TextEditingController tagController = TextEditingController();
  final TextEditingController introController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  late final focusNode = FocusNode();

  RxString selectedCategory = "".obs;
  RxBool categorySelected = false.obs;
  RxString selectedType = "".obs;
  RxList tags = [].obs;

  RxBool isLoading = true.obs;
  RxBool isInited = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    // challengeModel = await DashboardChallengeRepository()
    //     .get(DashboardChallengeReqGet(page: 1).toJson());
    // practiceModel = await DashboardPracticeRepository()
    //     .get(DashboardPracticeReqGet(page: 1).toJson());
    // registeredModel = await DashboardRegisteredRepository().get();
    introController.addListener(formatText);
    isLoading.value = false;
    isInited.value = true;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    categorySelected.value = true;
  }

  void addTag(String tag) {
    tags.add(tag.toLowerCase().replaceAll(' ', ''));
    tagController.text = "";
  }

  void formatText() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('- ')) {
        lines[i] = '\t\t-\t\t';
      }
      if (lines[i].startsWith('* ')) {
        lines[i] = '\t\t•\t\t';
      }
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void nextList() {
    String text = introController.text;
    if (text.isEmpty) return;

    List<String> lines = text.split('\n');
    if (lines.last.startsWith('\t\t-\t\t')) {
      lines.add('\t\t-\t\t');
    }
    if (lines.last.startsWith('\t\t•\t\t')) {
      lines.add('\t\t•\t\t');
    }
    String formattedText = lines.join('\n');
    if (formattedText != text) {
      introController.value = introController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
}
