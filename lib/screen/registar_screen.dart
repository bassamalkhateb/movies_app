import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/auth_controller.dart';
import 'package:movies_app/widgets/bottom_widgwt.dart';
import 'package:movies_app/widgets/text_filed_form.dart';

class RegistarScreen extends StatefulWidget {
  const RegistarScreen({Key? key}) : super(key: key);

  @override
  State<RegistarScreen> createState() => _RegistarScreenState();
}

class _RegistarScreenState extends State<RegistarScreen> {
  final loginController = Get.find<AuthController>();
  final registerController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = true;
  bool _showPasswordConfirmation = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _registarData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        buildTopbanner(),
        buildForm(),
      ],
    ));
  }

  Widget buildTopbanner() {
    return Container(
      height: 250,
      color: Colors.amber,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              _emailController.text = 'bassam@app.com';
              _passwordController.text = 'password';
              _passwordConfirmationController.text = 'password';
              _nameController.text = 'Bassam';
            },
            child: Center(
              child: Text(
                'Register',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 1,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Form(
          key: _formKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFiledForm(
                label: 'User Name',
                textInputType: TextInputType.name,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'User Name field is required';
                  }
                },
              ),
              TextFiledForm(
                label: 'Email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email field is required';
                  }
                },
              ),
              TextFiledForm(
                label: 'Password',
                textInputType: TextInputType.visiblePassword,
                controller: _passwordController,
                obscureText: _showPassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: _showPassword == true
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password field is required';
                  } else if (value.length < 8) {
                    return 'Password must be greater or equal to 8 characters or numbers ';
                  }
                },
              ),
              TextFiledForm(
                label: 'Password Confirmation',
                textInputType: TextInputType.visiblePassword,
                controller: _passwordConfirmationController,
                obscureText: _showPasswordConfirmation,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPasswordConfirmation = !_showPasswordConfirmation;
                      });
                    },
                    icon: _showPasswordConfirmation == true
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Make sure the password is similar';
                  }
                },
              ),
              BottomWidget(
                titelButton: 'Registrar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _registarData['email'] = _emailController.text;
                    _registarData['password'] = _passwordController.text;
                    _registarData['password_confirmation'] =
                        _passwordConfirmationController.text;
                    _registarData['name'] = _nameController.text;
                    registerController.register(registerData: _registarData);
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => RegistarScreen(), preventDuplicates: false);
                },
                child: Text('Already have an accuount ?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              ),
            ],
          )),
    );
  }
}
