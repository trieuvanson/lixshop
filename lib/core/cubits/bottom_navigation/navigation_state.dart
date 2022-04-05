

import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int index;

  const NavigationState({required this.index});

  //copyWith
  NavigationState copyWith({int? index}) =>
      NavigationState(index: index ?? this.index);

  @override
  List<Object> get props => [index];

  @override
  String toString() => 'NavigationState { index: $index }';
}
