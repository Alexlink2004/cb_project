import 'package:flutter/material.dart';

import '../../../login_screen/login_handler.dart';

class LogOutButton extends StatefulWidget {
  @override
  _LogOutButtonState createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text("¿Estás seguro de cerrar sesión?"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acciones para cerrar sesión y cerrar pestañas
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(LoginHandler.id);
                    },
                    child: const Text("Sí"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Acciones para cerrar solo la ventana emergente
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color:
                _isHovered ? Colors.grey.withOpacity(0.25) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 40,
                color: _isHovered ? Colors.white : Colors.grey,
              ),
              const SizedBox(width: 4),
              Text(
                "Cerrar sesión",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: _isHovered ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
