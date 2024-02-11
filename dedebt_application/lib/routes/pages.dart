import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/HomeScreen.dart';
import 'package:dedebt_application/screens/layouts/adminLayout.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/screens/layouts/matcherLayout.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/screens/loginScreen.dart';
import 'package:dedebt_application/screens/registerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:go_router/go_router.dart';

class ROUTE {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.INITIAL,
    routes: <RouteBase>[
      GoRoute(
        name: 'Home',
        path: AppRoutes.INITIAL,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: 'main-regis',
        path: '/register/:email', // เพิ่ม ":email" ลงใน path
        builder: (context, state) {
          final email = state.pathParameters['email'] as String?;
          return RegisterScreen(email: email ?? '');
        },
      ),
      GoRoute(
        name: 'main-user',
        path: AppRoutes.MAIN_USER,
        builder: (context, state) => UserLayout(),
      ),
      GoRoute(
        name: 'main-advisor',
        path: AppRoutes.MAIN_ADVISOR,
        builder: (context, state) => AdvisorLayout(),
      ),
      GoRoute(
        name: 'main-admin',
        path: AppRoutes.MAIN_ADMIN,
        builder: (context, state) => AdminLayout(),
      ),
      GoRoute(
        name: 'main-matcher',
        path: AppRoutes.MAIN_MATCHER,
        builder: (context, state) => MatcherLayout(),
      ),
    ],
  );
}
