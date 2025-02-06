// lib/data/company_register/company_register_req_post.dart

class FreeBoardRegisterReqPost {
  String? title;
  String? content;
  String? attachedFile;

  FreeBoardRegisterReqPost({
    this.title,
    this.content,
    this.attachedFile,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "attachedFile": attachedFile,
      };
}
