import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:delivery_app/home/slider_catalogo_page.dart';
import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/sub_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/restaurantes.dart';
import '../utils/dimensions.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();
  final int _currentIndex = 1;
  bool estaEnBaseDatos = false;

  bool switchValue = false;

  List<Restaurantes> restaurantes = [];

  Future<List<Restaurantes>> getRestaurantes() async {
    try {
      var response = await http.get(Uri.https('victordiaz74.github.io', '/delivery-app/api.json'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Restaurantes> fetchedRestaurantes = [];
        for (var restaurant in jsonData['restaurantes']) {
          final restaurante = Restaurantes(
            id: restaurant['id'],
            nombre: restaurant['nombre'],
            direccion: restaurant['direccion'],
            ciudad: restaurant['ciudad'],
            provincia: restaurant['provincia'],
            codigo_postal: restaurant['codigo_postal'],
            telefono: restaurant['telefono'],
            horario: restaurant['horario'],
            logo_imagen: restaurant['logo_imagen'],
            img_default: restaurant['img_default'],
            menus: restaurant['menus'],
          );
          fetchedRestaurantes.add(restaurante);
        }
        print(fetchedRestaurantes.length);
        return fetchedRestaurantes;
      } else {
        // Manejar el error de manera más explícita y devolver una lista vacía
        print('Error en la solicitud HTTP: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${response.body}');
        return [];
      }
    } catch (error) {
      // Manejar errores de manera general y devolver una lista vacía
      print(error);
      print('Error en la solicitud HTTP: $error');
      return [];
    }
  }

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
      appBar: AppBar(
        backgroundColor: AppColors.mainBlackColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(text: "Direccion", color: AppColors.mainColor),
              ],
            ),
            customSwitch(),
          ],
        ),
      ),
      bottomNavigationBar: wBottomNavigationBar(),
      body: Container(
        color: AppColors.mainBlackColor, // Establecer el color de fondo de toda la página a negro
        child: Column(
          children: [
            SizedBox(height: 0.5),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      height: Dimensions.height55,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar ',
                          prefixIcon: Icon(Icons.search, color: Colors.white,),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          prefixStyle: TextStyle(color: Colors.white),
                          suffixStyle: TextStyle(color: Colors.white),
                          counterStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            const SliderCatalogoPage(),
            listaRestaurantes()
          ],
        ),
      ),
    );
  }

  Expanded listaRestaurantes() {
    return Expanded(
      child: FutureBuilder<List<Restaurantes>>(
        future: getRestaurantes(),
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50, // Ancho del contenedor del logo
                        height: 50, // Altura del contenedor del logo
                        margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
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
                          estaEnBaseDatos ? Icons.favorite : Icons.favorite_border,
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

  CurvedNavigationBar wBottomNavigationBar() {
    return CurvedNavigationBar(
      height: 55,
      color: AppColors.mainBlackColor,
      backgroundColor: AppColors.mainColor,
      animationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 400),
      items: const <Widget>[
        Icon(Icons.person, size: 30, color: AppColors.mainColor),
        Icon(Icons.home, size: 30, color: AppColors.mainColor),
        Icon(Icons.shopping_cart, size: 30, color: AppColors.mainColor),
      ],
      onTap: (index) {
        setState(() {
          index = _currentIndex;
        });
      });
  }

  Center customSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_walk,
              color: switchValue ? Colors.grey : AppColors.mainColor),
          CupertinoSwitch(
            activeColor: AppColors.mainColor,
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
          ),
          Icon(Icons.delivery_dining,
              color: switchValue ? AppColors.mainColor : Colors.grey),
        ],
      ),
    );
  }

  void agregarParadaABaseDatosIcono(){
    if (estaEnBaseDatos) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quitar de favoritos'),
            content: Text('¿Estás seguro que quieres quitar este restaurante de favoritos?'),
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Restaurante eliminado correctamente')));
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
