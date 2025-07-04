import 'package:mindsight_admin_page/data/base_model.dart';

class NoticeBoardEditReqPut extends BaseModel {
  String? title;
  String? content;
  String? attachedFile; // 첨부파일

  NoticeBoardEditReqPut({
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
