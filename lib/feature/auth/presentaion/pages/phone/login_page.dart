import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notink/config/constants/constants.dart';
import 'package:notink/config/router/routers.dart';
import 'package:notink/core/common/custom_snackbar.dart';
import 'package:notink/core/common/formfiled.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_even.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_state.dart';

class LoginPagePhoneLayout extends StatefulWidget {
  const LoginPagePhoneLayout({super.key});

  @override
  State<LoginPagePhoneLayout> createState() => _LoginPagePhoneLayoutState();
}

class _LoginPagePhoneLayoutState extends State<LoginPagePhoneLayout> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "aayushpandey616@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "VerySecretPassword@100");

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
      appBar: AppBar(
        backgroundColor: isDark ? KColors.blackColor : KColors.whiteColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 100,
        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? KColors.whiteColor : KColors.blackColor,
          ),
        ),
        actions: [
          // Register Button
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.signupRoute,
                (route) => false,
              );
            },
            child: Text(
              'Register',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: constraints.maxHeight < MediaQuery.of(context).size.height
                ? null
                : const NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Login Texts
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 80,
                      maxWidth: mediaQuerySize.width,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Login Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Log In',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 40,
                                ),
                          ),
                        ),
                        // Welcome back Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Welcome back, we missed you',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Login Form
                  Container(
                    height: mediaQuerySize.height * 0.5,
                    width: mediaQuerySize.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isDark ? KColors.whiteColor : KColors.blackColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: BlocConsumer<RemoteAuthBloc, RemoteAuthState>(
                      listener: (context, state) {
                        if (state is RemoteAuthError) {
                          kShowSnackBar(
                            state.error!.message,
                            color: Colors.red,
                            context: context,
                          );
                        }
                        if (state is RemoteAuthLoggedIn) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.homeRoute,
                            (route) => false,
                            arguments: {
                              "selectedIndex": 0,
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        return Stack(
                          children: [
                            LoginForm(
                              formKey: formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  BlocProvider.of<RemoteAuthBloc>(context).add(
                                    RemoteAuthLoginEvent(
                                      userEntity: UserEntity.empty().copyWith(
                                        email: email,
                                        password: password,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            if (state is RemoteAuthLoading)
                              authLoading(mediaQuerySize, context),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Center authLoading(Size mediaQuerySize, BuildContext context) {
    return Center(
      child: Container(
        height: mediaQuerySize.height * 0.2,
        width: mediaQuerySize.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: KColors.whiteColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.onPressed,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super();

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Email Text Form Field
          CTextFormFiled(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            labelText: 'Email',
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(
                r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$',
              ).hasMatch(p0)) {
                return 'Email is invalid';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Password Text Form Field
          CPasswordFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hintText: 'Password',
            labelText: 'Password',
            obscureText: true,
            validator: (p0) {
              if (p0!.isEmpty) {
                return 'Password is required';
              } else if (p0.length < 8) {
                return 'Password must be at least 8 characters';
              } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(p0)) {
                return 'Password must contain at least one uppercase letter';
              } else if (!RegExp(r'^(?=.*?[a-z])').hasMatch(p0)) {
                return 'Password must contain at least one lowercase letter';
              } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(p0)) {
                return 'Password must contain at least one number';
              } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(p0)) {
                return 'Password must contain at least one special character';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Forgot Password Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 15,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? KColors.blackColor
                            : KColors.whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Login Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: KColors.accentColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: Size(
                MediaQuery.of(context).size.width,
                50,
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onPressed();
              }
            },
            child: Text(
              'LOGIN',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          // Terms and Conditions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "By continuing, you’re agreeing to Notink Privacy policy and Terms of use.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 15,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? KColors.blackColor
                        : KColors.whiteColor,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
