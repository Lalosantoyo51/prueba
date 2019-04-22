class messageModel{
  int id;
  int place_id;
  String title;
  String created_at;
  bool isOnShift;
  String message;

  messageModel(this.id, this.place_id, this.title, this.created_at, this.isOnShift,
      this.message);

  messageModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        place_id = json["place_id"],
        title = json["title"],
        created_at = json['created_at'],
        message = json["message"];

}