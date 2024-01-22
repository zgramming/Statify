import 'package:equatable/equatable.dart';

import '../../../../utils/enum.dart';

class PropsSurveyResponseGrouping extends Equatable {
  final String surveyId;
  final MachineResponsePlatformEnum platform;
  const PropsSurveyResponseGrouping({
    required this.surveyId,
    required this.platform,
  });

  @override
  List<Object> get props => [surveyId, platform];

  @override
  bool get stringify => true;
}
