import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GestBookItem {
  final String name;
  final String message;
  final String password;

  GestBookItem({
    required this.name,
    required this.message,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'password': password,
    };
  }

  static GestBookItem fromSnapshot(Map<String, dynamic> doc) {
    return GestBookItem(
      name: doc['name'],
      message: doc['message'],
      password: doc['password'],
    );
  }
}

class GestBookListView extends StatefulWidget {
  final List<GestBookItem> gestBookItems;
  final void Function(GestBookItem item) onRemoveItem;
  final void Function(GestBookItem item, String password) onEditItem;

  GestBookListView({
    required this.gestBookItems,
    required this.onRemoveItem,
    required this.onEditItem,
  });

  @override
  _GestBookListViewState createState() => _GestBookListViewState();
}

class _GestBookListViewState extends State<GestBookListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.gestBookItems.length,
      itemBuilder: (context, index) {
        final item = widget.gestBookItems[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.message),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onRemoveItem(item);
            },
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
    );
  }
}