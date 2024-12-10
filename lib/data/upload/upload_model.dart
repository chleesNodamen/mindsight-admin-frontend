import 'package:mindsight_admin_page/data/base_model.dart';

class UploadModel extends BaseModel {
  String? url;
  String? folder;

  UploadModel({
    this.url,
    this.folder,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) => UploadModel(
        url: json["url"],
        folder: json["folder"],
      );
}
