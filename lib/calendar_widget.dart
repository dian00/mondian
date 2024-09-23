import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime dDay;
  const CalendarWidget({super.key, required this.dDay});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dDay);
    final day = difference.inDays;
    final hour = difference.inHours - (day * 24);
    final min  = difference.inMinutes - (day * 24 * 60) - (hour * 60);
    final sec = difference.inSeconds - (difference.inMinutes * 60) - (hour * 60 * 60);
    return Column(
      children: [
        TableCalendar(
            headerStyle: const HeaderStyle(
                titleCentered: true,
                leftChevronVisible: false,
                rightChevronVisible: false,
                headerMargin: const EdgeInsets.only(bottom: 10),
                formatButtonShowsNext: false, formatButtonVisible: false),
            rangeStartDay: dDay,
            focusedDay: dDay,
            firstDay: DateTime(dDay.year, dDay.month, 1),
            lastDay: DateTime(dDay.year, dDay.month + 1, 0), // 매월 0일이 직전 달의 마지막 날로 표기 됨
        ),
        // 초단위로 업데이트하는 블록으로 따로 뺄지 고민 중
        Text(
          "D $day "// + " :  H $hour : M $min"
        )
      ],
    );
  }
}

