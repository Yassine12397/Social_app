import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_app/models/message_model.dart';
import 'package:flutter_app/models/social_user_model.dart';
import 'package:flutter_app/shared/styles/colors.dart';
import 'package:flutter_app/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;

  ChatDetailsScreen({required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(userModel.image),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(userModel.name)
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).model!.uId ==
                                message.senderId)
                              return buildMyMessage(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 12,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            )),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).getMessageImage();
                                },
                                minWidth: 1,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message here ...',
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  if (SocialCubit.get(context).messagePicture ==
                                      null)
                                    SocialCubit.get(context).sendMessage(
                                        receiverId: userModel.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                  else
                                    SocialCubit.get(context).uploadMessageImage(
                                        receiverId: userModel.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                },
                                minWidth: 1,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                )),
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(model.text)),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: BoxDecoration(
                color: defaultColor.withOpacity(.2),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                )),
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Text(model.text)),
      );
}
