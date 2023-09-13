import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../injection.dart';
import '../../router.dart';

class AsyncErrorBuilder extends ConsumerStatefulWidget {
  const AsyncErrorBuilder({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final String error;
  final void Function() onRetry;

  @override
  ConsumerState<AsyncErrorBuilder> createState() => _AsyncErrorBuilderState();
}

class _AsyncErrorBuilderState extends ConsumerState<AsyncErrorBuilder> {
  Future<void> onLogout() async {
    final notifier = ref.read(authenticationNotifier.notifier);
    await notifier.logout();
    if (mounted) {
      context.goNamed(routeLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUnauthenticated =
        widget.error.toLowerCase().contains('unauthenticated');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.error.toString()),
          const SizedBox(height: 16.0),
          if (isUnauthenticated) ...[
            ElevatedButton(
              onPressed: onLogout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Login again"),
            ),
          ] else ...[
            ElevatedButton(
              onPressed: widget.onRetry,
              child: const Text("Retry again"),
            ),
          ],
        ],
      ),
    );
  }
}
