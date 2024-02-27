import 'package:dedebt_application/routes/transitionRoute.dart';

import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/Admin/adminHomeScreen.dart';
import 'package:dedebt_application/screens/HomeScreen.dart';
import 'package:dedebt_application/screens/Matcher/homeMatcher.dart';
import 'package:dedebt_application/screens/User/assignmentUserScreen.dart';
import 'package:dedebt_application/screens/User/historyUserScreen.dart';
import 'package:dedebt_application/screens/User/homeUserScreen.dart';
import 'package:dedebt_application/screens/User/profileUserScreen.dart';
import 'package:dedebt_application/screens/User/requestUserScreen.dart';
import 'package:dedebt_application/screens/User/sendRequestPage2Screen.dart';
import 'package:dedebt_application/screens/User/sendRequestSuccessScreen.dart';
import 'package:dedebt_application/screens/User/sendRequestScreen.dart';
import 'package:dedebt_application/screens/layouts/adminLayout.dart';
import 'package:dedebt_application/screens/Advisor/homeAdvisorScreen.dart';
import 'package:dedebt_application/screens/Advisor/requesListAdvisorScreen.dart';
import 'package:dedebt_application/screens/Advisor/requestAdvisorScreen.dart';
import 'package:dedebt_application/screens/Advisor/assignmentAdvisorScreen.dart';
import 'package:dedebt_application/screens/Advisor/historyAdvisorScreen.dart';
import 'package:dedebt_application/screens/Advisor/profileAdvisorScreen.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/screens/layouts/matcherLayout.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
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
            Body: HomeUserScreen(),
            currentPage: 0,
          ),
        ),
      ),
      GoRoute(
        name: '/User/history',
        path: AppRoutes.HISTORY_USER,
        builder: (context, state) => TransitionRoutePage(
          child: UserLayout(
            Body: HistoryUserScreen(),
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
        name: '/send-request-page2-users',
        path: AppRoutes.SEND_REQUEST_PAGE2_USER,
        builder: (context, state) => TransitionRoutePage(
          child: sendRequestPage2Screen(),
        ),
      ),
      GoRoute(
        name: '/send-request-user',
        path: AppRoutes.SEND_REQUEST_USER,
        builder: (context, state) => TransitionRoutePage(
          child: sendRequestScreen(),
        ),
      ),
      GoRoute(
          name: '/assignment-user',
          path: AppRoutes.ASSIGNMENT_USER,
          builder: (context, state) => TransitionRoutePage(
                child: assignmentUserScreen(),
              )),
      GoRoute(
          name: '/send-request-success-user',
          path: AppRoutes.SEND_REQUESt_SUCCESS_USER,
          builder: (context, state) {
            return TransitionRoutePage(
              child: sendRequestSuccessScreen(),
            );
          }),
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
        name: '/home-advisor',
        path: AppRoutes.HOME_ADVISOR,
        builder: (context, state) => TransitionRoutePage(
          child: AdvisorLayout(
            body: homeAdvisorScreen(),
            currentPage: 0,
          ),
        ),
      ),
      GoRoute(
        name: '/request-list-advisor',
        path: AppRoutes.REQUEST_LIST_ADVISOR,
        builder: (context, state) => TransitionRoutePage(
          child: AdvisorLayout(
            body: requestListAdvisorScreen(),
            currentPage: 1,
          ),
        ),
      ),
      GoRoute(
        name: '/request-advisor',
        path: AppRoutes.REQUEST_ADVISOR,
        builder: (context, state) => TransitionRoutePage(
          child: AdvisorLayout(
            body: requestAdvisorScreen(),
            currentPage: 1,
          ),
        ),
      ),
      GoRoute(
        name: '/assignment-advisor',
        path: AppRoutes.ASSIGNMENT_ADVISOR,
        builder: (context, state) => TransitionRoutePage(
          child: assignmentAdvisorScreen(),
        ),
      ),
      GoRoute(
        name: '/history-advisor',
        path: AppRoutes.HISTORY_ADVISOR,
        builder: (context, state) => TransitionRoutePage(
          child: AdvisorLayout(
            body: historyAdvisorScreen(),
            currentPage: 2,
          ),
        ),
      ),
      GoRoute(
        name: '/profile-advisor',
        path: AppRoutes.PROFILE_ADVISOR,
        builder: (context, state) => TransitionRoutePage(
          child: AdvisorLayout(
            body: profileAdvisorScreen(),
            currentPage: 3,
          ),
        ),
      ),
      GoRoute(
        name: '/home-admin',
        path: AppRoutes.HOME_ADMIN,
        builder: (context, state) => AdminLayout(
          Body: AdminHomeScreen(),
        ),
      ),
      GoRoute(
        name: 'main-matcher',
        path: AppRoutes.MAIN_MATCHER,
        builder: (context, state) => MatcherLayout(
          Body: HomeMatcher(),
        ),
      ),
    ],
  );
}
