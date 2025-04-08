import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '메디로지스 알림',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    ManagePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: '알림',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.subject_sharp),
      label: '관리리스트',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: '설정',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        iconSize: 30,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = '메디로지스 알림';

    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TitleSection(name: '나중에 루프로 출력될 곳1', location: ''),
          TitleSection(name: '나중에 루프로 출력될 곳2', location: ''),
          TitleSection(name: '나중에 루프로 출력될 곳3', location: ''),
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Text(location, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  bool isWorking = true;
  int memberCount = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관리리스트'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(child: Text('인원: $memberCount명')),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          ToggleButtons(
            borderRadius: BorderRadius.circular(12),
            selectedColor: Colors.white,
            color: Colors.black,
            fillColor: Colors.blue,
            constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
            isSelected: [isWorking, !isWorking],
            onPressed: (int index) {
              setState(() {
                isWorking = index == 0;
              });
            },
            children: const [Text('출근'), Text('퇴근')],
          ),
          const SizedBox(height: 24),
          // 아래에 리스트나 컨텐츠 추가 가능
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('설정 페이지')),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoggedIn = false;
  String currentArea = '서울 강남구'; // 예시
  int memberCount = 12;
  int unitCount = 6;
  String status = '정상 운영 중';

  @override
  void initState() {
    super.initState();
    // TODO: 여기서 API 호출로 데이터 받아오도록 구현할 수 있어
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 관리 중인 지역
            Text(
              '현재 관리 지역: $currentArea',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ✅ 인원 / 호수 / 상태
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('관리 인원 수', '$memberCount명'),
                    _buildInfoRow('호 수', '$unitCount호'),
                    _buildInfoRow('상태', status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // ✅ 로그인/로그아웃/회원가입 버튼
            Center(
              child: isLoggedIn
                  ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoggedIn = false;
                  });
                  // TODO: 로그아웃 로직
                },
                child: const Text('로그아웃'),
              )
                  : Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: 로그인 로직
                      setState(() {
                        isLoggedIn = true;
                      });
                    },
                    child: const Text('로그인'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: 회원가입 로직
                    },
                    child: const Text('회원가입'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}