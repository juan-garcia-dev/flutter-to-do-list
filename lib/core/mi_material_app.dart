import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ventana_principal.dart';

class MiMaterialApp extends StatelessWidget {
  const MiMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VentanaPrincipal(),debugShowCheckedModeBanner: false,);
  }
}