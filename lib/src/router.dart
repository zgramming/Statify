import 'package:go_router/go_router.dart';

import 'pages/welcome/machine/machine_form_page.dart';
import 'pages/welcome/machine/machine_page.dart';
import 'pages/welcome/machine/machine_response_form_page.dart';
import 'pages/welcome/machine/machine_response_page.dart';
import 'pages/welcome/machine/machine_survey_form_page.dart';
import 'pages/welcome/machine/machine_survey_page.dart';
import 'pages/welcome/machine/machine_whatsapp_form_page.dart';
import 'pages/welcome/machine/machine_whatsapp_page.dart';
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

// Experimental routes
const routeMachine = "machine";
const routeMachineForm = "machine/form/:id";

const routeMachineResponseSetting = "machine/:idMachine/response_setting";
const routeMachineResponseSettingForm =
    "machine/:idMachine/response_setting/form/:id";

const routeMachineWhatsApp = "machine/:idMachine/whatsapp";
const routeMachineWhatsAppForm = "machine/:idMachine/whatsapp/form/:id";

const routeMachineSurvey = "machine/:idMachine/survey";
const routeMachineSurveyForm = "machine/:idMachine/survey/form/:id";

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
    path: "/machine/:idMachine/whatsapp/form/:id",
    name: routeMachineWhatsAppForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineWhatsAppFormPage(idMachine: idMachine, id: id);
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/response_setting",
    name: routeMachineResponseSetting,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineResponsePage(idMachine: idMachine);
    },
  ),
  GoRoute(
    path: "/machine/:idMachine/response_setting/form/:id",
    name: routeMachineResponseSettingForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineResponseFormPage(idMachine: idMachine, id: id);
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/survey",
    name: routeMachineSurvey,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineSurveyPage(idMachine: idMachine);
    },
  ),
  GoRoute(
    path: "/machine/:idMachine/survey/form/:id",
    name: routeMachineSurveyForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineSurveyFormPage(idMachine: idMachine, id: id);
    },
  ),
];
