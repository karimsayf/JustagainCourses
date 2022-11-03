import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/enums/enums.dart';
import 'package:justagain_tesk_task/screens/home.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  Auth _currentAuth = Auth.login;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  bool _passSecure = true;
  bool _passConfirmationSecure = true;
  bool _isLoading = false;
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
                height: 40.sp,
              ),

           const Padding(
                padding :EdgeInsets.symmetric(horizontal: 50),
                child: Divider(color: Colors.white30),
              ),
              SizedBox(
                height: 40.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () async{
                        setState(() {_currentAuth = Auth.login;});
                        await Provider.of<ServiceProvider>(context,listen: false).login(_emailController.text, _passwordController.text);},
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
                        AppLocalizations.of(context)!.signUp,
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
                height: 30.sp,
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
                      decoration: InputDecoration(
                        hintText:  AppLocalizations.of(context)!.enterYourEmail,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        border:const  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:const  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder:const  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        disabledBorder:const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: _passSecure,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterYourPassword,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passSecure = !_passSecure;
                            });
                          },
                          icon: Icon(
                            _passSecure
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
                          onPressed: () {
                            _forgotPassword();
                          },
                          child:  Text(
                              AppLocalizations.of(context)!.forgotPassword,
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                    Visibility(
                        visible: _currentAuth == Auth.signUp,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            TextFormField(
                              controller: _passwordConfirmationController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: _passConfirmationSecure,
                              decoration: InputDecoration(
                                hintText:  AppLocalizations.of(context)!.enterPasswordConfirmation,
                                contentPadding: const EdgeInsets.all(20),
                                hintStyle: const TextStyle(color: Colors.white),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passConfirmationSecure =
                                          !_passConfirmationSecure;
                                    });
                                  },
                                  icon: Icon(
                                    _passConfirmationSecure
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
                    Visibility(visible: _isLoading,child: const Center(child: LinearProgressIndicator(color: Colors.white30,backgroundColor: Colors.transparent,))),
                    ElevatedButton(
                      onPressed: () async{
                        if(_validateFields()){
                         await _submit();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.emptyField)));
                        }
                      },
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(size.width, 30.sp)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white30)),
                      child: Text(
                          _currentAuth == Auth.login ? AppLocalizations.of(context)!.login : AppLocalizations.of(context)!.signUp),
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

  bool _validateFields(){
    setState(() {
      _emailController.text.trim();
      _passwordController.text.trim();
      _passwordConfirmationController.text.trim();
    });
    if(_currentAuth == Auth.login){
      if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
        return false;
      }else{
        return true;
      }
    }else{
      if(_emailController.text.isEmpty || _passwordController.text.isEmpty || _passwordConfirmationController.text.isEmpty){
        return false;
      }else{
        return true;
      }
    }
  }

  _submit()async{
    setState(() {
      _isLoading = true;
    });
    if(_currentAuth == Auth.login){
      await Provider.of<ServiceProvider>(context,listen: false).login(_emailController.text, _passwordController.text).then((res){
        if(res == true){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder:  (context) => const Home(),));
        }
      });
    }else{
       if(_passwordController.text == _passwordConfirmationController.text){
         await Provider.of<ServiceProvider>(context,listen: false).signUp(_emailController.text, _passwordController.text).then((res)async{
           if(res == true){
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder:  (context) => const Home(),));
           }
         });
       }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.passwordsDoesNotMatch)));
       }
    }
    setState(() {
      _isLoading = false;
    });
  }

  _forgotPassword()async{
    setState(() {
      _emailController.text.trim();
    });
    if(_emailController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.enterYourEmail)));
    }else{
      await Provider.of<ServiceProvider>(context,listen: false).forgotPassword(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.forgotEmailSent)));

    }
  }
}
