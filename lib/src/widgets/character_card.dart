import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Character Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                character.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Character Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('ID: ${character.id}'),
                  Text('Species: ${character.species}'),
                  Text('Status: ${character.status}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}