import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_app/data/models/pokemon_models.dart';
import 'package:poke_app/data/models/stats_models.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';
import 'package:poke_app/domain/usecase/pokemon_usecase.dart';
import 'package:poke_app/presentation/bloc/stats/stats_bloc.dart';
import 'package:poke_app/presentation/bloc/stats/stats_event.dart';
import 'package:poke_app/presentation/bloc/stats/stats_state.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_event.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_state.dart';

class MockStatsUseCase extends Mock implements GetStatsUseCase {}

class MockPokemonsUseCase extends Mock implements GetPokemonUseCase {}

void main() {
  late MockStatsUseCase mockStatsUseCase;
  late MockPokemonsUseCase mockPokemonsUseCase;
  late StatsBloc statsBloc;
  late PokemonBloc pokemonBloc;

  setUp(() {
    mockStatsUseCase = MockStatsUseCase();
    mockPokemonsUseCase = MockPokemonsUseCase();
    statsBloc = StatsBloc(mockStatsUseCase);
    pokemonBloc = PokemonBloc(mockPokemonsUseCase);
  });

  const pokemonModels = [
    PokemonModel(
      name: "hjkhjkhk",
      url: "hkjhk",
    )
  ];

  const stats = 
    StatsDetail(
        id: 1,
        stats: [StatElement(baseStat: 10, name: "B")],
        height: 90,
        weight: 100,
        types: [TypeModel(types: '')])
  ;
  String url = 'https://pokeapi.co/api/v2/pokemon/1/';
  blocTest<StatsBloc, StatsState>(
    "Bloc Stats",
    build: () {
      when(
        () => mockStatsUseCase.call(url),
      ).thenAnswer((invocation) async => Right(stats));
      return statsBloc;
    },
    act: (bloc) => bloc.add(StatsLoadEvent(url: url)),
    expect: () => [StatsLoadingState(), StatsLoadState(pokemon: stats)],
  );

  blocTest<PokemonBloc, PokemonState>(
    "Bloc Pokemon",
    build: () {
      when(
        () => mockPokemonsUseCase.call(),
      ).thenAnswer((invocation) async => Right(pokemonModels));
      return pokemonBloc;
    },
    act: (bloc) => bloc.add(PokemonLoadEvent()),
    expect: () =>
        [PokemonLoadingState(), PokemonLoadState(pokemon: pokemonModels)],
  );
}
