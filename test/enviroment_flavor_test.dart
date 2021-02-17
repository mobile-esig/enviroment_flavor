import 'package:flutter_test/flutter_test.dart';

import 'package:enviroment_flavor/enviroment_flavor.dart';

void main() {
  test("Test EnviromentFlavor Beta", () {
    EnviromentFlavor.create(
        enviroment: Enviroments.BETA, baseURL: "google.com");

    expect(EnviromentFlavor.instance.enviroment, Enviroments.BETA);
    expect(EnviromentFlavor.instance.isBeta, true);
    expect(EnviromentFlavor.instance.isProd, false);
  });

  test("Test EnviromentFlavor Prod", () {
    EnviromentFlavor.create(
        enviroment: Enviroments.PROD, baseURL: "google.com");

    expect(EnviromentFlavor.instance.enviroment, Enviroments.PROD);
    expect(EnviromentFlavor.instance.isProd, true);
    expect(EnviromentFlavor.instance.isBeta, false);
  });

  test("Test EnviromentFlavor Dev", () {
    EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");

    expect(EnviromentFlavor.instance.enviroment, Enviroments.DEV);
    expect(EnviromentFlavor.instance.isDev, true);
    expect(EnviromentFlavor.instance.isProd, false);
  });

  test("Test EnviromentFlavor Demo", () {
    EnviromentFlavor.create(
        enviroment: Enviroments.DEMO, baseURL: "google.com");

    expect(EnviromentFlavor.instance.enviroment, Enviroments.DEMO);
    expect(EnviromentFlavor.instance.isDemo, true);
    expect(EnviromentFlavor.instance.isDev, false);
  });

  test("Test EnviromentFlavor ADD and GET single property", () {
    EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");

    EnviromentFlavor.instance.addProperty(key: "active", value: true);
    expect(EnviromentFlavor.instance.getProperty(key: "active"), true);

    EnviromentFlavor.instance.addProperty(key: "active", value: false);
    expect(EnviromentFlavor.instance.getProperty(key: "active"), false);

    expect(EnviromentFlavor.instance.getProperty(key: ""), "");
    expect(() => EnviromentFlavor.instance.getProperty(key: null),
        throwsA(isAssertionError));

    expect(() => EnviromentFlavor.instance.addProperty(key: null, value: true),
        throwsA(isAssertionError));

    expect(
        () => EnviromentFlavor.instance.addProperty(key: "active", value: null),
        throwsA(isAssertionError));
  });

  test('Test EnviromentFlavor ADD and GET multiple properties', () {
    EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: 'google.com');

    /// Try to add but input is an empty map
    EnviromentFlavor.instance.addProperties(properties: {});
    expect(EnviromentFlavor.instance.properties.entries.length, 0);

    /// Adds and gets multiple properties
    EnviromentFlavor.instance
        .addProperties(properties: {'active': true, 'inactive': false});
    expect(EnviromentFlavor.instance.getProperty(key: 'active'), true);
    expect(EnviromentFlavor.instance.getProperty(key: 'inactive'), false);
    expect(
        EnviromentFlavor.instance.getProperties(keys: ['active', 'inactive']),
        {'active': true, 'inactive': false});

    /// Try to get but input is an empty array
    expect(EnviromentFlavor.instance.getProperties(keys: []), {});

    expect(() => EnviromentFlavor.instance.addProperties(properties: null),
        throwsA(isAssertionError));

    expect(() => EnviromentFlavor.instance.getProperties(keys: null),
        throwsA(isAssertionError));
  });

  test("Test EnviromentFlavor instance", () {
    EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");
    expect(EnviromentFlavor.instance, isInstanceOf<EnviromentFlavor>());
  });

  test("Test EnviromentFlavor baseURL", () {
    EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");
    expect(EnviromentFlavor.instance.getBaseURL, "google.com");
    expect(EnviromentFlavor.instance.getBaseURL.isNotEmpty, true);
  });
}
