import 'package:flutter/foundation.dart';

const kIsDevelopment = true;
const hiveSMSBox = 'smsBox';
const hivePhoneBox = 'phoneBox';
const hiveApplicationConfigBox = 'applicationConfigBox';
const incomingCallKeyEC = 'incomingCallEventChannel';

// const kBaseApiUrl = "https://sms-api.hitechterminal.com/api";
const kBaseApiUrl = kReleaseMode
    ? "https://sms-api.hitechterminal.com/api"
    : 'http://192.168.200.85:8000/api';
const kTokenAuth = 'token_auth';
const kUserAuth = 'user_auth';
