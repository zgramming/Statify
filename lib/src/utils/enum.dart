import 'package:json_annotation/json_annotation.dart';

enum MachineSMSSettingEnum {
  sim1,
  sim2,
  @JsonValue('sim_1_priority')
  sim1Priority,
  @JsonValue('sim_2_priority')
  sim2Priority,
  both,
}

enum MachineActionEnum {
  sms,
  whatsapp,
  @JsonValue('whatsapp_priority')
  whatsappPriority,
  @JsonValue('whatsapp_sms')
  whatsappSMS
}

enum MachineResponseTypeEnum {
  welcome,
  regular,
  banned,
  @JsonValue('wrong_password')
  wrongPassword,
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

extension MachineSMSSettingEnumEXT on MachineSMSSettingEnum {
  String get valueString {
    switch (this) {
      case MachineSMSSettingEnum.sim1:
        return 'sim_1';
      case MachineSMSSettingEnum.sim2:
        return 'sim_2';
      case MachineSMSSettingEnum.sim1Priority:
        return 'sim_1_priority';
      case MachineSMSSettingEnum.sim2Priority:
        return 'sim_2_priority';
      case MachineSMSSettingEnum.both:
        return 'both';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineSMSSettingEnum.sim1:
        return 'Sim 1';
      case MachineSMSSettingEnum.sim2:
        return 'Sim 2';
      case MachineSMSSettingEnum.sim1Priority:
        return 'Sim 1 Priority';
      case MachineSMSSettingEnum.sim2Priority:
        return 'Sim 2 Priority';
      case MachineSMSSettingEnum.both:
        return 'Both';
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
      case MachineActionEnum.whatsappPriority:
        return 'whatsapp_priority';
      case MachineActionEnum.whatsappSMS:
        return 'whatsapp_sms';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineActionEnum.sms:
        return 'SMS';
      case MachineActionEnum.whatsapp:
        return 'Whatsapp';
      case MachineActionEnum.whatsappPriority:
        return 'Whatsapp Priority';
      case MachineActionEnum.whatsappSMS:
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
      case MachineResponseTypeEnum.wrongPassword:
        return 'wrong_password';
      case MachineResponseTypeEnum.finish:
        return 'finish';
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
      case MachineResponseTypeEnum.wrongPassword:
        return 'Wrong Password';
      case MachineResponseTypeEnum.finish:
        return 'Finish';
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
        return 'Whatsapp';
      case MachineResponsePlatformEnum.sms:
        return 'SMS';
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
