import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:poke_app/data/datasource/localDataSource/pokemon_localdatasource.dart';
import 'package:poke_app/injection.dart';

import 'package:poke_app/presentation/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_state.dart';
import 'package:poke_app/presentation/page/detail.dart';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // await Hive.openBox<PokemonModel>('pokemon');
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PokemonLoadState) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              // padding: EdgeInsets.all(10),
              itemCount: state.pokemon.length,
              itemBuilder: (context, index) {
                var item = state.pokemon[index];
                sl.get<PokemonLocalDataSourceImpl>().getAllPokemon();
                String itemurl = item.url;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(url:itemurl,id:itemurl.split("/")[6],name : item.name)),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFF0E1F40)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${itemurl.split("/")[6]}.png",
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Text(
                              item.name,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is PokemonErorState) {
            return Center(
              child: Text(state.msg),
            );
          }
          return Container();
        },
      ),
    );
  }
}
