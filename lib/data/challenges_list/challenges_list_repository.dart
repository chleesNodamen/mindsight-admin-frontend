import 'package:http/http.dart';
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges_list/challenges_list_model.dart';
import 'package:mindsight_admin_page/data/challenges_list/challenges_list_req_get.dart';

class ChallengesListRepository extends BaseRepository {
  Future<ChallengesListModel> get(ChallengesListReqGet dto) async {
    if (!Account.isAdmin) {
      dto.masterId = Account.id;
    }
    // req
    String endpoint = "contents/challenge-list";
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    ChallengesListModel model = fetchJsonData<ChallengesListModel>(
        response, ChallengesListModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
