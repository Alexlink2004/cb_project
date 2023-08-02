import 'package:flutter/material.dart';

import '../models/general_data.dart';

class GeneralDataProvider extends ChangeNotifier {
  GeneralData? _data;
  // Getter para obtener los datos generales
  GeneralData? get generalData {
    return _data;
  }

  set generalData(GeneralData? data) {
    _data = data;
  }
}
