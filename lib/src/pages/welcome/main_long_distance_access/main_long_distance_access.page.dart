import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/fonts.dart';
import '../../../utils/styles.dart';
import '../../widgets/async_error_builder.dart';

class MainLongDistanceAccessPage extends StatelessWidget {
  const MainLongDistanceAccessPage({super.key});

  get kColorWhite => null;

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [_Content(), _ButtonActions()],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
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
                      ListView.separated(
                        padding: const EdgeInsets.only(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "Device ${index + 1}",
                              style: bodyFont.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                            subtitle: Text(
                              "Device ${index + 1}",
                              style: bodyFont.copyWith(
                                fontSize: 12.0,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          );
                        },
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

class _ContentStatus extends StatelessWidget {
  const _ContentStatus();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (index) => Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sent",
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
            ),
          ),
        ),
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
