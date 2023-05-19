import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ConsultaRango extends StatefulWidget {
  const ConsultaRango({Key? key}) : super(key: key);

  @override
  State<ConsultaRango> createState() => _ConsultaRangoState();
}

class _ConsultaRangoState extends State<ConsultaRango> {
  TextEditingController fechaInicioController = TextEditingController(text: "");
  TextEditingController fechaFinController = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    fechaInicioController.text = arguments['fechaInicio'];
    fechaFinController.text = arguments['fechaFin'];
    return Scaffold(
      appBar: AppBar(title: const Text("Asistencias por Rango", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, centerTitle: true,),
      body: FutureBuilder(
          future: getAsistenciasFechas(fechaInicioController.text, fechaFinController.text),
          builder: ((context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (builder){
                        return AlertDialog(
                          title: Text("OLA"),
                          content: Text("NO ESTA PERMITIDO MOVERLE A LAS ASISTENCIAS"),
                        );
                      });

                    },
                    child: ListTile(
                      title: Text(snapshot.data?[index]['fecha_hora']),
                      subtitle: Text(snapshot.data?[index]['revisor']),
                      trailing: Text(snapshot.data?[index]['materia']),
                    ),
                  );
                },);
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
      ),
    );
  }
}