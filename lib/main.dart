import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_en/firebase_options.dart';
import 'package:shopsmart_users_en/providers/cart_provider.dart';
import 'package:shopsmart_users_en/providers/order_provider.dart';
import 'package:shopsmart_users_en/providers/products_provider.dart';
import 'package:shopsmart_users_en/providers/theme_provider.dart';
import 'package:shopsmart_users_en/providers/user_provider.dart';
import 'package:shopsmart_users_en/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users_en/providers/wishlist_provider.dart';
import 'package:shopsmart_users_en/screens/auth/forgot_password.dart';
import 'package:shopsmart_users_en/screens/auth/login.dart';
import 'package:shopsmart_users_en/screens/auth/register.dart';
import 'package:shopsmart_users_en/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users_en/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users_en/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users_en/screens/search_screen.dart';
import 'package:shopsmart_users_en/root_screen.dart';
import 'package:shopsmart_users_en/consts/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BalochDev Shopping',
      theme: ThemeData(
        // Your theme data
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => ProductsProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => WishlistProvider()),
              ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => OrderProvider()),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context,
                  ),
                  home: const RootScreen(),
                  routes: {
                    RootScreen.routeName: (context) => const RootScreen(),
                    ProductDetailsScreen.routName: (context) => const ProductDetailsScreen(),
                    WishlistScreen.routName: (context) => const WishlistScreen(),
                    ViewedRecentlyScreen.routName: (context) => const ViewedRecentlyScreen(),
                    RegisterScreen.routName: (context) => const RegisterScreen(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
                    ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
                    SearchScreen.routeName: (context) => const SearchScreen(),
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
