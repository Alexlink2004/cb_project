import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../server/api/api_constants.dart';

class ChangeServerButton extends StatelessWidget {
  const ChangeServerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.black,
      ),
      label: const Text(
        'Cambiar dirección del servidor',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      onPressed: () async {
        String? newApiRoute = await _displayChangeServerDialog(context);
        if (newApiRoute != null && newApiRoute.isNotEmpty) {
          await ApiConstants.setApiRoute(newApiRoute);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
    );
  }

  Future<String?> _displayChangeServerDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar dirección del servidor'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Ingresa la nueva dirección del servidor',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}

class ServerAddressDisplay extends StatefulWidget {
  const ServerAddressDisplay({super.key});

  @override
  _ServerAddressDisplayState createState() => _ServerAddressDisplayState();
}

class _ServerAddressDisplayState extends State<ServerAddressDisplay> {
  String _currentAddress = ApiConstants.apiRoute;

  @override
  void initState() {
    super.initState();
    _loadCurrentAddress();
  }

  Future<void> _loadCurrentAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentAddress = prefs.getString('apiRoute') ?? ApiConstants.apiRoute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ChangeServerButton(),
        Text(
          'Dirección actual: ${ApiConstants.apiRoute}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
