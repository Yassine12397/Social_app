abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

class SocialGetUserErrorStates extends SocialStates {
  final String error;

  SocialGetUserErrorStates(this.error);
}

class SocialGetAllUserLoadingStates extends SocialStates {}

class SocialGetAllUserSuccessStates extends SocialStates {}

class SocialGetAllUserErrorStates extends SocialStates {
  final String error;

  SocialGetAllUserErrorStates(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

//create post

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsLoadingStates extends SocialStates {}

class SocialGetPostsSuccessStates extends SocialStates {}

class SocialGetPostsErrorStates extends SocialStates {
  final String error;

  SocialGetPostsErrorStates(this.error);
}

class SocialLikePostSuccessStates extends SocialStates {}

class SocialLikePostErrorStates extends SocialStates {
  final String error;

  SocialLikePostErrorStates(this.error);
}

class SocialCommentPostSuccessStates extends SocialStates {}

class SocialCommentPostErrorStates extends SocialStates {
  final String error;

  SocialCommentPostErrorStates(this.error);
}
