import 'package:cb_project/src/auth/admin/views/components/admin_page_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../server/models/user.dart';
import '../../../../server/sockets/sockets.dart';
import '../../controllers/general_data_controller.dart';

class GeneralDataView extends StatefulWidget {
  const GeneralDataView({super.key});

  @override
  State<GeneralDataView> createState() => _GeneralDataViewState();
}

class _GeneralDataViewState extends State<GeneralDataView> {

  @override
  void didChangeDependencies() {
    final SocketClient _socketClient = Provider.of<SocketClient>(context);
    _socketClient.socket.emit('client:requestgeneraldata');
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {


    final generalDataProvider = Provider.of<GeneralDataProvider>(context,listen: false);
    final generalData = generalDataProvider.generalData;

    if (generalData == null) {
      // If generalData is null, show a loading state or an error message
      return const Center(
        child: CircularProgressIndicator(), // Show a loading indicator
        // Or show an error message
        // child: Text('Error: General data not available.'),
      );
    }




    return Stack(
      children: [
        Positioned(
          bottom: 15,
          right: 15,
          child: FloatingActionButton(
            onPressed: () {
              // Mostrar el popup para agregar un nuevo usuario
              // _showAddUserPopup(context);
            },
            child: const Text('Agregar Usuario'),
          ),
        ),
        AdminPageTemplate(
          pageTitle: "Datos Generales",
          pageSubtitle:
              "Actualiza la información clave del Ayuntamiento, como los nombres de los gobernantes y otros detalles relevantes.",
          content: SizedBox(
            height: 10000000,
            child: GeneralidadesView(users: generalData.users,),
          ),
        ),
      ],
    );
  }
}

class GeneralidadesView extends StatefulWidget {

  final List<User> users; // Lista de usuarios desde el backend

  const GeneralidadesView({required this.users, Key? key}) : super(key: key);

  @override
  _GeneralidadesViewState createState() => _GeneralidadesViewState();
}

class _GeneralidadesViewState extends State<GeneralidadesView> {
  // Controladores para los campos del usuario en el popup de agregar/editar
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _municipalityNumberController =
      TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _partyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _memberStatusController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose de los controladores para evitar memory leaks
    _positionController.dispose();
    _municipalityNumberController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              _showAddUserPopup(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.black),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                'Agregar Usuario',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos tarjetas por fila
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.users.length,
              itemBuilder: (context, index) {
                User user = widget.users[index];
                return UserCard(
                  index: index,
                  user: user,
                  onEdit: (user, index) {
                    // Show the popup to edit the user
                    _showEditUserPopup(context, user, index);
                  },
                  onDelete: (index) {
                    // Remove the user from the list
                    setState(() {
                      widget.users.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para mostrar el popup para agregar un nuevo usuario
  void _showAddUserPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Aquí debes crear el contenido del popup con los textfields para agregar un nuevo usuario
        return AlertDialog(
          title: Text('Agregar Usuario'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Aquí los textfields para agregar cada propiedad del usuario
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
                  controller: _middleNameController,
                  decoration: InputDecoration(labelText: 'Segundo Nombre'),
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
                // Agregar el nuevo usuario a la lista y cerrar el popup
                setState(() {
                  widget.users.add(
                    User(
                      position: _positionController.text,
                      municipalityNumber:
                          int.tryParse(_municipalityNumberController.text) ?? 0,
                      last_name: _lastNameController.text,

                      first_name: _firstNameController.text,
                      gender: _genderController.text,
                      party: _partyController.text,
                      start_date:
                          DateTime.tryParse(_startDateController.text) ??
                              DateTime.now(),
                      end_date: DateTime.tryParse(_endDateController.text),
                      member_status: _memberStatusController.text,
                      password: _passwordController.text,
                    ),
                  );
                  // Limpiar los campos del popup
                  _positionController.clear();
                  _municipalityNumberController.clear();
                  _lastNameController.clear();
                  _middleNameController.clear();
                  _firstNameController.clear();
                  _genderController.clear();
                  _partyController.clear();
                  _startDateController.clear();
                  _endDateController.clear();
                  _memberStatusController.clear();
                  _passwordController.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                // Cerrar el popup sin agregar el nuevo usuario
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar el popup para editar un usuario existente
  void _showEditUserPopup(BuildContext context, User user, int index) {
    // Setear los valores iniciales de los controladores con los datos actuales del usuario
    _positionController.text = user.position!;
    _municipalityNumberController.text = user.municipalityNumber.toString();
    _lastNameController.text = user.last_name!;

    _firstNameController.text = user.first_name!;
    _genderController.text = user.gender!;
    _partyController.text = user.party!;
    _startDateController.text = user.start_date?.toString() ?? '';
    _endDateController.text = user.end_date?.toString() ?? '';
    _memberStatusController.text = user.member_status!;
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
                  controller: _middleNameController,
                  decoration: InputDecoration(labelText: 'Segundo Nombre'),
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
                // Actualizar la información del usuario en la lista y cerrar el popup
                setState(() {
                  widget.users[index] = User(
                    position: _positionController.text,
                    municipalityNumber:
                        int.tryParse(_municipalityNumberController.text) ?? 0,
                    last_name: _lastNameController.text,

                    first_name: _firstNameController.text,
                    gender: _genderController.text,
                    party: _partyController.text,
                    start_date: DateTime.tryParse(_startDateController.text) ??
                        DateTime.now(),
                    end_date: DateTime.tryParse(_endDateController.text),
                    member_status: _memberStatusController.text,
                    password: _passwordController.text,
                  );
                });
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
      color: Color(0xFFF5F5F5),
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
                  const CircleAvatar(
                    backgroundColor: Color(0xFFBDBDBD),
                    radius: 32,
                    child: FlutterLogo(),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Nombre: ${user.first_name} ${user.last_name}',
                      style: TextStyle(
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Género: ${user.gender}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Número de Municipio: ${user.municipalityNumber}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Partido: ${user.party}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Estado de Membresía: ${user.member_status}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
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
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      'Editar',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onDelete(index),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
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
