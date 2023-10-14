class Comments {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Comments({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body });

  factory Comments.fromJson(Map<String, dynamic> json){
    return Comments(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body']
    );
  }
}

