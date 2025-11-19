import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/target_service.dart';
import '../services/auth_service.dart';
import 'package:telephony/telephony.dart';

final Telephony telephony = Telephony.instance;

class SendPage extends StatefulWidget { @override State<SendPage> createState()=>_SendPageState(); }
class _SendPageState extends State<SendPage> {
  bool loading=false;
  List targets=[];
  @override void initState(){ super.initState(); fetch(); }
  fetch() async {
    setState(()=>loading=true);
    targets = await TargetService.fetchTargets();
    setState(()=>loading=false);
  }
  sendTo(target) async {
    final ok = await telephony.requestSmsPermissions;
    if(!ok){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SMS permission required'))); return; }
    setState(()=>loading=true);
    // send SMS using device
    await telephony.sendSms(to: target['number'], message: 'Hello from app');
    // report proof
    await TargetService.reportProof(target['number'], 'Hello from app');
    setState(()=>loading=false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Reported, wait for credit')));
  }
  @override Widget build(BuildContext c) => Scaffold(appBar: AppBar(title:Text('Send SMS')), body: loading?Center(child:CircularProgressIndicator()):ListView.builder(itemCount:targets.length,itemBuilder:(cx,i){
    final t = targets[i];
    return ListTile(title:Text(t['number']), subtitle:Text(t['note'] ?? ''), trailing: ElevatedButton(onPressed: ()=>sendTo(t), child: Text('Send')));
  }));
}