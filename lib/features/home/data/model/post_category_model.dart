import 'package:wemet/features/home/domain/entities/post_category_entities.dart';

class PostCategoryModel extends PostCategoryEntities{
  PostCategoryModel({
    required super.id, 
    required super.name
  });

  factory PostCategoryModel.fromJson(Map<String,dynamic> json){
    return PostCategoryModel(
      id: json['_id'], 
      name: json['name'],
    );
  }
}