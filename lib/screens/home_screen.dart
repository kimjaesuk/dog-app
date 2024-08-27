import 'package:flutter/material.dart';
import '../models/dog_breed.dart';
import '../widgets/dog_breed_card.dart';
import '../data/dog_breeds_data.dart';
import 'add_dog_breed_screen.dart';

class DogBreedsHomePage extends StatefulWidget {
  @override
  _DogBreedsHomePageState createState() => _DogBreedsHomePageState();
}

class _DogBreedsHomePageState extends State<DogBreedsHomePage> {
  int _selectedIndex = 0;
  List<DogBreed> favorites = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleFavorite(DogBreed dogBreed) {
    setState(() {
      if (favorites.contains(dogBreed)) {
        favorites.remove(dogBreed);
      } else {
        favorites.add(dogBreed);
      }
    });
  }

  void _addNewDogBreed() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDogBreedScreen()),
    );

    if (result != null && result is DogBreed) {
      setState(() {
        dogBreeds.add(result);
      });
    }
  }

  Future<void> _deleteDogBreed(DogBreed dogBreed) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('삭제 확인'),
        content: Text('${dogBreed.name}를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            child: Text('취소'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text('삭제'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        dogBreeds.remove(dogBreed);
        favorites.remove(dogBreed);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Dog Breeds' : 'Favorites'),
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
        itemCount: dogBreeds.length,
        itemBuilder: (context, index) {
          return DogBreedCard(
            dogBreed: dogBreeds[index],
            isFavorite: favorites.contains(dogBreeds[index]),
            onFavoritePressed: () => toggleFavorite(dogBreeds[index]),
            onDeletePressed: () => _deleteDogBreed(dogBreeds[index]),
          );
        },
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return DogBreedCard(
            dogBreed: favorites[index],
            isFavorite: true,
            onFavoritePressed: () => toggleFavorite(favorites[index]),
            onDeletePressed: () => _deleteDogBreed(favorites[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewDogBreed,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => _onItemTapped(0),
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}