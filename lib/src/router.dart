import 'package:go_router/go_router.dart';

import 'pages/welcome/machine/machine_form_page.dart';
import 'pages/welcome/machine/machine_page.dart';
import 'pages/welcome/setting/survey/survey_response_form_page.dart';
import 'pages/welcome/machine/machine_whatsapp_form_page.dart';
import 'pages/welcome/machine/machine_whatsapp_page.dart';
import 'pages/welcome/setting/log/log_page.dart';
import 'pages/welcome/setting/my_account/change_logo_form.page.dart';
import 'pages/welcome/setting/my_account/my_account.page.dart';
import 'pages/welcome/setting/my_account/my_account_form.page.dart';
import 'pages/welcome/setting/survey/surve_form.page.dart';
import 'pages/welcome/setting/survey/survey.page.dart';
import 'pages/welcome/welcome_page.dart';
import 'pages/introduction/introduction_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';

const routeWelcome = "welcome";
const routeSplash = "splash";
const routeIntroduction = "introduction";
const routeLogin = "login";

const routeMachine = "machine";
const routeMachineForm = "machine/form/:id";

const routeMachineWhatsApp = "machine/:idMachine/whatsapp";
const routeMachineWhatsAppForm = "machine/:idMachine/whatsapp/form/:id";

const routeLogPage = "log";

const routeSurveyPage = "survey";
const routeSurveyFormPage = "survey/form/:id";

const routeSurveyResponseForm = "survey/:idSurvey/response/form/:id";

const routeMyAccountPage = "my-account";
const routeMyAccountFormPage = "my-account/form/:id";

const routeChangeLogoPage = "change-logo";

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

  //  Experimental routes

  GoRoute(
    path: "/machine",
    name: routeMachine,
    builder: (context, state) => const MachinePage(),
  ),
  GoRoute(
    path: "/machine/form/:id",
    name: routeMachineForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      return MachineFormPage(id: id);
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/whatsapp",
    name: routeMachineWhatsApp,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineWhatsAppPage(idMachine: idMachine);
    },
  ),
  GoRoute(
    path: "/machine/whatsapp/form/:id",
    name: routeMachineWhatsAppForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      return MachineWhatsAppFormPage(id: id);
    },
  ),

  GoRoute(
    path: "/survey/:idSurvey/response/form/:id",
    name: routeSurveyResponseForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idSurvey = state.pathParameters['idSurvey'] ?? "-1";
      final isSMSBot = state.extra == null
          ? false
          : (state.extra as Map<String, dynamic>)['isSMSBot'] ?? false;
      return SurveyResponseFormPage(
        id: id,
        idSurvey: idSurvey,
        isSMSBot: isSMSBot,
      );
    },
  ),

  GoRoute(
    path: "/log",
    name: routeLogPage,
    builder: (context, state) {
      return const LogPage();
    },
  ),

  GoRoute(
    path: "/change-logo",
    name: routeChangeLogoPage,
    builder: (context, state) => const ChangeLogoPage(),
  ),
  GoRoute(
    path: "/my-account",
    name: routeMyAccountPage,
    builder: (context, state) {
      return const MyAccountPage();
    },
  ),

  GoRoute(
    path: "/my-account/form/:id",
    name: routeMyAccountFormPage,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      return MyAccountFormPage(id: id);
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/survey",
    name: routeSurveyPage,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return SurveyPage(
        idMachine: idMachine,
      );
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/survey/form/:id",
    name: routeSurveyFormPage,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return SurveyFormPage(
        idMachine: idMachine,
        id: id,
      );
    },
  ),
];
