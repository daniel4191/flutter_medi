import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = '메디로지스 알림';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          appBar: AppBar(title: const Text(appTitle)),
          body: ListView(
            children: const [
              TitleSection(name: '나중에 루프로 출력될 곳1', location: '',),
              TitleSection(name: '나중에 루프로 출력될 곳2', location: '',),
              TitleSection(name: '나중에 루프로 출력될 곳3', location: '',),
            ],
          ),
        bottomNavigationBar: const ButtonSection(),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 20),
        //   child: SizedBox(
        //     width: MediaQuery.of(context).size.width,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         FloatingActionButton(
        //           onPressed: () => print('알림'),
        //           tooltip: '알림',
        //           child: Icon(Icons.notifications),
        //           heroTag: 'btn1',
        //         ),
        //         FloatingActionButton(
        //           onPressed: () => print('관리리스트'),
        //           tooltip: '관리리스트',
        //           child: Icon(Icons.subject_sharp),
        //           heroTag: 'btn2',
        //         ),
        //         FloatingActionButton(
        //           onPressed: () => print('설정'),
        //           tooltip: '설정',
        //           child: Icon(Icons.settings),
        //           heroTag: 'btn3',
        //         ),
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
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(location, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    // final Color color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWithText(color: Colors.purple, icon: Icons.notifications, label: '알림'),
          ButtonWithText(color: Colors.purple, icon: Icons.subject_sharp, label: '관리리스트'),
          ButtonWithText(color: Colors.purple, icon: Icons.settings, label: '설정'),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: 600, height: 240, fit: BoxFit.cover);
  }
}

