import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_rpm/providers/auth_provider.dart';
import '../repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool twentyFourHoursRule=true;
const double settingValueTextSize=20;
class Setting {
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
    //var result= await FirebaseFirestore.instance.collection('usr').doc(uid).get();
  }
}


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:IconButton(onPressed:(){
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
                            TextButton(
                              onPressed:(){},
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('user').snapshots(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasError){
                                      return Text(
                                        '...',style:TextStyle(fontSize:15,color: Colors.grey),
                                      );
                                    }
                                    itemCount:snapshot.data!.docs.length;
                                    itemBuilder:(context, index) {
                                      return Text(
                                        snapshot.data!.docs[index]['nickname'],
                                        style: TextStyle(fontSize: 15, color: Colors.grey),
                                      );
                                    };
                                  }
                              )
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
                          ]
                      )
                  ),
                  //카테고리 설정
                  Container(
                      child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text('카테고리 설정',style:TextStyle(fontSize:settingValueTextSize, color:Colors.black),),
                            IconButton(onPressed:(){}, icon: Icon(Icons.add_circle),color: Colors.blue,),
                          ]
                      )
                  ),
                ]
            )
        )
    );
  }
}
