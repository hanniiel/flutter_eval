import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eval/bloc_widget.dart';
import 'package:flutter_eval/features/auth/ui/bloc/bloc_auth.dart';
import 'package:flutter_eval/firebase_options.dart';
import 'package:flutter_eval/routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocWidget(
      child: MaterialApp.router(
        title: 'Ancient',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (cotext, child) {
          //listener to redirect according to auth state by using go_router
          return BlocListener<BlocAuth, AuthState>(
            listener: (_, state) {
              if (state is Authenticated) {
                router.go('/home');
              } else {
                router.go('/');
              }
            },
            child: child,
          );
        },
        //usign go_router 4 navigation, the best for it from my pov.
        routerConfig: router,
      ),
    );
  }
}
