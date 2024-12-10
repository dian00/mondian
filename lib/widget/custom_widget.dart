import 'package:flutter/material.dart';
import 'package:mondian/provider/firestore_provider.dart';
import 'package:mondian/model/attendance_model.dart';

class CustomWidget {
  void showFloatingModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,	//	모달 뒤의 색
      context: context,
      builder: (context) {
        return Container(
          // width: 330,
          // height: 165,
          margin: const EdgeInsets.only(bottom: 50, left: 30, right: 30),	//	모달 밑의 띄어짐 정도
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _modalBar(context),	//	모달 상단의 바
                child
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _modalBar(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }


  void _showAttendanceDialog(BuildContext context) {
    // 초기화된 입력값들
    String? _selectedSide;
    final TextEditingController _attendeeNameController = TextEditingController();
    final TextEditingController _attendeeCountController = TextEditingController();
    bool _mealRequired = false;

    void _selectSide(String side) {
      // change ui
        _selectedSide = side;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('참석 의사 전달'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('어느 측에 참석하시나요?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSide == '신랑측'
                            ? Colors.pink
                            : Colors.grey[300],
                        foregroundColor: _selectedSide == '신랑측'
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () => _selectSide('신랑측'),
                      child: Text('신랑측'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSide == '신부측'
                            ? Colors.pink
                            : Colors.grey[300],
                        foregroundColor: _selectedSide == '신부측'
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () => _selectSide('신부측'),
                      child: Text('신부측'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _attendeeNameController,
                  decoration: InputDecoration(
                    labelText: '이름',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _attendeeCountController,
                  decoration: InputDecoration(
                    labelText: '참석 인원 (숫자)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _mealRequired,
                      onChanged: (value) {
                        // change ui
                          _mealRequired = value ?? false;
                      },
                    ),
                    Text('식사 여부'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Firestore 저장 로직
                if (_selectedSide == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('어느 측인지 선택해주세요.')),
                  );
                  return;
                }
                try {
                  await FirestoreProvider().createRSVPItem(
                    AttendanceModel(
                      side: _selectedSide!,
                      name: _attendeeNameController.text,
                      attendeesCount: int.tryParse(
                          _attendeeCountController.text) ?? 0,
                      mealRequired: _mealRequired,
                      timestamp: FirestoreProvider().serverTimestamp(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('참석 의사가 성공적으로 전달되었습니다!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('오류 발생: $e')),
                  );
                }
                Navigator.of(context).pop(); // 팝업 닫기
              },
              child: Text('제출'),
            ),
          ],
        );
      },
    );
  }
}