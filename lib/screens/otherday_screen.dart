import 'package:dashboard_rpm/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_rpm/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'main_screen.dart' as SD;

var date = SD.new_now;
String formatDate = DateFormat('MM/dd (E)','ko').format(date);

var nowTime = SD.formatDate;

class OtherdayScreen extends StatefulWidget {
  const OtherdayScreen({super.key});

  @override
  State<OtherdayScreen> createState() => _OtherdayScreenState();
}

class _OtherdayScreenState extends State<OtherdayScreen> {

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
    return null;
  }

  Offset? _getOffset() {
    if (_containerKey.currentContext != null) {
      final RenderBox renderBox =
      _containerKey.currentContext!.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      return offset;
    }
    return null;
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

            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: SD.new_now,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  //locale: const Locale('ko','KR'),
                );
                if (selectedDate != null) {
                  setState(() {
                    formatDate = DateFormat('MM/dd (E)','ko').format(selectedDate);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtherdayScreen(),
                        ));
                  });
                }
              },
              child: Text(
                  '$nowTime'
              ),
            ),

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
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await context.read<AuthProvideres>().signOut();
              },
              child: Text('로그아웃'),
            ),
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