import 'package:fpdart/fpdart.dart';
import 'package:wemet/core/error/failure.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/upload/domain/repositories/upload_post_repository.dart';

class UploadPostWithoutImageUsecase implements UseCase<String,UploadPostWithoutImageParams>{
  
  UploadPostRepository uploadPostRepository;
  UploadPostWithoutImageUsecase(this.uploadPostRepository);

  @override
  Future<Either<Failure, String>> call(UploadPostWithoutImageParams params) async{
    return await uploadPostRepository.uploadPostWithoutImage(
      id: params.id,
      caption: params.caption,
      dateTime: params.dateTime,
      uploaderName: params.uploaderName,
      email: params.emai,
      uploaderProfilePictureImageUrl: params.uploaderProfilePictureImageUrl,
    );
  }
}

class UploadPostWithoutImageParams{

  final int id;
  final String caption;
  final String dateTime;
  final String uploaderName;
  final String emai;
  final String uploaderProfilePictureImageUrl;
  
  UploadPostWithoutImageParams({
    required this.id,
    required this.caption,
    required this.dateTime,
    required this.uploaderName,
    required this.emai,
    required this.uploaderProfilePictureImageUrl,
  });
}