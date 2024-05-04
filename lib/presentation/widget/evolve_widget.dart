import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_bloc.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_event.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_state.dart';

class EvolveWidget extends StatefulWidget {
  final String id;
  const EvolveWidget({super.key, required this.id});

  @override
  State<EvolveWidget> createState() => _EvolveWidgetState();
}

class _EvolveWidgetState extends State<EvolveWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EvolveBloc>().add(EvolveLoadEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvolveBloc, EvolveState>(
      builder: (context, state) {
        if (state is EvolveLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is EvolveLoadState) {
          var id = state.evolve.url;
          return Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF0E1F40)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${id.split("/")[6]}.png",
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text(
                          state.evolve.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                for (var i in state.evolve.species)
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF0E1F40)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${i.urlspecies.split("/")[6]}.png",
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Text(
                            i.namespesies,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
        if (state is EvolveErrorState) {
          return Center(
            child: Text(state.msg),
          );
        }
        return Container();
      },
    );
  }
}
