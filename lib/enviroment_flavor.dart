library enviroment_flavor;

import 'package:package_info_plus/package_info_plus.dart';
import 'dart:developer' as developer;

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
    developer.log('EnvFlavor: creating instance ${_instance.hashCode}');
  }

  factory EnvironmentFlavor() {
    developer.log('EnvFlavor: getting instance ${_instance.hashCode}');
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
    developer.log('EnvFlavor: added properties: $properties');
  }

  Map<String, dynamic> getProperties(List<String> keys) {
    developer.log('EnvFlavor: getting properties: $keys');
    return {
      for (var key in keys)
        if (this.properties.keys.contains(key)) key: this.properties[key]
    };
  }

  dynamic getProperty(String key) {
    developer.log('EnvFlavor: getting property: $key');
    return properties.keys.contains(key) ? properties[key] : null;
  }

  Future<void> addPropertyAppVersion() async {
    developer.log('EnvFlavor: adding AppVersion to properties');

    final PackageInfo info = await PackageInfo.fromPlatform();
    addProperties(
      {
        'appVersion': info.version,
        'buildNumber': info.buildNumber,
      },
    );
  }
}
