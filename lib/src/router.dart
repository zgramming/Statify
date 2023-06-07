import 'package:go_router/go_router.dart';

import 'pages/home/home_page.dart';
import 'pages/home/sms/send_sms/send_sms_page.dart';
import 'pages/splash/splash_page.dart';

const routeHome = "home";
const routeSplash = "splash";
const routeSendSMS = "sms/send";

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
  GoRoute(
    path: "/sms/send",
    name: routeSendSMS,
    builder: (context, state) => const SendSMSPage(),
  ),
];
