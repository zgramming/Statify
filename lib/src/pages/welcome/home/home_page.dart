import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';

import '../../../../main.dart';
import '../../../injection.dart';
import '../../../utils/flutter_local_notification.dart';
import '../../../utils/fonts.dart';
import '../../../view_model/custom_notifier/listen_pending_response_notifier.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void listenIncomingSMS() async {
    final telephony = Telephony.instance;

    telephony.listenIncomingSms(
      listenInBackground: true,
      onBackgroundMessage: onBackgroundMessage,
      onNewMessage: (message) async {
        FlutterLocalNotificationUtils().showNotification(
          title: "New Message from ${message.address ?? ""}",
          body: message.body ?? "",
          payload: message.body ?? "",
        );

        log("""
        id : ${message.id}\n
        address : ${message.address}\n
        body : ${message.body}\n
        date : ${message.date}\n
        dateSent : ${message.dateSent}\n
        read : ${message.read}\n
        seen : ${message.seen}\n
        serviceCenterAddress : ${message.serviceCenterAddress}\n
        status : ${message.status}\n
        subject : ${message.subject}\n
        subscriptionId : ${message.subscriptionId}\n
        threadId : ${message.threadId}\n
        type : ${message.type}\n
        """);

        final machines = ref.read(machineNotifier).onGetAll.valueOrNull ?? [];
        if (machines.isEmpty) return;

        final notifier = ref.read(incomingMessageNotifier.notifier);
        final result = await notifier.handlingIncomingMessage(
          machineId: machines.first.id,
          number: message.address ?? "",
          message: message.body ?? "",
        );

        log("Result : $result");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      listenIncomingSMS();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(machineNotifier.select((value) => value.onGetAll),
        (previous, next) {
      next.whenData((value) {
        // Trigger Listen to get pending response
        if (value.isEmpty) return;
        final firstMachine = value.first;
        ref.watch(listenPendingResponseNotifier(firstMachine.id));
      });
    });
    final machineAsync = ref.watch(machineNotifier).onGetAll;
    return machineAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Text(
              "No Machine",
              style: headerFont.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

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
            style: headerFont.copyWith(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
