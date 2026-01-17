// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:user_repository/user_repository.dart';
// import 'app_view.dart';
// import 'blocs/authentication_bloc/authentication_bloc.dart';

// class MyApp extends StatelessWidget {
//   final UserRepository userRepository;
//   const MyApp(this.userRepository, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider<AuthenticationBloc>(
//       create: (context) => AuthenticationBloc(
//         userRepository: userRepository
//       ),
//       child: const MyAppView(),
//     );
//   }
// }

//=======================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'app_view.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
