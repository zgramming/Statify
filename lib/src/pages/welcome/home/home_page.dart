import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/fonts.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machinesAsync = ref.watch(machineNotifier).onGetAll;

    return machinesAsync.when(
      data: (items) {
        return Column(
          children: [
            const CustomAppbar(title: "Home"),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(machineNotifier);
                },
                child: ListView.separated(
                  itemCount: items.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Card(
                      margin: const EdgeInsets.only(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${index + 1}. ${item.number}",
                                style: headerFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  RowBody(
                                    title: "SMS Sent",
                                    content: "${item.send}",
                                    titleFlex: 2,
                                    contentFlex: 1,
                                  ),
                                  const SizedBox(height: 8.0),
                                  RowBody(
                                    title: "Total Reply",
                                    content: "${item.replied}",
                                    titleFlex: 2,
                                    contentFlex: 1,
                                  ),
                                  const SizedBox(height: 8.0),
                                  const RowBody(
                                    title: "Total Finished",
                                    content: "0",
                                    titleFlex: 2,
                                    contentFlex: 1,
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
