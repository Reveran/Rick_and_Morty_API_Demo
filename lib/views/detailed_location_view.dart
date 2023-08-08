import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';

import '../components/other_info.dart';
import '../models/character.dart';
import '../providers/locations_provider.dart';
import '../models/location.dart';
import 'error_view.dart';

class DetailedLocationView extends StatefulWidget {
  const DetailedLocationView({super.key, required this.locationId});

  final String locationId;
  @override
  State<DetailedLocationView> createState() => _DetailedLocationViewState();
}

class _DetailedLocationViewState extends State<DetailedLocationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LocationsProvider>(context, listen: false)
          .getlocationInfo(widget.locationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Consumer<LocationsProvider>(
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

        Location location = value.currentInspected;
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
                  icon: Icons.place,
                  title: location.name,
                  subtitle: location.type,
                  other: location.dimension,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last seen in this location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.iconTheme.color,
                      ),
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      location.residents.length.toString(),
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
                    itemCount: location.residents.length,
                    itemBuilder: (context, index) {
                      Character character = location.residents[index];
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
