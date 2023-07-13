# Dio API Client

[![Pub Version](https://img.shields.io/pub/v/dio_dio_api_client?color=blue)](https://pub.dev/packages/dio_dio_api_client)
![GitHub License](https://img.shields.io/github/license/rvndsngwn/dio_dio_api_client)

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
import 'package:dio_dio_api_client/dio_dio_api_client.dart';
```

2. Create an instance of the `FlutterApiClient` class:

```dart
final apiClient = FlutterApiClient();
```

3. Make API requests:

```dart
try {
  final response = await apiClient.get('https://api.example.com/users');
  // Process the response
} catch (e) {
  // Handle the error
}
```

For more detailed usage instructions and examples, please refer to the [API documentation](link-to-api-docs).

## Configuration

The Flutter API Client can be customized by providing a configuration object during initialization:

```dart
final apiClient = FlutterApiClient(
  options: ApiClientOptions(
    baseUrl: 'https://api.example.com',
    headers: {'Authorization': 'Bearer <your-token>'},
    timeout: Duration(seconds: 10),
  ),
);
```

The available configuration options include:

- `baseUrl`: The base URL of your API.
- `headers`: Additional headers to include in every request.
- `timeout`: The maximum duration to wait for a response before timing out.

For a full list of available options, please refer to the [API documentation](link-to-api-docs).

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please [open an issue](link-to-issue-tracker). Additionally, feel free to submit pull requests with bug fixes or new features.

When contributing to this project, please follow the [code of conduct](link-to-code-of-conduct).

## License

This package is open source and released under the [MIT License](link-to-license). Feel free to use, modify, and distribute the package according to the terms of the license.

## Contact

If you have any questions or inquiries about the Flutter API Client, please contact [contact@mohesu.com](mailto:contact@mohesu.com).

Happy coding!

[rvndsngwn](https://github.com/rvndsngwn)
