class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;

  SocialUserModel(
      {required this.name,
      required this.uId,
      required this.email,
      required this.phone,
      required this.isEmailVerified});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uId = json['uId'];
    phone = json['phone'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
