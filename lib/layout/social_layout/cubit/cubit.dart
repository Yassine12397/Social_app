import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_app/models/comment_model.dart';
import 'package:flutter_app/models/message_model.dart';
import 'package:flutter_app/models/post_model.dart';
import 'package:flutter_app/models/social_user_model.dart';
import 'package:flutter_app/modules/chats/chats_screen.dart';
import 'package:flutter_app/modules/feeds/feeds_screen.dart';
import 'package:flutter_app/modules/new_post/new_post_screen.dart';
import 'package:flutter_app/modules/settings/settings_screen.dart';
import 'package:flutter_app/modules/social_login/login_screen.dart';
import 'package:flutter_app/shared/components/component.dart';
import 'package:flutter_app/shared/constant/constant.dart';
import 'package:flutter_app/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;

  void getUserData() {
    uId = CacheHelper.getData(key: 'uId');
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorStates(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    SettingsScreen(),
  ];
  List<String> titles = ['Home', 'Chats', 'Posts', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) getAllUsers();
    if (index == 3) getUserData();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No Profile image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No cover image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //     emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //    emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

/*  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null && profileImage != null) {
    } else {
      updateUserData(phone: phone, name: name, bio: bio);
    }
  }*/

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel userModel = SocialUserModel(
        email: model!.email,
        phone: phone,
        bio: bio,
        image: image ?? model!.image,
        cover: cover ?? model!.cover,
        name: name,
        isEmailVerified: false,
        uId: model!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No post image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  // ignore: non_constant_identifier_names
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      image: model!.image,
      name: model!.name,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void removeText(TextEditingController controller) {
    controller.clear();
    emit(SocialRemoveTextState());
  }

  void removeMessageImage() {
    messagePicture = null;
    emit(SocialRemoveMessageImageState());
  }

  List<PostModel> posts = [];
  List<PostModel> myPosts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> commentNumber = [];

  void getPost() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      likes = [];
      postsId = [];
      commentNumber = [];
      for (var element in event.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
        }).catchError((error) {});
        element.reference.collection('comments').get().then((value) {
          commentNumber.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      }
      emit(SocialGetPostsSuccessStates());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessStates());
    }).catchError((error) {
      emit(SocialLikePostErrorStates(error.toString()));
    });
  }

  void commentPost({
    required String dateTime,
    required String text,
    required String postId,
  }) {
    CommentModel commentModel = CommentModel(
        name: model!.name, dateTime: dateTime, text: text, uId: model!.uId);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialCommentPostSuccessStates());
    }).catchError((error) {
      emit(SocialCommentPostErrorStates(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUserLoadingStates());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessStates());
      }).catchError((error) {
        emit(SocialGetAllUserErrorStates(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? messageImage,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: model!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
      messageImage: messageImage ?? '',
    );
    //set my chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error.toString()));
      //set receiver chat
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(model!.uId)
          .collection('messages')
          .add(messageModel.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessStates());
      }).catchError((error) {
        emit(SocialSendMessageErrorStates(error.toString()));
      });
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessStates());
    });
  }

  File? messagePicture;

  Future<void> getMessageImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messagePicture = File(pickedFile.path);
      emit(SocialMessageImagePickedSuccessState());
    } else {
      print('No message image selected');
      emit(SocialMessageImagePickedErrorState());
    }
  }

  void uploadMessageImage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users')
        .child(model!.uId)
        .child('chats')
        .child(receiverId)
        .child('messages/${Uri.file(messagePicture!.path).pathSegments.last}')
        .putFile(messagePicture!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
            receiverId: receiverId,
            dateTime: dateTime,
            text: text,
            messageImage: value);
      }).catchError((error) {
        emit(SocialSendMessageSuccessStates());
      });
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error.toString()));
    });
  }

  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      users = [];
      messages = [];
      posts = [];
      postsId = [];
      likes = [];
      profileImage = null;
      coverImage = null;
      model = null;
      uId = '';
      CacheHelper.ClearData(key: 'uId');
      NavigateAndFinish(context, SocialLoginScreen());
      currentIndex = 0;
      emit(SocialLogOutSuccessState());
    }).catchError((error) {
      emit(SocialLogOutErrorState(error.toString()));
    });
  }
}
