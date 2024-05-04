// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../domain/entity/pokemon_entity.dart';



abstract class PokemonState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadState extends PokemonState {
  final List<PokemonEntity> pokemon;

  PokemonLoadState({required this.pokemon});

  @override
  // TODO: implement props
  List<Object?> get props => [pokemon];
}

class PokemonErorState extends PokemonState {
  final String msg;
  PokemonErorState({
    required this.msg,
  });
  @override
  List<Object?> get props => [msg];
}