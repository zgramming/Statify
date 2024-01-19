// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../model/model/route/machine_form.route-extra.model.dart';
import '../../router.dart';

class ScanQRCodeSerialNumberPage extends StatefulWidget {
  const ScanQRCodeSerialNumberPage({
    Key? key,
    required this.isNewMachine,
  }) : super(key: key);
  final bool isNewMachine;

  @override
  State<ScanQRCodeSerialNumberPage> createState() =>
      _ScanQRCodeSerialNumberPageState();
}

class _ScanQRCodeSerialNumberPageState
    extends State<ScanQRCodeSerialNumberPage> {
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
  );

  bool isAlreadyScanned = false;

  void onDetect(BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) {
      return;
    }
    // After get barcode, back to previous page with barcode value and prevent duplicate scan
    final barcode = barcodes.first;
    final value = barcode.rawValue;

    if (isAlreadyScanned) {
      return;
    }

    setState(() {
      isAlreadyScanned = true;
    });

    if (widget.isNewMachine) {
      context.pop(value);
      context.pushNamed(
        routeMachineForm,
        pathParameters: {
          "id": "-1",
        },
        extra: MachineFormRouteExtraModel(scannedQRCodeValueNewMachine: value),
      );
    } else {
      // Only back to previous page with barcode value if not new machine
      context.pop(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code Serial Number'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: onDetect,
        errorBuilder: (ctx, exception, child) {
          return Center(
            child: Text("Error: ${exception.toString()}"),
          );
        },
      ),
    );
  }
}
