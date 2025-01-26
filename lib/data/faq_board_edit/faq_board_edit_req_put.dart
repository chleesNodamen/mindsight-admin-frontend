import 'package:mindsight_admin_page/data/base_model.dart';

class FAQBoardEditReqPut extends BaseModel {
  String? question;
  String? answer;

  FAQBoardEditReqPut({
    this.question,
    this.answer,
  });

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
