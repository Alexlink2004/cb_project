
import 'package:cb_project/src/server/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../server/models/user.dart';

import '../models/general_data.dart';

class GeneralDataProvider extends ChangeNotifier {
  GeneralData? _data ;




  // Getter para obtener los datos generales
  GeneralData? get generalData {

    return _data;
  }

  set generalData (GeneralData? data){
    _data = data ;
  }
}
