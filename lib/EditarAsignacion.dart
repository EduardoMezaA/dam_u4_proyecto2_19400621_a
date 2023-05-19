import 'package:dam_u4_proyecto2_19400621_a/model/Asignacion.dart';
import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class EditarAsignacion extends StatefulWidget {
  const EditarAsignacion({Key? key}) : super(key: key);

  @override
  State<EditarAsignacion> createState() => _EditarAsignacionState();
}

class _EditarAsignacionState extends State<EditarAsignacion> {
  final salonController = TextEditingController();
  final edificioController = TextEditingController();
  final horarioController = TextEditingController();
  final docenteController = TextEditingController();
  final materiaController = TextEditingController();
  final idC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    salonController.text = arguments['salon'];
    edificioController.text = arguments['edificio'];
    horarioController.text = arguments['horario'];
    docenteController.text = arguments['docente'];
    materiaController.text = arguments['materia'];
    idC.text = arguments['id'];
    return Scaffold(
        appBar: AppBar(title: const Text("Capturar Asignación", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.deepOrange, centerTitle: true,),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(
              decoration: InputDecoration(labelText: "SALON"),
              controller: salonController, autofocus: true,
            ),
            TextField(
              decoration: InputDecoration(labelText: "EDIFICIO"),
              controller: edificioController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "HORARIO"),
              controller: horarioController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "DOCENTE"),
              controller: docenteController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "MATERIA"),
              controller: materiaController,
            ),

            FilledButton(onPressed: () async{
              Asignacion a = Asignacion(
                  salon: salonController.text,
                  edificio: edificioController.text,
                  horario: horarioController.text,
                  docente: docenteController.text,
                  materia: materiaController.text
              );

              await updateAsignacion(arguments['id'], a).then((value){
                Navigator.pop(context);
                Navigator.pop(context);
              });
            }, child: const Text("Guardar"))
          ],
        )
    );
  }
}