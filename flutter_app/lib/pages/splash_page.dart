import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'dashboard_page.dart';

class SplashPage extends StatefulWidget { @override State<SplashPage> createState() => _SplashPageState(); }
class _SplashPageState extends State<SplashPage> {
  @override void initState(){ super.initState(); check(); }
  check() async {
    final auth = Provider.of<AuthService>(context, listen:false);
    await auth.loadToken();
    await Future.delayed(Duration(milliseconds:700));
    if (auth.isAuthenticated) Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>DashboardPage()));
    else Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>LoginPage()));
  }
  @override Widget build(BuildContext c) => Scaffold(body: Center(child:CircularProgressIndicator()));
}