import 'package:flutter/material.dart';
import '../models/dog_breed.dart';
import '../widgets/dog_breed_card.dart';
import '../data/dog_breeds_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? '귀여운 강아지' : 'Favorites'),
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
        itemCount: dogBreeds.length,
        itemBuilder: (context, index) {
          return DogBreedCard(
            dogBreed: dogBreeds[index],
            isFavorite: favorites.contains(dogBreeds[index]),
            onFavoritePressed: () => toggleFavorite(dogBreeds[index]),
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
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}