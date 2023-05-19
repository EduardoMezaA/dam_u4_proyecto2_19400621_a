import 'package:dam_u4_proyecto2_19400621_a/Consultas.dart';
import 'package:dam_u4_proyecto2_19400621_a/ProgramaAsignaciones.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _indice = 0;

  void _cambiarIndice(int indice){
    setState(() {
      _indice = indice;
    });
  }

  final List<Widget> _paginas = [
    ProgramaAsignaciones(),
    Consultas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Image.network('https://www.tepic.tecnm.mx/images/escudo_itt_grande.png'), title: Text(
        'AsisTec', style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 32),
      ), centerTitle: true, backgroundColor: Colors.deepOrange, actions: [
        IconButton(onPressed: (){
          showDialog(context: context, builder: (builder){
            return AlertDialog(
              title: Text("¡AY PAPA UN POLLITO!"),
              content: Image.network(
                'https://i.ytimg.com/vi/4BqScYCZQow/maxresdefault.jpg',
                width: 200, // ancho de la imagen
                height: 200, // alto de la imagen
                fit: BoxFit.cover, // ajuste de la imagen
              ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("PIO PIO")),
              ],
            );
          });
        }, icon: Icon(Icons.monetization_on))
      ],),
      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment_ind), label: "Asignaciones"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Consultas"),
        ],
        currentIndex: _indice,
        onTap: _cambiarIndice,
        iconSize: 30,
        backgroundColor: CupertinoColors.systemBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
      ),
    );
  }
}