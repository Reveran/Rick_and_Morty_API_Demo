import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.imageUrl,
  });

  final String? imageUrl;
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            if (imageUrl != null && imageUrl!.contains('http'))
              Image.network(imageUrl!),
            if (imageUrl != null && imageUrl!.contains('assets'))
              Image.asset(imageUrl!),
            ListTile(
              tileColor: theme.colorScheme.tertiary,
              textColor: theme.iconTheme.color,
              iconColor: theme.colorScheme.secondary,
              titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              leading: Icon(icon),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
