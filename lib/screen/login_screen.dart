import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/auth_controller.dart';
import 'package:movies_app/screen/registar_screen.dart';
import 'package:movies_app/widgets/bottom_widgwt.dart';
import 'package:movies_app/widgets/text_filed_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Map<String, dynamic> _loginData = {};
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
              _emailController.text = 'super_admin@app.com';
              _passwordController.text = 'password';
            },
            child: Center(
              child: Text(
                'Login',
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              BottomWidget(
                titelButton: 'Login',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _loginData['email'] = _emailController.text ;
                    _loginData['password'] = _passwordController.text ;
                    loginController.Login(loginData: _loginData);
                  }
                },
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                Get.to(()=>RegistarScreen() ,preventDuplicates: false);
              }, child: Text('create new account',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))
            ],
          )),
    );
  }
}
