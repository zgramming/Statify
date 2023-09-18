// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../utils/fonts.dart';
import '../../../widgets/circle_index_number.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/row_body.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppbar(title: "Survey List"),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return _SurveyItem(index: index);
            },
          )),
        ],
      ),
    );
  }
}

class _SurveyItem extends StatefulWidget {
  const _SurveyItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<_SurveyItem> createState() => _SurveyItemState();
}

class _SurveyItemState extends State<_SurveyItem> {
  bool currentValue = false;

  Future<void> onChange(bool value) async {
    setState(() {
      currentValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleIndexNumber(
          radius: 30.0,
          index: widget.index,
        ),
        title: Text(
          "Survey ${widget.index}",
          style: headerFont.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            RowBody(
              title: "Action",
              content: "Whatsapp + SMS",
            ),
          ],
        ),
        trailing: Column(
          children: [
            Text(
              currentValue ? "ON" : "OFF",
              style: bodyFont.copyWith(fontSize: 10.0),
            ),
            Flexible(
              child: Switch.adaptive(
                value: currentValue,
                onChanged: onChange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
