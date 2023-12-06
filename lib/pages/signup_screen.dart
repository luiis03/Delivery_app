import 'package:delivery_app/utils/colors.dart';
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
          width: Dimensions.screenWidth,
          height: Dimensions.screenHeight,
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
                  Text(
                    "Add your details to sign up",
                  ),
                  Spacer(),
                  CustomTextInput(hintText: "Nombre", key: Key("nombre"),),
                  Spacer(),
                  CustomTextInput(hintText: "Email", key: Key("email"),),
                  Spacer(),
                  CustomTextInput(hintText: "Telefono", key: Key("telefono"),),
                  Spacer(),
                  CustomTextInput(hintText: "Direccion", key: Key("direccion"),),
                  Spacer(),
                  CustomTextInput(hintText: "Contraseña", key: Key("contraseña"),),
                  Spacer(),
                  CustomTextInput(hintText: "Confirmar contraseña", key: Key("confirmar contraseña"),),
                  Spacer(),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Sign Up"),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account?"),
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