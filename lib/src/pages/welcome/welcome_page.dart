import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telephony/telephony.dart';
import 'package:uuid/uuid.dart';

import '../../../main.dart';
import '../../injection.dart';
import '../../model/datasource/phone_local_datasource.dart';
import '../../model/model/phone_model.dart';
import '../../model/model/sms_model.dart';
import '../../utils/event_channel.dart';
import '../../utils/functions.dart';
import 'home/home_page.dart';
import 'long_distance_access/long_distance_access_page.dart';
import 'setting/setting_page.dart';
import 'statistic/statistic_page.dart';
import 'whatsapp/whatsapp_page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
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

  void listenIncomingSMS() {
    final telephony = Telephony.instance;

    telephony.listenIncomingSms(
      listenInBackground: true,
      onBackgroundMessage: onBackgroundMessage,
      onNewMessage: (message) {
        showSnackbar(
          context: context,
          message: "New Message Received",
          backgroundColor: Colors.green,
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
  void initState() {
    super.initState();
    // listenIncomingCall();
    listenIncomingSMS();
  }

  @override
  void dispose() {
    _subscriptionCallReceiver?.cancel();
    super.dispose();
  }

  int _selectedIndex = 0;

  final _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined, color: Colors.grey.withOpacity(.5)),
      selectedIcon: const Icon(Icons.home, color: Colors.white),
      label: "Home",
    ),
    NavigationDestination(
      icon: Icon(Icons.phone_outlined, color: Colors.grey.withOpacity(.5)),
      selectedIcon: const Icon(Icons.phone, color: Colors.white),
      label: "Whatsapp",
    ),
    NavigationDestination(
      icon: Icon(Icons.bar_chart_outlined, color: Colors.grey.withOpacity(.5)),
      selectedIcon: const Icon(Icons.bar_chart, color: Colors.white),
      label: "Statistic",
    ),
    NavigationDestination(
      icon: Icon(
        Icons.accessibility_new_outlined,
        color: Colors.grey.withOpacity(.5),
      ),
      selectedIcon: const Icon(Icons.accessibility_new, color: Colors.white),
      label: "L.D.A",
    ),
    NavigationDestination(
      icon: Icon(
        Icons.settings_outlined,
        color: Colors.grey.withOpacity(.5),
      ),
      selectedIcon: const Icon(Icons.settings, color: Colors.white),
      label: "Setting",
    ),

    // NavigationDestination(
    //   icon: Icon(
    //     Icons.device_hub_outlined,
    //     color: Colors.grey.withOpacity(.5),
    //   ),
    //   selectedIcon: const Icon(Icons.device_hub, color: Colors.white),
    //   label: "Machine",
    // ),
  ];

  final _pages = [
    const HomePage(),
    const WhatsAppPage(),
    const StatisticPage(),
    const LongDistanceAccessPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_) {
        final permissionFuture = ref.watch(checkPermissionNotifier);

        return permissionFuture.when(
          data: (_) => IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
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
        selectedIndex: _selectedIndex,
        destinations: _destinations,
        onDestinationSelected: (value) {
          setState(() => _selectedIndex = value);
        },
      ),
    );
  }
}
