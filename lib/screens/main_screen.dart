import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashboard_rpm/screens/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await context.read<AuthProvideres>().signOut();
          },
          child: Text('로그아웃'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            SizedBox(width:40),
            Container(
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    TextButton(
                      child:Text('Week'),
                      onPressed: (){
                      },

                    ),
                    TextButton(
                      child:Text('Today'),
                      onPressed: (){

                      },
                    ),
                    TextButton(
                      child:Text('Stat'),
                      onPressed: (){

                      },
                    ),
                  ]
              )
            ),
            IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:((context) => const SettingScreen()),
                  )
                );
              },
              icon:Icon(Icons.settings), //image.asset(''), iconSize:50,
            )
          ]
        )
      ),
    );
  }
}
