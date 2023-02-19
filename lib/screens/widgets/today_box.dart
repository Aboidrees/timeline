import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';

class ToDayBox extends StatelessWidget {
  const ToDayBox({super.key});
  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat(DateFormat.WEEKDAY).format(today),
            style: TextStyle(fontFamily: 'FiraCode', fontSize: SizeConfig.defaultSize * 1.8, color: primaryColor),
          ),
          Text(
            today.day.toString().padLeft(2, '0'),
            style: TextStyle(fontFamily: 'FiraCode', fontSize: SizeConfig.defaultSize * 7.5, color: primaryColor),
          ),
          Text(
            '${months[0][today.month - 1]}, ${today.year}',
            style: TextStyle(fontFamily: 'FiraCode', fontSize: SizeConfig.defaultSize * 1.8, color: primaryColor),
          )
        ],
      ),
    );
  }
}
