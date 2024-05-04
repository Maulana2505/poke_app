import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poke_app/data/models/evolve_model.dart';
import 'package:poke_app/data/models/stats_models.dart';

import '../../models/pokemon_models.dart';

abstract class PokemonLocalDataSource {
  Future<List<PokemonModel>> getAllPokemon();
  Future<StatsModel> getstatsPokemon();
  Future<EvolveModel> getEvolvePokemon();
}

class PokemonLocalDataSourceImpl implements PokemonLocalDataSource {
  final HiveInterface hive;

  PokemonLocalDataSourceImpl(this.hive);
  @override
  Future<List<PokemonModel>> getAllPokemon() async {
    var box = Hive.box<PokemonModel>('pokemonn');
    var data = box.values.toList();

    return data;
    // await Hive.openBox<PokemonModel>('pokemon')
  }

  @override
  Future<StatsModel> getstatsPokemon() {
    var box = hive.box('pokemon');
    return box.get("allstats");
  }

  @override
  Future<EvolveModel> getEvolvePokemon() {
    var box = hive.box('pokemon');
    return box.get("evolve");
  }
}
