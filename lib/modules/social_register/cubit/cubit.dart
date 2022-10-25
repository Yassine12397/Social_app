import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/social_user_model.dart';
import 'package:flutter_app/modules/social_register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  void UserRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(uId: value.user!.uid, email: email, name: name, phone: phone);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(Social2PasswordVisibilityState());
  }

  void userCreate({
    required String uId,
    required String email,
    required String name,
    required String phone,
  }) {
    SocialUserModel model = SocialUserModel(
        email: email,
        phone: phone,
        bio: 'Write your bio',
        image:
            'https://img.freepik.com/photos-premium/jeune-bel-homme-barbe-isole-gardant-bras-croises-position-frontale_1368-132662.jpg',
        cover:
            'https://img.freepik.com/photos-gratuite/jeune-femme-excitee-montrant-banniere-pointant-du-doigt-vers-gauche-souriant-camera-debout-etonnee-par-mur-blanc_176420-37497.jpg',
        name: name,
        uId: uId,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}
