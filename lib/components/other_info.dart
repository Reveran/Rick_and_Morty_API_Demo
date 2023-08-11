import 'package:flutter/material.dart';

/// A widget similar to the *PersonalInfo* widget, displays information of an object.
class OtherInfo extends StatelessWidget {
  const OtherInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.other,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String other;

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
            child: FittedBox(
          child: Icon(
            icon,
            color: theme.colorScheme.secondary,
          ),
        )),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: boldStyle,
                textScaleFactor: 1.5,
              ),
              Text(
                subtitle,
                style: boldStyle.copyWith(fontStyle: FontStyle.italic),
                textScaleFactor: 1.2,
              ),
              Text(
                other,
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
