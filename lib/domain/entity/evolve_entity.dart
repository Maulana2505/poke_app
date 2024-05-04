// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EvolutionEntity extends Equatable {
  final String name;
  final String url;
  List<Species> species;

  EvolutionEntity({
    required this.name,
     required this.url,
    required this.species,
  });

  @override
 
  List<Object?> get props => [name, species];
}

class Species extends Equatable {
  final String namespesies;
  final String urlspecies;

  const Species({
    required this.namespesies,
    required this.urlspecies,
    
  });

  @override
  
  List<Object?> get props => [namespesies];
}
