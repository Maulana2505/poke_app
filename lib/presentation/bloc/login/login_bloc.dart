import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/domain/usecase/pokemon_usecase.dart';
import 'package:poke_app/presentation/bloc/login/login_event.dart';
import 'package:poke_app/presentation/bloc/login/login_state.dart';

class LoginAuthBloc extends Bloc<LoginEvent, LoginState> {
  GoogleSignInUseCase googleSignInUseCase;
  LoginAuthBloc(this.googleSignInUseCase) : super(LoginInitialState()) {
    on<LoginClickEvent>(_onLoadData);
  }
  _onLoadData(LoginEvent event, Emitter<LoginState> emitter) async {
    emitter(LoginLoadingState());
    final loaddata = await googleSignInUseCase.call();
    loaddata.fold((fail) => emitter(LoginErorState(msg: fail.massage)),
        (r) => emitter(LoginSuccesState(user: r!)));
  }
}
