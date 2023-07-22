# Dio API Client

[![Pub Version](https://img.shields.io/pub/v/dio_api_client?color=blue)](https://pub.dev/packages/dio_api_client)
![GitHub License](https://img.shields.io/github/license/mohesu/dio_api_client)
![GitHub Repo Size](https://img.shields.io/github/repo-size/mohesu/dio_api_client)
![GitHub Last Commit](https://img.shields.io/github/last-commit/mohesu/dio_api_client)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/mohesu/dio_api_client)
![GitHub Issues](https://img.shields.io/github/issues/mohesu/dio_api_client)
![GitHub Stars](https://img.shields.io/github/stars/mohesu/dio_api_client?style=social)

## Description

The Flutter API Client is a package designed to simplify the process of making API requests in Flutter projects. It is built on top of the popular `dio` package, providing a streamlined and efficient way to communicate with RESTful APIs.

## Features

- **Easy integration**: The Flutter API Client is easy to integrate into your Flutter projects, allowing you to start making API requests quickly.
- **Simple configuration**: The package provides a straightforward configuration process, making it easy to set up and customize your API client.
- **Support for authentication**: The Flutter API Client supports various authentication methods, including token-based authentication and API key authentication.
- **Flexible request options**: With the Flutter API Client, you can easily customize request options such as headers, query parameters, timeouts, and more.
- **Error handling**: The package includes error handling mechanisms to handle API errors gracefully and provide meaningful error messages.

## Installation

To use the Flutter API Client in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  dio_api_client: ^1.0.0
```

Then, run the command `flutter pub get` to fetch the package.

## Usage

1. Import the package:

```dart
import 'package:dio_api_client/dio_api_client.dart';
```

2. Initialize the API client:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getTemporaryDirectory();
  await DioApiClient.init(directory);
  runApp(const MyApp());
}
```

3. Make API class and extend `DioApiClient`:

```dart
/// * [T] is the type of the response data
class PubPackage extends DioApiClient<T> {
  @override
  Duration get cacheDuration => Duration.zero;

  @override
  String get endpoint => 'pub.dev/api/';

  @override
  String get path => 'packages/';

  Future<T?> getPackage(String name) async {
    final response = await get(
      dynamicPath: name,
    );
    return response.data;
  }
}

```

## Configuration

You can configure the API client by overriding the following methods:

```dart
/// * [T] is the type of the response data
class MainBase<T> extends DioApiClient<T> {
  @override
  List<Interceptor> get interceptors => [authInterceptor, logInterceptor];

  @override
  Duration get cacheDuration => Duration.zero;

  @override
  String get endpoint => 'pub.dev/api/';

  @override
  String get path => 'packages/';
}


class PubPackage extends MainBase<T> {
  Future<T?> getPackage(String name) async {
    final response = await get(
      dynamicPath: name,
    );
    return response.data;
  }
}
```

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please [open an issue](https://github.com/mohesu/dio_api_client/issues). Additionally, feel free to submit pull requests with bug fixes or new features.

When contributing to this project, please follow the [code of conduct](https://github.com/mohesu/dio_api_client/blob/main/code_of_conduct.md).

## License

This package is open source and released under the [MIT License](https://github.com/mohesu/dio_api_client/blob/main/LICENSE). Feel free to use, modify, and distribute the package according to the terms of the license.

## Contact

If you have any questions or inquiries about the Flutter API Client, please contact [contact@mohesu.com](mailto:contact@mohesu.com).

## Authors

- [Hemant Kumar](https://github.com/heman4t)
- [Arvind Sangwan](https://github.com/rvndsngwn)

## Contributors

[![Contributors](https://contributors-img.web.app/image?repo=mohesu/dio_api_client)](https://github.com/mohesu/dio_api_client/graphs/contributors)

Happy coding! 💙 Flutter
