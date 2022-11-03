import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/screens/admin_dashboard/add_quiz.dart';
import 'package:justagain_tesk_task/screens/auth/authentication.dart';
import 'package:justagain_tesk_task/screens/my_graders/my_grades.dart';
import 'package:justagain_tesk_task/screens/quiz_displayer/quiz.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Future _getUserData = Provider.of<ServiceProvider>(context,listen: false).getUserData();
  late Future _getQuizzes = Provider.of<ServiceProvider>(context,listen: false).getQuizzes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FutureBuilder(future: _getUserData,builder:  (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data['userType'] == 'admin'){
            return FloatingActionButton.extended(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddQuiz(),));
            }, label: Text(AppLocalizations.of(context)!.addQuiz),icon: Icon(Icons.add),backgroundColor: Colors.blue.shade900);
          }else{
            return FloatingActionButton.extended(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyGrades(),));

            }, label: Text(AppLocalizations.of(context)!.myGrades),icon: Icon(Icons.grade),backgroundColor: Colors.blue.shade900);
          }
        }
        return Container();
      }),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.sp,),
            IconButton(onPressed: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                content: SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/bgs/profile_placeholder.png'),
                        radius: 50,
                      ),
                      SizedBox(height: 10,),
                      Text("Salaam All!"),
                      SizedBox(height: 5,),

                      Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(fontSize: 10)),
                      SizedBox(height: 20,),

                      ListTile(onTap: ()async{

                        await Provider.of<ServiceProvider>(context,listen: false).forgotPassword(FirebaseAuth.instance.currentUser!.email!);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.forgotEmailSent)));

                      },title: Text(AppLocalizations.of(context)!.resetPassword),leading: Icon(Icons.lock_reset),),
                      ListTile(onTap: ()async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context)!.pushReplacement(MaterialPageRoute(builder: (context) => Authentication(),));
                      },title: Text(AppLocalizations.of(context)!.logOut),leading: Icon(Icons.logout),)

                    ],
                  ),
                ),
              ),);
            }, icon: Icon(Icons.menu,color: Colors.white,)),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20,top: 10),
              child: Row(
                children: [
                  Icon(Icons.quiz,color: Colors.white,size: 20),
                  SizedBox(width: 10,),
                  Text(AppLocalizations.of(context)!.welcome,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100)),
                ],
              ),
            ),
            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: Text(AppLocalizations.of(context)!.whatToAdd,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,letterSpacing: 2),
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
                  future: _getQuizzes,
                  builder: (context, snapshot) {
                     if(snapshot.hasData){
                       return RefreshIndicator(
                         onRefresh: () {
                           setState(() {
                             _getQuizzes = Provider.of<ServiceProvider>(context,listen: false).getQuizzes();
                           });
                           return Future.value(true);
                         },
                         child: SingleChildScrollView(
                           physics: const AlwaysScrollableScrollPhysics(),

                           child: Column(
                             children: snapshot.data.docs.map<Widget>((item)=>_buildCourse(item)).toList()
                           ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(item['quizImageUrl'],height: 100.sp,width: 100.sp,fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.network('https://media.istockphoto.com/vectors/distance-education-business-online-learning-vector-id1140687101?b=1&k=20&m=1140687101&s=612x612&w=0&h=JKWPCvPG68ETdrSpoOHl5h8wDneYxa_bH-c1GU_VDYo=',height: 100.sp,width: 100.sp,fit: BoxFit.cover,),)),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text(item['quizName'],style: TextStyle(color: Colors.cyan.shade900,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                SizedBox(width: size.width * 0.55,child: Text(item['quizDesc'],textAlign: TextAlign.start,)),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timelapse,size: 15,color: Colors.blue.shade500),
                        SizedBox(width: 5,),
                        Text('${item['questions'].length} Questions',style: TextStyle(color: Colors.blue.shade500),),
                      ],
                    ),
                    SizedBox(width: 30,),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizDisplayer(questions: item['questions'],quizName: item['quizName']),));
                    },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade900)),
                      child: Text('Start'),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
