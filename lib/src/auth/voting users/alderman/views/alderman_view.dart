import 'package:cb_project/src/auth/voting%20users/components/voting_system_template.dart';
import 'package:flutter/material.dart';

class AldermanView extends StatelessWidget {
  static const String id = '/aldermanView';
  const AldermanView({super.key});

  @override
  Widget build(BuildContext context) {
    return VotingSystemTemplate(
      role: "Regidor",
      body: Placeholder(),
    );
  }
}
