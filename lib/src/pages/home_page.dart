import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:uuid/uuid.dart';
import 'package:wabot_utils/src/utils/event_channel.dart';

import '../injection.dart';
import '../model/model/sms_model.dart';
import '../utils/colors.dart';

final _telephony = Telephony.instance;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  StreamSubscription? _subscriptionCallReceiver;
  @override
  void initState() {
    super.initState();

    listenIncomingCall();

    _telephony.listenIncomingSms(
      listenInBackground: false,
      onNewMessage: (message) {
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
        const uuid = Uuid();
        final model = SMSModel(
          id: uuid.v4(),
          address: message.address ?? "",
          date: DateTime.fromMillisecondsSinceEpoch(message.date ?? 0),
          body: message.body ?? '',
        );
        ref.read(smsNotifier.notifier).insert(model);
      },
      // onBackgroundMessage: (message) {},
    );
  }

  @override
  void dispose() {
    _subscriptionCallReceiver?.cancel();
    super.dispose();
  }

  void listenIncomingCall() {
    Permission.phone.request().then((value) {
      if (value == PermissionStatus.granted) {
        _subscriptionCallReceiver =
            EventChannelUtils.listenIncomingCall().listen(
          (event) {
            log("event : $event");
          },
          onDone: () {
            log("onDone");
          },
          onError: (error) {
            log("error : $error");
          },
        );
      }
    });
  }

  int _selectedIndex = 0;

  final _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.sms_outlined, color: Colors.white.withOpacity(.5)),
      selectedIcon: const Icon(Icons.sms, color: Colors.white),
      label: "SMS",
    ),
    // NavigationDestination(
    //   icon: Icon(Icons.call_outlined, color: Colors.white.withOpacity(.5)),
    //   selectedIcon: const Icon(Icons.call, color: Colors.white),
    //   label: "Call",
    // ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined, color: Colors.white.withOpacity(.5)),
      selectedIcon: const Icon(Icons.settings, color: Colors.white),
      label: "Setting",
    ),
  ];

  final _pages = [
    const SMSPage(),
    // const CallPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectedIndex,
        destinations: _destinations,
        backgroundColor: primary,
        onDestinationSelected: (value) {
          setState(() => _selectedIndex = value);
        },
      ),
    );
  }
}

class SMSPage extends ConsumerWidget {
  const SMSPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(smsNotifier).items;
    return ListView.separated(
      itemCount: items.length,
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      reverse: true,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        final dateFormat = DateFormat("dd/MM/yyyy hh:mm:ss");
        return Card(
          margin: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(),
                  title: Text("${index + 1}. ${item.address}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16.0),
                      _RowBody(
                        title: "Content",
                        content: item.body,
                      ),
                      const SizedBox(height: 16.0),
                      _RowBody(
                        title: "Date",
                        content: dateFormat.format(item.date),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () async {
                    await ref.read(smsNotifier.notifier).delete(item.id);
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Hapus"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RowBody extends StatelessWidget {
  const _RowBody({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(title)),
        Expanded(flex: 2, child: Text(content)),
      ],
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("call")],
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("setting")],
        ),
      ),
    );
  }
}
