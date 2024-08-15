import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superstore/pages/auth/auth.dart';
import 'package:superstore/pages/auth/bloc/auth_bloc.dart';
import 'package:superstore/pages/stock_map/stock_map.dart';

class AuthGate extends StatelessWidget {
  static String routhPath() => "/";
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case AuthFailureState():
            return const LoginPage();
          case AuthSuccessState():
            return const StockMapPage();
        }
      },
    );
  }
}
