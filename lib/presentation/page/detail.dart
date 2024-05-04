import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_bloc.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_event.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_state.dart';
import 'package:poke_app/presentation/bloc/stats/stats_bloc.dart';
import 'package:poke_app/presentation/bloc/stats/stats_event.dart';
import 'package:poke_app/presentation/bloc/stats/stats_state.dart';
import 'package:poke_app/presentation/widget/evolve_widget.dart';
import 'package:poke_app/presentation/widget/stats_widget.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final String url;
  final String name;
  const DetailPage(
      {super.key, required this.url, required this.id, required this.name});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<StatsBloc>().add(StatsLoadEvent(url: widget.url));
    context.read<EvolveBloc>().add(EvolveLoadEvent(id: widget.id));
  }

  final List<Tab> _tabs = [
    const Tab(
      text: "Stats",
    ),
    const Tab(
      text: "Evolve",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _data(),
        ));
  }


  _data() {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StatsLoadState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF0E1F40)),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${state.pokemon.id}.png",
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Type : ",
                                      style: TextStyle(color: Colors.white)),
                                  for (var a in state.pokemon.types)
                                    Text(
                                      "${a.types} ",
                                      style: TextStyle(color: Colors.white),
                                    )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Height : ",
                                      style: TextStyle(color: Colors.white)),
                                  Text(
                                    state.pokemon.height.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Height : ",
                                      style: TextStyle(color: Colors.white)),
                                  Text(
                                    state.pokemon.weight.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TabBar(
                            controller: _tabController,
                            dividerColor: Colors.transparent,
                            tabs: _tabs),
                        Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                              StatsWiget(state: state),
                              EvolveWidget(id: widget.id)
                            ]))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        if (state is StatsErorState) {
          return Center(
            child: Text(state.msg),
          );
        }
        return Container();
      },
    );
  }
}
