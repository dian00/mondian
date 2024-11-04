import 'dart:async';

import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime dDay;
  const CountdownWidget({super.key, required this.dDay});

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.dDay.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = widget.dDay.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final months = _duration.inDays ~/ 30;
    final days = _duration.inDays;
    final hours = _duration.inHours % 24;
    final minutes = _duration.inMinutes % 60;
    final seconds = _duration.inSeconds % 60;

    return Column(
      children: [
        Text("D $days"),
        Text("M: $months D:$days H $hours : M $minutes : S $seconds"),
      ],
    );
  }
}
class DateDifferenceCardWidget extends StatefulWidget {
  final DateTime targetDate;

  DateDifferenceCardWidget({required this.targetDate});

  @override
  _DateDifferenceCardWidgetState createState() => _DateDifferenceCardWidgetState();
}

class _DateDifferenceCardWidgetState extends State<DateDifferenceCardWidget> {
  late Duration _difference;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _calculateDifference();
    _startTimer();
  }

  void _calculateDifference() {
    final now = DateTime.now();
    setState(() {
      _difference = widget.targetDate.difference(now);
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calculateDifference();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    super.dispose();
  }

  Widget _buildTimeCard(String label, String value) {
    return Card(
      margin: EdgeInsets.all(3.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
        child: Container(
          width: 50,
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final months = _difference.inDays ~/ 30;
    final days = _difference.inDays % 30;
    final hours = _difference.inHours % 24;
    final minutes = _difference.inMinutes % 60;
    final seconds = _difference.inSeconds % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimeCard('Months', months.toString()),
            _buildTimeCard('Days', days.toString()),
            _buildTimeCard('Hours', hours.toString().padLeft(2, '0')),
            _buildTimeCard('Minutes', minutes.toString().padLeft(2, '0')),
            _buildTimeCard('Seconds', seconds.toString().padLeft(2, '0')),
          ],
        ),
      ],
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final int year = 2025;
  final int month = 2;

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int firstWeekday = firstDayOfMonth.weekday;

    // Calculate the total grid cells needed (to align with the starting weekday)
    int totalCells = daysInMonth + firstWeekday - 1;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "February 2025",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            int dayNumber = index - firstWeekday + 2;

            // Empty cells before the first day of the month
            if (index < firstWeekday - 1) {
              return Container();
            }

            return Container(
              decoration: dayNumber == 8 ? BoxDecoration(
                color: Colors.pink[50],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.pinkAccent, width: 2),
              ) : null,
              child: Center(
                child: Text(
                  "$dayNumber",
                  style: TextStyle(
                    color: dayNumber == 8 ? Colors.pinkAccent : Colors.black,
                    fontWeight: dayNumber == 8 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class InstagramCalendarWidget extends StatelessWidget {
  final int year = 2025;
  final int month = 2;

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int firstWeekday = firstDayOfMonth.weekday;

    // Calculate total grid cells needed to align the starting weekday
    int totalCells = daysInMonth + firstWeekday - 1;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "February 2025",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            int dayNumber = index - firstWeekday + 2;

            // Empty cells before the first day of the month
            if (index < firstWeekday - 1) {
              return Container();
            }

            return GestureDetector(
              onTap: () {
                // Action when a date is tapped
                print("Tapped on $dayNumber");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: dayNumber == 8
                      ? Border.all(color: Colors.pinkAccent, width: 2)
                      : null,
                ),
                child: Center(
                  child: Text(
                    "$dayNumber",
                    style: TextStyle(
                      fontSize: 16,
                      color: dayNumber == 8 ? Colors.pinkAccent : Colors.black,
                      fontWeight: dayNumber == 8 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}