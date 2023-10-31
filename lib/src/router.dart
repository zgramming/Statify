import 'package:go_router/go_router.dart';

import 'pages/welcome/long_distance_access/admin/long_distance_access_admin.page.dart';
import 'pages/welcome/long_distance_access/home/long_distance_access_home_form.page.dart';
import 'pages/welcome/long_distance_access/long_distance_access.page.dart';
import 'pages/welcome/long_distance_access/manager/long_distance_access_manager.page.dart';
import 'pages/welcome/machine/machine_form_page.dart';
import 'pages/welcome/machine/machine_page.dart';
import 'pages/welcome/main_survey/main_survey_summary.page.dart';
import 'pages/welcome/setting/machine_group/machine_group.page.dart';
import 'pages/welcome/setting/machine_group/machine_group_form.page.dart';
import 'pages/welcome/setting/survey/survey_response_form_page.dart';
import 'pages/welcome/machine/machine_whatsapp_form_page.dart';
import 'pages/welcome/setting/log/log_page.dart';
import 'pages/welcome/setting/my_account/change_logo_form.page.dart';
import 'pages/welcome/setting/my_account/my_account.page.dart';
import 'pages/welcome/setting/my_account/my_account_form.page.dart';
import 'pages/welcome/setting/survey/surve_form.page.dart';
import 'pages/welcome/welcome_page.dart';
import 'pages/introduction/introduction_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/splash_page.dart';

// Route name

const routeWelcome = "welcome";
const routeSplash = "splash";
const routeIntroduction = "introduction";
const routeLogin = "login";

// Machine
const routeMachineGroup = "machine-group";
const routeMachineGroupForm = "machine-group/form/:id";
const routeMachine = "machine";
const routeMachineForm = "machine/form/:id";

// Machine Long Distance Access
const routeMachineLongDistanceAccess =
    "machine/:idMachine/long-distance-access";
const routeMachineLongDistanceAccessHomeForm =
    "machine/:idMachine/long-distance-access/home/form";

// Machine WhatsApp
const routeMachineWhatsAppForm = "machine/:idMachine/whatsapp/form/:id";

// Log
const routeLogPage = "log";

// Survey
const routeSurveySummaryPage = "survey/summary/:id";

const routeSurveyFormPage = "survey/form/:id";

const routeSurveyResponseForm = "survey/:idSurvey/response/form/:id";

// My Account

const routeMyAccountPage = "my-account";
const routeMyAccountFormPage = "my-account/form/:id";
const routeChangeLogoPage = "change-logo";

// Long Distance Access
const routeLDAAdminPage = "machine/:idMachine/long-distance-access/admin";
const routeLDAManagerPage = "machine/:idMachine/long-distance-access/manager";

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
    path: "/machine/:idMachine/long-distance-access",
    name: routeMachineLongDistanceAccess,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return LongDistanceAccessPage(idMachine: idMachine);
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/long-distance-access/home/form/:index",
    name: routeMachineLongDistanceAccessHomeForm,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      final index = int.tryParse(state.pathParameters['index'] ?? "-1") ?? -1;
      return LongDistanceAccessHomeFormPage(
        idMachine: idMachine,
        index: index,
      );
    },
  ),

  GoRoute(
    path: "/machine-group",
    name: routeMachineGroup,
    builder: (context, state) => const MachineGroupPage(),
  ),
  GoRoute(
    path: "/machine-group/form/:id",
    name: routeMachineGroupForm,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      return MachineGroupFormPage(id: id);
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
    path: "/machine/:idMachine/survey/form/:id",
    name: routeSurveyFormPage,
    builder: (context, state) {
      final id = state.pathParameters['id'] ?? "-1";
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return SurveyFormPage(
        id: id,
        idMachine: idMachine,
      );
    },
  ),

  GoRoute(
    path: "/machine/:idMachine/survey/:idSurvey/summary",
    name: routeSurveySummaryPage,
    builder: (context, state) {
      final surveyId = state.pathParameters['idSurvey'] ?? "-1";
      final machineId = state.pathParameters['idMachine'] ?? "-1";
      return SurveySummaryPage(
        surveyId: surveyId,
        machineId: machineId,
      );
    },
  ),

  // Long Distance Access
  GoRoute(
    path: "/machine/:idMachine/long-distance-access/admin",
    name: routeLDAAdminPage,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return LongDistanceAccessAdminPage(
        idMachine: idMachine,
      );
    },
  ),
  GoRoute(
    path: "/machine/:idMachine/long-distance-access/manager",
    name: routeLDAManagerPage,
    builder: (context, state) {
      final idMachine = state.pathParameters['idMachine'] ?? "-1";
      return LongDistanceAccessManagerPage(
        idMachine: idMachine,
      );
    },
  ),
];
