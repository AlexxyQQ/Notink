import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notink/config/constants/constants.dart';
import 'package:notink/config/router/routers.dart';
import 'package:notink/core/common/custom_snackbar.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_even.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_state.dart';

class LoginSignupButtonPhoneLayout extends StatelessWidget {
  const LoginSignupButtonPhoneLayout({
    super.key,
    required this.isDark,
    required this.mediaQuerySize,
  });

  final bool isDark;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: isDark ? KColors.whiteColor : KColors.blackColor,
      ),
      height: mediaQuerySize.height / 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Text
            Text(
              'Welcome to Notink',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 26,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
            // Description Text
            const SizedBox(height: 6),
            Text(
              'Notink is a powerful note taking app for everyone.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
            const SizedBox(height: 18),
            // Continue with Google Text
            Center(
              child: BlocListener<RemoteAuthBloc, RemoteAuthState>(
                listener: (context, state) {
                  if (state is RemoteAuthLoggedIn) {
                    kShowSnackBar(
                      "Logged in successfully!",
                      context: context,
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.homeRoute,
                      (route) => false,
                      arguments: {
                        "selectedIndex": 0,
                      },
                    );
                  }
                  if (state is RemoteAuthError) {
                    kShowSnackBar(state.error!.message, context: context);
                  }
                },
                child: ElevatedButton.icon(
                  onPressed: () {
                    BlocProvider.of<RemoteAuthBloc>(context).add(
                      const RemoteAuthGoogleEvent(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(
                    FontAwesomeIcons.google,
                    color: KColors.accentColor,
                  ),
                  label: const Text("Continue with Google"),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Divider(),
            const SizedBox(height: 8),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'You can also ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? KColors.blackColor
                            : KColors.offWhiteColor,
                      ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? KColors.blackColor
                                    : KColors.whiteColor,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.loginRoute);
                        },
                    ),
                    TextSpan(
                      text: ' or ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? KColors.blackColor
                                    : KColors.whiteColor,
                          ),
                    ),
                    TextSpan(
                      text: 'Signup',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? KColors.blackColor
                                    : KColors.whiteColor,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          log("Login or Signup tapped");
                        },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'By Continue, you’re agree to Notink Privacy policy and Terms of use.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? KColors.greyColor
                            : KColors.whiteColor,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoAndAppNamePhoneLayout extends StatelessWidget {
  const LogoAndAppNamePhoneLayout({
    super.key,
    required this.mediaQuerySize,
    required this.isDark,
  });

  final Size mediaQuerySize;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //! Logo
            // Image.asset(
            //   'assets/splash_screen/Logo.png',
            //   height: 80,
            // ),
            // App Name
            Text(
              'Notink',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 40,
                  ),
            ),
            const SizedBox(height: 10),
            // App Description
            Text(
              'A powerful note taking app for everyone.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
