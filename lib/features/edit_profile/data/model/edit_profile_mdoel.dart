import 'package:wemet/features/edit_profile/domain/entities/edit_profile_entities.dart';

class EditprofileModel extends EditProfileEntities{
  
  EditprofileModel({
    required super.fullName, 
    required super.bio, 
    required super.email,
  });

  Map<String,dynamic> toJson(){
    return <String,dynamic>{
      'fullName' : fullName,
      'bio' : bio,
    };
  }

}