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
    final machineByIdAsync = ref.watch(machineNotifier).onGetById;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Survey List", withBackButton: true),
          Builder(
            builder: (context) {
              return machineByIdAsync.when(
                data: (machine) => surveyAsync.when(
                  data: (items) {
                    final isEmpty = items?.isEmpty ?? true;
                    if (isEmpty) {
                      return const Center(
                        child: Text("No Survey"),
                      );
                    }
                    return Expanded(
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
                    );
                  },
                  error: (error, stackTrace) => AsyncErrorBuilder(
                    error: error.toString(),
                    onRetry: () =>
                        ref.invalidate(surveyNotifier(widget.idMachine)),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => AsyncErrorBuilder(
                  error: error.toString(),
                  onRetry: () => ref.invalidate(machineNotifier),
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
    if (!value) return;

    // update value
    final notifier = ref.read(surveyNotifier(widget.item.machineId).notifier);

    final result = await notifier.active(surveyId: widget.item.id);
    result.onActive.when(
      data: (data) {
        // Load machine by id
        // ref.read(machineNotifier.notifier).getById(
        //       machineId: widget.item.machineId,
        //     );
        ref.invalidate(machineNotifier);
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
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
    );
  }
}
