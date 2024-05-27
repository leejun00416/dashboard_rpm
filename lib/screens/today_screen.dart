import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key); // key 매개변수 수정

  @override
  State<MainScreen> createState() => _MainScreenState(); // createState 메서드 수정
}

class _MainScreenState extends State<MainScreen> { // _MainScreenState 클래스 추가
  @override
  Widget build(BuildContext context) {
    return SchedulePage();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(), // MainScreen을 홈으로 사용하도록 수정
    );
  }
}


class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('어느 날짜로 갈까요?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('확인'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('5/7 (화)', style: TextStyle(color: Colors.white)),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ScheduleGrid()),
          NotesSection(),
          PlannerButtons(),
        ],
      ),
    );
  }
}

class ScheduleGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: buildLeftTimeSlots()),
              buildMiddleTimeline(),
              Expanded(child: buildRightTimeSlots()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLeftTimeSlots() {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(10,0,0,0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6, // 가로로 여섯 개의 칸
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 1, // 높이/너비 비율
      ),
      itemCount: 144, // 오전 12시간
      itemBuilder: (context, index) {
        return TimeSlot('$index', Colors.brown, index-60, index + 1);
      },
    );
  }

  Widget buildMiddleTimeline() {
    return Container(
      width: 30, // 타임라인의 너비를 조정합니다.
      color: Colors.grey[300],
      child: Column(
        children: List.generate(24, (index) {
          return Container(
            height: 40.0,
            alignment: Alignment.center,
            child: Text('$index', style: TextStyle(fontSize: 12.0)),
          );
        }),
      ),
    );
  }

  Widget buildRightTimeSlots() {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6, // 가로로 두 개의 칸
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 1, // 높이/너비 비율
      ),
      itemCount: 72, // 오후 12시간
      itemBuilder: (context, index) {
        return TimeSlot(" $index", Colors.greenAccent, index, index +1);
      },
    );
  }
}

class TimeSlot extends StatelessWidget {
  final String label;
  final Color color;
  final int startHour;
  final int endHour;

  TimeSlot(this.label, this.color, this.startHour, this.endHour);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontSize: 16.0, color: Colors.white)),
    );
  }
}

class NotesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('화분에 물 주기', style: TextStyle(fontSize: 16.0)),
          Text('rpm 39페이지까지 풀기', style: TextStyle(fontSize: 16.0)),
          Text('이번 주에는 꼭 운동가자', style: TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}

class PlannerButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.yellow[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('계획: 소프'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('기록: 공기수'),
          ),
        ],
      ),
    );
  }
}
