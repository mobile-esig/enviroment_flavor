import 'package:enviroment_flavor/enviroment_flavor.dart';

void main() {
  EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");
  print("isProd: ${EnviromentFlavor.instance.isProd}");
  print("isProd: ${EnviromentFlavor.instance.getBaseURL}");

  EnviromentFlavor.instance.addProperty(key: "name", value: "Lucas Andrade");
  print("Properties: ${EnviromentFlavor.instance.getProperty(key: 'name')}");
}
