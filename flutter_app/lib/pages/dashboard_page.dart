import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/target_service.dart';
import '../services/auth_service.dart';
import 'send_page.dart';
import 'history_page.dart';

class DashboardPage extends StatefulWidget { @override State<DashboardPage> createState()=>_DashboardPageState(); }
class _DashboardPageState extends State<DashboardPage> {
  @override Widget build(BuildContext c){
    final auth = Provider.of<AuthService>(context);
    return Scaffold(appBar: AppBar(title:Text('Dashboard (${auth.userPhone ?? ''})')), body: Center(child:Column(children:[
      ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>SendPage())), child: Text('Send SMS')),
      ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>HistoryPage())), child: Text('History')),
    ])));
  }
}