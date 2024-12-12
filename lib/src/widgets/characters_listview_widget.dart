import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/providers/rick_and_morty_provider.dart';

import '../screens/character_details_screen.dart';
import 'character_card.dart';

class CharactersListviewWidget extends StatelessWidget {
  final RickAndMortyProvider characterProvider;
  const CharactersListviewWidget({super.key, required this.characterProvider});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (characterProvider.loading || !characterProvider.hasMore) {
          return false;
        }

        if (scrollInfo.metrics.pixels ==
            scrollInfo.metrics.maxScrollExtent) {
          characterProvider.fetchCharacters();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: characterProvider.characters.length + 1,
        itemBuilder: (context, index) {
          if (index == characterProvider.characters.length) {
            return characterProvider.loading
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            )
                : Container();
          }
          final character = characterProvider.characters[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CharacterDetailsScreen(character: character)),
              );
            },
            child: Hero(
              tag: 'character-${character.id}',
              child: CharacterCard(character: character),
            ),
          );
        },
      ),
    );
  }
}
