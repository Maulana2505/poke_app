// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:poke_app/domain/entity/stats_entity.dart';

abstract class StatsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StatsInitialState extends StatsState {}

class StatsLoadingState extends StatsState {}

class StatsLoadState extends StatsState {
  final StatsDetail pokemon;
  StatsLoadState({
    required this.pokemon,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [pokemon];
}

class StatsErorState extends StatsState {
  final String msg;
  StatsErorState({
    required this.msg,
  });
  @override
  List<Object?> get props => [msg];
}