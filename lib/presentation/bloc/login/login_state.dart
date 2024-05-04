// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitialState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccesState extends LoginState {
  final User user;
  LoginSuccesState({
    required this.user,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
class LoginErorState extends LoginState {
  final String msg;
  LoginErorState({
    required this.msg,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}


