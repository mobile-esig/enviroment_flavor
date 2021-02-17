library enviroment_flavor;

import 'package:flutter/material.dart';

enum Enviroments {
  PROD,
  BETA,
  DEV,
  DEMO,
}

class EnviromentFlavor {
  EnviromentFlavor.create({@required this.enviroment, this.baseURL}) {
    assert(enviroment != null && baseURL != null);
    enviromentConfig = this;
  }

  static EnviromentFlavor enviromentConfig;

  Map<String, dynamic> properties = Map();
  String baseURL;
  final Enviroments enviroment;

  void addProperty({@required String key, @required dynamic value}) {
    assert(key != null && value != null);
    properties[key] = value;
  }

  getProperty({@required String key}) {
    assert(key != null);
    return properties[key] ?? '';
  }

  void addProperties({@required Map<String, dynamic> properties}) {
    assert(this.properties != null && properties != null);
    this.properties = {
      ...this.properties,
      ...properties,
    };
  }

  Map<String, dynamic> getProperties({@required List<String> keys}) {
    assert(keys != null);
    return {
      for (var key in keys)
        if (this.properties.keys.contains(key)) key: this.properties[key]
    };
  }

  String get getBaseURL => baseURL;

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
