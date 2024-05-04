import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:poke_app/data/datasource/remoteDataSource/pokemon_datasource.dart';

import '../../fixture/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late PokemonDataSourceImpl pokemonDataSourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    pokemonDataSourceImpl = PokemonDataSourceImpl(client: mockHttpClient);
  });

  test("get url with json", () async {
    when(
      () => mockHttpClient.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon'),
      ),
    ).thenAnswer(
        (_) async => http.Response(fixture('pokemon.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }));
    await pokemonDataSourceImpl.getPokemon();

    verify(
      () => mockHttpClient.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon'),
      ),
    );
  });
}
