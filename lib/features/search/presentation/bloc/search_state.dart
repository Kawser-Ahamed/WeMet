import 'package:equatable/equatable.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/features/search/domain/entities/search_user_entities.dart';

class SearchState extends Equatable {

  final List<SearchUserEntities> randomUser;
  final List<SearchUserEntities> searchUser;
  final UiStatus uiStatus;
  final UiStatus searchUistatus;
  final String message;
  
  const SearchState({
    this.randomUser = const [],
    this.searchUser = const [],
    this.message = '',
    this.searchUistatus = UiStatus.loading,
    this.uiStatus = UiStatus.loading,
  });

  SearchState copyWith({
    List<SearchUserEntities> ? randomUser,
    List<SearchUserEntities> ? searchUser,
    UiStatus ? uiStatus,
    UiStatus ? searchUistatus,
    String ? message,
  }){
    return SearchState(
      randomUser: randomUser ?? this.randomUser,
      searchUser: searchUser ?? this.searchUser,
      message: message ?? this.message,
      searchUistatus: searchUistatus ?? this.searchUistatus,
      uiStatus: uiStatus ?? this.uiStatus,
    );
  }

  @override
  List<Object> get props => [randomUser,searchUser,uiStatus,searchUistatus,message];
}
