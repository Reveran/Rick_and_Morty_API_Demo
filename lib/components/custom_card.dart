import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String value;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: theme.colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 50,
                color: const Color(0x55ffffff),
              ),
              const SizedBox(height: 8),
              Text(
                '$title\n',
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: theme.cardColor,
                ),
                textScaleFactor: 1.2,
              ),
              Text(
                '$value\n',
                style: TextStyle(
                  height: 1,
                  color: theme.cardColor,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
