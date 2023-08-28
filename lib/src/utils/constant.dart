import 'package:flutter/foundation.dart';

const kIsDevelopment = true;
const hiveSMSBox = 'smsBox';
const hivePhoneBox = 'phoneBox';
const hiveApplicationConfigBox = 'applicationConfigBox';
const incomingCallKeyEC = 'incomingCallEventChannel';

const kBaseApiUrl = kReleaseMode
    ? "https://sms-api.hitechterminal.com/api"
    : 'http://192.168.0.6:8000/api';
const kTokenAuth = 'token_auth';
const kUserAuth = 'user_auth';
