import 'package:mindsight_admin_page/data/base_model.dart';

class FAQBoardEditReqPut extends BaseModel {
  String? question;
  String? answer;
  String? attachedFile;

  FAQBoardEditReqPut({
    this.question,
    this.answer,
    this.attachedFile,
  });

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "attachedFile": attachedFile,
      };
}
