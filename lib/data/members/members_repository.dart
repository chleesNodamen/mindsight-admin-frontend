import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members/members_model.dart';
import 'package:mindsight_admin_page/data/members/members_req_get.dart';

class MembersRepository extends BaseRepository {
  Future<MembersModel> get(MembersReqGet dto) async {
    // req
    String endpoint = "members";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    MembersModel model =
        fetchJsonData<MembersModel>(response, MembersModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}

// class MembersRepository extends BaseRepository {
//   Future<MembersModel> get(MembersReqGet dto) async {
//     // Logger.log(dto.toJson());
//     // req
//     String endpoint = "members";
//     // endpoint += addGetParam(query);
//     Response response = await httpClient.getRequest(endpoint, query: dto.toJson());

//     // result
//     MembersModel model =
//         fetchJsonData<MembersModel>(response, MembersModel.fromJson);
//     model.length = model.id?.length ?? model.length;

//     return model;
//   }
// }
