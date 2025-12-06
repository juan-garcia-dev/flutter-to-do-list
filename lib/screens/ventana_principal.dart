import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/provider_task.dart';
import 'package:provider/provider.dart';

class VentanaPrincipal extends StatelessWidget {
  const VentanaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add),
        onPressed: () {
          openDialog(context);
        },
      ),
      appBar: AppBar(
        title: Text('Lista de tareas'),
       
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 8, child: MiLista()),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BotonSeleccion(titulo: "Todas", tipoTareas: "todos"),
                    BotonSeleccion(
                      titulo: "Completadas",
                      tipoTareas: "completadas",
                    ),
                    BotonSeleccion(
                      titulo: "Pendientes",
                      tipoTareas: "pendientes",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }

  Future<dynamic> openDialog(BuildContext context) {
    ProviderTask miProvider = Provider.of<ProviderTask>(context, listen: false);
    final TextEditingController controladorTexto = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Añadir Tareas"),
          content: TextField(autofocus: true, controller: controladorTexto),
          actions: [
            TextButton(
              onPressed: () {
                if (controladorTexto.text.isNotEmpty) {
                  miProvider.addTarea(controladorTexto.text, false);
                }
                Navigator.pop(context);
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}

class MiLista extends StatelessWidget {
  const MiLista({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderTask miProvider = Provider.of<ProviderTask>(context, listen: true);
    final lista = miProvider.getTareas;
    return lista.isEmpty
        ? Center(child: Text("No hay tareas disponibles"))
        : ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: ListTile(
                    tileColor: lista[index].completada
                        ? const Color.fromARGB(255, 213, 251, 168)
                        : const Color.fromARGB(255, 255, 172, 166),
                    title: Text(lista[index].titulo.toUpperCase()),
                    subtitle: Text(
                      "Estado: ${lista[index].completada ? "Completado" : "No completado"}",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        miProvider.cambiarEstado(lista[index]);
                      },
                      icon: lista[index].completada
                          ? Icon(Icons.close, size: 18)
                          : Icon(Icons.done, size: 18),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class BotonSeleccion extends StatelessWidget {
  const BotonSeleccion({
    super.key,
    required this.titulo,
    required this.tipoTareas,
  });
  final String titulo;
  final String tipoTareas;

  @override
  Widget build(BuildContext context) {
    ProviderTask miProvider = Provider.of<ProviderTask>(context, listen: true);
    bool seleccionado=miProvider.tipoActual==tipoTareas;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: seleccionado ? Colors.deepPurple[100] : Colors.white,
        foregroundColor: seleccionado ? Colors.deepPurple : Colors.black,
      ),
      onPressed: () {
        miProvider.setTipo(tipoTareas);

      },
      child: Text(titulo),
      
    );
  }
}
