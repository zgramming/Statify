enum MachineSMSSettingEnum {
  sim1,
  sim2,
  sim1Priority,
  sim2Priority,
  both,
}

enum MachineActionEnum { sms, whatsapp, whatsappPriority, whatappSMS }

enum MachineResponseTypeEnum { welcome, regular, banned, wrongPassword, finish }

enum MachineWhatsappStatusEnum {
  connected,
  disconnected,
}

enum MachineResponsePlatform {
  whatsapp,
  sms,
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
      case MachineActionEnum.whatappSMS:
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
      case MachineActionEnum.whatappSMS:
        return 'Whatsapp SMS';
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

extension MachineResponsePlatformEXT on MachineResponsePlatform {
  String get valueString {
    switch (this) {
      case MachineResponsePlatform.whatsapp:
        return 'whatsapp';
      case MachineResponsePlatform.sms:
        return 'sms';
    }
  }

  String get valueStringReadable {
    switch (this) {
      case MachineResponsePlatform.whatsapp:
        return 'Whatsapp';
      case MachineResponsePlatform.sms:
        return 'SMS';
    }
  }
}
