// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../injection.dart';
import '../../../../../utils/enum.dart';
import '../../../../../utils/fonts.dart';
import '../../../../widgets/async_error_builder.dart';
import 'survey_tabbarview_smsbotorwhatsapp.dart';

class SurveyTabBarConfiguration extends ConsumerStatefulWidget {
  const SurveyTabBarConfiguration({
    super.key,
    required this.surveyId,
  });

  final String surveyId;
  @override
  ConsumerState<SurveyTabBarConfiguration> createState() =>
      SurveyTabBarConfigurationState();
}

class SurveyTabBarConfigurationState
    extends ConsumerState<SurveyTabBarConfiguration>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref
        .watch(surveySettingNotifier(widget.surveyId))
        .onGetAll
        .unwrapPrevious();

    return settingsAsync.when(
      data: (settings) {
        return DefaultTabController(
          length: settings.length,
          initialIndex: selectedIndex,
          child: Card(
            margin: const EdgeInsets.only(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TabBar(
                        onTap: (value) => setState(() => selectedIndex = value),
                        labelStyle: bodyFont.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        unselectedLabelColor: Colors.blue,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0),
                          color: Colors.blue,
                        ),
                        tabs: settings
                            .map((e) =>
                                Tab(text: e.platform.valueStringReadable))
                            .toList()),
                  ),
                  IndexedStack(
                    index: selectedIndex,
                    children: settings
                        .map(
                          (e) => Builder(
                            builder: (context) {
                              if (e.platform ==
                                  MachineResponsePlatformEnum.sms) {
                                return SurveyTabBarViewSMSBotOrWhatsapp(
                                  surveyId: widget.surveyId,
                                  idSetting: e.id,
                                  isSMSBot: true,
                                );
                              } else {
                                return SurveyTabBarViewSMSBotOrWhatsapp(
                                  surveyId: widget.surveyId,
                                  idSetting: e.id,
                                  isSMSBot: false,
                                );
                              }
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) => AsyncErrorBuilder(
        error: error.toString(),
        onRetry: () => ref.invalidate(surveySettingNotifier),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
