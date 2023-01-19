import 'package:go_router/go_router.dart';

import 'pages/home_page.dart';
import 'pages/splash_page.dart';

const routeHome = "home";
const routeSplash = "splash";

final routerConfig = GoRouter(routes: _routes, initialLocation: "/splash");

final _routes = <RouteBase>[
  GoRoute(
    path: "/splash",
    name: routeSplash,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: "/home",
    name: routeHome,
    builder: (context, state) => const HomePage(),
  ),
];
