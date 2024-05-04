import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/presentation/bloc/login/login_bloc.dart';
import 'package:poke_app/presentation/bloc/login/login_event.dart';
import 'package:poke_app/presentation/bloc/login/login_state.dart';
import 'package:poke_app/presentation/page/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginAuthBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoginSuccesState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);
        }
        if (state is LoginErorState) {
          print(state.msg);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0E1F40),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/pokemon_logo.png"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginAuthBloc>(context).add(LoginClickEvent());
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "images/google.png",
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        const Text(
                          "Sign in with Google",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
