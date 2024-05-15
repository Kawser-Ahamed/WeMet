import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';

class UploadPostState extends Equatable {
  
  final String message;
  final UiStatus uiStatus;

  const UploadPostState({
    this.message = '',
    this.uiStatus = UiStatus.loading,
  });

  UploadPostState copyWith({String ? message, UiStatus ? uiStatus}){
    return UploadPostState(
      message: message ?? this.message,
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }
  
  @override
  List<Object> get props => [message,uiStatus];
}

