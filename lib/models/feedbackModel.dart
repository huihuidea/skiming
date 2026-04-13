class Feedbackmodel {
  Feedbackmodel({
      this.id, 
      this.userId, 
      this.content, 
      this.createdAt,});

  Feedbackmodel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    content = json['content'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? userId;
  String? content;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['content'] = content;
    map['createdAt'] = createdAt;
    return map;
  }

}