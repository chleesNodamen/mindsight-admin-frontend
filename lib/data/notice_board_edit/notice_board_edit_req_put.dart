import 'package:mindsight_admin_page/data/base_model.dart';

class NoticeBoardEditReqPut extends BaseModel {
  String? title;
  String? content;

  NoticeBoardEditReqPut({
    this.title,
    this.content,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
