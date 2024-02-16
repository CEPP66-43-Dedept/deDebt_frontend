import 'package:dedebt_application/routes/transitionRoute.dart';

import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/HomeScreen.dart';
import 'package:dedebt_application/screens/User/historyUserScreen.dart';
import 'package:dedebt_application/screens/User/homeUserScreen.dart';
import 'package:dedebt_application/screens/User/profileUserScreen.dart';
import 'package:dedebt_application/screens/User/requestUserScreen.dart';
import 'package:dedebt_application/screens/layouts/adminLayout.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/screens/layouts/matcherLayout.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/screens/loginScreen.dart';
import 'package:dedebt_application/screens/registerScreen.dart';
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
        path: AppRoutes.Register,
        builder: (context, state) {
          final email = state.pathParameters['email'] as String?;
          return RegisterScreen(email: email ?? '');
        },
      ),
      GoRoute(
        name: '/Home',
        path: AppRoutes.HOME_USER,
        builder: (context, state) => TransitionRoutePage(
          child: UserLayout(
            Body: homeUserScreen(),
            currentPage: 0,
          ),
        ),
      ),
      GoRoute(
        name: '/User/history',
        path: AppRoutes.HISTORY_USER,
        builder: (context, state) => TransitionRoutePage(
          child: UserLayout(
            Body: historyUserScreen(),
            currentPage: 2,
          ),
        ),
      ),
      GoRoute(
        name: '/request-user',
        path: AppRoutes.REQUEST_USER,
        builder: (context, state) => TransitionRoutePage(
          child: UserLayout(
            Body: requestUserScreen(),
            currentPage: 1,
          ),
        ),
      ),
      GoRoute(
        name: '/profile-user',
        path: AppRoutes.PROFILE_USER,
        builder: (context, state) => TransitionRoutePage(
          child: UserLayout(
            Body: profileUserScreen(),
            currentPage: 3,
          ),
        ),
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
