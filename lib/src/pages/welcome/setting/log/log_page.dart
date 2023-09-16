import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
            ),
            labelColor: Colors.blue,
            tabs: const [
              Tab(text: "Pending Response"),
              Tab(text: "Incoming Message"),
              Tab(text: "Incoming Call"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                _PendingResponseTab(),
                _IncomingMessageTab(),
                _IncomingCallTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingResponseTab extends ConsumerWidget {
  const _PendingResponseTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(logListenPendingResponseNotifier).logs;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          subtitle: Text(item ?? ""),
        );
      },
    );
  }
}

class _IncomingMessageTab extends ConsumerWidget {
  const _IncomingMessageTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(logIncomingMessageNotifier).logs;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final (type, message) = item;
        return ListTile(
          title: Text(type),
          subtitle: Text(message),
        );
      },
    );
  }
}

class _IncomingCallTab extends ConsumerWidget {
  const _IncomingCallTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(logIncomingCallNotifier).items;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text("Get Incoming Call from ${item.number}"),
          subtitle: Text("Phone State ${item.state}"),
        );
      },
    );
  }
}
