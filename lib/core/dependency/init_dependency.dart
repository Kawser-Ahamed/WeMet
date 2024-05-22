import 'package:get_it/get_it.dart';
import 'package:wemet/features/auth/data/datasource/auth_datasource.dart';
import 'package:wemet/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:wemet/features/auth/domain/repositories/auth_repository.dart';
import 'package:wemet/features/auth/domain/usecase/signin_usecase.dart';
import 'package:wemet/features/auth/domain/usecase/signup_usecase.dart';
import 'package:wemet/features/auth/domain/usecase/user_usecase.dart';
import 'package:wemet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wemet/features/comment/data/datasource/comment_datasource.dart';
import 'package:wemet/features/comment/data/repositories/comment_repository_implementation.dart';
import 'package:wemet/features/comment/domain/repositories/comment_repository.dart';
import 'package:wemet/features/comment/domain/usecase/fetch_comment_usecase.dart';
import 'package:wemet/features/comment/domain/usecase/upload_comment_usecase.dart';
import 'package:wemet/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:wemet/features/edit_profile/data/datasource/edit_profile_datasource.dart';
import 'package:wemet/features/edit_profile/data/repositories/edit_profile_repository_implementation.dart';
import 'package:wemet/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:wemet/features/edit_profile/domain/usecase/edit_cover_photo_usecase.dart';
import 'package:wemet/features/edit_profile/domain/usecase/edit_profile_picture_usecase.dart';
import 'package:wemet/features/following/data/datasource/following_datasource.dart';
import 'package:wemet/features/following/data/repositories/following_repository_implementation.dart';
import 'package:wemet/features/following/domain/repositories/following_repository.dart';
import 'package:wemet/features/following/domain/usecase/add_following_usecase.dart';
import 'package:wemet/features/following/presentation/bloc/following_bloc.dart';
import 'package:wemet/features/home/data/datasource/post_category_datasource.dart';
import 'package:wemet/features/home/data/datasource/posts_datasource.dart';
import 'package:wemet/features/home/data/repositories/post_category_repository_implementation.dart';
import 'package:wemet/features/home/data/repositories/posts_repository_implementation.dart';
import 'package:wemet/features/home/domain/repositories/post_category_repository.dart';
import 'package:wemet/features/home/domain/repositories/posts_repository.dart';
import 'package:wemet/features/home/domain/usecase/post_category_usecase.dart';
import 'package:wemet/features/home/domain/usecase/posts_usecase.dart';
import 'package:wemet/features/home/presentation/bloc/post_category/post_category_bloc.dart';
import 'package:wemet/features/home/presentation/bloc/posts/posts_bloc.dart';
import 'package:wemet/features/profile/data/datasources/profile_datasource.dart';
import 'package:wemet/features/profile/data/repositories/profile_repository_implementation.dart';
import 'package:wemet/features/profile/domain/repositories/profile_repository.dart';
import 'package:wemet/features/edit_profile/domain/usecase/edit_profile_usecase.dart';
import 'package:wemet/features/profile/domain/usecase/profile_usecase.dart';
import 'package:wemet/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:wemet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wemet/features/search/data/datasource/search_datasource.dart';
import 'package:wemet/features/search/data/repositories/search_repository_implementation.dart';
import 'package:wemet/features/search/domain/repositories/search_repository.dart';
import 'package:wemet/features/search/domain/usecase/random_user_usecase.dart';
import 'package:wemet/features/search/domain/usecase/search_user_use_case.dart';
import 'package:wemet/features/search/presentation/bloc/search_bloc.dart';
import 'package:wemet/features/upload/data/datasource/upload_post_datasource.dart';
import 'package:wemet/features/upload/data/repositories/upload_post_repository_implementation.dart';
import 'package:wemet/features/upload/domain/repositories/upload_post_repository.dart';
import 'package:wemet/features/upload/domain/usecase/uplaod_post_without_image_usecase.dart';
import 'package:wemet/features/upload/domain/usecase/upload_post_with_image_usecase.dart';
import 'package:wemet/features/upload/presentation/bloc/upload_post_bloc.dart';
import 'package:wemet/features/user_profile/data/datasource/user_profile_datasource.dart';
import 'package:wemet/features/user_profile/data/repositories/user_profile_repository_implementation.dart';
import 'package:wemet/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:wemet/features/user_profile/domain/usecase/user_profile_data_usecase.dart';
import 'package:wemet/features/user_profile/domain/usecase/user_profile_post_usecase.dart';
import 'package:wemet/features/user_profile/presentation/bloc/user_profile_bloc.dart';

part 'init_dependency_main.dart';