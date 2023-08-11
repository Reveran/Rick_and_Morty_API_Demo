import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

/// Singletone holding the app configuration.
class ConfigLoader {
  ConfigLoader._() {
    load();
  }
  final Completer<void> _configCompleter = Completer<void>();
  static ConfigLoader? _configLoader;
  Map? _config;

  static ConfigLoader instance() {
    _configLoader ??= ConfigLoader._();
    return _configLoader!;
  }

  void load() async {
    String configString = await rootBundle.loadString('assets/config.yaml');
    _config = loadYaml(configString) as Map;
    _configCompleter.complete();
  }

  Future<void> getConfigLoaded() => _configCompleter.future;

  Future<String> get apiBaseUrl async {
    await getConfigLoaded();

    return _config!['api_base_url'];
  }
}
