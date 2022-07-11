import 'dart:convert';

class CommentBean {
  late String name;
  late String content;
  late String datetime;

  CommentBean({
    required this.name,
    required this.content,
    required this.datetime,
  });

  factory CommentBean.fromJson(Map<String, dynamic> json) {
    return CommentBean(
        content: json['content'],
        name: json['name'],
        datetime: json['datetime']);
  }

  Map<String, dynamic> toJson(CommentBean entity) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = entity.content;
    data['datetime'] = entity.datetime;
    data['name'] = entity.name;
    return data;
  }

  static Map<String, dynamic> toMap(CommentBean diary) => {
        'name': diary.name,
        'content': diary.content,
        'datetime': diary.datetime,
      };

  static String encode(List<CommentBean> list) => json.encode(
        list
            .map<Map<String, dynamic>>((diary) => CommentBean.toMap(diary))
            .toList(),
      );

  static List<CommentBean> decode(String diarys) =>
      (json.decode(diarys) as List<dynamic>)
          .map<CommentBean>((item) => CommentBean.fromJson(item))
          .toList();
}
