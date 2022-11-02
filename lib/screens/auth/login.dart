import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/enums/enums.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Auth _currentAuth = Auth.login;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool _passVisible = false;
  bool _passConfirmationVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(20, 55, 67, 1),
              Color.fromRGBO(37, 99, 120, 1),
            ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: largeSpace,
              ),
              Image.asset('assets/logos/logo.png',
                  color: Colors.white, width: size.width * 70 / 100),
              SizedBox(
                height: 80.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () async{
                        setState(() {_currentAuth = Auth.login;});
                        await Provider.of<ServiceProvider>(context,listen: false).login(_emailController.text, _passwordController.text);},
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                _currentAuth == Auth.login ? 22.sp : 18.sp,
                            fontWeight: _currentAuth == Auth.login
                                ? FontWeight.bold
                                : FontWeight.normal),
                      )),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _currentAuth = Auth.signUp;
                        });
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                _currentAuth == Auth.signUp ? 22.sp : 18.sp,
                            fontWeight: _currentAuth == Auth.signUp
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ))
                ],
              ),
              SizedBox(
                height: 50.sp,
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter your Email',
                        contentPadding: EdgeInsets.all(20),
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: _passVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter a Password',
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          },
                          icon: Icon(
                            _passVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Visibility(
                      visible: _currentAuth == Auth.login,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Your Password?',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Visibility(
                        visible: _currentAuth == Auth.signUp,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.sp,
                            ),
                            TextFormField(
                              controller: _passwordConfirmationController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: _passConfirmationVisible,
                              decoration: InputDecoration(
                                hintText: 'Enter a Password Confirmation',
                                contentPadding: const EdgeInsets.all(20),
                                hintStyle: const TextStyle(color: Colors.white),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passConfirmationVisible =
                                          !_passConfirmationVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _passConfirmationVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                                border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                disabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 100.sp,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(size.width, 30.sp)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white30)),
                      child: Text(
                          _currentAuth == Auth.login ? 'LOGIN' : 'SIGN UP'),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
