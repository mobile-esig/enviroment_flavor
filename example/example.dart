import 'package:enviroment_flavor/enviroment_flavor.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  EnvironmentFlavor.create(Environment.DEV, 'google.com');
  print('isProd: ${EnvironmentFlavor().isProd}');
  print('baseURL: ${EnvironmentFlavor().baseURL}');

  EnvironmentFlavor().addProperties({'active': true, 'inactive': false});
  print(
    'Properties: ${EnvironmentFlavor().getProperties(
      ['active', 'inactive'],
    )}',
  );

  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentFlavor().addPropertyAppVersion();
  print(
    'App version: ${EnvironmentFlavor().getProperties(['appVersion'])}',
  );
}
