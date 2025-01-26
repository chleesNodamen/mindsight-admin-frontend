import 'package:mindsight_admin_page/data/base_model.dart';

class InquiryBoardEditReqPut extends BaseModel {
  String? subject;
  String? message;
  String? response;

  InquiryBoardEditReqPut({
    this.subject,
    this.message,
    this.response,
  });

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "message": message,
        "response": response,
      };
}
