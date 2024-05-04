import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poke_app/domain/usecase/pokemon_usecase.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_event.dart';
import 'package:poke_app/presentation/bloc/pokemon/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetPokemonUseCase getPokemonUseCase;
  PokemonBloc(this.getPokemonUseCase) : super(PokemonInitialState()) {
    on<PokemonLoadEvent>(_onLoadData);
  }
  _onLoadData(PokemonLoadEvent event, Emitter<PokemonState> emitter) async {
    emitter(PokemonLoadingState());
    final loaddata = await getPokemonUseCase.call();
    loaddata.fold((l) => emitter(PokemonErorState(msg: l.massage)),
        (r) => emitter(PokemonLoadState(pokemon: r)));
  }
}
