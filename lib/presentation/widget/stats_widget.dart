import 'package:flutter/material.dart';
import 'package:poke_app/domain/entity/stats_entity.dart';
import 'package:poke_app/presentation/bloc/stats/stats_state.dart';

class StatsWiget extends StatefulWidget {
  final StatsLoadState state;
  const StatsWiget({super.key, required this.state});

  @override
  State<StatsWiget> createState() => _StatsWigetState();
}

class _StatsWigetState extends State<StatsWiget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var e in widget.state.pokemon.stats)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(e.name), Text(e.baseStat.toString())],
            ),
          )
      ],
    );
  }
}
