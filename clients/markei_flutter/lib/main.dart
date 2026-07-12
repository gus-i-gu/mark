import 'package:flutter/material.dart';

import 'app/markei_app.dart';
import 'app/markei_composition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MarkeiApp(composition: MarkeiComposition.appPrivate()));
}
