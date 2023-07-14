import 'package:dio/src/dio_mixin.dart';
import 'package:dio_api_client/dio_api_client.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioApiClient.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio Api Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dio Api Client by Mohesu.com'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller =
      TextEditingController(text: "map_location_picker");

  @override
  void initState() {
    final user = User(
      name: "Mohesu",
      address: "#1268",
      email: "contact@mohesu.com",
      isVerified: true,
      password: "123456",
      token: "9adf88fa-359d-4dcb-89a3-b3628f40ee22",
    );
    User.setUser(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search your package',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pubPackage = PubPackage();
          await pubPackage.getPackage(_controller.text);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// * This is a config class that extends [DioApiClient] and implements (method 1)
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

/// * This is a service class that extends [DioApiClient] and implements (method 1)
class PubPackage extends MainBase<Map<String, dynamic>?> {
  Future<Map<String, dynamic>?> getPackage(String name) async {
    final response = await get(
      dynamicPath: name,
    );
    return response.data;
  }
}

/// * This is a service class that extends [DioApiClient] and implements (method 2)
/// Directly extends [DioApiClient] and implements [fromMap] and [path]
class ExampleClass extends DioApiClient<Map<String, dynamic>?> {
  @override
  Duration get cacheDuration => Duration.zero;

  @override
  String get endpoint => 'pub.dev/api/';

  @override
  String get path => 'packages/';

  @override
  get fromMap => (dynamic source) =>
      Map<String, dynamic>.from(source as Map<String, dynamic>);

  Future<Map<String, dynamic>?> getPackage(String name) async {
    final response = await get(
      dynamicPath: name,
    );
    return response.data;
  }
}
