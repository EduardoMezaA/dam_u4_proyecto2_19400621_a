import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ConsultaRevisor extends StatefulWidget {
  const ConsultaRevisor({Key? key}) : super(key: key);

  @override
  State<ConsultaRevisor> createState() => _ConsultaRevisorState();
}

class _ConsultaRevisorState extends State<ConsultaRevisor> {
  TextEditingController revisorController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final String arguments = ModalRoute.of(context)!.settings.arguments as String;
    revisorController.text = arguments;
    return Scaffold(
      appBar: AppBar(title: const Text("Asistencias por Revisor", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, centerTitle: true,),
      body: FutureBuilder(
          future: getAsistenciasRevisor(revisorController.text),
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