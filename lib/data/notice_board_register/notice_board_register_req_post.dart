// lib/data/company_register/company_register_req_post.dart

class NoticeBoardRegisterReqPost {
  String? title;
  String? content;

  NoticeBoardRegisterReqPost({
    this.title,
    this.content,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
