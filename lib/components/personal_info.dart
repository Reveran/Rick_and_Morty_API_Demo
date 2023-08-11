import 'package:flutter/material.dart';

/// A widget made to show detailed information about a character.
class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    super.key,
    required this.name,
    required this.type,
    required this.specie,
    required this.status,
    required this.characterId,
    required this.imageUrl,
  });

  final String characterId;
  final String name;
  final String type;
  final String specie;
  final String status;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextStyle boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: theme.iconTheme.color,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.network(
            imageUrl,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: boldStyle,
                textScaleFactor: 1.5,
              ),
              Text(
                type,
                style: boldStyle.copyWith(fontStyle: FontStyle.italic),
                textScaleFactor: 1.2,
              ),
              Text(
                specie,
                style: boldStyle,
                textScaleFactor: 1.2,
              ),
              Text(
                status,
                style: boldStyle,
                textScaleFactor: 1.2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
