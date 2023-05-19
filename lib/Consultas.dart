import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Consultas extends StatefulWidget {
  const Consultas({Key? key}) : super(key: key);

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  final fechaInicioController = TextEditingController();
  final fechaFinController = TextEditingController();

  String _selectedDateIn = 'Seleccione fecha de asistencia';
  String _selectedDateFin = 'Seleccione fecha de asistencia';

  List<DropdownMenuItem<String>> _dropdownItems = [];
  String? _selectedItem;
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController revisorController = TextEditingController();

  List<String> _uniqueValues = [];

  final TextEditingController docenteController = TextEditingController();
  final TextEditingController edificioController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Realizar consulta a Firebase y obtener los documentos
    FirebaseFirestore.instance.collectionGroup('asistencia').get().then((querySnapshot) {
      // Recorrer los documentos y crear los DropdownMenuItem a partir de los datos
      querySnapshot.docs.forEach((doc) {
        String fieldValue = doc.get('revisor');
        if (!_uniqueValues.contains(fieldValue)) {
          _uniqueValues.add(fieldValue);
          _dropdownItems.add(
            DropdownMenuItem(
              value: doc['revisor'], // El valor es el depto del vehiculo
              child: Text(doc['revisor']), // El texto es el valor de un campo del documento
            ),
          );
        }
      });
      // Actualizar el estado con los nuevos elementos de DropdownMenuItem
      setState(() {});
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(40),
        children: [
          SizedBox(height: 30,),

          Text("ASISTENCIAS POR DOCENTE", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          TextField(decoration: InputDecoration(labelText: "Docente"),
            controller: docenteController,),

          SizedBox(height: 20,),

          FilledButton(onPressed: (){
            Navigator.pushNamed(context, '/consultaD', arguments:
            docenteController.text);
          }, child: Text("Buscar")),

          SizedBox(height: 30,),

          Divider(
            color: Colors.blueGrey, // Color de la línea
            thickness: 0.5, // Grosor de la línea
          ),

          SizedBox(height: 30,),

          Text("BUSQUEDA DE ASISTENCIAS POR RANGO DE FECHAS", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          Text("FECHA INICIO", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          OutlinedButton(onPressed: (){
            _selectDateIn(context);
          }, child: Text((_selectedDateIn).substring(0,10))),

          SizedBox(height: 20,),

          Text("FECHA FIN", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          OutlinedButton(onPressed: (){
            _selectDateFin(context);
          }, child: Text((_selectedDateFin).substring(0,10))),

          SizedBox(height: 20,),

          FilledButton(onPressed: (){
            Navigator.pushNamed(context, '/consultaR', arguments: {
              "fechaInicio": fechaInicioController.text,
              "fechaFin": fechaFinController.text,
            });
          }, child: Text("Buscar")),

          SizedBox(height: 30,),

          TextField(decoration: InputDecoration(labelText: "EDIFICIO"),
            controller: edificioController,),

          SizedBox(height: 20,),

          FilledButton(onPressed: (){
            Navigator.pushNamed(context, '/consultaEd', arguments: {
              "fechaInicio": fechaInicioController.text,
              "fechaFin": fechaFinController.text,
              "edificio": edificioController.text,
            });
          }, child: Text("Buscar Por Edificio")),

          SizedBox(height: 20,),

          Divider(
            color: Colors.blueGrey, // Color de la línea
            thickness: 0.5, // Grosor de la línea
          ),

          SizedBox(height: 30,),

          Text("ASISTENCIAS POR REVISOR", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Selecciona Revisor',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              value: _selectedItem,
              items: _dropdownItems,
              onChanged: (newValue) {
                // Actualizar el estado con el nuevo elemento seleccionado
                setState(() {
                  _selectedItem = newValue;
                  revisorController.text = _selectedItem.toString();
                  print(revisorController.text);
                });
              },
              buttonStyleData: const ButtonStyleData(
                height: 40,
                width: 200,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: textEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value.toString().contains(searchValue));
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
          SizedBox(height: 20,),

          FilledButton(onPressed: (){
            Navigator.pushNamed(context, '/XD',
                arguments: revisorController.text);
          }, child: Text("Ver Asistencias por revisor")),


        ],
      ),
    );
  }

  Future<void> _selectDateIn(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2010),
      maxTime: DateTime(2025),
      onConfirm: (date) {
        setState(() {
          fechaInicioController.text = date.toString();
          _selectedDateIn = date.toString();
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
  }

  Future<void> _selectDateFin(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2010),
      maxTime: DateTime(2025),
      onConfirm: (date) {
        setState(() {
          fechaFinController.text = date.toString();
          _selectedDateFin = date.toString();
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
  }


}