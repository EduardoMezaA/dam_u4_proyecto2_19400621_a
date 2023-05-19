import 'package:dam_u4_proyecto2_19400621_a/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ProgramaAsignaciones extends StatefulWidget {
  const ProgramaAsignaciones({Key? key}) : super(key: key);

  @override
  State<ProgramaAsignaciones> createState() => _ProgramaAsignacionesState();
}

class _ProgramaAsignacionesState extends State<ProgramaAsignaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getAsignacion(),
          builder: ((context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (builder){
                        return AlertDialog(
                          title: Text("ATENCIÓN"),
                          content: Text("¿QUE DESEA HACER CON ${snapshot.data?[index]['docente']}"),
                          actions: [
                            TextButton(onPressed: () async{
                              await Navigator.pushNamed(context, '/editAs', arguments: {
                                "salon": snapshot.data?[index]['salon'],
                                "edificio": snapshot.data?[index]['edificio'],
                                "horario": snapshot.data?[index]['horario'],
                                "docente": snapshot.data?[index]['docente'],
                                "materia": snapshot.data?[index]['materia'],
                                "id": snapshot.data?[index]['id'],
                              });
                              setState(() { });
                            }, child: const Text("ACTUALIZAR")),
                            TextButton(onPressed: () async{
                              await deleteAsignacion(snapshot.data?[index]['id']).then((value){
                                setState(() {
                                  Navigator.pop(context);
                                  ProgramaAsignaciones();
                                });
                              });
                            }, child: const Text("ELIMINAR")),
                            TextButton(onPressed: () async{
                              await Navigator.pushNamed(context, '/asisPorDoc', arguments: {
                                "id": snapshot.data?[index]['id'],
                                "materia": snapshot.data?[index]['materia'],
                              });
                              setState(() { });
                            }, child: const Text("Asistencias")),
                          ],
                        );
                      });

                    },
                    child: ListTile(
                      title: Text(snapshot.data?[index]['docente'] + ' - ' + snapshot.data?[index]['materia']),
                      subtitle: Text(snapshot.data?[index]['horario']),
                      trailing: Text(snapshot.data?[index]['salon'] + ' - ' + snapshot.data?[index]['edificio']),
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
        await Navigator.pushNamed(context, '/addAs').then((value) {
          setState(() {
            ProgramaAsignaciones();
          });
        },);
      },child: Icon(Icons.add), backgroundColor: Colors.blue,),
    );
  }
}