import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../../model/model/machine/machine_model.dart';
import '../../../../router.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/styles.dart';
import '../../../../view_model/custom_provider/custom_provider.dart';
import '../../../widgets/async_error_builder.dart';

class LongDistanceAccessHomePage extends ConsumerWidget {
  const LongDistanceAccessHomePage({
    Key? key,
    required this.idMachine,
  }) : super(key: key);
  final String idMachine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final machine = ref.watch(CustomProvider.getMachineByIdProvider(idMachine));
    if (machine == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      fit: StackFit.expand,
      children: [_Content(machine: machine), const _ButtonActions()],
    );
  }
}

class _Content extends ConsumerWidget {
  final MachineModel machine;
  const _Content({
    required this.machine,
  });

  static void _onTap({
    required BuildContext context,
    required MachineModel machine,
    required int index,
  }) {
    context.pushNamed(routeMachineLongDistanceAccessHomeForm, pathParameters: {
      "idMachine": machine.id,
      "index": "$index",
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        return SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: height),
            child: Stack(
              children: [
                SizedBox(
                  height: height * 0.25,
                  child: const _BackgroundImage(),
                ),
                Container(
                  margin: EdgeInsets.only(top: height * 0.22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _ContentStatus(),
                      const SizedBox(height: 20),
                      ListView(
                        padding: const EdgeInsets.only(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _ContentListItem(
                            index: 1,
                            sender: machine.config?.sender1,
                            sms: machine.config?.sms1,
                            onTap: () => _onTap(
                              context: context,
                              machine: machine,
                              index: 1,
                            ),
                          ),
                          _ContentListItem(
                            index: 2,
                            sender: machine.config?.sender2,
                            sms: machine.config?.sms2,
                            onTap: () => _onTap(
                              context: context,
                              machine: machine,
                              index: 2,
                            ),
                          ),
                          _ContentListItem(
                            index: 3,
                            sender: machine.config?.sender3,
                            sms: machine.config?.sms3,
                            onTap: () => _onTap(
                              context: context,
                              machine: machine,
                              index: 3,
                            ),
                          ),
                          _ContentListItem(
                            index: 4,
                            sender: machine.config?.sender4,
                            sms: machine.config?.sms4,
                            onTap: () => _onTap(
                              context: context,
                              machine: machine,
                              index: 4,
                            ),
                          ),
                          _ContentListItem(
                            index: 5,
                            sender: machine.config?.sender5,
                            sms: machine.config?.sms5,
                            onTap: () => _onTap(
                              context: context,
                              machine: machine,
                              index: 5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.5),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ContentListItem extends StatelessWidget {
  const _ContentListItem({
    Key? key,
    required this.index,
    this.sender,
    this.sms,
    // ignore: unused_element
    this.onTap,
  }) : super(key: key);

  final int index;
  final String? sender;
  final String? sms;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (sender == null || sms == null) {
      return const SizedBox();
    }

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Text("$index"),
      ),
      title: Text(
        "$sender",
        style: bodyFont.copyWith(
          fontSize: 14.0,
        ),
      ),
      subtitle: Text(
        "$sms",
        style: bodyFontBold.copyWith(
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class _ContentStatus extends StatelessWidget {
  const _ContentStatus();

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ContentStatusItem(title: "Sent"),
            _ContentStatusItem(title: "Status"),
            _ContentStatusItem(title: "Task"),
          ],
        ),
      ),
    );
  }
}

class _ContentStatusItem extends StatelessWidget {
  const _ContentStatusItem({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: bodyFont.copyWith(
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 5.0,
            children: [
              Card(
                color: Colors.blue[400],
                margin: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Working",
                    style: bodyFont.copyWith(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.blue[400],
                margin: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Stopped",
                    style: bodyFont.copyWith(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ButtonActions extends StatelessWidget {
  const _ButtonActions();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Device is not connected",
                  style: bodyFontBold.copyWith(
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: elevatedButtonStyle(),
                    child: const Text("Start"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: elevatedButtonStyle(),
                    child: const Text("Stop"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: elevatedButtonStyle(),
                    child: const Text("Reset"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundImage extends ConsumerWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoAsync = ref.watch(logoNotifier).onGetFirstLogo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: kGradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Builder(
              builder: (context) {
                return logoAsync.when(
                  data: (data) {
                    if (data == null) {
                      return Image.asset(
                        kURLLogoHitech,
                        width: 100,
                        height: 100,
                      );
                    }

                    return Image.memory(
                      data.logo!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    );
                  },
                  error: (error, stackTrace) => AsyncErrorBuilder(
                    error: error.toString(),
                    onRetry: () {
                      ref.invalidate(logoNotifier);
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
