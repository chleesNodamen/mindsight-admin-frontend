// lib/data/company_register/company_register_req_post.dart

class InquiryBoardRegisterReqPost {
  String? subject;
  String? message;

  InquiryBoardRegisterReqPost({
    this.subject,
    this.message,
  });

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "message": message,
      };
}
