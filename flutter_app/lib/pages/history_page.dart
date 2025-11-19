import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget { @override State<HistoryPage> createState()=>_HistoryPageState(); }
class _HistoryPageState extends State<HistoryPage> {
  List items=[];
  @override void initState(){ super.initState(); fetch(); }
  fetch() async {
    final auth = Provider.of<AuthService>(context, listen:false);
    items = await auth.fetchHistory();
    setState(()=>{});
  }
  @override Widget build(BuildContext c) => Scaffold(appBar: AppBar(title:Text('History')), body: ListView.builder(itemCount:items.length,itemBuilder:(cx,i){
    final it = items[i];
    return ListTile(title:Text(it['type']), subtitle:Text(it['note'] ?? ''), trailing:Text('₹${it['amount']}'));
  }));
}