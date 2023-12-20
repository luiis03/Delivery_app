import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/material.dart';
import '../utils/dimensions.dart';
import '../widgets/custom_text_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signUpScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Spacer(),
                  SizedBox(height: 30),
                  CustomTextInput(hintText: "Nombre", key: Key("nombre"),),
                  SizedBox(height: 20),
                  CustomTextInput(hintText: "Email", key: Key("email"),),
                  SizedBox(height: 20),
                  CustomTextInput(hintText: "Teléfono", key: Key("telefono"),),
                  SizedBox(height: 20),
                  CustomTextInput(hintText: "Dirección", key: Key("direccion"),),
                  SizedBox(height: 20),
                  CustomTextInput(hintText: "Contraseña", key: Key("contraseña"),),
                  SizedBox(height: 20),
                  CustomTextInput(hintText: "Confirmar contraseña", key: Key("confirmar contraseña"),),
                  Spacer(),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Registrarse"),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.push(LoginScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿Ya tienes una cuenta?"),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.naranja,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}