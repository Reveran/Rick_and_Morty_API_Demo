import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/errors_enum.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.error});

  final Errors? error;

  final Map<Errors, String> messages = const {
    Errors.serverError:
        'It looks like a problem on our servers.\nMake sure you have internet connection and the latest version of the app.',
    Errors.connectionError:
        'Our servers cannot be accessed.\nPlease check your internet connection.',
    Errors.internalError:
        'Something went wrong.\nMake sure you have the latest version of the app.',
  };

  @override
  Widget build(BuildContext context) {
    String message = messages[error] ??
        'it looks like the portal gun has jammed, you shouldn\'t be here...';

    ThemeData theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Oops!,',
              textScaleFactor: 2,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: theme.cardColor),
            ),
            Text(
              message,
              textScaleFactor: 1.5,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: theme.cardColor),
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/error.svg',
                semanticsLabel: 'Something Went Wrong!',
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ));
  }
}
