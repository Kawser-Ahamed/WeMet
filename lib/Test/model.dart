class Model{
  final String name;

  Model({required this.name});

  factory Model.fromJson(Map<String,dynamic> json){
    return Model(
      name: json['name'],
    );
  }
}