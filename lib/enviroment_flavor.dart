library enviroment_flavor;

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Environment {
  PROD,
  BETA,
  DEV,
  DEMO,
}

class EnvironmentFlavor {
  static late final EnvironmentFlavor _instance;

  final String baseURL;
  final Environment environment;
  Map<String, dynamic> properties = <String, dynamic>{};

  EnvironmentFlavor.create(this.environment, this.baseURL) {
    _instance = this;
    debugPrint('-- EnvironmentFlavor creating instance ${_instance.hashCode}');
  }

  factory EnvironmentFlavor() {
    debugPrint('-- EnvironmentFlavor getting instance ${_instance.hashCode}');
    return _instance;
  }

  bool get isProd => environment == Environment.PROD;
  bool get isDev => environment == Environment.DEV;
  bool get isBeta => environment == Environment.BETA;
  bool get isDemo => environment == Environment.DEMO;

  void addProperties(Map<String, dynamic> properties) {
    _devPrint('-- EnvironmentFlavor adding properties: $properties');

    this.properties = {
      ...this.properties,
      ...properties,
    };
  }

  Map<String, dynamic> getProperties({required List<String> keys}) {
    _devPrint('-- EnvironmentFlavor getting properties: $keys');

    return {
      for (var key in keys)
        if (this.properties.keys.contains(key)) key: this.properties[key]
    };
  }

  Future<void> addPropertyAppVersion() async {
    _devPrint('-- EnvironmentFlavor adding AppVersion to properties');

    final PackageInfo info = await PackageInfo.fromPlatform();
    addProperties(
      {
        'appVersion': info.version,
        'buildNumber': info.buildNumber,
      },
    );
  }

  void _devPrint(String msg) {
    if (!isProd) {
      debugPrint(msg);
    }
  }
}
