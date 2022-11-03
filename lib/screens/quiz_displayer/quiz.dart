import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justagain_tesk_task/services/service_provider.dart';
import 'package:justagain_tesk_task/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class QuizDisplayer extends StatefulWidget {
  List questions;
  String quizName;
  QuizDisplayer({Key? key,required this.questions,required this.quizName}) : super(key: key);

  @override
  State<QuizDisplayer> createState() => _QuizDisplayerState();
}

class _QuizDisplayerState extends State<QuizDisplayer> {
  final TextEditingController _question = TextEditingController();
  final TextEditingController _firstAnswer = TextEditingController();
  final TextEditingController _secondAnswer = TextEditingController();
  final TextEditingController _thirdAnswer = TextEditingController();
  final TextEditingController _fourthAnswer = TextEditingController();
  final TextEditingController _fifthAnswer = TextEditingController();
  Map<String,int> _answers = {};

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
                          Icon(Icons.gpp_good,color: Colors.white,size: 20),
                          SizedBox(width: 10,),
                          Text(AppLocalizations.of(context)!.goodLuck,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100)),
                        ],
                      ),
                    ),

                    Column(
                      children: widget.questions.map<Widget>((qs) => _buildQuestionItem(qs)).toList(),
                    ),




                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if(widget.questions.length == _answers.length){
                          calcDegress();
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.answerAll)));
                        }
                      },
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(size.width, 30.sp)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white30)),
                      child: Text(
                          AppLocalizations.of(context)!.finishTheQuiz
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

  _buildQuestionItem(dynamic qs){
    return Column(
      children: [
        TextField(
            controller: TextEditingController(text: qs['question']),
            readOnly: true,
            style: const TextStyle(color: Colors.white),

            decoration: InputDecoration(
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
                _answers.addAll({
                  qs['question'] : 1,
                });
              });
            },
            readOnly:  true,

            controller: TextEditingController(text: qs['1stAnswer']),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: _answers[qs['question']]  == 1 ? Icon(
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
                _answers.addAll({
                  qs['question'] : 2,
                });
              });
            },
            readOnly:  true,

            controller: TextEditingController(text: qs['2stAnswer']),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: _answers[qs['question']]  == 2 ? Icon(
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
                _answers.addAll({
                  qs['question'] : 3,
                });
              });
            },
            readOnly:  true,

            controller: TextEditingController(text: qs['3rdAnswer']),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              hintText: AppLocalizations.of(context)!.third,
              suffixIcon: _answers[qs['question']]  == 3 ? Icon(
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
                _answers.addAll({
                  qs['question'] : 4,
                });
              });
            },
            readOnly:  true,

            controller: TextEditingController(text: qs['4thAnswer']),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: _answers[qs['question']]  == 4 ? Icon(
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
                _answers.addAll({
                  qs['question'] : 5,
                });
              });
            },
            readOnly:  true,
            controller: TextEditingController(text: qs['5thAnswer']),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: _answers[qs['question']] == 5 ? Icon(
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
        SizedBox(height: 20,),
        Divider(color: Colors.white,),
        SizedBox(height: 20,),

      ],
    );
  }

  calcDegress(){
    int totalCorrect = 0;
    for(int i= 0;i < widget.questions.length ; i++ ){
      if(widget.questions[i]['correctAnswer'] == _answers[widget.questions[i]['question']]){
        setState(() {
          totalCorrect ++;
        });
      }
    }

    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.congrats),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${AppLocalizations.of(context)!.youGot} $totalCorrect from ${widget.questions.length}'),
          Icon(Icons.check_box,color: Colors.green.shade900,)
        ],
      ),
      actions: [

        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text(AppLocalizations.of(context)!.exit,style: TextStyle(color: Colors.blue.shade900))),
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue.shade900)),
            onPressed: ()async{
          await Provider.of<ServiceProvider>(context,listen: false).saveDegree(widget.quizName, totalCorrect.toString());
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.doneAdding)));
        }, child: Text(AppLocalizations.of(context)!.save,)),
      ],
    ),);
  }
}
