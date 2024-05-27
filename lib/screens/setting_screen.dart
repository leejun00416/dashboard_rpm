import 'dart:async';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_rpm/providers/auth_provider.dart';
import '../repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dashboard_rpm/screens/setting_category_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool twentyFourHoursRule=true;
const double settingValueTextSize=20;

/*class Setting {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firebaseFirestore;

  const Setting({
    required this.firebaseAuth,
    required this.firebaseStorage,
    required this.firebaseFirestore,
  });

  Future<void> getData({
    required String email,
    required String nickName,
    required String password,
  }) async{
    UserCredential userCredential =
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );
    String uid = userCredential.user!.uid;
    var userInformation= await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }
}*/


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}
var AlramTime;

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
                            TextButton(onPressed:(){},child : Text('고치는 중'),),
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
                              onPressed:() async{
                                <Widget>[
                                  hourMinute12H()
                                ];
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
        )
    );
  }

  Widget hourMinute12H(){
    return new TimePickerSpinner(
      is24HourMode: twentyFourHoursRule,
      onTimeChange: (time) {
        setState(() async{
          AlramTime = time;
        });
      },
    );
  }


}