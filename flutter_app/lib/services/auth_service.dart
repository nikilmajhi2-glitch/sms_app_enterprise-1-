import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService extends ChangeNotifier {
  String? token;
  String? userPhone;
  bool get isAuthenticated => token != null;
  Future<void> loadToken() async {
    final sp = await SharedPreferences.getInstance();
    token = sp.getString('token');
    userPhone = sp.getString('phone');
  }
  Future<bool> login(String phone, String password) async {
    final res = await http.post(Uri.parse('http://10.0.2.2:5000/auth/login'), headers:{'Content-Type':'application/json'}, body: jsonEncode({'phone':phone,'password':password}));
    if(res.statusCode==200){
      final d = jsonDecode(res.body);
      token = d['token'];
      userPhone = phone;
      final sp = await SharedPreferences.getInstance();
      await sp.setString('token', token!); await sp.setString('phone', phone);
      notifyListeners();
      return true;
    }
    return false;
  }
  Future<bool> register(String phone, String password) async {
    final res = await http.post(Uri.parse('http://10.0.2.2:5000/auth/register'), headers:{'Content-Type':'application/json'}, body: jsonEncode({'phone':phone,'password':password}));
    return res.statusCode==201;
  }
  Future<List> fetchHistory() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token') ?? '';
    final res = await http.get(Uri.parse('http://10.0.2.2:5000/user/history'), headers: {'Authorization':'Bearer '+token});
    if(res.statusCode==200) return List.from(jsonDecode(res.body));
    return [];
  }
}