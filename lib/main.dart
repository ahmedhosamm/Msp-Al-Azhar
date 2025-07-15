import 'package:flutter/material.dart';
import 'src/screens/Home/UI/home.dart';
import 'src/screens/Blogs/UI/blogs.dart';
import 'src/screens/OurTeam/UI/team.dart';
import 'src/screens/Setting/UI/setting.dart';
import 'src/screens/Splash/Splash.dart';
import 'style/Colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary700,
        scaffoldBackgroundColor: AppColors.neutral100,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary700,
          foregroundColor: AppColors.neutral100,
          iconTheme: IconThemeData(color: AppColors.neutral100),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary700,
          primary: AppColors.primary700,
          secondary: AppColors.primary400,
          background: AppColors.neutral100,
          surface: AppColors.neutral100,
          onPrimary: AppColors.neutral100,
          onSecondary: AppColors.primary700,
          onBackground: AppColors.neutral1000,
          onSurface: AppColors.neutral1000,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primary700,
          unselectedItemColor: AppColors.neutral600,
          backgroundColor: AppColors.neutral100,
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeScreen(),
    BlogsScreen(),
    TeamScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary700,
        unselectedItemColor: AppColors.neutral600,
        backgroundColor: AppColors.neutral100,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Our Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
