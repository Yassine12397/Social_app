import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/social_layout/cubit/states.dart';
import 'package:flutter_app/models/post_model.dart';
import 'package:flutter_app/shared/network/end_points.dart';
import 'package:flutter_app/shared/styles/colors.dart';
import 'package:flutter_app/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          SocialCubit.get(context).getPost();
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit
                .get(context)
                .posts
                .length > 0 &&
                SocialCubit
                    .get(context)
                    .model != null,
            builder: (context) =>
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: AssetImage('assets/images/image_7.jpg'),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Connect with friends',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildPostItem(
                                SocialCubit
                                    .get(context)
                                    .posts[index],
                                context,
                                index),
                        itemCount: SocialCubit
                            .get(context)
                            .posts
                            .length,
                        separatorBuilder: (context, index) =>
                            SizedBox(
                              height: 8,
                            ),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildPostItem(PostModel postModel, context, index) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${postModel.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${postModel.name}',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          '${postModel.dateTime}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${postModel.text} ',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 5),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: defaultColor,
                              ),
                            ),
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: defaultColor,
                              ),
                            ),
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 6),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                color: defaultColor,
                              ),
                            ),
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (postModel.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage('${postModel.postImage}'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${SocialCubit
                                    .get(context)
                                    .likes[index]}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                          onTap: () {
                            SocialCubit.get(context).likePost(
                                SocialCubit
                                    .get(context)
                                    .postsId[index]);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0 comment',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                '${SocialCubit
                                    .get(context)
                                    .model!
                                    .image}'),
                          ),
                          onTap: () {
                            SocialCubit.get(context).commentPost(
                                SocialCubit
                                    .get(context)
                                    .postsId[index],
                                commentController.text);
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(
                                hintText: 'write a comment ...',
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
