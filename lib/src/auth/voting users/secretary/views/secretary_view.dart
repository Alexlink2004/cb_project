import 'package:cb_project/src/auth/voting%20users/components/voting_system_template.dart';
import 'package:flutter/material.dart';

class SecretaryView extends StatelessWidget {
  static const String id = '/secretaryView';
  const SecretaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return VotingSystemTemplate(
      role: "Secretario",
      body: Placeholder(),
    );
  }
}
