import 'dart:convert';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentFiles extends StatefulWidget {
  const RecentFiles({Key? key}) : super(key: key);

  @override
  _RecentFilesState createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  List<Map<String, dynamic>> users = [];
  late List<bool> userVisibility;

  Future<void> fetchUsers() async {
    final url = Uri.parse('http://localhost:5000/api/user/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        users = List<Map<String, dynamic>>.from(responseData);
        userVisibility = List<bool>.filled(users.length, true);
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }
 
  Future<void> _blockUser(String userId) async {
    final url = Uri.parse('http://localhost:5000/api/user/$userId/ban');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        _showAlertDialog(responseData['message']);
      } else {
        var errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? errorData['message'];
        _showAlertDialog(errorMessage);
      }
    } catch (e) {
      _showAlertDialog('Exception during ban request: $e');
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Block User'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Utilisateurs",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Visibility')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: List<DataRow>.generate(users.length, (index) {
  return DataRow(cells: [
    DataCell(
      IconButton(
        icon: Icon(
          userVisibility[index]
              ? Icons.visibility
              : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            userVisibility[index] = !userVisibility[index];
          });
        },
      ),
    ),
    DataCell(
      Visibility(
        visible: userVisibility[index],
        child: Text(users[index]['username'] ?? 'N/A'),
      ),
    ),
    DataCell(
      Visibility(
        visible: userVisibility[index],
        child: Text(users[index]['address'] ?? 'N/A'),
      ),
    ),
    DataCell(
      Visibility(
        visible: userVisibility[index],
        child: Text(users[index]['email'] ?? 'N/A'),
      ),
    ),
    DataCell(
      Visibility(
        visible: userVisibility[index],
        child: Text(users[index]['role'] ?? 'N/A'),
      ),
    ),
    DataCell(
      Visibility(
        visible: userVisibility[index],
        child: IconButton(
          icon: Icon(Icons.block),
          color: Colors.red,
          onPressed: () {
            _blockUser(users[index]['_id']);
          },
        ),
      ),
    ),
  ]);
}),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}