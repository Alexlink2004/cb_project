import 'package:flutter/material.dart';

import '../../components/voting_system_template.dart';

class AldermanView extends StatelessWidget {
  static const String id = '/aldermanView';
  const AldermanView({super.key});

  @override
  Widget build(BuildContext context) {
    return VotingSystemTemplate(
      body: Placeholder(),
    );
  }
}
