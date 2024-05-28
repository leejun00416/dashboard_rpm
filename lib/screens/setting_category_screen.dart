import 'package:flutter/material.dart';

class SettingCategoryScreen extends StatefulWidget {
  const SettingCategoryScreen({super.key});

  @override
  State<SettingCategoryScreen> createState() => _SettingCategoryScreenState();
}

class _SettingCategoryScreenState extends State<SettingCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:IconButton(onPressed:() async{
            Navigator.of(context).pop();
          },
            icon: Icon(Icons.arrow_left_outlined),color: Colors.black,
          ),
          title:Text("카테고리",style:TextStyle(fontSize:27, color:Colors.black,),),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              // 폴더와 카테고리 추가 버튼
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Text('폴더추가',style:TextStyle(fontSize: 20, color:Colors.black,),),
                    IconButton(onPressed:(){}, icon: Icon(Icons.add_circle),color: Colors.blue,),
                    SizedBox(width:10,),
                    Text('카테고리 추가',style:TextStyle(fontSize:20, color:Colors.black,),),
                    IconButton(onPressed:(){}, icon: Icon(Icons.add_circle),color: Colors.blue,),
                  ]
                )
              ),
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                   Icon(Icons.folder,color: Colors.black),
                  ]
                )
              ),
            ]
          )
        )

    );
  }
}
