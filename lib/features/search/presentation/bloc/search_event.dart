import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class RandomUserEvent extends SearchEvent{}

class SearchUserEvent extends SearchEvent{

  final String searchValue;
  final BuildContext context;

  const SearchUserEvent({
    required this.searchValue,
    required this.context,
  });
}
