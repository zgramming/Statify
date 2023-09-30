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

class _PendingResponseTab extends ConsumerStatefulWidget {
  const _PendingResponseTab();

  @override
  ConsumerState<_PendingResponseTab> createState() =>
      _PendingResponseTabState();
}

class _PendingResponseTabState extends ConsumerState<_PendingResponseTab> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(logListenPendingResponseNotifier).logs;
    return ListView.separated(
      controller: _scrollController,
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final reverseIndex = items.length - index;
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 10,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$reverseIndex"),
              ),
            ),
          ),
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
        final reverseIndex = items.length - index;
        final item = items[index];
        final (type, message) = item;
        return ListTile(
          leading: CircleAvatar(
            radius: 10,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$reverseIndex"),
              ),
            ),
          ),
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
        final reverseIndex = items.length - index;
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 10,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$reverseIndex"),
              ),
            ),
          ),
          title: Text("Get Incoming Call from ${item.number}"),
          subtitle: Text("Phone State ${item.state}"),
        );
      },
    );
  }
}
