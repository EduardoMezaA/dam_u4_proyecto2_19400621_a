
import 'package:dam_u4_proyecto2_19400621_a/Asistencias.dart';
import 'package:dam_u4_proyecto2_19400621_a/CapturaAsignacion.dart';
import 'package:dam_u4_proyecto2_19400621_a/CapturarAsistencia.dart';
import 'package:dam_u4_proyecto2_19400621_a/ConsultaDocente.dart';
import 'package:dam_u4_proyecto2_19400621_a/ConsultaEdificio.dart';
import 'package:dam_u4_proyecto2_19400621_a/ConsultaRango.dart';
import 'package:dam_u4_proyecto2_19400621_a/ConsultaRevisor.dart';
import 'package:dam_u4_proyecto2_19400621_a/EditarAsignacion.dart';
import 'package:dam_u4_proyecto2_19400621_a/services/Pantalla_Principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const PantallaPrincipal(),
        '/addAs': (context) => const CapturaAsignacion(),
        '/editAs': (context) => const EditarAsignacion(),
        '/asisPorDoc': (context) => const Asistencias(),
        '/addAsist': (context) => const CapturarAsistencia(),
        '/consultaR': (context) => const ConsultaRango(),
        '/XD': (context) => const ConsultaRevisor(),
        '/consultaD': (context) => const ConsultaDocente(),
        '/consultaEd': (context) => const ConsultaEdificio(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}