// lib/data/company_register/company_register_req_post.dart

class FreeBoardCommentRegisterReqPost {
  String? content;

  FreeBoardCommentRegisterReqPost({
    this.content,
  });

  Map<String, dynamic> toJson() => {
        "content": content,
      };
}
