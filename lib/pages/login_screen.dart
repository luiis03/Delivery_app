import 'package:delivery_app/pages/home/home_page.dart';
import 'package:delivery_app/pages/home/main_page.dart';
import 'package:delivery_app/pages/signup_screen.dart';
import 'package:delivery_app/utils/helper.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../widgets/custom_text_input.dart';
import 'forget_pw_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Spacer(flex: 2),
                CustomTextInput(
                  hintText: "Email", key: Key("email"),
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Contraseña", key: Key("password"),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.navigateToMainPage(context);
                    },
                    child: Text("Iniciar sesión"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.push(ForgetPwScreen());
                  },
                  child: Text("¿Has olvidado tu contraseña?"),
                ),
                Spacer(
                  flex: 2,
                ),
                Text("o Inicia sesión con"),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "assets/img/logo_google.png"
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Iniciar con Google")
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                GestureDetector(
                  onTap: () {
                    context.push(SignUpScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Si no tienes cuenta..."),
                      Text(
                        "Regístrate",
                        style: TextStyle(
                          color: AppColors.naranja,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
