// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wemet/core/status/ui_status.dart';
import 'package:wemet/core/usecase/usecase.dart';
import 'package:wemet/features/search/domain/usecase/random_user_usecase.dart';
import 'package:wemet/features/search/domain/usecase/search_user_use_case.dart';
import 'package:wemet/features/search/presentation/bloc/search_event.dart';
import 'package:wemet/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final RandomUserUsecase _randomUserUsecase;
  final SearchUserUsecase _searchUserUsecase;
  SearchBloc({
    required RandomUserUsecase randomUserUsecase,
    required SearchUserUsecase searchUserUsecase,
  }) : _randomUserUsecase = randomUserUsecase,
    _searchUserUsecase = searchUserUsecase,
    super(const SearchState()) {
    on<RandomUserEvent>(_getRandomUser);
    on<SearchUserEvent>(_getSearchUser);
  }

  Future<void> _getRandomUser(RandomUserEvent event, Emitter<SearchState> emit) async{
    final response = await _randomUserUsecase(NoParams());
    response.fold(
      (l) => emit(state.copyWith(message: l.message,uiStatus: UiStatus.error)), 
      (r) => emit(state.copyWith(randomUser: r,uiStatus: UiStatus.success)),
    );
  }

  Future<void> _getSearchUser(SearchUserEvent event, Emitter<SearchState> emit) async{
    final response = await _searchUserUsecase(SeacrhParams(searchValue: event.searchValue));
    response.fold(
      (l) => emit(state.copyWith(message: l.message,uiStatus: UiStatus.error)), 
      (r)=>emit(state.copyWith(searchUser: r,searchUistatus: UiStatus.success)),
    );
    Navigator.pop(event.context);
  }
}
