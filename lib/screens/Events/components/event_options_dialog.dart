import 'package:flutter/material.dart';

class EventOptionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Event Options"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            iconColor: Colors.green,
            title: Text("Update"),
            textColor: Colors.green,
            onTap: () {
              // Handle update action
              Navigator.pop(context); // Close the dialog
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            iconColor: Colors.red,
            title: Text("Delete"),
            textColor: Colors.red,
            onTap: () {
              // Handle delete action
              Navigator.pop(context); // Close the dialog
            },
          ),
        ],
      ),
    );
  }
}
