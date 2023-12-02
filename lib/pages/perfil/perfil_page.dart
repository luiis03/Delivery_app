import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Lista de pedidos del usuario (puedes cargarla desde algún lugar)
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
                    Text(
                      'Información del Usuario',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Nombre: John'),
                    Text('Apellidos: Doe'),
                    Text('Dirección: Calle Principal, 123'),
                    Text('Preferencias: Pizza, Hamburguesas'),
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
                    Text(
                      'Mis Pedidos',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
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
    // En este ejemplo, simplemente devolvemos una fecha ficticia.
    // En tu aplicación, puedes obtener la fecha real de tus datos.
    return '01/01/2023';
  }
}

