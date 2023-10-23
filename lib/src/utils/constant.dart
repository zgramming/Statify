import 'package:flutter/foundation.dart';

const kIntroductionKey = 'introduction_key';
// const kBaseApiUrl = "https://sms-api.hitechterminal.com/api";
const kBaseApiUrl = kReleaseMode
    ? "https://sms-api.hitechterminal.com/api"
    : 'http://192.168.0.6:8000/api';
const kTokenAuth = 'token_auth';

const kUserAuth = 'user_auth';

const kURLImageAsset = "assets/image";
const kURLLogoHitech = "assets/image/logo-hitech.png";

const kErrorMachineNumberNotFoundInUserSIM =
    "Machine number is not found in user sim";
