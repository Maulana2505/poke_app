import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'package:poke_app/data/models/pokemon_models.dart';
import 'package:poke_app/firebase_options.dart';
import 'package:poke_app/injection.dart';
import 'package:poke_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:poke_app/presentation/bloc/auth/auth_event.dart';
import 'package:poke_app/presentation/bloc/auth/auth_state.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_bloc.dart';
import 'package:poke_app/presentation/bloc/login/login_bloc.dart';

import 'package:poke_app/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_event.dart';
import 'package:poke_app/presentation/bloc/stats/stats_bloc.dart';
import 'package:poke_app/presentation/page/home.dart';
import 'package:poke_app/presentation/page/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final appDocumentDirectory = await getApplicationCacheDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonAdapter());
  await Hive.openBox<PokemonModel>('pokemonn');
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl.get<PokemonBloc>()..add(PokemonLoadEvent()),
          ),
          BlocProvider(
            create: (context) => sl.get<StatsBloc>(),
          ),
          BlocProvider(
            create: (context) => sl.get<LoginAuthBloc>(),
          ),
          BlocProvider(
            create: (context) =>
                sl.get<AuthenticationBloc>()..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => sl.get<EvolveBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colo),
            useMaterial3: true,
          ),
          home:
          //  const HomePage()
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return const HomePage();
              }
              if (state is AuthenticationUnauthenticated) {
                return const LoginPage();
              }
              if (state is AuthenticationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        )
        );
  }
}
