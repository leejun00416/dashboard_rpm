import 'dart:math';

//import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:dashboard_rpm/screens/setting_screen.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //그리드 안 컨테이너 정보 얻기 함수
  final GlobalKey _containerKey = GlobalKey();
  Size? size;
  Offset? offset;

  //시간 리스트 (6~24시까지)
  final List<int> timeList = <int>[6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];

  //그리드 안 컨테이너 정보 얻기
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        size = _getSize();
        offset = _getOffset();
      });
    });
  }

  Size? _getSize() {
    if (_containerKey.currentContext != null) {
      final RenderBox renderBox =
      _containerKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
  }

  Offset? _getOffset() {
    if (_containerKey.currentContext != null) {
      final RenderBox renderBox =
      _containerKey.currentContext!.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      return offset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 10,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios),),

            Text("5/27 (월)"),

            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios), ),
          ],
        ),
      ),

      body:
          ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, mainAxisSpacing: 2, crossAxisSpacing: 2),
                      itemCount: 114,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          color: Colors.grey,
                        );
                      },
                    ),

                  ),


                  Expanded(
                    child: ListView.separated(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: timeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: size?.height,
                          margin: EdgeInsets.only(left: 2, right: 2,),
                          color: Colors.orange,
                          child: Center(child: Text('${timeList[index]}'),),
                        );
                      },
                      separatorBuilder: (BuildContext context ,int index) => const Divider(
                        height: 2,
                      )
                    ),
                  ),

                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, mainAxisSpacing: 2, crossAxisSpacing: 2),
                      itemCount: 114,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          color: Colors.grey
                        );
                      },
                    ),
                  ),

                ],
              ),

              //size checking 용도
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, mainAxisSpacing: 2, crossAxisSpacing: 2),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          color: Colors.white,
                          key: _containerKey,
                        );
                      },
                    ),

                  ),


                  Expanded(
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: size?.height,
                            margin: EdgeInsets.only(left: 2, right: 2,),
                            color: Colors.white,
                            child: Center(child: Text(''),),
                          );
                        },
                        ),
                    ),


                  Expanded(
                    flex: 4,
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6, mainAxisSpacing: 2, crossAxisSpacing: 2),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                            color: Colors.white
                        );
                      },
                    ),
                  ),

                ],
              ),
            ],
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