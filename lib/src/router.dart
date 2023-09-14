import 'package:go_router/go_router.dart';

import 'pages/welcome/machine/machine_form_page.dart';
import 'pages/welcome/machine/machine_page.dart';
import 'pages/welcome/machine/machine_response_form_page.dart';
import 'pages/welcome/machine/machine_response_page.dart';
import 'pages/welcome/machine/machine_survey_form_page.dart';
import 'pages/welcome/machine/machine_survey_page.dart';
import 'pages/welcome/machine/machine_whatsapp_form_page.dart';
import 'pages/welcome/machine/machine_whatsapp_page.dart';
import 'pages/welcome/setting/log/log_page.dart';
import 'pages/welcome/setting/my_account/my_account.page.dart';
import 'pages/welcome/setting/my_account/my_account_form.page.dart';
import 'pages/welcome/setting/phone_number_setting/phone_number_setting_form_page.dart';
import 'pages/welcome/welcome_page.dart';
import 'pages/introduction/introduction_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';

const routeWelcome = "welcome";
const routeSplash = "splash";
const routeIntroduction = "introduction";
const routeLogin = "login";

// Experimental routes
const routeMachine = "machine";
const routeMachineForm = "machine/form/:id";

const routeMachineResponse = "machine/:idMachine/response";
const routeMachineResponseForm = "machine/:idMachine/response/form/:id";

// const routeMachineSetting = "machine/:idMachine/setting";
// const routeMachineSettingForm = "machine/:idMachine/setting/form/:id";

const routeMachineWhatsApp = "machine/:idMachine/whatsapp";
const routeMachineWhatsAppForm = "machine/:idMachine/whatsapp/form/:id";

const routeMachineSurvey = "machine/:idMachine/survey";
const routeMachineSurveyForm = "machine/:idMachine/survey/form/:id";

const routePhoneNumberSettingFormPage = "phone-number-setting/form";
const routeLogPage = "log";
const routeMyAccountPage = "my-account";
const routeMyAccountFormPage = "my-account/form/:id";

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
    path: "/machine/:idMachine/response",
    name: routeMachineResponse,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return MachineResponsePage(idMachine: idMachine);
    },
  ),
  GoRoute(
    path: "/machine/:idMachine/response/form/:id",
    name: routeMachineResponseForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      final isSMSBot = state.extra == null
          ? false
          : (state.extra as Map<String, dynamic>)['isSMSBot'] ?? false;
      return MachineResponseFormPage(
        idMachine: idMachine,
        id: id,
        isSMSBot: isSMSBot,
      );
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

  GoRoute(
    path: "/phone-number-setting/form",
    name: routePhoneNumberSettingFormPage,
    builder: (context, state) {
      return const PhoneNumberSettingFormPage();
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
];
