import 'package:flutter/material.dart';
import 'package:rick_and_morty_preview/model/character.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem(
      {super.key,
      required this.character,
      required this.onFavorite,
      required this.onClick});

  final Character character;
  final Function(Character) onFavorite;
  final Function(Character) onClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onClick(character),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(character.image),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    character.status,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    character.species,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 32,
              icon: Icon(
                character.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: character.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => onFavorite(character),
            )
          ],
        ),
      ),
    );
  }
}
