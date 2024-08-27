import 'package:flutter/material.dart';
import '../models/dog_breed.dart';
import '../screens/detail_screen.dart';

class DogBreedCard extends StatelessWidget {
  final DogBreed dogBreed;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onDeletePressed;

  DogBreedCard({
    required this.dogBreed,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              dogBreed.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('이미지를 불러올 수 없습니다.'));
              },
            ),
          ),
        ),
        title: Text(dogBreed.name),
        subtitle: Text(dogBreed.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: onFavoritePressed,
            ),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogDetailPage(dogBreed: dogBreed),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}