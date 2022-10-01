class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerified;

  SocialUserModel(
      {required this.name,
      required this.uId,
      required this.email,
      required this.phone,
      required this.image,
      required this.cover,
      required this.bio,
      required this.isEmailVerified});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uId = json['uId'];
    phone = json['phone'];
    bio = json['bio'];
    cover = json['cover'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
