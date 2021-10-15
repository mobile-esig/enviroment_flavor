library enviroment_flavor;

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Enviroments {
  PROD,
  BETA,
  DEV,
  DEMO,
}

class EnviromentFlavor {
  EnviromentFlavor.create({required this.enviroment, this.baseURL}) {
    enviromentConfig = this;
  }

  static late EnviromentFlavor enviromentConfig;

  final Enviroments enviroment;
  String? baseURL;
  Map<String, dynamic> properties = Map();

  void addProperty({required String key, required dynamic value}) {
    properties[key] = value;
  }

  getProperty({required String key}) {
    return properties[key];
  }

  void addProperties({required Map<String, dynamic> properties}) {
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

  Future addPropertyAppVersion() async => await PackageInfo.fromPlatform()
      .then((value) => addProperty(key: 'appVersion', value: value.version));

  String? get getBaseURL => baseURL;

  bool get isProd => enviroment == Enviroments.PROD;
  bool get isDev => enviroment == Enviroments.DEV;
  bool get isBeta => enviroment == Enviroments.BETA;
  bool get isDemo => enviroment == Enviroments.DEMO;
  Enviroments getEnviroment() => enviroment;
  static EnviromentFlavor get instance {
    debugPrint("-- EnviromentConfig Access");
    return enviromentConfig;
  }
}
