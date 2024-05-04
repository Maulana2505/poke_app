// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:poke_app/core/failure.dart';
import 'package:poke_app/domain/entity/evolve_entity.dart';
import 'package:poke_app/domain/entity/pokemon_entity.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';
import 'package:poke_app/domain/repository/pokemon_repository.dart';

class GetPokemonUseCase {
  final PokemenRepository pokemenRepository;

  GetPokemonUseCase({required this.pokemenRepository});

  Future<Either<Failure, List<PokemonEntity>>> call() async {
    return await pokemenRepository.getPokemon();
  }
}

class GetStatsUseCase {
  final PokemenRepository pokemenRepository;

  GetStatsUseCase({required this.pokemenRepository});

  Future<Either<Failure, StatsDetail>> call(String url) async {
    return await pokemenRepository.getStats(url);
  }
}

class GetEvoUseCase {
  final PokemenRepository pokemenRepository;

  GetEvoUseCase({required this.pokemenRepository});

  Future<Either<Failure, EvolutionEntity>> call(String id) async {
    return await pokemenRepository.getEvolution(id);
  }
}

class GoogleSignInUseCase {
  final PokemenRepository pokemenRepository;
  GoogleSignInUseCase({
    required this.pokemenRepository,
  });
  Future<Either<Failure, User?>> call() async {
    return await pokemenRepository.goggleSignIn();
  }
}
