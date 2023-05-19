import 'package:dam_u4_proyecto2_19400621_a/model/Asistencia.dart';
import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';

class CapturarAsistencia extends StatefulWidget {
  const CapturarAsistencia({Key? key}) : super(key: key);

  @override
  State<CapturarAsistencia> createState() => _CapturarAsistenciaState();
}

class _CapturarAsistenciaState extends State<CapturarAsistencia> {
  final fechaController = TextEditingController();
  final revisorController = TextEditingController();

  TextEditingController idController = TextEditingController(text: "");
  TextEditingController mController = TextEditingController(text: "");

  String _selectedDate = 'Seleccione fecha de asistencia';

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    idController.text = arguments['id'];
    mController.text = arguments['materia'];
    return Scaffold(
        appBar: AppBar(title: const Text("Capturar Asistencia", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.deepOrange, centerTitle: true,),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            Text("FECHA", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

            SizedBox(height: 20,),

            OutlinedButton(onPressed: (){
              _selectDate(context);
            }, child: Text((_selectedDate).substring(0,10))),

            SizedBox(height: 30,),

            TextField(
              decoration: InputDecoration(labelText: "REVISOR"),
              controller: revisorController,
            ),

            SizedBox(height: 20,),

            FilledButton(onPressed: () async{
              Asistencia a = Asistencia(
                fecha_hora: (fechaController.text).substring(0,16),
                revisor: revisorController.text,
                materia: mController.text,
              );

              await addAsistencia(idController.text, a).then((_){
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2010),
      maxTime: DateTime(2025),
      onConfirm: (date) {
        setState(() {
          fechaController.text = date.toString();
          _selectedDate = date.toString();
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
  }
}