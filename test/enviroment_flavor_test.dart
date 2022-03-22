import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:enviroment_flavor/enviroment_flavor.dart';

void main() {
  test('Environment Beta', () {
    EnvironmentFlavor.create(Environment.BETA, 'google.com');

    expect(EnvironmentFlavor().environment, equals(Environment.BETA));
    expect(EnvironmentFlavor().isBeta, isTrue);
    expect(EnvironmentFlavor().isProd, isFalse);
  });

  test('Environment Prod', () {
    EnvironmentFlavor.create(Environment.PROD, 'google.com');

    expect(EnvironmentFlavor().environment, equals(Environment.PROD));
    expect(EnvironmentFlavor().isProd, isTrue);
    expect(EnvironmentFlavor().isBeta, isFalse);
  });

  test('Environment Dev', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');

    expect(EnvironmentFlavor().environment, equals(Environment.DEV));
    expect(EnvironmentFlavor().isDev, isTrue);
    expect(EnvironmentFlavor().isProd, isFalse);
  });

  test('Environment Demo', () {
    EnvironmentFlavor.create(Environment.DEMO, 'google.com');

    expect(EnvironmentFlavor().environment, equals(Environment.DEMO));
    expect(EnvironmentFlavor().isDemo, isTrue);
    expect(EnvironmentFlavor().isDev, isFalse);
  });

  test('Environment ADD and GET multiple properties', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');

    /// Try to add but input is an empty map
    EnvironmentFlavor().addProperties({});
    expect(EnvironmentFlavor().properties.entries.length, 0);

    /// Adds and gets multiple properties
    EnvironmentFlavor().addProperties({'active': true, 'inactive': false});
    expect(
      EnvironmentFlavor().getProperties(['active', 'inactive']),
      {'active': true, 'inactive': false},
    );

    /// Try to get but input is an empty array
    expect(EnvironmentFlavor().getProperties([]), {});
  });

  test('EnviromentFlavor ADD and GET single property', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');

    EnvironmentFlavor().addProperties({'active': true});
    expect(EnvironmentFlavor().getProperty('active'), isTrue);

    EnvironmentFlavor().addProperties({'active': false});
    expect(EnvironmentFlavor().getProperty('active'), isFalse);

    expect(EnvironmentFlavor().getProperty(''), isNull);

    EnvironmentFlavor().addProperties({'active': null});
    expect(EnvironmentFlavor().getProperty('active'), isNull);
  });

  test('Environment instance', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');
    expect(EnvironmentFlavor(), isInstanceOf<EnvironmentFlavor>());
    final hashCode1 = EnvironmentFlavor();
    final hashCode2 = EnvironmentFlavor();
    expect(hashCode1, hashCode2);
  });

  test('Environment baseURL', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');
    expect(EnvironmentFlavor().baseURL, 'google.com');
  });

  //TESTE FALHA: só funciona em aparelhos Andrdoi e iOS
  test('AppVersion', () async {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');
    WidgetsFlutterBinding.ensureInitialized();
    await EnvironmentFlavor()
        .addPropertyAppVersion(); // Só funciona nas plataformas Android e iOS

    final appVersion = EnvironmentFlavor().getProperties(
      ['appVersion', 'buildNumber'],
    );

    expect(appVersion.entries.length, equals(2));
    expect(appVersion['appVersion'], isA<String>());
    expect(appVersion['appVersion'], isNotEmpty);

    expect(appVersion['buildNumber'], isA<String>());
    expect(appVersion['buildNumber'], isNotEmpty);
  });
}
