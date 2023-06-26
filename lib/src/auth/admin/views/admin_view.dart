import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  static const id = '/adminDashboard';
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin View'),
      ),
      body: Center(
        child: Text(
          'Bienvenido al panel de administración',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
