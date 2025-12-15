import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/screens/auth/views/welcome_screen.dart';

import 'screens/home/views/home_screen.dart';

class myAppView extends StatelessWidget {
  const myAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Point',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                    context.read < AuthenticationBloc().userRepository,
                  ),
                ),
                BlocProvider(
                  create: (context) => GetFoodBloc(
                  firebaseFoodRepo()
                )..add(GetFood()),
                ),
              ],
              child: const HomeScreen(),
            );
          } else {
            return WelcomeScreen();
          }
        }),
      ),
    );
  }
}
