import 'package:go_router/go_router.dart';

import 'pages/welcome/sms/send_sms/send_sms_page.dart';
import 'pages/welcome/welcome_page.dart';
import 'pages/introduction/introduction_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';

const routeWelcome = "welcome";
const routeSplash = "splash";
const routeSendSMS = "sms/send";
const routeIntroduction = "introduction";
const routeLogin = "login";

final routerConfig = GoRouter(
  routes: _routes,
  initialLocation: "/splash",
);

final _routes = <RouteBase>[
  GoRoute(
    path: "/splash",
    name: routeSplash,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: "/introduction",
    name: routeIntroduction,
    builder: (context, state) => const IntroductionPage(),
  ),
  GoRoute(
    path: '/login',
    name: routeLogin,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: "/welcome",
    name: routeWelcome,
    builder: (context, state) => const WelcomePage(),
  ),
  GoRoute(
    path: "/sms/send",
    name: routeSendSMS,
    builder: (context, state) => const SendSMSPage(),
  ),
];
