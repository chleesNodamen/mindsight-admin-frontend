// lib/data/company_register/company_register_req_post.dart

class InquiryBoardRegisterReqPost {
  String? subject;
  String? message;
  String? attachedFile;

  InquiryBoardRegisterReqPost({
    this.subject,
    this.message,
    this.attachedFile,
  });

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "message": message,
        "attachedFile": attachedFile,
      };
}
