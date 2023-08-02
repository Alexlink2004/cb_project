import 'package:cb_project/src/server/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserButton extends StatefulWidget {
  const AddUserButton({
    super.key,
  });

  @override
  AddUserButtonState createState() => AddUserButtonState();
}

class AddUserButtonState extends State<AddUserButton> {
  // final TextStyle _textStyle =
  //     const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(10.0);
  final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.grey),
  );
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _municipalityNumberController =
      TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _memberStatusController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SocketClient socket = Provider.of<SocketClient>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.black),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Agregar Usuario'),
              content: SizedBox(
                width: 500,
                child: Column(
                  children: [
                    _buildTextField('Apellido', _lastNameController),
                    _buildTextField('Nombre', _firstNameController),
                    GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 3.0,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 8.0,
                      shrinkWrap: true,
                      children: [
                        _buildTextField('Cargo', _positionController),
                        _buildTextField('Número de Municipio',
                            _municipalityNumberController),
                        _buildTextField('Género', _genderController),
                        _buildTextField('Partido', _partyController),
                        _buildTextField(
                            'Fecha de Inicio', _startDateController),
                        _buildTextField('Fecha de Fin', _endDateController),
                        _buildTextField(
                            'Estado de Membresía', _memberStatusController),
                        _buildTextField('Contraseña', _passwordController),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    socket.socket.emit('client:adduser', {
                      'position': _positionController.value.text,
                      'municipalityNumber':
                          _municipalityNumberController.value.text,
                      'last_name': _lastNameController.value.text,
                      'first_name': _firstNameController.value.text,
                      'gender': _genderController.value.text,
                      'party': _partyController.value.text,
                      'start_date': _startDateController.value.text,
                      'end_date': _endDateController.value.text,
                      'member_status': _memberStatusController.value.text,
                      'password': _passwordController.value.text,
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
                TextButton(
                  onPressed: () {
                    // Cerrar el popup sin agregar el nuevo usuario
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
        debugPrint("Add user clicked");
      },
      child: const Text('Agregar Usuario'),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: _outlineInputBorder,
      ),
    );
  }
}
