// ignore_for_file: public_member_api_docs, sort_constructors_first, annotate_overrides, overridden_fields
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:poke_app/domain/entity/pokemon_entity.dart';
part 'pokemon_models.g.dart';

@HiveType(typeId: 0, adapterName: "PokemonAdapter")
class PokemonModel extends PokemonEntity {
  @HiveField(0,defaultValue: true)
  final String name;
  @HiveField(1,defaultValue: true) 
  final String url;
  const PokemonModel({required this.name, required this.url})
      : super(name: name, url: url);

      
  factory PokemonModel.fromJson(String str) =>
      PokemonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromMap(Map<String, dynamic> json) => PokemonModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };

  PokemonModel copyWith({
    String? name,
    String? url,
  }) {
    return PokemonModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
