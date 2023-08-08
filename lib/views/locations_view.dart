import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'error_view.dart';
import '../providers/navigation_provider.dart';
import '../utils/app_routes_enum.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_list_tile.dart';
import '../models/location.dart';
import '../providers/locations_provider.dart';
import '../components/custom_paginator.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LocationsProvider>(context, listen: false).getAllLocations();
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
            provider: Provider.of<LocationsProvider>(context, listen: false),
          ),
          const SizedBox(height: 16),
          Text(
            'Show Destinations',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.cardColor, height: 1),
            textScaleFactor: 2,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<LocationsProvider>(
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

                List<Location> locations = value.locationList;
                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    Location location = locations[index];
                    return CustomListTile(
                      icon: Icons.place,
                      title: location.name,
                      subtitle: location.type,
                      onTap: () {
                        Provider.of<NavigationProvider>(context, listen: false)
                            .gotoRoute(AppRoute.detailedLocation,
                                args: location.id);
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          CustomPaginator(provider: Provider.of<LocationsProvider>(context)),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
