import 'package:felimma_admin/providers/service.dart';
import 'package:flutter/material.dart';
import 'package:felimma_admin/providers/app_states.dart';
import 'package:felimma_admin/providers/category.dart';
import 'package:felimma_admin/providers/user.dart';
import 'package:felimma_admin/screens/dashboard.dart';
import 'package:felimma_admin/screens/login.dart';
import 'package:felimma_admin/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
//        ChangeNotifierProvider.value(value: ClientProvider.initialize()),
        ChangeNotifierProvider.value(value: ServiceProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return DashboardScreen();
      default:
        return LoginScreen();
    }
  }
}
