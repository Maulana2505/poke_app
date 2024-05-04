import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:poke_app/domain/entity/evolve_entity.dart';
class EvolveModel extends EvolutionEntity {
  EvolveModel({required super.name,required super.url, required List<SpeciesModel> super.species});

  factory EvolveModel.fromJson(String str) =>
      EvolveModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EvolveModel.fromMap(Map<String, dynamic> json) => EvolveModel(
      name: json["species"]["name"],
      url: json["species"]["url"],
      species: List<SpeciesModel>.from(
            json["evolves_to"].map((x) => SpeciesModel.fromMap(x))),);

  Map<String, dynamic> toMap() => {
        "name": name,
        "species": species,
      };
}

class SpeciesModel extends Species {
  const SpeciesModel({required super.namespesies, required super.urlspecies});
  factory SpeciesModel.fromJson(String str) =>
      SpeciesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpeciesModel.fromMap(Map<String, dynamic> json) => SpeciesModel(
        namespesies: json["species"]["name"],
        urlspecies: json["species"]["url"]
      );

  Map<String, dynamic> toMap() => {
        "name": namespesies,
      };
}
