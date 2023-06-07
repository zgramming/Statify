import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';
import 'package:uuid/uuid.dart';
import 'package:wabot_utils/src/model/datasource/phone_local_datasource.dart';
import 'package:wabot_utils/src/model/model/phone_model.dart';

import '../../injection.dart';
import '../../model/model/sms_model.dart';
import '../../utils/colors.dart';
import '../../utils/event_channel.dart';
import 'call/call_page.dart';
import 'setting/setting_page.dart';
import 'sms/sms_page.dart';

final _telephony = Telephony.instance;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  StreamSubscription? _subscriptionCallReceiver;

  void listenIncomingCall() {
    _subscriptionCallReceiver =
        EventChannelUtils.listenIncomingCall().listen((event) {
      final phoneNumber = event.number;
      if (phoneNumber != null && event.state == "RINGING") {
        final id = const Uuid().v4();
        final model = PhoneModel(
          id: id,
          date: DateTime.now(),
          number: phoneNumber,
        );
        ref.read(phoneNotifier.notifier).insert(model);
        log("message : $event");
      }
    });
  }

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
    );
  }

  @override
  void dispose() {
    _subscriptionCallReceiver?.cancel();
    super.dispose();
  }

  int _selectedIndex = 0;

  final _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.sms_outlined, color: Colors.white.withOpacity(.5)),
      selectedIcon: const Icon(Icons.sms, color: Colors.white),
      label: "SMS",
    ),
    NavigationDestination(
      icon: Icon(Icons.call_outlined, color: Colors.white.withOpacity(.5)),
      selectedIcon: const Icon(Icons.call, color: Colors.white),
      label: "Call",
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined, color: Colors.white.withOpacity(.5)),
      selectedIcon: const Icon(Icons.settings, color: Colors.white),
      label: "Setting",
    ),
  ];

  final _pages = [
    const SMSPage(),
    const CallPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_) {
        final permissionFuture = ref.watch(checkPermissionNotifier);

        return permissionFuture.when(
          data: (_) => SafeArea(child: _pages[_selectedIndex]),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(error.toString()),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    ref.invalidate(checkPermissionNotifier);
                  },
                  child: const Text("Coba Lagi"),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      }),
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
