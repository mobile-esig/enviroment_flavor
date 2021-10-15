import 'package:enviroment_flavor/enviroment_flavor.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");
  print("isProd: ${EnviromentFlavor.instance.isProd}");
  print("BaseURL: ${EnviromentFlavor.instance.getBaseURL}");

  EnviromentFlavor.instance.addProperty(key: "name", value: "Lucas Andrade");
  print("Properties: ${EnviromentFlavor.instance.getProperty(key: 'name')}");

  WidgetsFlutterBinding.ensureInitialized();
  await EnviromentFlavor.instance.addPropertyAppVersion();

  print(
      "Version App: v.${EnviromentFlavor.instance.getProperty(key: 'appVersion')}");
}
