import 'package:flutter/material.dart';

import '../../../../model/model/machine/machine_model.dart';
import '../../../../utils/fonts.dart';

class AlertMachinesNotHaveGroup extends StatefulWidget {
  const AlertMachinesNotHaveGroup({
    Key? key,
    required this.machinesNotHaveGroup,
  }) : super(key: key);

  final List<MachineModel> machinesNotHaveGroup;

  @override
  State<AlertMachinesNotHaveGroup> createState() =>
      _AlertMachinesNotHaveGroupState();
}

class _AlertMachinesNotHaveGroupState extends State<AlertMachinesNotHaveGroup> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    if (widget.machinesNotHaveGroup.isEmpty) return const SizedBox.shrink();

    if (!isShow) return const SizedBox.shrink();

    return Stack(
      children: [
        Card(
          color: Colors.orange,
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Some Machine Not Have Group, Please Add Group First to Machine ${widget.machinesNotHaveGroup.map((e) => e.name).join(", ")}",
              style: bodyFont.copyWith(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 10,
          child: CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isShow = false;
                });
              },
              icon: const FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(Icons.close, color: Colors.black),
              )),
            ),
          ),
        )
      ],
    );
  }
}
