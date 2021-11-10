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

  final Environment environment;

  final String baseURL;

  Map<String, dynamic> properties = <String, dynamic>{};

  EnvironmentFlavor.create(this.environment, this.baseURL) {
    debugPrint('-- EnvironmentFlavor create instance ${_instance.hashCode}');
    _instance = this;
  }

  factory EnvironmentFlavor() {
    debugPrint('-- EnvironmentFlavor get instance ${_instance.hashCode}');
    return _instance;
  }

  bool get isProd => environment == Environment.PROD;
  bool get isDev => environment == Environment.DEV;
  bool get isBeta => environment == Environment.BETA;
  bool get isDemo => environment == Environment.DEMO;

  void addProperties(Map<String, dynamic> properties) {
    this.properties = {
      ...this.properties,
      ...properties,
    };
  }

  Map<String, dynamic> getProperties({required List<String> keys}) {
    return {
      for (var key in keys)
        if (this.properties.keys.contains(key)) key: this.properties[key]
    };
  }

  Future addPropertyAppVersion() async => await PackageInfo.fromPlatform().then(
        (value) => addProperties(
          {
            'appVersion': value.version,
            'buildNumber': value.buildNumber,
          },
        ),
      );

  String? get getBaseURL => baseURL;
}
