import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../widgets/custom_appbar.dart';

class SurveySummaryPage extends ConsumerStatefulWidget {
  const SurveySummaryPage({
    super.key,
    required this.surveyId,
    required this.machineId,
  });
  final String surveyId;
  final String machineId;

  @override
  ConsumerState<SurveySummaryPage> createState() => _SurveySummaryPageState();
}

class _SurveySummaryPageState extends ConsumerState<SurveySummaryPage> {
  Future<void> init() async {
    final notifier = ref.read(surveyNotifier(widget.machineId).notifier);
    await notifier.getVotingSummary(surveyId: widget.surveyId);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
  }

  @override
  Widget build(BuildContext context) {
    final votingSummaryAsync = ref
        .watch(surveyNotifier(widget.machineId)
            .select((value) => value.onGetVotingSummary))
        .unwrapPrevious();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(
            title: "Survey Summary",
            withBackButton: true,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                return votingSummaryAsync.when(
                  data: (votingSummary) {
                    if (votingSummary == null || votingSummary.isEmpty) {
                      return const Center(child: Text("No data"));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: votingSummary.length,
                      itemBuilder: (context, index) {
                        final item = votingSummary[index];
                        return Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                const Text("Receive :"),
                                const SizedBox(width: 8),
                                Text(item.key),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                const Text("Total :"),
                                const SizedBox(width: 8),
                                Text(item.count.toString()),
                              ],
                            ),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  onPressed: () async {},
                                  icon: const Icon(Icons.download),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error: (e, s) => Center(child: Text(e.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
