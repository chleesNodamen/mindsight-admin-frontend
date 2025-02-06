// lib/data/company_register/company_register_req_post.dart

class NoticeBoardRegisterReqPost {
  String? title;
  String? content;
  String? attachedFile; // 첨부파일

  NoticeBoardRegisterReqPost({
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
