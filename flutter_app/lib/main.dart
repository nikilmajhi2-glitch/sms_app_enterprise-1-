import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sms_enterprise_app/services/auth_service.dart';
import 'package:sms_enterprise_app/pages/splash_page.dart';
import 'package:sms_enterprise_app/pages/login_page.dart';
import 'package:sms_enterprise_app/pages/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'SMS Enterprise',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}