import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/domain/usecase/pokemon_usecase.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_event.dart';
import 'package:poke_app/presentation/bloc/evolve/evolve_state.dart';

class EvolveBloc extends Bloc<EvolveEvent, EvolveState> {
  final GetEvoUseCase getEvoUseCase;
  EvolveBloc(this.getEvoUseCase) : super(EvolveInitialState()) {
    on<EvolveLoadEvent>(_onLoad);
  }

  _onLoad(EvolveLoadEvent event, Emitter<EvolveState> emitter) async {
    emitter(EvolveLoadingState());
    final data = await getEvoUseCase.call(event.id);
    data.fold((l) => emitter(EvolveErrorState(msg: l.massage)),
        (r) => emitter(EvolveLoadState(evolve: r)));
  }
}
