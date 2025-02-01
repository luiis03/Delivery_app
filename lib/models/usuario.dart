class Usuario {
  final int id;
  final String nombre;
  final String apellidos;
  final String direccion;
  final String email;

  // Constructor
  Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.direccion,
    required this.email,
  });

  // Método fromJson con validación
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] != null ? json['id'] : 1, // Valor por defecto si 'id' es null
      nombre: json['nombre'] ?? '',
      apellidos: json['apellidos'] ?? '',
      direccion: json['direccion'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'direccion': direccion,
      'email': email,
    };
  }
}
