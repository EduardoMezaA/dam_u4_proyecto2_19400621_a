import 'package:dam_u4_proyecto2_19400621_a/model/Asignacion.dart';
import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class CapturaAsignacion extends StatefulWidget {
  const CapturaAsignacion({Key? key}) : super(key: key);

  @override
  State<CapturaAsignacion> createState() => _CapturaAsignacionState();
}

class _CapturaAsignacionState extends State<CapturaAsignacion> {
  final salonController = TextEditingController();
  final edificioController = TextEditingController();
  final horarioController = TextEditingController();
  final docenteController = TextEditingController();
  final materiaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

              await addAsignacion(a).then((_){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("SE INSERTÓ!"))
                );
                Navigator.pop(context);
              });
            }, child: const Text("Guardar"))
          ],
        )
    );
  }
}