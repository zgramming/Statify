import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/custom_notifier/request_permission_notifier.dart';
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
  // StreamSubscription? _subscriptionCallReceiver;

  // void listenIncomingCall() {
  //   _subscriptionCallReceiver =
  //       EventChannelUtils.listenIncomingCall().listen((event) {
  //     final phoneNumber = event.number;
  //     if (phoneNumber != null && event.state == "RINGING") {
  //       final id = const Uuid().v4();
  //       final model = PhoneModel(
  //         id: id,
  //         date: DateTime.now(),
  //         number: phoneNumber,
  //       );
  //       ref.read(phoneNotifier.notifier).insert(model);
  //       log("message : $event");
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _subscriptionCallReceiver?.cancel();
  //   super.dispose();
  // }

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
