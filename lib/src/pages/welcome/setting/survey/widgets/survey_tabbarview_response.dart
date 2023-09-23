import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection.dart';
import '../../../../../model/model/helper/props/props_get_survey_response_grouping.model.dart';
import '../../../../../model/model/survey_response/survey_response_model.dart';
import '../../../../../router.dart';
import '../../../../../utils/enum.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/functions.dart';
import '../../../../../view_model/custom_provider/custom_provider.dart';

class SurveyTabbarViewResponse extends ConsumerStatefulWidget {
  const SurveyTabbarViewResponse({
    Key? key,
    required this.surveyId,
    required this.isSMSBot,
  }) : super(key: key);
  final String surveyId;
  final bool isSMSBot;

  @override
  ConsumerState<SurveyTabbarViewResponse> createState() =>
      _SurveyTabbarViewResponseState();
}

class _SurveyTabbarViewResponseState
    extends ConsumerState<SurveyTabbarViewResponse> {
  Future<void> onAdd() async {
    context.pushNamed(
      routeSurveyResponseForm,
      pathParameters: {
        "id": "-1",
        "idSurvey": widget.surveyId,
      },
      extra: {
        "isSMSBot": widget.isSMSBot,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final propsSMS = PropsSurveyResponseGrouping(
      surveyId: widget.surveyId,
      platform: MachineResponsePlatformEnum.sms,
    );
    final propsWA = PropsSurveyResponseGrouping(
      surveyId: widget.surveyId,
      platform: MachineResponsePlatformEnum.whatsapp,
    );

    final groupingSMS = ref.watch(
      CustomProvider.getSurveyResponseGroupingSMS(propsSMS),
    );

    final groupingWA = ref.watch(
      CustomProvider.getSurveyResponseGroupingSMS(propsWA),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text("Add Response"),
            ),
          ),
          const SizedBox(height: 16.0),
          if (widget.isSMSBot) ...[
            ...groupingSMS.entries.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    e.key,
                    style: bodyFontBold.copyWith(fontSize: 12.0),
                  ),
                  const SizedBox(height: 10.0),
                  ...e.value.map((e) {
                    return _ResponseItem(item: e);
                  }).toList(),
                  const SizedBox(height: 10.0),
                ],
              );
            }).toList()
          ],
          if (!widget.isSMSBot) ...[
            ...groupingWA.entries.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    e.key,
                    style: bodyFontBold.copyWith(fontSize: 14.0),
                  ),
                  const SizedBox(height: 10.0),
                  ...e.value.map((e) {
                    return _ResponseItem(item: e);
                  }).toList(),
                  const SizedBox(height: 10.0),
                ],
              );
            }).toList()
          ],
        ],
      ),
    );
  }
}

class _ResponseItem extends ConsumerStatefulWidget {
  const _ResponseItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SurveyResponseModel item;

  @override
  ConsumerState<_ResponseItem> createState() => _ResponseItemState();
}

class _ResponseItemState extends ConsumerState<_ResponseItem> {
  Future<void> onEdit() async {
    context.pushNamed(routeSurveyResponseForm, pathParameters: {
      "id": widget.item.id,
      "idSurvey": widget.item.surveyId,
    });
  }

  Future<void> onDelete() async {
    final result = await ref
        .read(surveyResponseNotifier(widget.item.surveyId).notifier)
        .delete(responseId: widget.item.id);
    result.onDelete.when(
      data: (data) => ref.invalidate(surveyResponseNotifier),
      error: (error, stackTrace) => showSnackbar(
        context: context,
        message: error.toString(),
        backgroundColor: Colors.red,
      ),
      loading: () => showSnackbar(
        context: context,
        message: "Deleting...",
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.item.key,
              style: bodyFont.copyWith(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8.0,
            children: [
              InkWell(
                onTap: onEdit,
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 16.0,
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10.0),
          Text(
            widget.item.value,
            style: bodyFont.copyWith(fontSize: 10.0),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
