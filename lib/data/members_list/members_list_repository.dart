import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_list/members_list_model.dart';
import 'package:mindsight_admin_page/data/members_list/members_list_req_get.dart';

class MembersListRepository extends BaseRepository {
  Future<MembersListModel> get(MembersListReqGet dto) async {
    // req
    String endpoint = "members";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MembersListModel model =
        fetchJsonData<MembersListModel>(response, MembersListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}

// class MembersListRepository extends BaseRepository {
//   Future<MembersListModel> get(MembersListReqGet dto) async {
//     // Logger.log(dto.toJson());
//     // req
//     String endpoint = "members";
//     // endpoint += addGetParam(query);
//     Response response = await httpClient.getRequest(endpoint, query: dto.toJson());

//     // result
//     MembersListModel model =
//         fetchJsonData<MembersListModel>(response, MembersListModel.fromJson);
//     model.length = model.id?.length ?? model.length;

//     return model;
//   }
// }
