import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/activity_chat.dart/activity_chat_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class ActivityChatRepository extends BaseRepository {
  Future<ActivityChatModel> get(String id) async {
    // req
    String endpoint = "activity/chat/$id";
    Response response = await httpClient.get(endpoint);

    // result
    ActivityChatModel model =
        fetchJsonData<ActivityChatModel>(response, ActivityChatModel.fromJson);

    if (model.isSuccess) {
      model.length = model.chatlog?.length ?? 0;
    }
    return model;
  }
}
