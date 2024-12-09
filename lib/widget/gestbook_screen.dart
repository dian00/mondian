import 'package:flutter/material.dart';

class GuestbookScreen extends StatefulWidget {
  @override
  _GuestbookScreenState createState() => _GuestbookScreenState();
}

class _GuestbookScreenState extends State<GuestbookScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _guestbookEntries = [];

  void _addEntry() {
    if (_nameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
      setState(() {
        _guestbookEntries.add({
          'name': _nameController.text,
          'message': _messageController.text,
        });
      });
      _nameController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
            itemCount: _guestbookEntries.length,
            itemBuilder: (context, index) {
              final entry = _guestbookEntries[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  title: Text(entry['name'] ?? ''),
                  subtitle: Text(entry['message'] ?? ''),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
