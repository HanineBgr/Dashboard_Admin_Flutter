import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:admin/screens/main/main_screen.dart';

class CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final TextEditingController categoryNameController = TextEditingController();
  TextEditingController _photoController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> saveCategory(BuildContext context) async {
    final String categoryName = categoryNameController.text;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:5000/api/categories'),
      );

      // Set the Content-Type header
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add other fields
      request.fields['NomCategorie'] = categoryName;
      request.fields['NbreTotalArticles'] = '0';

      // Add file field
      if (_imageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'PhotoCategorie',
            _imageBytes!,
            filename: 'photo.jpg',
          ),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Category created successfully!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        print('Failed to create category: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _getImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _imageBytes != null
                          ? Image.memory(
                              _imageBytes!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text('Tap to pick an image'),
                            ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: categoryNameController,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      hintText: 'Enter category name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        saveCategory(context);
                      },
                      child: Text('Save Category'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
