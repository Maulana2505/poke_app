// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:poke_app/core/failure.dart';
import 'package:poke_app/data/datasource/localDataSource/pokemon_localdatasource.dart';
import 'package:poke_app/data/datasource/remoteDataSource/pokemon_datasource.dart';
import 'package:poke_app/data/models/pokemon_models.dart';
import 'package:poke_app/domain/entity/evolve_entity.dart';

import 'package:poke_app/domain/entity/pokemon_entity.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';
import 'package:poke_app/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemenRepository {
  final PokemonDataSource pokemonDataSource;
  final PokemonLocalDataSource pokemonLocalDataSource;

  PokemonRepositoryImpl(this.pokemonDataSource, this.pokemonLocalDataSource);
  @override
  Future<Either<Failure, List<PokemonEntity>>> getPokemon() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      try {
        List<PokemonModel> data = await pokemonLocalDataSource.getAllPokemon();
        print(data);
        return Right(data);
      } catch (e) {
        print(e.toString());
        return Left(DatabaseFailure(e.toString()));
      }
    } else {
      try {
        
        List<PokemonModel> data = await pokemonDataSource.getPokemon();
        
        
        return Right(data);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, StatsDetail>> getStats(String url) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      try {
        var data = await pokemonLocalDataSource.getstatsPokemon();
        return Right(data);
      } catch (e) {
        return Left(DatabaseFailure(e.toString()));
      }
    } else {
      try {
        var pokemon = await pokemonDataSource.getStats(url);
        return Right(pokemon);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, EvolutionEntity>> getEvolution(String id) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      try {
        var data = await pokemonLocalDataSource.getEvolvePokemon();
        return Right(data);
      } catch (e) {
        return Left(DatabaseFailure(e.toString()));
      }
    } else {
      try {
        var pokemon = await pokemonDataSource.getEvolve(id);
        return Right(pokemon);
      } catch (e) {
        print(e.toString());
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, User?>> goggleSignIn() async {
    try {
      final login = await pokemonDataSource.googleSignIn();
      return Right(login);
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }
}
