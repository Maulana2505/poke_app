import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/data/models/evolve_model.dart';
import 'package:poke_app/data/models/pokemon_models.dart';
import 'package:poke_app/data/models/stats_models.dart';
import 'package:poke_app/domain/entity/evolve_entity.dart';
import 'package:poke_app/domain/entity/pokemon_entity.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';

import '../../fixture/fixture.dart';

void main() {
  const pokemonModels = PokemonModel(name: "hjkhjkhk", url: "hkjhk", );
  
  // final evolve = EvolveModel(
  //     name: "wartortle", img: "", species: SpeciesModel(namespesies: "", imgspesies: "blastoise"));
   final evolve = EvolveModel(
      name: "wartortle", url: "",species: [SpeciesModel(namespesies: "blastoise", urlspecies: "")]);
  
  const stats = StatsModel(
      id: 1,
      stats: [StatElementModel(baseStat: 45, name: "")],
      height: 90,
      weight: 100,
      types: [TypeModel(types: "")]);

  test("should subclass of Pokemon entity", () async {
    expect(pokemonModels, isA<PokemonEntity>());
  });

  test("should subclass of Stats entity", () async {
    expect(stats, isA<StatsDetail>());
  });

   test("should subclass of Evolve entity", () async {
    expect(evolve, isA<EvolutionEntity>());
  });

  group("From json", () {
    test("Should return model json pokemon", () async {
      final Map<String, dynamic> jsonmap = jsonDecode(fixture('pokemon.json'));
      final result = PokemonModel.fromMap(jsonmap);
      expect(result, pokemonModels);
    });

    test("Should return model json stats", () async {
      var jsonmap = (jsonDecode(fixture('stats.json')));
      final result = StatsModel.fromMap(jsonmap);
      expect(result, stats);
    });
    test("Should return model json Evolve", () async {
      var jsonmap = (jsonDecode(fixture('evolve.json')));
      final result = EvolveModel.fromMap(jsonmap);
      print(result);
      expect(result, evolve);
    });
  });

  
}
