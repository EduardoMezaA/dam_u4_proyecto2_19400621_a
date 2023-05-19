import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ConsultaDocente extends StatefulWidget {
  const ConsultaDocente({Key? key}) : super(key: key);

  @override
  State<ConsultaDocente> createState() => _ConsultaDocenteState();
}

class _ConsultaDocenteState extends State<ConsultaDocente> {
  TextEditingController docenteController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final String arguments = ModalRoute.of(context)!.settings.arguments as String;
    docenteController.text = arguments;
    return Scaffold(
      appBar: AppBar(title: const Text("Asistencias por Docente", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, centerTitle: true,),
      body: FutureBuilder(
          future: getAsistenciasDocente(docenteController.text),
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