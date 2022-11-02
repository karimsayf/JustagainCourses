import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/firebase_options.dart';
import 'package:justagain_tesk_task/screens/auth/login.dart';
import 'package:justagain_tesk_task/screens/home.dart';
import 'package:justagain_tesk_task/services/navigation_services.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ServiceProvider>(
      create: (context) => ServiceProvider(),
    ),

  ],
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Justagian Test Task',
            navigatorKey: NavigationService.navigatorKey,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: StreamBuilder(
              stream:FirebaseAuth.instance.authStateChanges() ,
              builder: (context, snapshot) {
                if(snapshot.data == null){
                  return const Login();
                }
                return Home();
              },
            )
          );
        });
  }
}
