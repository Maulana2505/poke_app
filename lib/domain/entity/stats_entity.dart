import 'package:equatable/equatable.dart';

class StatsDetail extends Equatable {
  final int id;
  final int height;
  final int weight;
  final List<StatElement> stats;
  final List<Types> types;
  const StatsDetail(
      {required this.id,
      required this.stats,
      required this.height,
      required this.weight,
      required this.types});

  @override
  // TODO: implement props
  List<Object?> get props => [id, height, weight, stats,types];
}

class StatElement extends Equatable {
  final int baseStat;

  final String name;

  const StatElement({
    required this.baseStat,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [baseStat, name];
}

class Types extends Equatable {
  final String types;
  const Types({
    required this.types,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [types];
}
