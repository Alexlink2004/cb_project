import 'package:cb_project/src/auth/admin/controllers/general_data_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../server/models/user.dart';

final List<String> positions = [
  'Secretario',
  'Presidente',
  'Regidor',
  'Administrador',
];

final List<String> memberStatus = ['Activo', 'Inactivo'];

final List<String> genders = ['Masculino', 'Femenino'];

class AddUserButton extends StatefulWidget {
  const AddUserButton({super.key});

  @override
  _AddUserButtonState createState() => _AddUserButtonState();
}

class _AddUserButtonState extends State<AddUserButton> {
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _municipalityNumberController =
      TextEditingController(text: '24');
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _memberStatusController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set default values for controllers
    _positionController.text = positions[0];
    _genderController.text = genders[0];
    _memberStatusController.text = 'Activo';
    _partyController.text = 'sin-definir';
    _startDateController.text =
        '${DateTime.now().year - 2}-${DateTime.now().month}-${DateTime.now().day}';
    _endDateController.text =
        '${DateTime.now().year + 2}-${DateTime.now().month}-${DateTime.now().day}';
  }

  @override
  void dispose() {
    _positionController.dispose();
    _municipalityNumberController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _genderController.dispose();
    _partyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _memberStatusController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _generalDataContenController =
        Provider.of<GeneralDataContentController>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Nombre',
                              _firstNameController,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                              'Apellido',
                              _lastNameController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                              'Puesto',
                              _positionController,
                              positions,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                              'Número de Municipio',
                              _municipalityNumberController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                              'Género',
                              _genderController,
                              genders,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                              'Partido',
                              _partyController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateField(
                              'Fecha de Inicio',
                              _startDateController,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildDateField(
                              'Fecha de Fin',
                              _endDateController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildDropdownField(
                        'Estado de Membresía',
                        _memberStatusController,
                        memberStatus,
                      ),
                      const SizedBox(height: 8),
                      _buildTextField(
                        'Contraseña',
                        _passwordController,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final Map<String, dynamic> userAdded = {
                      'position': _positionController.value.text,
                      'municipalityNumber':
                          _municipalityNumberController.value.text,
                      'lastName': _lastNameController.value.text,
                      'firstName': _firstNameController.value.text,
                      'gender': _genderController.value.text,
                      'party': _partyController.value.text,
                      'startDate': _startDateController.value.text,
                      'endDate': _endDateController.value.text,
                      'memberStatus': _memberStatusController.value.text,
                      'password': _passwordController.value.text,
                      'memberPhoto': '',
                    };

                    _generalDataContenController.addUser(
                      User.fromJson(
                        userAdded,
                      ),
                    );

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String labelText,
    TextEditingController controller,
    List<String> items,
  ) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          controller.text = value!;
        });
      },
    );
  }

  Widget _buildDateField(String labelText, TextEditingController controller) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (date != null) {
          String formattedDate =
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
          setState(() {
            controller.text = formattedDate;
          });
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
