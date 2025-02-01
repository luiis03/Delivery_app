import 'package:delivery_app/api/controller/user_controller.dart';
import 'package:delivery_app/pages/perfil/pedido_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/repository/impl/pedidos_repository_impl.dart';
import '../../api/repository/impl/perfil_repository_impl.dart';
import '../../api/repository/impl/usuario_repository_impl.dart';
import '../../models/pedido.dart';
import '../../models/usuario.dart';
import '../../utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/user_notifier.dart';


class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

enum Tema {claro, oscuro}

class _PerfilPageState extends State<PerfilPage> {
  late Future<Usuario> usuario;

  static const routeName = "/perfilPage";
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  Tema _temaSeleccionado = Tema.claro;

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
      _temaSeleccionado = _obtenerTemaGuardado(prefs.getString('Tema'));
    });
  }

  Tema _obtenerTemaGuardado(String? tema) {
    switch (tema) {
      case 'Tema.claro':
        return Tema.claro;
      case 'Tema.oscuro':
        return Tema.oscuro;
      default:
        return Tema.claro;
    }
  }

  @override
  void initState() {
    super.initState();
    cargar_datos();
    usuario = UsuarioRepositoryImpl().getUsuarioById(1);
  }

  @override
  Widget build(BuildContext context) {
    // Obtén el UserNotifier
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);

    return FutureBuilder<Usuario>(
      future: userNotifier.fetchUser(1),  // Aquí llamamos al método para obtener el usuario
      builder: (context, snapshot) {
        // Si el futuro está en progreso
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Indicador de carga
        }

        // Si ocurrió un error al cargar el usuario
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar el usuario'));
        }

        // Si el futuro se completó con éxito
        if (snapshot.hasData) {
          final usuario = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 5.0,
                      color: Colors.grey[200],
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
                                        abrirEditar(userNotifier);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(height: 15, color: Colors.grey),
                            buildInfoField('Nombre', usuario.nombre),
                            buildInfoField('Apellidos', usuario.apellidos),
                            buildInfoField('Email', usuario.email),
                            buildInfoField('Dirección', usuario.direccion),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    // Aquí pasamos el ID del usuario obtenido desde el snapshot
                    listMisPedidos(userNotifier),
                    SizedBox(height: 12),
                    Card(
                      color: Colors.grey[200],
                      elevation: 5.0,
                      child: Container(
                        height: 160.0,
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
                            Divider(height: 20, color: Colors.grey),
                            Container(
                              height: 30.0,
                              child: buildNotificacionOption("Recibir notificaciones", _valNotificaciones, onChangeFunctionNotifications),
                            ),
                            SizedBox(height: 15),
                            buildTemaOption(context, "Ajustes de tema", _temaSeleccionado),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // En caso de que no haya datos
        return Center(child: Text('No se encontró al usuario'));
      },
    );
  }


  Card listMisPedidos(UserNotifier userNotifier) {
    return Card(
      color: Colors.grey[200],
      elevation: 5.0,
      child: Container(
        height: 200,
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
            SizedBox(height: 10),
            // Lista de pedidos
            listaPedidos(userNotifier),
          ],
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
            activeColor: AppColors.naranja,
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

  void abrirEditar(UserNotifier userNotifier) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.grey[300],
          title: const Text('Editar usuario'),
          children: <Widget>[
            form(userNotifier)
          ],
        );
      },
    );
  }

  GestureDetector buildTemaOption(BuildContext context, String title, Tema tema) {
    return GestureDetector(
      onTap: () async {
        final seleccionado = await showDialog<Tema>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<Tema>(
                    title: const Text("Tema claro"),
                    value: Tema.claro,
                    groupValue: tema,
                    onChanged: (Tema? val) {
                      Navigator.of(context).pop(val);
                    },
                  ),
                  RadioListTile<Tema>(
                    title: const Text("Tema oscuro"),
                    value: Tema.oscuro,
                    groupValue: tema,
                    onChanged: (Tema? val) {
                      Navigator.of(context).pop(val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cerrar"),
                )
              ],
            );
          },
        );
        if (seleccionado != null) {
          setState(() {
            _temaSeleccionado = seleccionado;
          });
          PerfilRepositoryImpl().guardarTema(_temaSeleccionado);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: Colors.grey[600])),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  validate(UserNotifier userNotifier) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isEditing) {
        Usuario u = Usuario(nombre: nombre, apellidos: apellidos, email: email, direccion: direccion, id: userNotifier.usuario!.id);
        // dbHelper.updateUser(u);
        setState(() {
          isEditing = false;
        });
      } else {
        bool codigoValido = true;
        if (codigoValido) {
          // int idInsert = await dbHelper.getLastIdEmt() ?? 1;
          Usuario u = Usuario(nombre: nombre, apellidos: apellidos, email: email, direccion: direccion, id: userNotifier.usuario!.id);
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

  Form form(UserNotifier userNotifier) {
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
                  onPressed: validate(userNotifier),
                  child: const Text('EDITAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded listaPedidos(UserNotifier userNotifier) {
    return Expanded(
      child: FutureBuilder<List<Pedido>>(
        future: PedidosRepositoryImpl().getPedidosByIdUsuario(userNotifier.usuario!.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay pedidos disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Pedido pedido = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.naranja,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        'Pedido #${pedido.id}}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${formatDate(pedido.fecha)}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            '${formatEstadoEnvio(pedido.estadoEnvio)}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '${pedido.precioTotal.toStringAsFixed(2)}€',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () => context.push(PedidoPage(pedido: pedido)),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String formatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('d MMM y, h:mm'); // Formato legible: 10 Jan 2025, 1:45 PM
    return formatter.format(date);
  }

  String formatEstadoEnvio(EstadoEnvio estadoEnvio) {
    switch (estadoEnvio) {
      case EstadoEnvio.EN_PREPARACION:
        return "EN PREPARACION";
      case EstadoEnvio.CONFIRMADO || EstadoEnvio.CONFIRMADO_RESTAURANTE:
        return "CONFIRMADO";
      case EstadoEnvio.LISTO:
        return "LISTO";
      case EstadoEnvio.EN_REPARTO:
        return "EN REPARTO";
      case EstadoEnvio.ENTREGADO:
        return "ENTREGADO";
      case EstadoEnvio.PAGADO:
        return "PAGADO";
      case EstadoEnvio.FINALIZADO:
        return "FINALIZADO";
      default:
        return "Estado desconocido";
    }
  }

}

