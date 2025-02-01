import 'package:flutter/material.dart';

import '../../models/pedido.dart';

class PedidoPage extends StatefulWidget {
  final Pedido pedido;
  const PedidoPage({Key? key, required this.pedido}) : super(key: key);

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  late int currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = getStepForEstado(widget.pedido.estadoEnvio);
  }

  int getStepForEstado(EstadoEnvio estado) {
    switch (estado) {
      case EstadoEnvio.CONFIRMADO:
        return 0;
      case EstadoEnvio.CONFIRMADO_RESTAURANTE:
        return 1;
      case EstadoEnvio.EN_PREPARACION:
        return 2;
      case EstadoEnvio.LISTO:
        return 3;
      case EstadoEnvio.EN_REPARTO:
        return 4;
      case EstadoEnvio.ENTREGADO:
        return 5;
      // case EstadoEnvio.PAGADO:
      //   return 6;
      // case EstadoEnvio.FINALIZADO:
      //   return 7;
      default:
        return 0; // En caso de que el estado no esté mapeado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seguimiento del Pedido"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estado del pedido
            Text(
              "Estado del pedido",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 350, // Altura fija para el contenedor
                child: buildStepper(), // Aquí está el Stepper, será desplazable dentro de este contenedor
              ),
            ),


            SizedBox(height: 10),
            // Información del pedido
            Text(
              "Información del Pedido",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ...widget.pedido.productos.map((producto) {
                    return pedidoItem(
                      producto.nombre,
                      producto.cantidad,
                      producto.precio,
                    );
                  }).toList(),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "\$${widget.pedido.productos.fold(0.0, (total, producto) => total + producto.cantidad * producto.precio).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Divider(),
            // ListTile(
            //   title: Text("Forma de pago"),
            //   trailing: Text("Tarjeta"),
            // ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildStepper() {
    return SingleChildScrollView( // Hace que el Stepper sea scrollable
      physics: AlwaysScrollableScrollPhysics(), // Permite el scroll
      child: Stepper(
        currentStep: currentStep,
        controlsBuilder: (context, details) {
          return SizedBox.shrink(); // Ocultar los botones de control
        },
        connectorThickness: 3,
        steps: [
          Step(
            title: Text("Pedido confirmado"),
            content: Text("Tu pedido ha sido confirmado."),
            isActive: currentStep >= 0,
          ),
          Step(
            title: Text("Confirmación del restaurante"),
            content: Text("El restaurante ha confirmado tu pedido."),
            isActive: currentStep >= 1,
          ),
          Step(
            title: Text("En preparación"),
            content: Text("Tu pedido está siendo preparado."),
            isActive: currentStep >= 2,
          ),
          Step(
            title: Text("Listo para salir o recoger"),
            content: Text("Tu pedido está listo."),
            isActive: currentStep >= 3,
          ),
          Step(
            title: Text("En reparto"),
            content: Text("Tu pedido está en camino."),
            isActive: currentStep >= 4,
          ),
          Step(
            title: Text("Entregado con éxito"),
            content: Text("Tu pedido ha sido entregado."),
            isActive: currentStep >= 5,
          ),
          // Step(
          //   title: Text("Pagado con éxito"),
          //   content: Text("Tu pedido ha sido pagado correctamente."),
          //   isActive: currentStep >= 6,
          // ),
          // Step(
          //   title: Text("Pedido finalizado"),
          //   content: Text("Pedido finalizado"),
          //   isActive: currentStep >= 7,
          // )
        ],
      ),
    );
  }


  Widget pedidoItem(String name, int quantity, double price) {
    return ListTile(
      title: Text(name),
      subtitle: Text("Cantidad: $quantity"),
      trailing: Text("\$${(price * quantity).toStringAsFixed(2)}"),
    );
  }
}
