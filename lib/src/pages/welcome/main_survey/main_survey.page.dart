import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/survey/survey.model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_notifier/get_all_survey_by_user.notifier.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class MainSurveyPage extends ConsumerStatefulWidget {
  const MainSurveyPage({super.key});

  @override
  ConsumerState<MainSurveyPage> createState() => _MainSurveyPageState();
}

class _MainSurveyPageState extends ConsumerState<MainSurveyPage> {
  Future<void> onAdd() async {
    try {
      await context.pushNamed(routeSurveyFormPage, pathParameters: {
        "id": "-1",
        "idMachine": "-1",
      });
    } catch (e) {
      showSnackbar(
        context: context,
        message: e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyAsync =
        ref.watch(getAllSurveyByUserGroupByMachineFutureProvider);
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppbar(
              title: "Survey List",
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(
                      getAllSurveyByUserGroupByMachineFutureProvider);
                  showSnackbar(
                    context: context,
                    message: "Refreshing...",
                    backgroundColor: Colors.blue,
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Builder(
                    builder: (context) {
                      return surveyAsync.when(
                        data: (map) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: map.entries.map((e) {
                              final machine = e.key;
                              final surveys = e.value;

                              if (surveys.isEmpty) {
                                return const SizedBox();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "Machine: ${e.key.name}",
                                    style: headerFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: surveys.length,
                                    padding: EdgeInsets.zero,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 8),
                                    itemBuilder: (context, index) {
                                      final item = surveys[index];
                                      return _SurveyItem(
                                        index: index,
                                        item: item,
                                        activeSurveyId: machine.activeSurveyId,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }).toList(),
                          );
                        },
                        error: (error, stackTrace) => AsyncErrorBuilder(
                          error: error.toString(),
                          onRetry: () {
                            ref.invalidate(
                                getAllSurveyByUserGroupByMachineFutureProvider);
                          },
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            heroTag: "addSurvey",
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class _SurveyItem extends ConsumerStatefulWidget {
  const _SurveyItem({
    Key? key,
    required this.index,
    required this.item,
    required this.activeSurveyId,
  }) : super(key: key);
  final int index;
  final String? activeSurveyId;
  final SurveyModel item;

  @override
  ConsumerState<_SurveyItem> createState() => _SurveyItemState();
}

class _SurveyItemState extends ConsumerState<_SurveyItem> {
  bool currentValue = false;

  Future<void> onChange(bool value) async {
    // Check if value is false then do nothing
    if (!value) {
      showSnackbar(
        context: context,
        message:
            "Cannot deactivate survey, please activate another survey or create new survey",
        backgroundColor: Colors.red,
      );
      return;
    }

    // update value
    final notifier = ref.read(surveyNotifier(widget.item.machineId).notifier);

    final result = await notifier.active(surveyId: widget.item.id);
    result.onActive.when(
      data: (data) {
        if (data == null) return;

        // invalidate machine
        ref.invalidate(getAllMachineFutureProvider);
      },
      error: (error, stackTrace) => showSnackbar(
        context: context,
        message: error.toString(),
        backgroundColor: Colors.red,
      ),
      loading: () => log("loading active survey"),
    );
  }

  void onTap() {
    context.pushNamed(routeSurveyFormPage, pathParameters: {
      "idMachine": widget.item.machineId,
      "id": widget.item.id,
    });
  }

  void init() {
    currentValue = widget.item.id == widget.activeSurveyId;
    setState(() {});
  }

  Future<void> onSelected(String value, SurveyModel item) async {
    final notifier = ref.read(surveyNotifier(item.machineId).notifier);
    switch (value) {
      case "delete":
        if (currentValue) {
          showSnackbar(
            context: context,
            message: "Cannot delete active survey",
            backgroundColor: Colors.red,
          );
          return;
        }

        final result = await notifier.delete(surveyId: item.id);
        result.onDelete.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Success Deleting Survey",
              backgroundColor: Colors.green,
            );

            // reload data survey & machine
            ref.invalidate(getAllMachineFutureProvider);
            ref.invalidate(surveyNotifier(item.machineId));
          },
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

        break;

      case "reset":
        final result = await notifier.reset(surveyId: item.id);
        result.onReset.when(
          data: (data) {
            if (data == null) return;
            showSnackbar(
              context: context,
              message: "Success Reset Survey with name ${item.name}",
              backgroundColor: Colors.green,
            );

            // reload data survey only
            ref.invalidate(surveyNotifier(item.machineId));
          },
          error: (error, stackTrace) => showSnackbar(
            context: context,
            message: error.toString(),
            backgroundColor: Colors.red,
          ),
          loading: () => showSnackbar(
            context: context,
            message: "Resetting...",
            backgroundColor: Colors.blue,
          ),
        );
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Card(
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.all(16),
            leading: CircleIndexNumber(
              radius: 30.0,
              index: widget.index,
            ),
            title: Text(
              item.name,
              style: headerFont.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                RowBody(
                  title: "Action",
                  content: item.action.valueStringReadable,
                ),
              ],
            ),
            trailing: Column(
              children: [
                Text(
                  currentValue ? "ON" : "OFF",
                  style: bodyFont.copyWith(fontSize: 10.0),
                ),
                Flexible(
                  child: Switch.adaptive(
                    value: currentValue,
                    onChanged: (value) => onChange(value),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton<String>(
              onSelected: (value) => onSelected(value, item),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: "reset",
                    child: Row(
                      children: [
                        Icon(Icons.refresh, color: Colors.blue),
                        SizedBox(width: 8.0),
                        Text("Reset", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "delete",
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8.0),
                        Text("Delete", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}
