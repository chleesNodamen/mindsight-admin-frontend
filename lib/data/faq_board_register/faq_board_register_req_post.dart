// lib/data/company_register/company_register_req_post.dart

class FAQBoardRegisterReqPost {
  String? question;
  String? answer;
  String? attachedFile;

  FAQBoardRegisterReqPost({
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
