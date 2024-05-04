import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poke_app/data/models/evolve_model.dart';
import 'package:poke_app/data/models/pokemon_models.dart';
import 'package:poke_app/data/models/stats_models.dart';
import 'package:http/http.dart' as http;

abstract class PokemonDataSource {
  Future<List<PokemonModel>> getPokemon();
  Future<StatsModel> getStats(String url);
  Future<EvolveModel> getEvolve(String id);
  Future<User?> googleSignIn();
}

class PokemonDataSourceImpl implements PokemonDataSource {
  final http.Client client;

  PokemonDataSourceImpl({required this.client});
  @override
  Future<List<PokemonModel>> getPokemon() async {
    var response = await client
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon/"), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    var data = (json.decode(response.body)["results"] as List)
        .map((e) => PokemonModel.fromMap(e))
        .toList();
    if (response.statusCode == 200) {
      return data;
    } else {
      print(jsonDecode(response.body));
      throw Exception(response.body);
    }
  }

  @override
  Future<StatsModel> getStats(String url) async {
    var response = await client.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    var data = (json.decode(response.body));
    var s = StatsModel.fromMap(data);
    if (response.statusCode == 200) {
      return s;
    }
    return s;
  }

  @override
  Future<EvolveModel> getEvolve(String id) async {
    var response = await client.get(
      Uri.parse("https://pokeapi.co/api/v2/evolution-chain/$id"),headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    }
    );
    if (response.statusCode == 200) {
      final evolveList = (json.decode(response.body)['chain']);
      final toList = EvolveModel.fromMap(evolveList);
      return toList;
    } else {
      print(jsonDecode(response.body));
      throw Exception(response.body);
    }
  }

  @override
  Future<User?> googleSignIn() async {
    final googleaccount = await GoogleSignIn().signIn();
    final googleauth = await googleaccount!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken, idToken: googleauth.idToken);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  }
}
