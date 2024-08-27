import 'package:flutter/material.dart';
import '../models/dog_breed.dart';

class AddDogBreedScreen extends StatefulWidget {
  @override
  _AddDogBreedScreenState createState() => _AddDogBreedScreenState();
}

class _AddDogBreedScreenState extends State<AddDogBreedScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? description;
  String? imageUrl;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newDogBreed = DogBreed(
        name: name!,
        description: description!,
        imageUrl: imageUrl!,
      );
      Navigator.pop(context, newDogBreed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('새로 등록할 강아지 친구')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: '견종 이름'),
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              onSaved: (value) => name = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '설명'),
              validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              onSaved: (value) => description = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '사진 이미지 url'),
              validator: (value) => value!.isEmpty ? 'Please enter an image URL' : null,
              onSaved: (value) => imageUrl = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Add Dog Breed'),
            ),
          ],
        ),
      ),
    );
  }
}