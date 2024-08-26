import 'package:flutter/material.dart';
import '../models/dog_breed.dart';

class DogDetailPage extends StatelessWidget {
  final DogBreed dogBreed;

  DogDetailPage({required this.dogBreed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dogBreed.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 5 / 3,
              child: Image.network(
                dogBreed.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('이미지를 불러올 수 없습니다.'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dogBreed.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    dogBreed.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  // ... (추가 정보)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}