class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String text;
  late String messageImage;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
    required this.messageImage,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    messageImage = json['messageImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'messageImage': messageImage,
    };
  }
}
