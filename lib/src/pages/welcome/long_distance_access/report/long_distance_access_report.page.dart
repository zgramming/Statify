import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/async_error_builder.dart';

class LongDistanceAccessReportPage extends ConsumerStatefulWidget {
  const LongDistanceAccessReportPage({
    super.key,
    required this.idMachine,
  });
  final String idMachine;

  @override
  ConsumerState<LongDistanceAccessReportPage> createState() =>
      _LongDistanceAccessReportPageState();
}

class _LongDistanceAccessReportPageState
    extends ConsumerState<LongDistanceAccessReportPage> {
  Future<void> init() async {
    final machine =
        ref.read(CustomProvider.getMachineByIdProvider(widget.idMachine));
    if (machine == null) return;
    // const nameFile = "machine-results/6548fa72c27f4.txt";
    final nameFile = machine.result;
    final notifier = ref.read(machineNotifier.notifier);
    await notifier.getResults(nameFile ?? "-");
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    final machineResultsAsync = ref
        .watch(machineNotifier.select((value) => value.onGetResults))
        .unwrapPrevious();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          title: const Text('Report'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Builder(
                  builder: (context) {
                    return machineResultsAsync.when(
                      data: (results) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('IMSI')),
                          ],
                          rows: [
                            for (int i = 0; i < (results?.length ?? 0); i++)
                              DataRow(
                                cells: [
                                  DataCell(Text("${i + 1}")),
                                  DataCell(Text(results?[i] ?? "")),
                                ],
                              )
                            // for (final result in (results ?? []))
                            //   DataRow(
                            //     cells: [
                            //       DataCell(Text(result)),
                            //       DataCell(Text(result)),
                            //     ],
                            //   ),
                          ],
                        ),
                      ),
                      error: (error, stackTrace) => AsyncErrorBuilder(
                        error: error.toString(),
                        onRetry: () =>
                            ref.invalidate(getAllMachineFutureProvider),
                      ),
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
