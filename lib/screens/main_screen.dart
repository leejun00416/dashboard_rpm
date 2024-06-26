import 'package:dashboard_rpm/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();
var new_now = new DateTime.now();
String formatDate = DateFormat('MM/dd (E)', 'ko').format(now);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SchedulePage(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _showNotesSection = false;

  void _toggleNotesSection() {
    setState(() {
      _showNotesSection = !_showNotesSection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff656565),
        elevation: 10,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  now = now.subtract(Duration(hours: 24));
                  formatDate = DateFormat('MM/dd (E)', 'ko').format(now);
                });
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                if (selectedDate != null) {
                  setState(() {
                    new_now = selectedDate;
                    formatDate = DateFormat('MM/dd (E)', 'ko').format(selectedDate);
                  });
                }
              },
              child: Text('$formatDate'),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  now = now.add(Duration(hours: 24));
                  formatDate = DateFormat('MM/dd (E)', 'ko').format(now);
                });
              },
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: ScheduleGrid()),
          if (_showNotesSection) NotesSection(),
          PlannerActionBar1(toggleNotesSection: _toggleNotesSection),
          PlannerActionBar2(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 40),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text('Week'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Text('Today'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: Text('Stat'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleGrid extends StatefulWidget {
  @override
  _ScheduleGridState createState() => _ScheduleGridState();
}

class _ScheduleGridState extends State<ScheduleGrid> {
  Set<int> _selectedSlots = Set<int>();
  bool _isDragging = false;

  void _handleSelection(int index) {
    setState(() {
      _selectedSlots.add(index);
    });
  }

  void _startDragging(int index) {
    setState(() {
      _isDragging = true;
      _handleSelection(index);
    });
  }

  void _updateDragging(int index) {
    if (_isDragging) {
      _handleSelection(index);
    }
  }

  void _stopDragging() {
    setState(() {
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey,
        child: Row(
          children: [
            Expanded(child: buildTimeSlots(0), flex: 6),
            Expanded(child: buildMiddleTimeline(), flex: 1),
            Expanded(child: buildTimeSlots(144), flex: 6),
          ],
        ),
      ),
    );
  }

  Widget buildTimeSlots(int offset) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 1,
      ),
      itemCount: 144,
      itemBuilder: (context, index) {
        int actualIndex = index + offset;
        return GestureDetector(
          onPanStart: (_) => _startDragging(actualIndex),
          onPanUpdate: (_) => _updateDragging(actualIndex),
          onPanEnd: (_) => _stopDragging(),
          child: TimeSlot(
            ' ',
            _selectedSlots.contains(actualIndex) ? Colors.blue : Colors.white,
            actualIndex,
            actualIndex + 1,
          ),
        );
      },
    );
  }

  Widget buildMiddleTimeline() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1,
      ),
      itemCount: 24,
      itemBuilder: (context, index) {
        return TimeSlot('$index', Colors.white38, index, index);
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
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ㅁ 화분에 물 주기', style: TextStyle(fontSize: 16.0)),
            Text('ㅁ rpm 39페이지까지 풀기', style: TextStyle(fontSize: 16.0)),
            Text('이번 주에는 꼭 운동가자', style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}

class PlannerActionBar1 extends StatelessWidget {
  final VoidCallback toggleNotesSection;

  PlannerActionBar1({required this.toggleNotesSection});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('계획:', style: TextStyle(fontSize: 16.0)),
          ElevatedButton(
            onPressed: () {},
            child: Text('소프1', style: TextStyle(fontSize: 16.0)),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
            ),
          ),
          Text('할 시간', style: TextStyle(fontSize: 16.0)),
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: toggleNotesSection,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
          ),
        ],
      ),
    );
  }
}

class PlannerActionBar2 extends StatefulWidget {
  @override
  _PlannerActionBar2State createState() => _PlannerActionBar2State();
}

class _PlannerActionBar2State extends State<PlannerActionBar2> {
  final List<String> _dropdownItems = ['소프1', '공기수', '잉컨', '플러터'];
  String _selectedItem = '소프1';
  bool _isPlaying = false;

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: const Color(0xffe1e1da),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(' 기록:', style: TextStyle(fontSize: 16.0)),
          Container(
            width: 87,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: DropdownButton<String>(
              value: _selectedItem,
              style: TextStyle(
                color: Colors.black,
              ),
              items: _dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 16.0)),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedItem = newValue!;
                });
              },
            ),
          ),
          Text('하는 중', style: TextStyle(fontSize: 16.0)),
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: _togglePlayPause,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
          ),
        ],
      ),
    );
  }
}
