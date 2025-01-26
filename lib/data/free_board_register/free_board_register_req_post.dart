// lib/data/company_register/company_register_req_post.dart

class FreeBoardRegisterReqPost {
  String? title;
  String? content;

  FreeBoardRegisterReqPost({
    this.title,
    this.content,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
