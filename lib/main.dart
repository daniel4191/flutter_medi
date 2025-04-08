import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<String> notifications = [
    '나중에 루프로 출력될 곳1',
    '나중에 루프로 출력될 곳2',
    '나중에 루프로 출력될 곳3',
  ];
  Set<int> readNotifications = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(
        notifications: notifications,
        readNotifications: readNotifications,
        onRead: (int index) {
          setState(() {
            readNotifications.add(index);
          });
        },
      ),
      ManagePage(),
      SettingsPage(),
    ];

    int unreadCount = notifications.length - readNotifications.length;

    return MaterialApp(
      title: '메디로지스 알림',
      home: Scaffold(
        appBar: AppBar(title: const Text('메디로지스', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.notifications),
                  if (unreadCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: '알림',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.subject_sharp),
              label: '관리리스트',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.notifications, required this.readNotifications, required this.onRead});

  final List<String> notifications;
  final Set<int> readNotifications;
  final void Function(int index) onRead;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        bool isRead = readNotifications.contains(index);
        return GestureDetector(
          onTap: () => onRead(index),
          child: Card(
            color: isRead ? Colors.white : Colors.amber[800],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: ListTile(
              title: Text(notifications[index]),
              subtitle: Text(isRead ? '읽음' : '새 알림'),
            ),
          ),
        );
      },
    );
  }
}

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  bool isWork = true;
  int people = 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('관리리스트', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ToggleButtons(
                isSelected: [isWork, !isWork],
                onPressed: (int index) {
                  setState(() {
                    isWork = index == 0;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('출근', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('퇴근', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Align(
            alignment: Alignment.centerRight,
            child: Text('현재 인원: $people명', style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
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
  String currentArea = '서울 강남구';
  int memberCount = 12;
  int unitCount = 6;
  String status = '정상 운영 중';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('현재 관리 지역: $currentArea', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
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
          Center(
            child: isLoggedIn
                ? ElevatedButton(
              onPressed: () {
                setState(() => isLoggedIn = false);
              },
              child: const Text('로그아웃'),
            )
                : Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => isLoggedIn = true);
                  },
                  child: const Text('로그인'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('회원가입'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 20)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

