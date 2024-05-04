// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:poke_app/domain/entity/evolve_entity.dart';

abstract class EvolveState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EvolveInitialState extends EvolveState {}
class EvolveLoadingState extends EvolveState {}
class EvolveLoadState extends EvolveState {
  final EvolutionEntity evolve;
  EvolveLoadState({
    required this.evolve,
  });
  @override
  
  List<Object?> get props => [evolve];
}
class EvolveErrorState extends EvolveState {
  final String msg;
  EvolveErrorState({
    required this.msg,
  });
  @override
  
  List<Object?> get props => [msg];
}

