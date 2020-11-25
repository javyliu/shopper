import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopper/models/cart.dart';

import 'common/theme.dart';
import 'models/catalog.dart';
import 'screens/cart.dart';
import 'screens/catalog.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("-- my app build");

    ///提供多个对象时，使用MultiProvider很方便。
    return MultiProvider(
      providers: [
        ///在此示例应用程序中，CatalogModel永不更改，因此一个简单的Provider 足够了。
        Provider(
          create: (context) {
            log("-- first provider create");

            return CatalogModel();
          },
        ),

        ///CartModel被实现为ChangeNotifier，它需要使用ChangeNotifierProvider。
        ///而且，CartModel取决于在CatalogModel上，因此需要ProxyProvider。
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) {
            log("-- proxy provider create");

            return CartModel();
          },
          update: (context, value, previous) {
            log("-- proxy provider update");
            previous.catalog = value;
            return previous;
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
