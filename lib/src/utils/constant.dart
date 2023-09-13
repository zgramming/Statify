import 'package:flutter/foundation.dart';

const kIntroductionKey = 'introduction_key';
const kIsDevelopment = true;
// const kBaseApiUrl = "https://sms-api.hitechterminal.com/api";
const kBaseApiUrl = kReleaseMode
    ? "https://sms-api.hitechterminal.com/api"
    : 'http://192.168.0.4:8000/api';
const kTokenAuth = 'token_auth';

const kUserAuth = 'user_auth';
