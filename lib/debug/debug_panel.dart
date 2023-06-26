import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:flutter/material.dart';

class DebugPanel extends StatelessWidget {
  const DebugPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.666,
      height: 137,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'Debug Panel (No mostrar en release)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildButton(
                context,
                'Admin',
                routeName: AdminView.id,
                color: Colors.grey.withOpacity(0.1),
              ),
              _buildButton(
                context,
                'Presidente',
                routeName: '/presidente',
                color: Colors.grey.withOpacity(0.3),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildButton(
                context,
                'Secretario',
                routeName: '/secretario',
                color: Colors.grey.withOpacity(0.5),
              ),
              _buildButton(
                context,
                'Regidor',
                routeName: '/regidor',
                color: Colors.grey.withOpacity(0.7),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildButton(
                context,
                'TV',
                routeName: '/tv',
                color: Colors.grey.withOpacity(0.9),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String buttonText, {
    required String routeName,
    required Color color,
  }) {
    return SizedBox(
      width: 90,
      height: 25,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            routeName,
          );
        },
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
