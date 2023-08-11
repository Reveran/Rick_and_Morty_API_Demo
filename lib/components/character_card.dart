import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';

/// A custom widget looking like a personal record
class CharacterCard extends StatelessWidget {
  const CharacterCard(
      {super.key,
      required this.pictureUrl,
      required this.status,
      required this.name,
      required this.characterId});

  final String characterId;
  final String pictureUrl;
  final String status;
  final String name;

  @override
  Widget build(BuildContext context) {
    NavigationProvider navProvider = Provider.of(context);
    return GestureDetector(
      onTap: () =>
          navProvider.gotoRoute(AppRoute.detailedCharacter, args: characterId),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/folder.png'),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 24, 32, 24),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tilted Photography
              RotationTransition(
                turns: const AlwaysStoppedAnimation(-7 / 360),
                child: Container(
                  constraints: BoxConstraints.loose(const Size.fromWidth(320)),
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
                  color: Colors.white70,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      pictureUrl,
                      // Fallback Image
                      errorBuilder: (context, child, stackTrace) =>
                          Image.asset('assets/images/placeholder.jpeg'),
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // Character's Name
              Text(
                name,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff333333),
                  height: 1.1,
                ),
              ),

              // Status Text
              const Text(
                "Status:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff333333),
                  height: 1,
                ),
              ),

              // Character's Status
              SizedBox(
                width: double.infinity,
                child: Text(
                  status,
                  textScaleFactor: 1.4,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: "Stamped",
                      color: status == 'Dead'
                          ? const Color(0xff880000) // Dead Character
                          : status == 'Alive'
                              ? const Color(0xff005500) // Alive Character
                              : const Color(0xff000000), // Unknown Status
                      height: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
