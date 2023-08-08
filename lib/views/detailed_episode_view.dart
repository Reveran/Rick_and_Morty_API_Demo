import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';

import '../components/other_info.dart';
import '../models/character.dart';
import '../providers/episodes_provider.dart';
import '../models/episode.dart';
import 'error_view.dart';

class DetailedEpisodeView extends StatefulWidget {
  const DetailedEpisodeView({super.key, required this.episodeId});

  final String episodeId;
  @override
  State<DetailedEpisodeView> createState() => _DetailedEpisodeViewState();
}

class _DetailedEpisodeViewState extends State<DetailedEpisodeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EpisodesProvider>(context, listen: false)
          .getepisodeInfo(widget.episodeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Consumer<EpisodesProvider>(
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

        Episode episode = value.currentInspected;
        return Card(
          color: theme.cardColor,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                OtherInfo(
                  icon: Icons.tv,
                  title: episode.name,
                  subtitle: episode.episode,
                  other: episode.airDate,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Characters seen in this episode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.iconTheme.color,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      episode.characters.length.toString(),
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
                    itemCount: episode.characters.length,
                    itemBuilder: (context, index) {
                      Character character = episode.characters[index];
                      return Card(
                        color: theme.colorScheme.tertiary,
                        child: ListTile(
                          textColor: theme.iconTheme.color,
                          titleTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          leading: Icon(
                            Icons.tv,
                            color: theme.colorScheme.secondary,
                          ),
                          title: Text(
                            character.name,
                          ),
                          subtitle: Text(
                            character.species,
                          ),
                          onTap: () {
                            Provider.of<NavigationProvider>(context,
                                    listen: false)
                                .gotoRoute(AppRoute.detailedCharacter,
                                    args: character.id);
                          },
                        ),
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
