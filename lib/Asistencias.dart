import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Asistencias extends StatefulWidget {
  const Asistencias({Key? key}) : super(key: key);

  @override
  State<Asistencias> createState() => _AsistenciasState();
}

class _AsistenciasState extends State<Asistencias> {
  TextEditingController idController = TextEditingController(text: "");
  TextEditingController mController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    idController.text = arguments['id'];
    mController.text = arguments['materia'];
    return Scaffold(
      appBar: AppBar(title: const Text("Asistencias", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, centerTitle: true,),
      body: FutureBuilder(
          future: getAsistencia(idController.text),
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
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await Navigator.pushNamed(context, '/addAsist', arguments: {
          "id": idController.text,
          "materia": mController.text,
        }).then((value) {
          setState(() {
            Asistencias();
          });
        },);
      },child: Icon(Icons.add), backgroundColor: Colors.blue,),
    );
  }
}