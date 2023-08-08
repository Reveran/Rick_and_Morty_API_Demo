import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/components/custom_list_tile.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';

import '../components/custom_card.dart';
import '../components/personal_info.dart';
import '../providers/characters_provider.dart';
import '../models/character.dart';
import '../models/episode.dart';
import 'error_view.dart';

class DetailedCharacterView extends StatefulWidget {
  const DetailedCharacterView({super.key, required this.characterId});

  final String characterId;
  @override
  State<DetailedCharacterView> createState() => _DetailedCharacterViewState();
}

class _DetailedCharacterViewState extends State<DetailedCharacterView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CharactersProvider>(context, listen: false)
          .getcharacterInfo(widget.characterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (value.exeption != null) {
          return ErrorView(
            error: value.exeption,
          );
        }

        Character character = value.currentInspected;
        ThemeData theme = Theme.of(context);
        return Card(
          color: theme.cardColor,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                PersonalInfo(
                  characterId: widget.characterId,
                  imageUrl: character.image,
                  name: character.name,
                  type: character.type,
                  specie: '${character.gender} - ${character.species}',
                  status: 'Status: ${character.status}',
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        icon: Icons.remove_red_eye,
                        title: 'First seen in:',
                        value: character.origin.name,
                        onTap: () {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .gotoRoute(AppRoute.detailedLocation,
                                  args: character.origin.id);
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                        icon: Icons.place,
                        title: 'Last known location:',
                        value: character.location.name,
                        onTap: () {
                          Provider.of<NavigationProvider>(context,
                                  listen: false)
                              .gotoRoute(AppRoute.detailedLocation,
                                  args: character.location.id);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Character\'s Appearances',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.iconTheme.color,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      character.episodes.length.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.iconTheme.color,
                      ),
                      textScaleFactor: 1.2,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: character.episodes.length,
                    itemBuilder: (context, index) {
                      Episode episode = character.episodes[index];
                      return CustomListTile(
                        icon: Icons.tv,
                        title: episode.name,
                        subtitle: episode.episode,
                        onTap: () {
                          Provider.of<NavigationProvider>(
                            context,
                            listen: false,
                          ).gotoRoute(
                            AppRoute.detailedEpisode,
                            args: episode.id,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
