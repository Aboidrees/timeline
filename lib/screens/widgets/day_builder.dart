import 'package:flutter/material.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';

class DayBuilderWidget extends StatelessWidget {
  const DayBuilderWidget({super.key, required this.date, required this.dayType});

  final DateTime date;
  final String dayType;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var dynamicSize = SizeConfig.screenWidth / 10;

    return Container(
      alignment: Alignment.center,
      width: dynamicSize,
      height: dynamicSize,
      child: Text(
        date.day.toString(),
        textWidthBasis: TextWidthBasis.longestLine,
        style: TextStyle(
          fontSize: SizeConfig.defaultSize * 1.6,
          fontFamily: 'FiraCode',
          color: dayColors[dayType],
          fontWeight: ['selected', 'today'].contains(dayType) ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
