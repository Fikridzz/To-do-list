import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/data/to_do_data.dart';
import 'package:todo_list/view/detail_screen.dart';
import 'package:todo_list/view/home_screen.dart';
import 'package:todo_list/view/login_screen.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        // GoRoute(
        //   path: 'detail',
        //   builder: (BuildContext context, GoRouterState state) {
        //     final Map<String, dynamic> param =
        //         state.extra as Map<String, dynamic>;
        //     final String? id = param['id'] as String?;
        //     return DetailScreen(int.parse(id ?? ''));
        //   },
        // ),
      ],
    ),
  ],
);
