import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name), // Display character's name in the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${character.name}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Species: ${character.species}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Status: ${character.status}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Gender: ${character.gender}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Origin: ${character.origin.name}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Location: ${character.location.name}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
