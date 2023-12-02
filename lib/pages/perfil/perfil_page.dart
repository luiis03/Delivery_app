import 'package:flutter/material.dart';

import '../../models/usuario.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerApellidos = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerDireccion = TextEditingController();
  late String nombre;
  late String apellidos;
  late String email;
  late String direccion;
  late bool isEditing;
  final formKey = GlobalKey<FormState>();

  List<String> misPedidos = ['Pedido 1', 'Pedido 2', 'Pedido 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Informacion del usuario',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  abrirEditar();
                                },
                                icon: Icon(Icons.edit)
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(height: 15),
                    Text('Nombre: John'),
                    Text('Email: john@gmail.com'),
                    Text('Dirección: Calle Principal, 123'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Mis Pedidos',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  abrirEditar();
                                },
                                icon: Icon(Icons.edit)
                            )
                          ],
                        )
                      ],
                    ),
                    Divider(height: 15),
                    // Lista de pedidos
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: misPedidos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(misPedidos[index]),
                          subtitle: Text('Fecha: ${_obtenerFechaPedido(index)}'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _obtenerFechaPedido(int index) {
    return '01/01/2023';
  }

  clearName() {
    controllerNombre.text = '';
    controllerApellidos.text = '';
    controllerEmail.text = '';
    controllerDireccion.text = '';
  }

  void abrirEditar() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Editar usuario'),
          children: <Widget>[
            form()
          ],
        );
      },
    );
  }

  validate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isEditing) {
        Usuario u = Usuario(nombre: nombre, apellidos: apellidos , email: email, direccion: direccion);
        // dbHelper.updateUser(u);
        setState(() {
          isEditing = false;
        });
      } else {
        // Future<bool> codigoValido = DBHelper().existeCodigoEmt(codigo);
        bool codigoValido = true;
        if (codigoValido) {
          // int idInsert = await dbHelper.getLastIdEmt() ?? 1;
          Usuario u = Usuario(nombre: nombre, apellidos: apellidos, email: email, direccion: direccion);
          // dbHelper.saveUsuario(u);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuario editado correctamente')));

        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Codigo de parada no existe'), backgroundColor: Colors.red,));

        }
      }
      clearName();
    }
  }

  Form form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controllerNombre,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black), // Texto blanco
              cursorColor: Colors.black, // Cursor blanco
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondos
                ),
                filled: true,
                fillColor: Colors.transparent, // Fondo transparente
                labelStyle: const TextStyle(color: Colors.black),
              ),
              validator: (val) => val!.isEmpty ? 'Introduce el nombre' : null,
              onSaved: (val) => nombre = val!,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controllerApellidos,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black), // Texto blanco
              cursorColor: Colors.black, // Cursor blanco
              decoration: InputDecoration(
                labelText: 'Apellidos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondos
                ),
                filled: true,
                fillColor: Colors.transparent, // Fondo transparente
                labelStyle: TextStyle(color: Colors.black),
              ),
              validator: (val) => val!.length == 0 ? 'Introduce los apellidos' : null,
              onSaved: (val) => apellidos = val!,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controllerDireccion,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.black), // Texto blanco
              cursorColor: Colors.black, // Cursor blanco
              decoration: InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondos
                ),
                filled: true,
                fillColor: Colors.transparent, // Fondo transparente
                labelStyle: TextStyle(color: Colors.black),
              ),
              validator: (val) => val!.length == 0 ? 'Introduce la direccion' : null,
              onSaved: (val) => direccion = val!,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.red;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.white;
                      },
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = false;
                    });
                    clearName();
                    Navigator.pop(context);
                  },
                  child: const Text('CANCELAR'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.green;
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Colors.white;
                      },
                    ),
                  ),
                  onPressed: validate,
                  child: const Text('EDITAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

