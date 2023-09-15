import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/incoming_call_model.dart';
import '../../../model/model/machine/machine_model.dart';
import '../../../utils/event_channel.dart';
import '../../../utils/fonts.dart';
import '../../../view_model/custom_notifier/listen_delivered_message.notifier.dart';
import '../../../view_model/custom_notifier/listen_incoming_message.notifier.dart';
import '../../../view_model/custom_notifier/listen_pending_response_notifier.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  StreamSubscription<IncomingCallModel>? _subscriptionIncomingCall;

  final eventChannelUtils = EventChannelUtils();

  void listenIncomingCallV2() async {
    final logNotifier = ref.read(logIncomingCallNotifier.notifier);
    _subscriptionIncomingCall =
        EventChannelUtils.listenIncomingCall().listen((event) {
      logNotifier.addLog(event);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      listenIncomingCallV2();
    });
  }

  @override
  void dispose() {
    _subscriptionIncomingCall?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamListenIncomingMessageAsync =
        ref.watch(listenIncomingMessageNotifier);
    final streamListenDeliveredMessageAsync =
        ref.watch(listenDeliveredMessageNotifier);
    final machines = ref.watch(machineNotifier).onGetAll.valueOrNull ?? [];

    if (machines.isEmpty) {
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
    return streamListenIncomingMessageAsync.when(
      data: (_) {
        return streamListenDeliveredMessageAsync.when(
          data: (_) => Column(
            children: [
              const CustomAppbar(title: "Home"),
              // ElevatedButton(
              //   onPressed: () async {
              //     // Get file from folder asset
              //     // final file = await rootBundle.load(kURLLogoHitech);
              //     // final fileBytes = file.buffer.asUint8List();

              //     final methodChannel = MethodChannelUtils();
              //     const number = "085159412440";
              //     // const message =
              //     //     "Pentingnya menjaga keseimbangan dalam kehidupan tidak dapat diabaikan. Kita harus mengatur waktu dengan bijak antara pekerjaan, keluarga";
              //     const message =
              //         "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas ipsa nemo aspernatur asperiores! Error ipsa sunt voluptatibus ex iusto et perferendis aspernatur corrupti, enim unde. Delectus voluptate quisquam quas possimus?";
              //     const model = SendSMSModel(
              //       phoneNumber: number,
              //       message: message,
              //       simSlot: 0,
              //       surveyResponseId: "",
              //     );
              //     await methodChannel.sendSMS(model);
              //   },
              //   child: const Text("Send SMS"),
              // ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(machineNotifier);
                  },
                  child: ListView.separated(
                    itemCount: machines.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16.0),
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = machines[index];
                      return _MachineItem(item: item, index: index);
                    },
                  ),
                ),
              ),
            ],
          ),
          error: (error, stackTrace) => AsyncErrorBuilder(
            error: error.toString(),
            onRetry: () => ref.invalidate(listenIncomingMessageNotifier),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, stackTrace) => AsyncErrorBuilder(
        error: error.toString(),
        onRetry: () => ref.invalidate(listenIncomingMessageNotifier),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _MachineItem extends ConsumerWidget {
  const _MachineItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final MachineModel item;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(listenPendingResponseNotifier(item.id), (previous, next) {
      next.whenData((value) {
        if (value == null) return;

        // Add Log to Log Listen Pending Response
        ref.read(logListenPendingResponseNotifier.notifier).addLog(value);
      });
    });

    final streamAsync = ref.watch(listenPendingResponseNotifier(item.id));
    return streamAsync.when(
      data: (data) => Card(
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
      ),
      error: (error, stackTrace) => AsyncErrorBuilder(
        error: error.toString(),
        onRetry: () => ref.invalidate(listenPendingResponseNotifier(item.id)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
