import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poke_app/core/failure.dart';
import 'package:poke_app/domain/entity/evolve_entity.dart';
import 'package:poke_app/domain/entity/pokemon_entity.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';

abstract class PokemenRepository {
  Future<Either<Failure, List<PokemonEntity>>> getPokemon();
  Future<Either<Failure, StatsDetail>> getStats(String url);
  Future<Either<Failure, EvolutionEntity>> getEvolution(String id);
  Future<Either<Failure,User?>> goggleSignIn();
}
