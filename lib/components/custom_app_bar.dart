import 'package:flutter/material.dart';
import 'package:rick_and_morty_demo/providers/collection_provider.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({super.key, required this.provider});

  final CollectionProvider provider;

  final TextEditingController controller = TextEditingController();

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      children: [
        BackButton(
          color: theme.cardColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SearchBar(
            controller: widget.controller,
            constraints: BoxConstraints.loose(const Size.fromHeight(40)),
            onChanged: (value) {
              if (widget.controller.text.isEmpty) {
                widget.provider.searchTerm = widget.controller.text;
              }
            },
            trailing: [
              IconButton(
                onPressed: () {
                  widget.provider.searchTerm = widget.controller.text;
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
