# enviroment_flavor

Flutter package to manage simple environment variables.

## Getting Started

In your flutter project, add the dependency to your `pubspec.yaml`

```yaml
dependencies:
  ...
  enviroment_flavor: ^1.0.0
```

## Usage

### 1. Import

Import `enviroment_flavor`

```dart
import 'package:enviroment_flavor/enviroment_flavor.dart';
```

### 2. Create instance

Create instance at main file

```dart
EnviromentFlavor.create(enviroment: Enviroments.DEV, baseURL: "google.com");
```

### 3. Use anywhere

```dart
CustomDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnviromentConfig.instance.baseURL,
      ),
    );
}
```

## Contact

    Send e-mail: mobile@esig.group

## License
    Copyright (c) 2020 ESIG Group