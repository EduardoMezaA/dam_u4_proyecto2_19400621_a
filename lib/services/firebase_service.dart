import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_19400621_a/model/Asignacion.dart';
import 'package:dam_u4_proyecto2_19400621_a/model/Asistencia.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getAsignacion() async{
  List asignaciones = [];

  CollectionReference colAsign = db.collection('asignacion');

  QuerySnapshot queryAsignacion = await colAsign.get();

  for(var doc in queryAsignacion.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asignacion = {
      'salon': data['salon'],
      'edificio': data['edificio'],
      'horario': data['horario'],
      'docente': data['docente'],
      'materia': data['materia'],
      "id": doc.id,
    };
    asignaciones.add(asignacion);
  }
  return asignaciones;
}

Future<void> addAsignacion(Asignacion a) async{
  await db.collection('asignacion').add(a.toMap());
}

Future<void> updateAsignacion(String id, Asignacion a) async{
  await db.collection('asignacion').doc(id).set(a.toMap());
}

Future<void> deleteAsignacion(String id) async{
  await db.collection('asignacion').doc(id).delete();
}


//Asistencia -------------------------------------------------------------------
Future<List> getAsistencia(String docxd) async{
  List asistencias = [];

  final AsignacionRef = db.collection('asignacion').doc(docxd);
  final AsistenciaSnapshot = await AsignacionRef.collection('asistencia').get();

  for(var doc in AsistenciaSnapshot.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asistencia = {
      'fecha_hora': data['fecha_hora'],
      'revisor': data['revisor'],
      'materia': data['materia'],
      "id": doc.id,
    };
    asistencias.add(asistencia);
  }
  return asistencias;
}


Future<void> addAsistencia(String docid, Asistencia a) async{
  final DocumentReference documentRef = db.collection('asignacion').doc(docid);
  final CollectionReference subCollectionRef = documentRef.collection('asistencia');
  subCollectionRef.add(a.toMap());
}

Future<List> getAsistenciasRango() async{
  List asistencias = [];
  //String fechaInicio, String fechaFin
  final AsignacionRef = db.collection('asignacion').doc();
  final AsistenciaSnapshot = await AsignacionRef.collection('asistencia').get();

  for(var doc in AsistenciaSnapshot.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asistencia = {
      'fecha_hora': data['fecha_hora'],
      'revisor': data['revisor'],
      'materia': data['materia'],
      "id": doc.id,
    };
    asistencias.add(asistencia);
  }
  return asistencias;
}

Future<List> getAsistenciasFechas(String fechaInicio, String fechaFin) async{
  List asistencias = [];

  final AsistenciaSnapshot = await db.collectionGroup('asistencia').get();
  String niggai = (fechaInicio).substring(0,10).replaceAll('-', '');
  String niggaf = (fechaFin).substring(0,10).replaceAll('-', '');
  int fi = int.parse(niggai);
  int ff = int.parse(niggaf);

  for(var doc in AsistenciaSnapshot.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String niggaxd = (data['fecha_hora']).substring(0,10).replaceAll('-', '');
    int fxd = int.parse(niggaxd);
    if(fxd >= fi && fxd <= ff){
      final asistencia = {
        'fecha_hora': data['fecha_hora'],
        'revisor': data['revisor'],
        'materia': data['materia'],
        "id": doc.id,
      };
      asistencias.add(asistencia);
    }

  }
  return asistencias;
}

Future<List> yametekudasainyaaaaa(String fechaInicio, String fechaFin, String edificio) async{
  List asistencias = [];
  QuerySnapshot queryAsigDocente = await db.collection('asignacion').where('edificio',isEqualTo: edificio).get();

  String niggai = (fechaInicio).substring(0,10).replaceAll('-', '');
  String niggaf = (fechaFin).substring(0,10).replaceAll('-', '');
  int fi = int.parse(niggai);
  int ff = int.parse(niggaf);

  queryAsigDocente.docs.forEach((docAsig) async{
    QuerySnapshot queryAsisDocente = await db.collection('asignacion').doc(docAsig.id).collection('asistencia').get();
    queryAsisDocente.docs.forEach((docAsis){
      final Map<String,dynamic> data = docAsis.data() as Map<String,dynamic>;
      String niggaxd = (data['fecha_hora']).substring(0,10).replaceAll('-', '');
      int fxd = int.parse(niggaxd);
      if(fxd >= fi && fxd <= ff) {
        Map<String, dynamic> asistencia = {
          "fecha_hora": data['fecha_hora'],
          "revisor": data['revisor'],
          'materia': data['materia'],
        };
        asistencias.add(asistencia);
      }
    });
  });
  await Future.delayed(const Duration(seconds: 1));
  return asistencias;
}

Future<List> getAsistenciasRevisor(String revisor) async{
  List asistencias = [];

  final AsistenciaSnapshot = await db.collectionGroup('asistencia').get();

  for(var doc in AsistenciaSnapshot.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String niggaxd = data['revisor'];
    if(niggaxd == revisor){
      final asistencia = {
        'fecha_hora': data['fecha_hora'],
        'revisor': data['revisor'],
        'materia': data['materia'],
        "id": doc.id,
      };
      asistencias.add(asistencia);
    }
  }
  return asistencias;
}


Future<List> getAsistenciasDocente(String docente) async{
  List asistencias = [];
  QuerySnapshot queryAsigDocente = await db.collection('asignacion').where('docente',isEqualTo: docente).get();

  queryAsigDocente.docs.forEach((docAsig) async{
    QuerySnapshot queryAsisDocente = await db.collection('asignacion').doc(docAsig.id).collection('asistencia').get();
    queryAsisDocente.docs.forEach((docAsis){
      final Map<String,dynamic> data = docAsis.data() as Map<String,dynamic>;
      Map<String,dynamic> asistencia = {
        "fecha_hora": data['fecha_hora'],
        "revisor": data['revisor'],
        'materia': data['materia'],
      };
      asistencias.add(asistencia);
    });
  });
  await Future.delayed(const Duration(seconds: 1));
  return asistencias;
}