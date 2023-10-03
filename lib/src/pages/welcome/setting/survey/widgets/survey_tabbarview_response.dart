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
          const SizedBox(height: 16.0),
          if (widget.isSMSBot) ...[
            ...groupingSMS.entries.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    e.key.valueStringReadable,
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
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.key.valueStringReadable,
                            style: bodyFontBold.copyWith(fontSize: 14.0),
                          ),
                          if (e.key ==
                              SurveyResponseTypeEnum.yourAutoResponder) ...[
                            InkWell(
                              onTap: onAdd,
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 32.0,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      ...e.value.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: _ResponseItem(item: e),
                        );
                      }).toList(),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
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
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.grey, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Received:",
                            style: bodyFont.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.item.key,
                      style: bodyFont.copyWith(fontSize: 10.0),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 1.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Reply:",
                            style: bodyFont.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.item.value,
                      style: bodyFont.copyWith(fontSize: 10.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
