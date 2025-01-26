// lib/data/company_register/company_register_req_post.dart

class FAQBoardRegisterReqPost {
  String? question;
  String? answer;

  FAQBoardRegisterReqPost({
    this.question,
    this.answer,
  });

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
