part of 'init_dependency.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async{
  _initAuth();
  _initPostCategory();
  _uploadPost();
  _allPosts();
  _profileData();
  _commentDependency();
  _userProfileDependency();
  _editProfileDependency();
  _searchDependency();
  _followingDependency();
}

void _initAuth(){
  serviceLocator..registerFactory<AuthDatasource>(
    () => AuthDatasourceImplementation(),
  )..registerFactory<AuthRepository>(
    () => AuthRepositoryImplementation(serviceLocator()),
  )..registerFactory<SignInUseCase>(
    () => SignInUseCase(serviceLocator()),
  )..registerFactory<SignUpUseCase>(
    () => SignUpUseCase(serviceLocator()),
  )..registerFactory<UserUsecase>(
    () => UserUsecase(serviceLocator()),
  )..registerFactory<AuthBloc>(
    () => AuthBloc(
      signupUseCase: serviceLocator(), 
      singInUseCase: serviceLocator(),
      userUsecase: serviceLocator(),
    ),
  );
}

void _initPostCategory(){
  serviceLocator..registerFactory<PostCategoryDatasource>(
    () => PostCategoryDatasourceImplementation(),
  )..registerFactory<PostCategoryrepository>(
    () => PostCategoryRepositoryImplementation(serviceLocator()),
  )..registerFactory(
    () => PostCategoryUseCase(serviceLocator()),
  )..registerFactory(
    () => PostCategoryBloc(postCategoryUseCase: serviceLocator()),
  );
}

void _uploadPost(){
  serviceLocator..registerFactory<UploadPostDatasource>(
    () => UploadPostDatasourceImplementation(),
  )..registerFactory<UploadPostRepository>(
    () => UploadPostRepositoriesImplementation(serviceLocator()),
  )..registerFactory<UploadPostWithImageUsecase>(
    () => UploadPostWithImageUsecase(serviceLocator()),
  )..registerFactory<UploadPostWithoutImageUsecase>(
    () => UploadPostWithoutImageUsecase(serviceLocator()),
  )..registerFactory<UploadPostBloc>(
    () => UploadPostBloc(
      uploadPostWithImageUsecase: serviceLocator(), 
      uploadPostWithoutImageUsecase: serviceLocator(),
    ),
  );
}

void _allPosts(){
  serviceLocator..registerFactory<PostsDatasource>(
    () => PostsDatasourceImplementation(),
  )..registerFactory<PostsRepository>(
    () => PostsRepositoryImplementation(serviceLocator()),
  )..registerFactory<PostsUsecase>(
    () => PostsUsecase(serviceLocator()),
  )..registerFactory<PostsBloc>(
    () => PostsBloc(postsUsecase: serviceLocator()),
  );
}

void _profileData(){
  serviceLocator..registerFactory<ProfileDatasource>(
    () => ProfileDatasourceImplementation()
  )..registerFactory<ProfileRepository>(
    () => ProfileRepositoryImplementation(serviceLocator())
  )..registerFactory<ProfileUsecase>(
    () => ProfileUsecase(serviceLocator())
  )..registerFactory<ProfileBloc>(
    () => ProfileBloc(profileUsecase: serviceLocator())
  );
}

void _commentDependency(){
  serviceLocator..registerFactory<CommentDataSource>(
    () => CommentDatasourceImplementation(),
  )..registerFactory<CommentRepository>(
    () => CommentRepositoryImplementation(serviceLocator()),
  )..registerFactory<FetchCommentUsecase>(
    () => FetchCommentUsecase(serviceLocator()),
  )..registerFactory<UploadCommentUsecase>(
    () => UploadCommentUsecase(serviceLocator()),
  )..registerFactory<CommentBloc>(
    () => CommentBloc(
      fetchCommentUsecase: serviceLocator(), 
      uploadCommentUsecase: serviceLocator(),
    ),
  );
}

void _userProfileDependency(){
  serviceLocator..registerFactory<UserProfileDatasource>(
    () => UserProfileDatasourceImplementation()
  )..registerFactory<UserProfileRepository>(
    () => UserProfileRepositoryImplementation(serviceLocator())
  )..registerFactory<UserProfileDataUsecase>(
    () => UserProfileDataUsecase(serviceLocator())
  )..registerFactory<UserProfilePostUsecase>(
    () => UserProfilePostUsecase(serviceLocator())
  )..registerFactory<UserProfileBloc>(
    () => UserProfileBloc(
      userProfileDataUsecase: serviceLocator(),
      userProfilePostUsecase: serviceLocator(),
    )
  );
}

void _editProfileDependency(){
  serviceLocator..registerFactory<EditProfileDataSource>(
    () => EditProfileDataSourceImplementation(),
  )..registerFactory<EditProfileRepository>(
    () => EditProfileRepositoryImplementation(serviceLocator()),
  )..registerFactory<EditProfileUsecase>(
    () => EditProfileUsecase(serviceLocator()),
  )..registerFactory<EditprofilePictureUsecase>(
    () => EditprofilePictureUsecase(serviceLocator()),
  )..registerFactory<EditCoverPhotoUsecase>(
    () => EditCoverPhotoUsecase(serviceLocator()),
  )..registerFactory<EditProfileBloc>(
    () => EditProfileBloc(
      editProfileUsecase: serviceLocator(),
      editprofilePictureUsecase: serviceLocator(),
      editCoverPhotoUsecase: serviceLocator(),
    ),
  );
}

void _searchDependency(){
  serviceLocator..registerFactory<SearchDataSource>(
    () => SearchDataSourceImplementation(),
  )..registerFactory<SearchRepository>(
    () => SearchRepositoryImplementation(serviceLocator()),
  )..registerFactory<RandomUserUsecase>(
    () => RandomUserUsecase(serviceLocator()),
  )..registerFactory<SearchUserUsecase>(
    () => SearchUserUsecase(serviceLocator()),
    )..registerFactory<SearchBloc>(
    () => SearchBloc(
      randomUserUsecase: serviceLocator(),
      searchUserUsecase: serviceLocator(),
    ),
  );
}

void _followingDependency(){
  serviceLocator..registerFactory<FollowingDatasource>(
    () => FollowingDatasourceImplementation()
  )..registerFactory<FollowingRepository>(
    () => FollowingRepositoryImplementation(serviceLocator()),
  )..registerFactory<AddFollowingUsecase>(
    () => AddFollowingUsecase(serviceLocator())
  )..registerFactory<FetchFollowingUsecase>(
    () => FetchFollowingUsecase(serviceLocator()),
  )..registerFactory<RemoveFollowingUsecase>(
    () => RemoveFollowingUsecase(serviceLocator()),
  )..registerFactory<FollowingBloc>(
    () => FollowingBloc(
      addFollowingUsecase: serviceLocator(),
      fetchFollowingUsecase: serviceLocator(),
      removeFollowingUsecase: serviceLocator(),
    ),
  );
}
