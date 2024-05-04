import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  final String name;
  final String url;
  
  const PokemonEntity(
      {required this.name, required this.url, });

  @override
  // TODO: implement props
  List<Object?> get props => [name, url, ];
}
