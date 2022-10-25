class CommentModel {
  late String dateTime;
  late String text;
  late String name;
  late String uId;

  CommentModel({
    required this.name,
    required this.dateTime,
    required this.text,
    required this.uId,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
