import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/survey/survey.model.dart';
import '../../../../router.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/functions.dart';
import '../../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/async_error_builder.dart';
import '../../../widgets/circle_index_number.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/row_body.dart';

class SurveyPage extends ConsumerStatefulWidget {
  const SurveyPage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  ConsumerState<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends ConsumerState<SurveyPage> {
  Future<void> init() async {
    final survey = ref.read(surveyNotifier(widget.idMachine).notifier).getAll();
    final machineById =
        ref.read(machineNotifier.notifier).getById(machineId: widget.idMachine);
    await machineById;
    await survey;
  }

  Future<void> onAdd() async {
    context.pushNamed(
      routeSurveyFormPage,
      pathParameters: {"idMachine": widget.idMachine, 'id': '-1'},
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final surveyAsync = ref.watch(surveyNotifier(widget.idMachine)).onGetAll;
    final machine = ref.watch(getMachineByIdProvider(widget.idMachine));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Survey List", withBackButton: true),
          Builder(
            builder: (context) {
              return surveyAsync.when(
                data: (items) {
                  final isEmpty = items?.isEmpty ?? true;
                  if (isEmpty) {
                    return const Center(
                      child: Text("No Survey"),
                    );
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        ref.invalidate(surveyNotifier(widget.idMachine));
                        return Future.value();
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        itemCount: items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = items![index];
                          return _SurveyItem(
                            index: index,
                            item: item,
                            activeSurveyId: machine?.activeSurveyId,
                          );
                        },
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => AsyncErrorBuilder(
                  error: error.toString(),
                  onRetry: () =>
                      ref.invalidate(surveyNotifier(widget.idMachine)),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAdd,
        icon: const Icon(Icons.add),
        label: const Text("Add Survey"),
      ),
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

        // invalidate survey & machine
        ref.invalidate(getAllMachineFutureProvider);
        ref.invalidate(surveyNotifier(widget.item.machineId));

        // ref.invalidate(surveyNotifier(widget.item.machineId));

        // Invalidate machine
        // ref.invalidate(getAllMachineFutureProvider);

        // Load machine by id
        // ref.read(machineNotifier.notifier).getById(
        //       machineId: widget.item.machineId,
        //     );
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
