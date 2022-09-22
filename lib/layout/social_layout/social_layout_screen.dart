import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('News Feed'),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).model != null,
            builder: (context) {
              var model = SocialCubit.get(context).model;
              return Column(
                children: [
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      color: Colors.amber.withOpacity(.6),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Please verify your email',
                              ),
                            ),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification()
                                      .then((value) {})
                                      .catchError((error) {
                                    print('check your mail');
                                  });
                                },
                                child: Text('Send')),
                          ],
                        ),
                      ),
                    )
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
