import 'package:flutter/material.dart';

import '../providers/collection_provider.dart';

class CustomPaginator extends StatefulWidget {
  const CustomPaginator({
    super.key,
    required this.provider,
  });

  final CollectionProvider provider;

  @override
  State<CustomPaginator> createState() => _CustomPaginatorState();
}

class _CustomPaginatorState extends State<CustomPaginator> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      children: [
        IconButton.filled(
          onPressed: widget.provider.prevPage == null
              ? null
              : () {
                  setState(() {
                    widget.provider.currentPage =
                        widget.provider.currentPage - 1;
                  });
                },
          color: theme.colorScheme.primary,
          icon: const Icon(Icons.chevron_left),
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0x55ffffff);
              }
              return theme.colorScheme.tertiary;
            }),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: theme.colorScheme.tertiary,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: genButtons(widget.provider, theme),
            ),
          ),
        ),
        IconButton.filled(
          onPressed: widget.provider.nextPage == null
              ? null
              : () {
                  setState(() {
                    widget.provider.currentPage =
                        widget.provider.currentPage + 1;
                  });
                },
          color: theme.colorScheme.primary,
          icon: const Icon(Icons.chevron_right),
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color(0x55ffffff);
              }
              return theme.colorScheme.tertiary;
            }),
          ),
        ),
      ],
    );
  }

  List<int> genPages(int numPages, int maxPages, int currentPage) {
    List<int> pages = [];

    int inicio = currentPage - numPages;
    int fin = currentPage + numPages;

    if (1 - inicio > 0) {
      fin += 1 - inicio;
    }

    if (fin - maxPages > 0) {
      inicio -= fin - maxPages;
    }

    for (int i = inicio; i <= fin; i++) {
      if (i >= 1 && i <= maxPages) {
        pages.add(i);
      }
    }

    return pages;
  }

  List<Widget> genButtons(CollectionProvider provider, ThemeData theme) {
    List<int> pages = genPages(2, provider.maxPages, provider.currentPage);
    return pages.map((
      item,
    ) {
      IconButton button;
      if (item == provider.currentPage) {
        button = IconButton.filled(
          onPressed: () {},
          icon: Text(
            item.toString(),
            style: TextStyle(
              color: theme.colorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
          visualDensity: VisualDensity.compact,
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => theme.colorScheme.primary,
            ),
          ),
        );
      } else {
        button = IconButton(
          onPressed: () {
            setState(() {
              provider.currentPage = item;
            });
          },
          icon: Text(
            item.toString(),
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          visualDensity: VisualDensity.compact,
        );
      }
      return button;
    }).toList();
  }
}
