import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../animation/FadeAnimation.dart';
import '../../core/viewmodels/signUp_viewmodel.dart';
import 'login.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        InkWell(
                            onTap: () {},
                            child: RichText(
                              text: TextSpan(
                                text:
                                    "Create an account and enjoy reading books with Books to looks",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                                // ignore: prefer_const_literals_to_create_immutables
                              ),
                            )))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FormBuilder(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.2,
                          makeInput(
                              label: "Name",
                              controller: name,
                              prefixIcon: const Icon(Icons.person),
                              validator:
                                  FormBuilderValidators.required(context),
                              context: context)),
                      FadeAnimation(
                          1.3,
                          makeInput(
                              label: "Email",
                              prefixIcon: const Icon(Icons.email),
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.match(context,
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                                      errorText: "Not valid email")
                                ],
                              ),
                              controller: email,
                              context: context)),
                      FadeAnimation(
                          1.4,
                          makeInput(
                              label: "Password",
                              obscureText: true,
                              issufixIcon: true,
                              prefixIcon: const Icon(Icons.key),
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.match(context,
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                      errorText:
                                          "Password must contain A-Z,\nspecial character,number")
                                ],
                              ),
                              controller: password,
                              context: context)),
                      FadeAnimation(
                          1.5,
                          makeInput(
                              label: "Confirm Password",
                              obscureText: true,
                              controller: confirmPassword,
                              issufixIcon: true,
                              prefixIcon: const Icon(Icons.key),
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.match(context,
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                      errorText:
                                          "Password must contain A-Z,\nspecial character,number")
                                ],
                              ),
                              context: context)),
                    ],
                  ),
                ),
                FadeAnimation(
                    1.6,
                    Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          if (formKey.currentState!.saveAndValidate()) {
                            Provider.of<SignUpModel>(context, listen: false)
                                .requestsignUpUser(
                                    email.text,
                                    name.text,
                                    password.text,
                                    confirmPassword.text,
                                    context);
                          }
                        },
                        color: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    )),
                FadeAnimation(
                    1.7,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Already have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text(
                            " Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput(
      {label,
      obscureText = false,
      required Icon prefixIcon,
      bool issufixIcon = false,
      required TextEditingController controller,
      required FormFieldValidator<String>? validator,
      context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        Consumer<SignUpModel>(builder: (context, model, child) {
          return FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            name: "s",
            obscureText: issufixIcon ? !model.isSelected : false,
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: label,
              suffixIcon: issufixIcon
                  ? IconButton(
                      splashRadius: 4,
                      onPressed: () {
                        model.changeisShowPassword(model.isSelected);
                      },
                      icon: Icon(model.isSelected
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )
                  : const SizedBox.shrink(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          );
        }),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
