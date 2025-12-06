import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/mi_material_app.dart';
import 'package:flutter_application_1/providers/provider_task.dart';
import 'package:provider/provider.dart';

class ProviderBuild extends StatelessWidget {
  const ProviderBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderTask>(
          create: (BuildContext context) => ProviderTask(),
        ),
      ],
      child: MiMaterialApp(),
    );
  }
}
