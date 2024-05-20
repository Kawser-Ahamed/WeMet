import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {

  final String message;
  const EditProfileState({
    this.message = '',
  });

  EditProfileState copyWith({String ? message}){
    return EditProfileState(
      message: message ?? this.message,
    );
  }
  @override
  List<Object> get props => [message];
}

