import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider_learning/models/cart_model.dart';
import 'package:provider_learning/models/cart_provider.dart';
import 'package:provider_learning/utils/routes.dart';
import 'package:provider_learning/utils/routes_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);

  Hive.registerAdapter(CartAdapter());
  await Hive.openBox<Cart>('addproduct');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            title: 'Provider',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            // home: const ProductPageList(),
            initialRoute: RoutesName.ProductPage,
            onGenerateRoute: Routes.getRoutes,
          );
        },
      ),
    );
  }
}
