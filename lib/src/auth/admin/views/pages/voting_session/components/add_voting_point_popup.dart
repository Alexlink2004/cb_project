import 'package:cb_project/src/auth/admin/controllers/voting_point_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../server/models/voting_point.dart';

class AddVotingPointPopup extends StatefulWidget {
  const AddVotingPointPopup({super.key});

  @override
  _AddVotingPointPopupState createState() => _AddVotingPointPopupState();
}

class _AddVotingPointPopupState extends State<AddVotingPointPopup> {
  final TextEditingController _commissionController = TextEditingController();
  final TextEditingController _requiredVotesController =
      TextEditingController();
  final TextEditingController _votingFormController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _commissionController.dispose();
    _requiredVotesController.dispose();
    _votingFormController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black), // Texto negro
          hintText: 'Ingrese $labelText', // Hint negro
          hintStyle: const TextStyle(color: Colors.black), // Hint negro
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
            ), // Color de borde al estar enfocado
          ),
          filled: true,
          fillColor: Colors.grey[200], // Fondo gris claro
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final VotingPointController votingPointController =
        Provider.of<VotingPointController>(context);
    return AlertDialog(
      title: const Text(
        'Agregar Punto de Votación',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 800,
        height: 300,
        child: SingleChildScrollView(
          child: Row(
            children: [
              SizedBox(
                width: 380,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildTextField('Comisión', _commissionController),
                    _buildTextField(
                        'Votos Requeridos', _requiredVotesController),
                    _buildTextField('Forma de Votación', _votingFormController),
                    _buildTextField('Asunto', _subjectController),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  width: 400,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 13, // Múltiples líneas
                    style: const TextStyle(color: Colors.black), // Texto negro
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      labelStyle:
                          const TextStyle(color: Colors.black), // Texto negro
                      hintText:
                          'Ingrese una descripción del punto', // Hint negro
                      hintStyle:
                          const TextStyle(color: Colors.black), // Hint negro
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.black), // Cambiado a negro
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ), // Color de borde al estar enfocado
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], // Fondo gris claro
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar la ventana emergente
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Uuid uuid = const Uuid();
            String id = uuid.v4();
            VotingPoint newVotingPoint = VotingPoint(
              commision: _commissionController.text,
              requiredVotes: _requiredVotesController.text,
              votingForm: _votingFormController.text,
              subject: _subjectController.text,
              description: _descriptionController.text,
              votesAbstain: [],
              votesAgainst: [],
              votesFor: [],
              id: id,
            );
            votingPointController.createVotingPoint(newVotingPoint);
            Navigator.of(context).pop(); // Cerrar la ventana emergente
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
