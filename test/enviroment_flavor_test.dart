import 'package:flutter_test/flutter_test.dart';

import 'package:enviroment_flavor/enviroment_flavor.dart';

void main() {
  test('Test Environment Beta', () {
    EnvironmentFlavor.create(Environment.BETA, 'google.com');

    expect(EnvironmentFlavor().environment, Environment.BETA);
    expect(EnvironmentFlavor().isBeta, true);
    expect(EnvironmentFlavor().isProd, false);
  });

  test('Test Environment Prod', () {
    EnvironmentFlavor.create(Environment.PROD, 'google.com');

    expect(EnvironmentFlavor().environment, Environment.PROD);
    expect(EnvironmentFlavor().isProd, true);
    expect(EnvironmentFlavor().isBeta, false);
  });

  test('Test Environment Dev', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');

    expect(EnvironmentFlavor().environment, Environment.DEV);
    expect(EnvironmentFlavor().isDev, true);
    expect(EnvironmentFlavor().isProd, false);
  });

  test('Test Environment Demo', () {
    EnvironmentFlavor.create(Environment.DEMO, 'google.com');

    expect(EnvironmentFlavor().environment, Environment.DEMO);
    expect(EnvironmentFlavor().isDemo, true);
    expect(EnvironmentFlavor().isDev, false);
  });

  test('Test Environment ADD and GET multiple properties', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');

    /// Try to add but input is an empty map
    EnvironmentFlavor().addProperties({});
    expect(EnvironmentFlavor().properties.entries.length, 0);

    /// Adds and gets multiple properties
    EnvironmentFlavor().addProperties({'active': true, 'inactive': false});
    expect(EnvironmentFlavor().getProperties(keys: ['active', 'inactive']),
        {'active': true, 'inactive': false});

    /// Try to get but input is an empty array
    expect(EnvironmentFlavor().getProperties(keys: []), {});
  });

  test('Test Environment instance', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');
    expect(EnvironmentFlavor(), isInstanceOf<Environment>());
  });

  test('Test Environment baseURL', () {
    EnvironmentFlavor.create(Environment.DEV, 'google.com');
    expect(EnvironmentFlavor().baseURL, 'google.com');
  });
}
