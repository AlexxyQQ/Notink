import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notink/core/common/loading_screen.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_even.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_state.dart';

class LoginTT extends StatefulWidget {
  const LoginTT({super.key});

  @override
  State<LoginTT> createState() => _LoginTTState();
}

class _LoginTTState extends State<LoginTT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RemoteAuthBloc, RemoteAuthState>(
        listener: (context, state) {
          if (state is RemoteAuthLoggedIn && state.loggedUser != null) {
            // Navigate to home screen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
                (route) => false,
              );
            });
          }
          if (state is RemoteAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!.message),
              ),
            );
          }
        },
        child: Column(
          children: [
            const Text('Login'),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<RemoteAuthBloc>(context).add(
                  RemoteAuthLoginEvent(
                    userEntity: UserEntity.empty().copyWith(
                      email: "aayushpandey61s6@gmail.com",
                      password: "VerySecretPassword@1010",
                    ),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemoteAuthBloc, RemoteAuthState>(
        builder: (context, state) {
          if (state is RemoteAuthLoggedOut) {
            // Navigate to login screen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginTT(),
                ),
                (route) => false,
              );
            });
          }
          if (state is RemoteAuthLoading) {
            return const LoadingScreen();
          }
          if (state is! RemoteAuthLoading && state.loggedUser != null) {
            return Column(
              children: [
                Text(
                  state.toString(),
                ),
                Text(
                  state.loggedUser!.email,
                ),
                const Text('Home'),
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<RemoteAuthBloc>(context).add(
                      const RemoteAuthLogoutEvent(),
                    );
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          }
          return const Text('Something went wrong');
        },
      ),
    );
  }
}
