import 'package:mindsight_admin_page/data/base_model.dart';

class FreeBoardEditReqPut extends BaseModel {
  String? title;
  String? content;
  String? attachedFile;

  FreeBoardEditReqPut({
    this.title,
    this.content,
    this.attachedFile,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "attachedFile": attachedFile,
      };
}
