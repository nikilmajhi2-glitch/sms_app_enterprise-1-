import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget { @override State<RegisterPage> createState()=>_RegisterPageState(); }
class _RegisterPageState extends State<RegisterPage> {
  final phone = TextEditingController(), pass = TextEditingController();
  bool loading=false;
  register() async {
    setState(()=>loading=true);
    final auth = Provider.of<AuthService>(context, listen:false);
    final ok = await auth.register(phone.text.trim(), pass.text.trim());
    setState(()=>loading=false);
    if(ok) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered'))); Navigator.pop(context); }
    else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register failed')));
  }
  @override Widget build(BuildContext c) => Scaffold(appBar: AppBar(title:Text('Register')), body: Padding(padding:EdgeInsets.all(16), child: Column(children:[
    TextField(controller: phone, decoration: InputDecoration(labelText:'Phone')),
    TextField(controller: pass, decoration: InputDecoration(labelText:'Password'), obscureText:true),
    SizedBox(height:12),
    ElevatedButton(onPressed: loading?null:register, child: loading?CircularProgressIndicator(color:Colors.white):Text('Register')),
  ])));
}