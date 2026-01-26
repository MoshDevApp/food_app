import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:food_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:food_app/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:food_app/screens/auth/views/sign_in_screen.dart';
import 'package:food_app/screens/auth/views/sign_up_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Warm orange gradient background matching the app icon
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Color(0xFFFFA726), // Lighter orange center
                  Color(0xFFFF8C00), // Deep orange
                  Color(0xFFE65100), // Darker orange edge
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Subtle texture overlay for depth
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                  Colors.black.withOpacity(0.1),
                ],
              ),
            ),
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(),
          ),
          // Main content
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                children: [
                  // App Icon at top-middle
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/9.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TabBar(
                      controller: tabController,
                      unselectedLabelColor: Colors.white70,
                      labelColor: Colors.white,
                      indicatorColor: Colors.white,
                      indicatorWeight: 3,
                      tabs: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                            context.read<AuthenticationBloc>().userRepository,
                          ),
                          child: const SignInScreen(),
                        ),
                        BlocProvider<SignUpBloc>(
                          create: (context) => SignUpBloc(
                            context.read<AuthenticationBloc>().userRepository,
                          ),
                          child: const SignUpScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



