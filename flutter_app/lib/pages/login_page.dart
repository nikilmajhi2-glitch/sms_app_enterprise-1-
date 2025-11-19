import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'register_page.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget { @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final phone = TextEditingController(), pass = TextEditingController();
  bool loading=false;
  login() async {
    setState(()=>loading=true);
    final auth = Provider.of<AuthService>(context, listen:false);
    final ok = await auth.login(phone.text.trim(), pass.text.trim());
    setState(()=>loading=false);
    if(ok) Navigator.pushReplacement(context, MaterialPageRoute(builder:(_)=>DashboardPage()));
    else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
  }
  @override Widget build(BuildContext c) => Scaffold(appBar: AppBar(title:Text('Login')), body: Padding(padding:EdgeInsets.all(16), child: Column(children:[
    TextField(controller: phone, decoration: InputDecoration(labelText:'Phone')),
    TextField(controller: pass, decoration: InputDecoration(labelText:'Password'), obscureText:true),
    SizedBox(height:12),
    ElevatedButton(onPressed: loading?null:login, child: loading?CircularProgressIndicator(color:Colors.white):Text('Login')),
    TextButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>RegisterPage())), child: Text('Create account'))
  ])));
}