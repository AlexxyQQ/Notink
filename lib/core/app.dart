import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_bloc.dart';
// import 'package:notink/feature/home/presentaion/bloc/notes/local/local_note_bloc.dart';
import 'package:notink/injection/app_injection_container.dart';

import '../config/router/routers.dart';
import '../config/themes/app_theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteAuthBloc>(
          create: (context) => RemoteAuthBloc(
            loginUseCase: get(),
            logoutUseCase: get(),
            uploadProfilePicUseCase: get(),
            googleLoginUseCase: get(),
            signupUseCase: get(),
            deleteUserUseCase: get(),
          ),
        ),
        // BlocProvider<LocalNoteBloc>(
        //   create: (context) => LocalNoteBloc(
        //     addNoteUseCase: get(),
        //     updateNotesUseCase: get(),
        //     deleteNoteUseCase: get(),
        //     getUsersNotesUseCase: get(),
        //     getAllNoteByIDUseCase: get(),
        //   ),
        // ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          AppFlowyEditorLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
        title: "notink", // App name
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appLightTheme(),
        darkTheme: AppTheme.appDarkTheme(),
        themeMode: ThemeMode.system,
        routes: AppRoutes.routes, // Routes
      ),
    );
  }
}
