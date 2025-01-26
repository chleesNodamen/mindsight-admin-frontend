import 'package:mindsight_admin_page/data/base_model.dart';

class FreeBoardEditReqPut extends BaseModel {
  String? title;
  String? content;

  FreeBoardEditReqPut({
    this.title,
    this.content,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
