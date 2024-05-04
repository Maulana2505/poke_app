import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/presentation/bloc/auth/auth_event.dart';
import 'package:poke_app/presentation/bloc/auth/auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    on<AppStarted>(_appStarted);
    on<LoggedOut>(_loggedOut);
  }
  _appStarted(
      AuthenticationEvent event, Emitter<AuthenticationState> emitter) async {
    FirebaseAuth fa = FirebaseAuth.instance;
    emitter(AuthenticationLoading());
    final isSigned = fa.currentUser;
    if (isSigned != null) {
      emitter(AuthenticationAuthenticated());
    } else {
      emitter(AuthenticationUnauthenticated());
    }
  }

  _loggedOut(
      AuthenticationEvent event, Emitter<AuthenticationState> emitter) async {
    FirebaseAuth fa = FirebaseAuth.instance;
    fa.signOut();
  }
}
