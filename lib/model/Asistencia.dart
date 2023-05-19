class Asistencia{
  String fecha_hora;
  String revisor;
  String? materia;

  Asistencia({
    required this.fecha_hora,
    required this.revisor,
    this.materia
  });

  Map<String, dynamic> toMap(){
    return{
      'fecha_hora': fecha_hora,
      'revisor': revisor,
      'materia': materia,
    };
  }

  @override
  String toString() {
    return 'Asistencia{fecha_hora: $fecha_hora, revisor: $revisor, materia: $materia}';
  }
}