const kBaseApiUrl = "https://sms-api.hitechterminal.com/api";
// const kBaseApiUrl = kReleaseMode
//     ? "https://sms-api.hitechterminal.com/api"
//     : 'http://192.168.0.6:8000/api';
const kBaseFileUrl = "$kBaseApiUrl/files";

const kTokenAuth = 'token_auth';

const kUserAuth = 'user_auth';

const kURLImageAsset = "assets/image";
const kURLLogoHitech = "assets/image/logo-hitech.png";

const kErrorMachineNumberNotFoundInUserSIM =
    "Machine number is not found in user sim";

const kRawJsonConfigOperators =
    "[{\"status\":1,\"label\":\"TELKOMSEL\",\"mcc\":\"510\",\"mnc\":\"10\",\"name\":\"TELKOMSEL\",\"arfcn\":\"5\",\"timeout\":\"15\",\"country\":\"INDONESIA\",\"is_play\":1,\"curr\":0,\"lte_arfcn\":\"1850\",\"lte_pci\":\"111\",\"lte_tac\":\"1111\",\"lte_cell_id\":\"11111\",\"lte_downgrade\":\"5\",\"lte_rotation_time\":\"70\",\"lte_plmn\":\"51010\",\"default\":\"true\",\"three_g_arfcn\":\"10638\",\"five_g_arfcn\":\"1333\"},{\"status\":1,\"label\":\"XL\",\"mcc\":\"510\",\"mnc\":\"11\",\"name\":\"XL\",\"arfcn\":\"50\",\"timeout\":\"15\",\"country\":\"INDONESIA\",\"is_play\":1,\"curr\":0,\"lte_arfcn\":\"1313\",\"lte_pci\":\"122\",\"lte_tac\":\"1122\",\"lte_cell_id\":\"11222\",\"lte_downgrade\":\"5\",\"lte_rotation_time\":\"70\",\"lte_plmn\":\"51011\",\"default\":\"true\",\"three_g_arfcn\":\"10738\",\"five_g_arfcn\":\"2333\"},{\"status\":1,\"label\":\"INDOSAT\",\"mcc\":\"510\",\"mnc\":\"01\",\"name\":\"INDOSAT\",\"arfcn\":\"120\",\"timeout\":\"15\",\"country\":\"INDONESIA\",\"is_play\":1,\"curr\":0,\"lte_arfcn\":\"1625\",\"lte_pci\":\"133\",\"lte_tac\":\"1133\",\"lte_cell_id\":\"11111\",\"lte_downgrade\":\"120\",\"lte_rotation_time\":\"70\",\"lte_plmn\":\"51001\",\"default\":\"true\",\"three_g_arfcn\":\"10838\",\"five_g_arfcn\":\"3333\"}]";

// Application Config Key
const kIntroductionKey = 'introduction_key';
const kAutoRespondServer = "auto_respond_server";

// Success Message
const kSuccessMessageResetMachine = "After reset the device, Click Reboot";
