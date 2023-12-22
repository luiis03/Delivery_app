import 'package:delivery_app/pages/home/slider_catalogo_page.dart';
import 'package:delivery_app/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/repository/impl/restaurantes_repository_impl.dart';
import '../../models/restaurantes.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  final int _currentIndex = 1;
  bool estaEnBaseDatos = false;
  bool switchValue = false;
  List<Restaurantes> restaurantes = [];

  @override
  void initState() {
    super.initState();
    obtenerEstadoBaseDatos();
  }

  Future<void> obtenerEstadoBaseDatos() async {
    bool enBaseDatos = false;
    setState(() {
      estaEnBaseDatos = enBaseDatos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.buttonBackgroundColor,
        child: Column(
          children: [
            SizedBox(height: 5),
            Row(
              children: [
                SearchBarInput(),
              ],
            ),
            SizedBox(height: 10),
            SliderCatalogoPage(),
            listaRestaurantes(),
          ],
        ),
      ),
    );
  }


  Expanded listaRestaurantes() {
    return Expanded(
      child: FutureBuilder<List<Restaurantes>>(
        future: RestaurantesRepositoryImpl().getRestaurantes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Restaurantes restaurante = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.naranja,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50, // Ancho del contenedor del logo
                        height: 50, // Altura del contenedor del logo
                        margin: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(Dimensions.radius20),
                          child: Image.asset(
                            restaurante.logo_imagen,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(restaurante.nombre),
                      subtitle: Text(restaurante.direccion),
                      trailing: IconButton(
                        onPressed: () {
                          agregarParadaABaseDatosIcono();
                        },
                        icon: Icon(
                          estaEnBaseDatos
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: estaEnBaseDatos ? Colors.red : null,
                        ),
                      ),
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

  void agregarParadaABaseDatosIcono() {
    if (estaEnBaseDatos) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quitar de favoritos'),
            content: Text(
                '¿Estás seguro que quieres quitar este restaurante de favoritos?'),
            actions: <Widget>[
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
                  Navigator.pop(context);
                },
                child: Text('CANCELAR'),
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
                onPressed: () async {
                  setState(() {
                    estaEnBaseDatos = false;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Restaurante eliminado correctamente')));
                },
                child: Text('ACEPTAR'),
              ),
            ],
          );
        },
      );
    } else {
      estaEnBaseDatos = true;
    }
  }
}

