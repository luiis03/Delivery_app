import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/usuario.dart';
import '../../utils/colors.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  static const routeName = "/perfilPage";
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
  bool _valNotificaciones = true; //notificaciones

  onChangeFunctionNotifications(bool newValue1){
    setState(() {
      _valNotificaciones = newValue1;
      // PerfilRepositoryImpl().guardarHuelgas(_valNotificaciones);
    });
  }

  Future<void> cargar_datos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _valNotificaciones = prefs.getBool('Notificaciones') ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    cargar_datos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5.0,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Información del usuario',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  abrirEditar();
                                },
                                icon: Icon(Icons.edit),
                              )
                            ],
                          ),
                        ],
                      ),

                      Divider(height: 15, color: AppColors.mainBlackColor,),
                      buildInfoField('Nombre', 'John'),
                      buildInfoField('Apellidos', 'Dow'),
                      buildInfoField('Email', 'john@gmail.com'),
                      buildInfoField('Dirección', 'Calle Principal, 123'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Card(
                color: Colors.grey[300],
                elevation: 5.0,
                child: Container(
                  height: 250.0, // Ajusta la altura del Card según tus preferencias
                  padding: const EdgeInsets.all(15.0),
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
                        ],
                      ),
                      SizedBox(height: 10,),
                      // Lista de pedidos
                      Container(
                        height: 180.0, // Ajusta la altura de la lista según tus preferencias
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: misPedidos.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black), // Añade un borde
                                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                              ),
                              child: ListTile(
                                title: Text(
                                  misPedidos[index],
                                  style: TextStyle(
                                    color: Colors.black, // Cambia este color según tus preferencias
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Fecha: ${_obtenerFechaPedido(index)}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic, // Añade más estilos según tus preferencias
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Card(
                color: Colors.grey[300],
                elevation: 5.0,
                child: Container(
                  height: 140.0, // Ajusta la altura del Card según tus preferencias
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Configuración',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(height: 20, color: Colors.black,),
                      // Lista de pedidos
                      Container(
                        height: 60.0, // Ajusta la altura de la lista según tus preferencias
                        child: buildNotificacionOption("Recibir notificaciones", _valNotificaciones, onChangeFunctionNotifications),
                      ),
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  Padding buildNotificacionOption(String title, bool value, Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.grey[600]),),
          Transform.scale(scale: 0.7, child: CupertinoSwitch(
            activeColor: Colors.black,
            trackColor: Colors.grey,
            value: value,
            onChanged: (bool newValue){
              onChangeMethod(newValue);
            },
          ),)
        ],
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
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
          backgroundColor: Colors.grey[300],
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

