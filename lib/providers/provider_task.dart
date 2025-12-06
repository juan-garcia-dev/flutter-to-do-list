import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/tarea.dart';

class ProviderTask with ChangeNotifier {
  List<Tarea> tareas = [
    Tarea(titulo: "Poner colada", completada: false),
    Tarea(titulo: "Hacer deberes", completada: false),
    Tarea(titulo: "Sacar al perro", completada: false),

  ];

  void cambiarEstado(Tarea tarea) {
    int index = getTareas.indexOf(tarea);
    getTareas[index].completada = !getTareas[index].completada;
    notifyListeners();
  }

  void addTarea(String titulo, bool completada) {
    tareas.add(Tarea(titulo: titulo, completada: completada));
    notifyListeners();
  }

  String tipoActual = "todos";

  void setTipo(String tipo) {
    tipoActual = tipo;
    notifyListeners();
  }

  List<Tarea> get getTareas {
    if (tipoActual == "completadas") {
      return tareas.where((element) => element.completada).toList();
    } else if (tipoActual == "pendientes") {
      return tareas.where((element) => element.completada == false).toList();
    } else {
      return tareas;
    }
  }

}
