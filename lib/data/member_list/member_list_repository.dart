import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/member_list/member_list_model.dart';
import 'package:mindsight_admin_page/data/member_list/member_list_req_get.dart';

class MemberListRepository extends BaseRepository {
  Future<MemberListModel> get(MemberListReqGet dto) async {
    // req
    String endpoint = "member";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MemberListModel model =
        fetchJsonData<MemberListModel>(response, MemberListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}

// class MemberListRepository extends BaseRepository {
//   Future<MemberListModel> get(MemberListReqGet dto) async {
//     // Logger.log(dto.toJson());
//     // req
//     String endpoint = "member";
//     // endpoint += addGetParam(query);
//     Response response = await httpClient.getRequest(endpoint, query: dto.toJson());

//     // result
//     MemberListModel model =
//         fetchJsonData<MemberListModel>(response, MemberListModel.fromJson);
//     model.length = model.id?.length ?? model.length;

//     return model;
//   }
// }
