import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../server/models/user.dart';
import '../../../../../../server/sockets/sockets.dart';
import 'add_user_popup.dart';

class GeneralDataWidget extends StatefulWidget {
  //final List<dynamic> users; // Lista de usuarios desde el backend

  //const GeneralDataWidget({Key? key}) : super(key: key);

  @override
  GeneralDataWidgetState createState() => GeneralDataWidgetState();
}

class GeneralDataWidgetState extends State<GeneralDataWidget> {
  // late IO.Socket _socket;

  //controllers
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

  // @override
  // void initState() {
  //   super.initState();
  //
  //   // final SocketClient socketClient =
  //   //     Provider.of<SocketClient>(context, listen: false);
  //   //
  //   // socketClient.socket.emit('client:getusers');
  // }

  @override
  void dispose() {
    // Dispose de los controladores para evitar memory leaks
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
    //  _socket.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SocketClient socketClient = Provider.of<SocketClient>(context);

    List<User> users = socketClient.users;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AddUserButton(),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos tarjetas por fila
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];

                return UserCard(
                  index: index,
                  user: user,
                  onEdit: (user, index) {
                    // Show the popup to edit the user
                    _showEditUserPopup(context, user, index);
                  },
                  onDelete: (index) {
                    socketClient.socket.emit(
                      "client:deleteuser",
                      user.password,
                    );
                    debugPrint("client:deleteuser ${user.password}");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditUserPopup(BuildContext context, User user, int index) {
    _positionController.text = user.position!;
    _municipalityNumberController.text = user.municipalityNumber.toString();
    _lastNameController.text = user.lastName!;

    _firstNameController.text = user.firstName!;
    _genderController.text = user.gender!;
    _partyController.text = user.party!;
    _startDateController.text = user.startDate as String;
    _endDateController.text = user.endDate as String;
    _memberStatusController.text = user.memberStatus!;
    _passwordController.text = user.password!;

    showDialog(
      context: context,
      builder: (context) {
        // Aquí debes crear el contenido del popup con los textfields para editar el usuario
        return AlertDialog(
          title: Text('Editar Usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Aquí los textfields para editar cada propiedad del usuario
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(labelText: 'Cargo'),
                ),
                TextFormField(
                  controller: _municipalityNumberController,
                  decoration: InputDecoration(labelText: 'Número de Municipio'),
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Apellido'),
                ),

                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Género'),
                ),
                TextFormField(
                  controller: _partyController,
                  decoration: InputDecoration(labelText: 'Partido'),
                ),
                TextFormField(
                  controller: _startDateController,
                  decoration: InputDecoration(labelText: 'Fecha de Inicio'),
                ),
                TextFormField(
                  controller: _endDateController,
                  decoration: InputDecoration(labelText: 'Fecha de Fin'),
                ),
                TextFormField(
                  controller: _memberStatusController,
                  decoration: InputDecoration(labelText: 'Estado de Membresía'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final SocketClient socketClient =
                    Provider.of<SocketClient>(context, listen: false);

                // Crear un mapa con los datos del usuario actualizado
                Map<String, dynamic> updatedUserData = {
                  "index": index,
                  "position": _positionController.text,
                  "municipalityNumber":
                      int.tryParse(_municipalityNumberController.text) ?? 0,
                  "last_name": _lastNameController.text,
                  "first_name": _firstNameController.text,
                  "gender": _genderController.text,
                  "party": _partyController.text,
                  "start_date": DateTime.tryParse(_startDateController.text)
                          ?.toString() ??
                      DateTime.now().toString(),
                  "end_date":
                      DateTime.tryParse(_endDateController.text)?.toString(),
                  "member_status": _memberStatusController.text,
                  "password": _passwordController.text,
                };

                // Enviar los datos del usuario actualizado al servidor
                // socketClient.socket.emit('client:updateuser', updatedUserData);

                // Cerrar el popup
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                // Cerrar el popup sin guardar cambios
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final Function(User, int) onEdit;
  final Function(int) onDelete;
  final int index;

  const UserCard({
    Key? key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle_sharp,
                    color: Colors.black,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Nombre: ${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Cargo: ${user.position}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Género: ${user.gender}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Número de Municipio: ${user.municipalityNumber}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Partido: ${user.party}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Contraseña: ${user.password}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F3F3),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => onEdit(user, index),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      'Editar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onDelete(index),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      'Eliminar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
