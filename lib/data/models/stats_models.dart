// ignore_for_file: use_super_parameters

import 'dart:convert';

import 'package:poke_app/domain/entity/stats_entity.dart';

class StatsModel extends StatsDetail {
  const StatsModel(
      {required int id,
      required List<StatElementModel> stats,
      required int height,
      required int weight,
      required List<TypeModel> types})
      : super(
            id: id, stats: stats, height: height, weight: weight, types: types);

  factory StatsModel.fromJson(String str) =>
      StatsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatsModel.fromMap(Map<String, dynamic> json) => StatsModel(
        id: json["id"],
        height: json["height"],
        weight: json["weight"],
        stats: List<StatElementModel>.from(
            json["stats"].map((x) => StatElementModel.fromMap(x))),
        types: List<TypeModel>.from(json['types'].map((x) => TypeModel.fromMap(x))),    
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "height": height,
        "weight": weight,
        "stats": List<dynamic>.from(stats.map((x) => x)),
         
      };
}

class StatElementModel extends StatElement {
  const StatElementModel({required int baseStat, required String name})
      : super(baseStat: baseStat, name: name);
  factory StatElementModel.fromJson(String str) =>
      StatElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatElementModel.fromMap(Map<String, dynamic> json) =>
    StatElementModel(
        baseStat: json["base_stat"],
        name: json['stat']['name'],
    );
  

  Map<String, dynamic> toMap() => {"base_stat": baseStat, "name": name};
}

class TypeModel extends Types {
  const TypeModel({required super.types});

  factory TypeModel.fromMap(Map<String, dynamic> map) {
    return TypeModel(
      types: map['type']['name'],
    );
  }
}
