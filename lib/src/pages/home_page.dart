import 'package:flutter/material.dart';
import 'package:wabot_utils/src/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

const _items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

class SMSPage extends StatelessWidget {
  const SMSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _items.length,
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      reverse: true,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = _items[index];

        return Card(
          margin: const EdgeInsets.only(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              contentPadding: const EdgeInsets.only(),
              leading: CircleAvatar(child: Text("${index + 1}")),
              title: const Text("089111222333"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Ini isi SMS $index"),
                ],
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [const Text("call")],
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [const Text("setting")],
        ),
      ),
    );
  }
}
