import 'package:flutter_eval/features/home/ui/pages/home_page.dart';
import 'package:flutter_eval/features/login/ui/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    )
  ],
);
