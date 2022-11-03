import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/screens/admin_dashboard/add_quiz_questions.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({Key? key}) : super(key: key);

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final TextEditingController _quizName = TextEditingController();
  final TextEditingController _quizDesc = TextEditingController();
  final TextEditingController _quizImageUrl = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(20, 55, 67, 1),
                  Color.fromRGBO(37, 99, 120, 1),
                ])),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20,top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,color: Colors.white,size: 20),
                        SizedBox(width: 10,),
                        Text(AppLocalizations.of(context)!.addNewQuiz,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100)),
                      ],
                    ),
                  ),

                  TextField(
                      controller: _quizName,
                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.quizName,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),

                        suffixIcon: const Icon(
                          Icons.drive_file_rename_outline,
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
                      )),
                  SizedBox(height: 10,),
                  TextField(
                      controller: _quizDesc,
                      style: const TextStyle(color: Colors.white),

                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.quizDesc,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),

                        suffixIcon: const Icon(
                          Icons.description,
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
                      )),

                  TextField(
                      controller: _quizImageUrl,
                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.quizImageUrl,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),

                        suffixIcon: const Icon(
                          Icons.image,
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
                      )),
                  SizedBox(height: 10,),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async{
                      if(_validateFields()){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddQuizQuestions(quizDesc: _quizDesc.text.trim(), quizName: _quizName.text.trim(),quizImageUrl: _quizImageUrl.text),));
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
                        AppLocalizations.of(context)!.addQuiz),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  bool _validateFields(){
    setState(() {
      _quizName.text.trim();
      _quizDesc.text.trim();
    });
    if(_quizName.text.isEmpty || _quizDesc.text.isEmpty){
      return false;
    }else{
      return true;
    }
  }
}
