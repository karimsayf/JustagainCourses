import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/screens/admin_dashboard/add_quiz.dart';
import 'package:justagain_tesk_task/screens/quiz_displayer/quiz.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MyGrades extends StatefulWidget {
  const MyGrades({Key? key}) : super(key: key);

  @override
  State<MyGrades> createState() => _MyGradesState();
}

class _MyGradesState extends State<MyGrades> {
  late final Future _getUserData = Provider.of<ServiceProvider>(context,listen: false).getUserDegrees();
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
        /*   decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgs/bg.jpeg'),
            fit: BoxFit.cover
          )
        ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60.sp,),

            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: Text(AppLocalizations.of(context)!.myGrades,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,letterSpacing: 2),
                )),

            SizedBox(height: 50.sp,),

            Expanded(
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                margin: const EdgeInsets.symmetric(horizontal:10),
                child: FutureBuilder(
                  future: _getUserData,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return SingleChildScrollView(
                        child: Column(
                            children: snapshot.data.docs.map<Widget>((item)=>_buildCourse(item)).toList()
                        ),
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(color: Colors.blue.shade900),);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCourse(dynamic item){
    return  Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(item['quizName'],style: TextStyle(color: Colors.cyan.shade900,fontWeight: FontWeight.w700,fontSize: 25),),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizDisplayer(questions: item['questions'],quizName: item['quizName']),));
            },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade900)),
              child: Text(item['degree']),)

          ],
        ),
      ),
    );
  }
}
