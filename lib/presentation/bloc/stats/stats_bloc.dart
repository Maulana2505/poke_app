

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/domain/usecase/pokemon_usecase.dart';
import 'package:poke_app/presentation/bloc/stats/stats_event.dart';
import 'package:poke_app/presentation/bloc/stats/stats_state.dart';

class StatsBloc extends Bloc<StatsEvent,StatsState> {
 final GetStatsUseCase getStatsUseCase;
  StatsBloc(this.getStatsUseCase):super(StatsInitialState()){
    on<StatsLoadEvent>(_onLoadData);
  }
   _onLoadData(StatsLoadEvent event,
      Emitter<StatsState> emitter) async {
    emitter(StatsLoadingState());
    final loaddata = await getStatsUseCase.call(event.url);
    loaddata.fold((fail) => emitter(StatsErorState(msg: fail.massage)),
        (r) => emitter(StatsLoadState(pokemon: r)));
  }
}