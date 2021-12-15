import 'package:ak_mined/modules/auth/providers/login_form_providers.dart';
import 'package:ak_mined/modules/auth/services/auth_service.dart';
import 'package:ak_mined/modules/auth/services/notification_service.dart';
import 'package:ak_mined/modules/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ak_mined/modules/auth/ui/input_decorations.dart';
import 'package:ak_mined/modules/auth/widgets/auth_background.dart';
import 'package:ak_mined/modules/auth/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            CardContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/akademos-logo.png",
                    /* height: 90, */
                    height: 50,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  )
                ],
              ),
            ),
            /*   SizedBox(
              height: 50,
            ),
            Text("Se te olvidó la contraseña?",style: TextStyle(fontSize: 18,color: Theme.of(context).primaryColor),),
            SizedBox(
              height: 50,
            ), */
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          child: Column(
            children: [
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 11,
                  validator: (value) {
                    return (value != null && value.length == 11)
                        ? null
                        : 'El CI debe tener 11 dígitos';
                  },
                  onChanged: (value) => loginForm.ci = value,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      context: context, labelText: "CI", icon: Icons.person)),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 2,
                  onChanged: (value) => loginForm.tomo = value,
                  validator: (value) {
                    return (value != null && value.length == 2)
                        ? null
                        : 'El tomo debe tener 2 dígitos';
                  },
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      context: context, labelText: "Tomo", icon: Icons.book)),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 3,
                onChanged: (value) => loginForm.folio = value,
                validator: (value) {
                  return (value != null && value.length == 3)
                      ? null
                      : 'El folio debe tener 3 dígitos';
                },
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    context: context,
                    labelText: "Folio",
                    icon: Icons.description),
              ),
              SizedBox(
                height: 35,
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey[300],
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: !loginForm.isloading
                      ? Text(
                          loginForm.isloading ? 'Espere' : "Entrar",
                          style: TextStyle(color: Colors.white),
                        )
                      : CircularProgressIndicator(),
                ),
                onPressed: loginForm.isloading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isloading = true;

                        final String? errorMessage = await authService.login(
                            loginForm.ci, loginForm.tomo, loginForm.folio);
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        } else {
                          print(errorMessage);
                          NotificationService.showSnackBar(errorMessage);
                          loginForm.isloading = false;
                        }
                      },
              )
            ],
          )),
    );
  }
}
