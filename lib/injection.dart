import 'package:get_it/get_it.dart';
// import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poke_app/data/datasource/localDataSource/pokemon_localdatasource.dart';
import 'package:poke_app/data/datasource/remoteDataSource/pokemon_datasource.dart';
import 'package:poke_app/data/repository/pokemon_repository_impl.dart';
import 'package:poke_app/domain/repository/pokemon_repository.dart';
import 'package:poke_app/domain/usecase/pokemon_usecase.dart';
import 'package:poke_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_bloc.dart';
import 'package:poke_app/presentation/bloc/login/login_bloc.dart';
import 'package:poke_app/presentation/bloc/stats/stats_bloc.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(
    () => HiveInterface,
  );
  sl.registerLazySingleton(
    () => Hive,
  );

  //bloc
  sl.registerFactory(() => PokemonBloc(sl()));
  sl.registerFactory(() => StatsBloc(sl()));
  sl.registerFactory(() => LoginAuthBloc(sl()));
  sl.registerFactory(() => EvolveBloc(sl()));
  sl.registerFactory(() => AuthenticationBloc());

  // usecase
  sl.registerLazySingleton(() => GetPokemonUseCase(pokemenRepository: sl()));
  sl.registerLazySingleton(() => GetStatsUseCase(pokemenRepository: sl()));
  sl.registerLazySingleton(() => GoogleSignInUseCase(pokemenRepository: sl()));
  sl.registerLazySingleton(() => GetEvoUseCase(pokemenRepository: sl()));


  // repository
  sl.registerLazySingleton<PokemenRepository>(
      () => PokemonRepositoryImpl(sl(), sl()));

  //datasouce
  sl.registerLazySingleton<PokemonDataSource>(
      () => PokemonDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PokemonLocalDataSource>(
      () => PokemonLocalDataSourceImpl(sl()));
}
