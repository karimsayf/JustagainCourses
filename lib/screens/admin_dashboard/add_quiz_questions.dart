import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddQuizQuestions extends StatefulWidget {
  String quizName;
  String quizDesc;
  String quizImageUrl;
   AddQuizQuestions({Key? key,required this.quizDesc, required this.quizName,required this.quizImageUrl}) : super(key: key);

  @override
  State<AddQuizQuestions> createState() => _AddQuizQuestionsState();
}

class _AddQuizQuestionsState extends State<AddQuizQuestions> {
  List _questions = [];
  final TextEditingController _question = TextEditingController();
  final TextEditingController _firstAnswer = TextEditingController();
  final TextEditingController _secondAnswer = TextEditingController();
  final TextEditingController _thirdAnswer = TextEditingController();
  final TextEditingController _fourthAnswer = TextEditingController();
  final TextEditingController _fifthAnswer = TextEditingController();
  int? correctAnswer ;

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.closed_caption,color: Colors.white,size: 20),
                            SizedBox(width: 10,),
                            Text(AppLocalizations.of(context)!.addQuestion,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(_questions.length.toString(),style: TextStyle(color: Colors.white),),
                            IconButton(onPressed: (){
                              if(_question.text.isEmpty ||_firstAnswer.text.isEmpty  || _secondAnswer.text .isEmpty || _thirdAnswer.text.isEmpty  || _fourthAnswer.text.isEmpty  || _fifthAnswer.text.isEmpty ){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.emptyField)));

                              }else{
                                setState(() {
                                  _questions.add({
                                    'question' : _question.text,
                                    '1stAnswer':_firstAnswer.text,
                                    '2stAnswer' :_secondAnswer.text,
                                    '3rdAnswer' : _thirdAnswer.text,
                                    '4thAnswer' : _fourthAnswer.text,
                                    '5thAnswer':_fifthAnswer.text,
                                    'correctAnswer' : correctAnswer
                                  });
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.doneAdding)));
                                clearFields();
                              }
                              }, icon: Icon(Icons.add_box,color: Colors.white,)),
                          ],
                        )
                      ],
                    ),
                  ),

                  TextField(
                      controller: _question,
                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.addQuestionTitle,
                        contentPadding: const EdgeInsets.all(20),
                        hintStyle: const TextStyle(color: Colors.white),

                        suffixIcon: const Icon(
                          Icons.question_mark,
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
                  SizedBox(height: 30,),
                  TextField(
                    onTap: () {
                      setState(() {
                        correctAnswer = 1;
                      });
                    },
                      controller: _firstAnswer,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: AppLocalizations.of(context)!.first,
                        suffixIcon: correctAnswer == 1 ? Icon(
                          Icons.check_box,
                          color: Colors.green.shade500,
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
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
                      onTap: () {
                        setState(() {
                          correctAnswer = 2;
                        });
                      },
                      controller: _secondAnswer,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: AppLocalizations.of(context)!.second,
                        suffixIcon: correctAnswer == 2 ? Icon(
                          Icons.check_box,
                          color: Colors.green.shade500,
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
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
                      onTap: () {
                        setState(() {
                          correctAnswer = 3;
                        });
                      },
                      controller: _thirdAnswer,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: AppLocalizations.of(context)!.third,
                        suffixIcon: correctAnswer == 3 ? Icon(
                          Icons.check_box,
                          color: Colors.green.shade500,
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
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
                      onTap: () {
                        setState(() {
                          correctAnswer = 4;
                        });
                      },
                      controller: _fourthAnswer,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: AppLocalizations.of(context)!.fourth,
                        suffixIcon: correctAnswer == 4 ? Icon(
                          Icons.check_box,
                          color: Colors.green.shade500,
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
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
                      onTap: () {
                        setState(() {
                          correctAnswer = 5;
                        });
                      },
                      controller: _fifthAnswer,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        hintText: AppLocalizations.of(context)!.fifth,
                        suffixIcon: correctAnswer == 5 ? Icon(
                          Icons.check_box,
                          color: Colors.green.shade500,
                        ) : null,
                        filled: true,
                        fillColor: Colors.white,
                        border:const  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:const  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder:const  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        disabledBorder:const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      )),
                  Visibility(visible: _isLoading,child: const Center(child: LinearProgressIndicator(color: Colors.white30,backgroundColor: Colors.transparent,))),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async{
                      if(_questions.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.emptyField)));
                      }else{
                        await Provider.of<ServiceProvider>(context,listen: false).addQuiz(widget.quizName, widget.quizDesc, widget.quizImageUrl, _questions);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.doneAdding)));
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                            Size(size.width, 30.sp)),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.white30)),
                    child: Text(
                        AppLocalizations.of(context)!.submit
                    ),
                  )

                ],
              ),
            )
          ],
        )
      ),
    );
  }

  clearFields()async{
setState(() {
  _question.clear();
  _firstAnswer.clear();
  _secondAnswer.clear();
  _thirdAnswer.clear();
  _fourthAnswer.clear();
  _fifthAnswer.clear();
  correctAnswer = null;
});
  }


}
