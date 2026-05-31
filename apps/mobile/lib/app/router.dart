import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('RideForge X Garage')),
        ),
      ),
      GoRoute(
        path: '/garage',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Motorcycle Garage')),
        ),
      ),
      GoRoute(
        path: '/touring',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Touring Planner')),
        ),
      ),
      GoRoute(
        path: '/diagnostics',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('AI Diagnostics')),
        ),
      ),
    ],
  );
});

