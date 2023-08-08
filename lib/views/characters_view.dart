import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/components/custom_app_bar.dart';

import '../providers/characters_provider.dart';
import '../components/character_card.dart';
import '../components/custom_paginator.dart';
import '../models/character.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CharactersProvider>(context, listen: false)
          .getAllCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CustomAppBar(
            provider: Provider.of<CharactersProvider>(context, listen: false),
          ),
          const SizedBox(height: 16),
          Text(
            'Characters Showcase',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.cardColor, height: 1),
            textScaleFactor: 2,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<CharactersProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Character> characters = value.characterList;
                return GridView.builder(
                  itemCount: characters.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 10 / 16,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    Character character = characters[index];
                    return CharacterCard(
                      characterId: character.id,
                      name: character.name,
                      pictureUrl: character.image,
                      status: character.status,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          CustomPaginator(provider: Provider.of<CharactersProvider>(context)),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
