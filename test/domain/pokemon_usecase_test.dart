import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_app/data/models/stats_models.dart';
import 'package:poke_app/domain/entity/evolve_entity.dart';
import 'package:poke_app/domain/entity/pokemon_entity.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';
import 'package:poke_app/domain/repository/pokemon_repository.dart';
import 'package:poke_app/domain/usecase/pokemon_usecase.dart';

class MockPokemonRepository extends Mock implements PokemenRepository {}

void main() {
  late GetPokemonUseCase getPokemonUseCase;
  late GetStatsUseCase getStatsUseCase;
  late GetEvoUseCase getEvoUseCase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    getPokemonUseCase =
        GetPokemonUseCase(pokemenRepository: mockPokemonRepository);
    getStatsUseCase = GetStatsUseCase(pokemenRepository: mockPokemonRepository);
    getEvoUseCase = GetEvoUseCase(pokemenRepository: mockPokemonRepository);
  });

  final pokemon = [
    const PokemonEntity(name: "ghgj", url: "hjkhkhkj", ),
    const PokemonEntity(name: "", url: "", )
  ];

  final stats = 
    const StatsDetail(
        id: 1,
        stats: [StatElement(baseStat: 10, name: "B")],
        height: 90,
        weight: 100,
        types: [TypeModel(types: '')])
  ;
  // final evolve = EvolutionEntity(
  //     name: "", img: "", species: Species(namespesies: "", imgspesies: ""));

  final evolve = EvolutionEntity(
      name: "wartortle",
      url: "",
      species: [Species(namespesies: "", urlspecies: "blastoise")]);
  String url = 'https://pokeapi.co/api/v2/pokemon/1/';
  test("get pokemen data from repository", () async {
    when(() => mockPokemonRepository.getPokemon())
        .thenAnswer((_) async => Right(pokemon));
    final result = await getPokemonUseCase.call();
    expect(result, Right(pokemon));
    verify(
      () => mockPokemonRepository.getPokemon(),
    );
    verifyNoMoreInteractions(mockPokemonRepository);
  });

  test("get stats data from repository", () async {
    when(() => mockPokemonRepository.getStats(url))
        .thenAnswer((_) async => Right(stats));
    final result = await getStatsUseCase.call(url);
    expect(result, Right(stats));
    verify(
      () => mockPokemonRepository.getStats(url),
    );
    verifyNoMoreInteractions(mockPokemonRepository);
  });
  test("get evolve data from repository", () async {
    when(() => mockPokemonRepository.getEvolution("1"))
        .thenAnswer((_) async => Right(evolve));
    final result = await getEvoUseCase.call("1");
    expect(result, Right(evolve));
    verify(
      () => mockPokemonRepository.getEvolution("1"),
    );
    verifyNoMoreInteractions(mockPokemonRepository);
  });
}
