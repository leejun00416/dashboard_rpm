import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dashboard_rpm/screens/setting_category_screen.dart';
import 'package:provider/provider.dart';

bool twentyFourHoursRule=true;
const double settingValueTextSize=20;
final firestore=FirebaseFirestore.instance;
var AlramTime;
String current_Nickname="";

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

void updateAlramTime() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('time',AlramTime.toString());
}
void bringAlramTime() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? time=prefs.getString('time');
  AlramTime=DateTime.parse(time??"0");
}

class SettingScreenState extends State<SettingScreen>{
  StreamController<String> streamController = StreamController<String>();

  @override
  Widget build(BuildContext context) {

    bool isTimeChanged=false;
    var temporaryTime=DateTime.now();
    if (AlramTime == null){
      AlramTime=DateTime.now();
    }
    final user = FirebaseAuth.instance.currentUser;
    var uid="";
    if(user!=null){
      uid=user.uid;
    }
    String changedNickName="";
    bringAlramTime();

    return Scaffold(
        appBar: AppBar(
          leading:IconButton(onPressed:() async{
            updateAlramTime();
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_left_outlined),color: Colors.black,
        ),
          title:Text("설정",style:TextStyle(fontSize:27, color:Colors.black,),),
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
                          children: [
                            Text('닉네임',style:TextStyle(fontSize:settingValueTextSize, color:Colors.black),),
                            TextButton(onPressed:(){
                              showDialog(
                                context:context,
                                barrierDismissible: false,
                                builder:(BuildContext context){
                                  return AlertDialog(
                                    content: TextField(
                                      onChanged: (text){
                                        setState(() {
                                          changedNickName=text;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText:"${firestore.collection('users').doc("nickName").get()}",
                                      )
                                    ),
                                    actions:[
                                      TextButton(onPressed:(){
                                        changedNickName="";
                                        Navigator.of(context).pop();
                                      },
                                        child:Text('취소',style:TextStyle(color:Colors.blue)),
                                      ),
                                      TextButton(onPressed:() async{
                                        if(user!=null && changedNickName!="") {
                                          await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                                            'nickName': changedNickName,
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      },
                                        child:Text('확인',style:TextStyle(color:Colors.blue)),
                                      )
                                    ]
                                  );
                                }
                              );
                            },
                              child:
                                Text('Error',style:TextStyle(fontSize:20, color:Colors.grey,),),
                            ),
                          ]
                      )
                  ),
                  //24시간으로 표현
                  Container(
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text('24시간으로 표현',style:TextStyle(fontSize:settingValueTextSize, color:Colors.black),),
                            CupertinoSwitch(
                              value: twentyFourHoursRule,
                              activeColor: CupertinoColors.activeBlue,
                              onChanged: (bool? value){
                                setState(() {
                                  twentyFourHoursRule = value ?? false;
                                });
                              },
                            ),
                          ]
                      )
                  ),
                  //일정 알림
                  Container(
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text('일정 알림',style:TextStyle(fontSize:settingValueTextSize, color:Colors.black),),
                            TextButton(
                              onPressed:(){
                                showDialog(
                                  context:context,
                                  barrierDismissible:false,
                                  builder:(BuildContext context){
                                    return AlertDialog(
                                      title: Text("일정 알림 시간"),
                                      content:TimePickerSpinner(
                                        is24HourMode: twentyFourHoursRule,
                                        onTimeChange: (time) {
                                          setState(() async{
                                            temporaryTime=time;
                                            isTimeChanged=true;
                                          });
                                        },
                                      ),
                                      actions:[
                                        TextButton(onPressed:(){
                                          changedNickName="";
                                          Navigator.of(context).pop();
                                        },
                                          child:Text('취소',style:TextStyle(color:Colors.blue)),
                                        ),
                                        TextButton(onPressed:() async{
                                          if(isTimeChanged){
                                            AlramTime = temporaryTime;
                                            isTimeChanged=false;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                          child:Text('확인',style:TextStyle(color:Colors.blue)),
                                        )
                                      ]
                                    );
                                  }
                                );
                              },
                              child:
                                Text(
                                  AlramTime.hour.toString().padLeft(2,'0')+":"+
                                  AlramTime.minute.toString().padLeft(2,'0'),
                                  style: TextStyle(
                                    fontSize: settingValueTextSize,
                                    color:Colors.grey,
                                  )
                                )
                            )
                          ]
                      )
                  ),
                  //카테고리 설정
                  Container(
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text('카테고리 설정',style:TextStyle(fontSize:settingValueTextSize, color:Colors.black),),
                            IconButton(onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:((context) => const SettingCategoryScreen()),
                                  )
                              );
                            }, icon: Icon(Icons.add_circle),color: Colors.blue,),
                          ]
                      )
                  ),
                ]
            )
        ),
        bottomNavigationBar: BottomAppBar(
          child:Row(
            children:[
              TextButton(
                onPressed: () async{
                  await context.read<AuthProvideres>().signOut();
                },
                child:Text('로그아웃',style:TextStyle(color:Colors.red,),),
              )
            ]
          ),
        ),
    );
  }
}