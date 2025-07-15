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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MSP Al-Azhar',
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    BlogsScreen(),
    TeamScreen(),
    SettingScreen(),
  ];

  final List<String> iconPaths = [
    "assets/img/icons/home.png",
    "assets/img/icons/blog.png",
    "assets/img/icons/team.png",
    "assets/img/icons/setting.png"
  ];

  final List<String> selectedIconPaths = [
    "assets/img/icons/home_selected.png",
    "assets/img/icons/blog_selected.png",
    "assets/img/icons/team_selected.png",
    "assets/img/icons/setting_selected.png"
  ];

  final List<String> labels = ["Home", "Blogs", "Our Team", "Setting"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary700,
        unselectedItemColor: AppColors.neutral600,
        backgroundColor: AppColors.neutral100,
        items: List.generate(4, (index) {
          return BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Image.asset(
                _selectedIndex == index
                    ? selectedIconPaths[index]
                    : iconPaths[index],
                width: 28,
                height: 28,
              ),
            ),
            label: labels[index],
          );
        }),
      ),
    );
  }
}
