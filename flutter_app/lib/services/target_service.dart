import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class TargetService {
  static Future<List> fetchTargets() async {
    final res = await http.get(Uri.parse('http://10.0.2.2:5000/targets'));
    if(res.statusCode==200) return List.from(jsonDecode(res.body));
    return [];
  }
  static Future<Map> reportProof(String target, String text) async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    final res = await http.post(Uri.parse('http://10.0.2.2:5000/sms/proof'), headers: {'Content-Type':'application/json','Authorization':'Bearer '+token}, body: jsonEncode({'target':target,'text':text,'sentAt':DateTime.now().toIso8601String()}));
    if(res.statusCode==200) return Map.from(jsonDecode(res.body));
    throw Exception('report failed');
  }
}