import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


bool Twenty_Four_Hours_Rule=true;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading:IconButton(onPressed:(){}, icon: Icon(Icons.arrow_left_outlined),color: Colors.black,),
          title:Text("설정",style:TextStyle(fontSize:30, color:Colors.black,),),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 25, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //닉네임
            Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('닉네임',style:TextStyle(fontSize:15, color:Colors.black),),
                  TextButton(onPressed:(){},child:Text("TEXT BUTTON"),),
                ]
              )
            ),
            //24시간으로 표현
            Container(
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text('24시간으로 표현',style:TextStyle(fontSize:15, color:Colors.black),),
                      CupertinoSwitch(
                          value: Twenty_Four_Hours_Rule,
                          activeColor: CupertinoColors.activeBlue,
                          onChanged: (bool? value){
                            setState(() {
                              Twenty_Four_Hours_Rule = value ?? false;
                            });
                          },
                      ),
                    ]
                )
            ),
          ]
        )
      )
    );
  }
}
