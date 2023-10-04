import 'package:json_annotation/json_annotation.dart';

enum ErrorCode {
  // ignore: constant_identifier_names
  MC_NEED_ACTIVE_SURVEY,
}

enum ExportTypeEnum {
  totalReplied,
  totalFinished,
  totalVoted,
  totalSMSSent,
}

enum SurveyResponseTypeEnum {
  systemAutoResponder,
  yourAutoResponder,
}

enum MachineSMSSettingEnum {
  sim_1,
  sim_2,
  // ignore: constant_identifier_names
  sim_1_priority,
  // ignore: constant_identifier_names
  sim_2_priority,
  both,
}

enum MachineStatusEnum {
  offline,
  online,
}

enum MachineActionEnum {
  sms,
  whatsapp,
  // ignore: constant_identifier_names
  whatsapp_priority,
  // ignore: constant_identifier_names
  whatsapp_sms
}

enum MachineResponseTypeEnum {
  welcome,
  regular,
  banned,
  // ignore: constant_identifier_names
  wrong_reply,
  // ignore: constant_identifier_names
  wrong_password,
  // ignore: constant_identifier_names
  incoming_call,
  timeout,
  finish
}

enum MachineWhatsappStatusEnum {
  connected,
  disconnected,
}

enum MachineResponsePlatformEnum {
  whatsapp,
  sms,
}

enum MachineSettingToolsOptionEnum {
  allNumber,
  @JsonValue('specific_number')
  specificNumber,
}

enum SurveyTemplateEnum {
  @JsonValue('candidate')
  canditate,
  @JsonValue('product_sales')
  // ignore: constant_identifier_names
  product_sales,
  @JsonValue('customer_satisfaction')
  // ignore: constant_identifier_names
  customer_satisfaction,
  @JsonValue('ready_to_edit')
  // ignore: constant_identifier_names
  ready_to_edit,
}

enum WhatSIMHasBeenChanged {
  sim1,
  sim2,
  both,
  none,
}

extension MachineSMSSettingEnumEXT on MachineSMSSettingEnum {
  String get valueString {
    switch (this) {
      case MachineSMSSettingEnum.sim_1:
        return 'sim_1';
      case MachineSMSSettingEnum.sim_2:
        return 'sim_2';
      case MachineSMSSettingEnum.sim_1_priority:
        return 'sim_1_priority';
      case MachineSMSSettingEnum.sim_2_priority:
        return 'sim_2_priority';
      case MachineSMSSettingEnum.both:
        return 'both';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineSMSSettingEnum.sim_1:
        return 'Sim 1';
      case MachineSMSSettingEnum.sim_2:
        return 'Sim 2';
      case MachineSMSSettingEnum.sim_1_priority:
        return 'Sim 1 Priority';
      case MachineSMSSettingEnum.sim_2_priority:
        return 'Sim 2 Priority';
      case MachineSMSSettingEnum.both:
        return 'Both';
    }
  }
}

extension MachineStatusEnumEXT on MachineStatusEnum {
  String get valueString {
    switch (this) {
      case MachineStatusEnum.offline:
        return 'offline';
      case MachineStatusEnum.online:
        return 'online';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineStatusEnum.offline:
        return 'Offline';
      case MachineStatusEnum.online:
        return 'Online';
    }
  }
}

extension MachineActionEnumEXT on MachineActionEnum {
  String get valueString {
    switch (this) {
      case MachineActionEnum.sms:
        return 'sms';
      case MachineActionEnum.whatsapp:
        return 'whatsapp';
      case MachineActionEnum.whatsapp_priority:
        return 'whatsapp_priority';
      case MachineActionEnum.whatsapp_sms:
        return 'whatsapp_sms';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineActionEnum.sms:
        return 'SMS';
      case MachineActionEnum.whatsapp:
        return 'Whatsapp';
      case MachineActionEnum.whatsapp_priority:
        return 'Whatsapp Priority';
      case MachineActionEnum.whatsapp_sms:
        return 'Whatsapp + SMS';
    }
  }
}

extension MachineResponseTypeEnumEXT on MachineResponseTypeEnum {
  String get valueString {
    switch (this) {
      case MachineResponseTypeEnum.welcome:
        return 'welcome';
      case MachineResponseTypeEnum.regular:
        return 'regular';
      case MachineResponseTypeEnum.banned:
        return 'banned';
      case MachineResponseTypeEnum.wrong_password:
        return 'wrong_password';
      case MachineResponseTypeEnum.wrong_reply:
        return 'wrong_reply';
      case MachineResponseTypeEnum.timeout:
        return 'timeout';
      case MachineResponseTypeEnum.finish:
        return 'finish';
      case MachineResponseTypeEnum.incoming_call:
        return 'incoming_call';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineResponseTypeEnum.welcome:
        return 'Welcome';
      case MachineResponseTypeEnum.regular:
        return 'Regular';
      case MachineResponseTypeEnum.banned:
        return 'Banned';
      case MachineResponseTypeEnum.wrong_password:
        return 'Wrong Password';
      case MachineResponseTypeEnum.wrong_reply:
        return 'Wrong Reply';
      case MachineResponseTypeEnum.timeout:
        return 'Timeout';
      case MachineResponseTypeEnum.finish:
        return 'Finish';
      case MachineResponseTypeEnum.incoming_call:
        return 'Incoming Call';
    }
  }
}

extension MachineWhatsappStatusEXT on MachineWhatsappStatusEnum {
  String get valueString {
    switch (this) {
      case MachineWhatsappStatusEnum.connected:
        return 'connected';
      case MachineWhatsappStatusEnum.disconnected:
        return 'disconnected';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineWhatsappStatusEnum.connected:
        return 'Connected';
      case MachineWhatsappStatusEnum.disconnected:
        return 'Disconnected';
    }
  }
}

extension MachineResponsePlatformEXT on MachineResponsePlatformEnum {
  String get valueString {
    switch (this) {
      case MachineResponsePlatformEnum.whatsapp:
        return 'whatsapp';
      case MachineResponsePlatformEnum.sms:
        return 'sms';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineResponsePlatformEnum.whatsapp:
        return 'Whatsapp Bot';
      case MachineResponsePlatformEnum.sms:
        return 'SMS Bot';
    }
  }
}

extension MachineSettingToolsOptionEXT on MachineSettingToolsOptionEnum {
  bool get valueBoolean {
    switch (this) {
      case MachineSettingToolsOptionEnum.allNumber:
        return true;
      case MachineSettingToolsOptionEnum.specificNumber:
        return false;
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineSettingToolsOptionEnum.allNumber:
        return 'All Numbers Can Join Survey';
      case MachineSettingToolsOptionEnum.specificNumber:
        return 'Only Invited Numbers Can Join Survey';
    }
  }
}

extension SurveyTemplateEnumEXT on SurveyTemplateEnum {
  String get valueString {
    switch (this) {
      case SurveyTemplateEnum.canditate:
        return 'candidate';
      case SurveyTemplateEnum.product_sales:
        return 'product_sales';
      case SurveyTemplateEnum.customer_satisfaction:
        return 'customer_satisfaction';
      case SurveyTemplateEnum.ready_to_edit:
        return 'ready_to_edit';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case SurveyTemplateEnum.canditate:
        return 'Candidate';
      case SurveyTemplateEnum.product_sales:
        return 'Product Sales';
      case SurveyTemplateEnum.customer_satisfaction:
        return 'Customer Satisfaction';
      case SurveyTemplateEnum.ready_to_edit:
        return 'Ready To Edit';
    }
  }
}

extension WhatSIMHasBeenChangedEXT on WhatSIMHasBeenChanged {
  String get valueString {
    switch (this) {
      case WhatSIMHasBeenChanged.sim1:
        return 'sim1';
      case WhatSIMHasBeenChanged.sim2:
        return 'sim2';
      case WhatSIMHasBeenChanged.both:
        return 'both';
      case WhatSIMHasBeenChanged.none:
        return 'none';
    }
  }
}

extension ErrorCodeEXT on ErrorCode {
  String get valueString {
    switch (this) {
      case ErrorCode.MC_NEED_ACTIVE_SURVEY:
        return 'MC_NEED_ACTIVE_SURVEY';
    }
  }
}

extension SurveyResponseTypeEnumEXT on SurveyResponseTypeEnum {
  String get valueString {
    switch (this) {
      case SurveyResponseTypeEnum.systemAutoResponder:
        return 'system_auto_responder';
      case SurveyResponseTypeEnum.yourAutoResponder:
        return 'your_auto_responder';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case SurveyResponseTypeEnum.systemAutoResponder:
        return 'System Auto Responder';
      case SurveyResponseTypeEnum.yourAutoResponder:
        return 'Your Auto Responder';
    }
  }
}

extension ExportTypeEnumEXT on ExportTypeEnum {
  String get valueString {
    switch (this) {
      case ExportTypeEnum.totalReplied:
        return 'total-replied';
      case ExportTypeEnum.totalFinished:
        return 'total-finished';
      case ExportTypeEnum.totalVoted:
        return 'total-voted';
      case ExportTypeEnum.totalSMSSent:
        return 'total-sms-sent';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case ExportTypeEnum.totalReplied:
        return 'Total Replied';
      case ExportTypeEnum.totalFinished:
        return 'Total Finished';
      case ExportTypeEnum.totalVoted:
        return 'Total Voted';
      case ExportTypeEnum.totalSMSSent:
        return 'Total SMS Sent';
    }
  }
}
