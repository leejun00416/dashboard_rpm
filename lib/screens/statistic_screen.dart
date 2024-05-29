import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("1주일 평균", style: TextStyle(fontSize: 14,),),
                  Text("5시간 45분", style: TextStyle(fontSize: 20,),),
                  Text("5월 5일 일요일", style: TextStyle(fontSize: 14,),),
                  Text("6시간 27분", style: TextStyle(fontSize: 20,),),
                  Text("목표 시간 대비 79.5% 성공했어요", style: TextStyle(fontSize: 14)),
                ]
            )
        )
    );
  }
}