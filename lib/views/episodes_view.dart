import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_provider.dart';
import '../utils/app_routes_enum.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_list_tile.dart';
import '../models/episode.dart';
import '../providers/episodes_provider.dart';
import '../components/custom_paginator.dart';
import 'error_view.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EpisodesProvider>(context, listen: false).getAllEpisodes();
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
            provider: Provider.of<EpisodesProvider>(context, listen: false),
          ),
          const SizedBox(height: 16),
          Text(
            'Show Episodes',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.cardColor, height: 1),
            textScaleFactor: 2,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<EpisodesProvider>(
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

                List<Episode> episodes = value.episodeList;
                String season = '-01';
                return ListView.builder(
                  itemCount: episodes.length,
                  cacheExtent: 9000,
                  itemBuilder: (context, index) {
                    Episode episode = episodes[index];

                    Widget tile = CustomListTile(
                      icon: Icons.tv,
                      title: episode.name,
                      subtitle: episode.episode,
                      onTap: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .gotoRoute(AppRoute.detailedEpisode,
                                args: episode.id);
                      },
                    );

                    if (episode.episode.substring(1, 3) != season) {
                      season = episode.episode.substring(1, 3);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            'Season $season',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.cardColor,
                                height: 1),
                            textScaleFactor: 1.5,
                          ),
                          const SizedBox(height: 8),
                          tile,
                        ],
                      );
                    } else {
                      return tile;
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          CustomPaginator(provider: Provider.of<EpisodesProvider>(context)),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
