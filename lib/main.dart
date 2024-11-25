import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const MyApp());
}

final ValueNotifier<bool> isDarkTheme = ValueNotifier(false);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkTheme,
        builder: (context, value, child) {
          return ShadApp.material(
            home: const HomeScreen(),
            theme: ShadThemeData(
                brightness: Brightness.light,
                colorScheme: ShadColorScheme.fromName('orange')),
            darkTheme: ShadThemeData(
              brightness: Brightness.dark,
              colorScheme: ShadColorScheme.fromName(
                'orange',
                brightness: Brightness.dark,
              ),
            ),
            themeMode: value ? ThemeMode.dark : ThemeMode.light,
          );
        });
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<String> currentSelected = ValueNotifier('None');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkTheme,
        builder: (context, value, child) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Flutter Cooking App'),
                actions: [
                  ShadSwitch(
                    value: value,
                    label: Text(
                      value ? '☼' : '☾',
                      style: const TextStyle(fontSize: 16),
                    ),
                    padding: const EdgeInsets.all(8),
                    onChanged: (value) {
                      isDarkTheme.value = value;
                    },
                  ),
                ],
              ),
              bottomNavigationBar: SizedBox(
                height: kBottomNavigationBarHeight,
                child: Center(
                  child: ShadButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Clicked Next'),
                        ),
                      );
                    },
                    child: const Text("Next"),
                  ),
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            "Filter recipes by diet and preference!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ShadButton.outline(
                                  onPressed: () {
                                    currentSelected.value = "Vegan";
                                  },
                                  child: const Text("Vegan"),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ShadButton.outline(
                                  onPressed: () {
                                    currentSelected.value = "Low Carb";
                                  },
                                  child: const Text("Low Carb"),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ShadButton.outline(
                                  onPressed: () {
                                    currentSelected.value = "High Protein";
                                  },
                                  child: const Text("High Protein"),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ShadButton.outline(
                                  onPressed: () {
                                    currentSelected.value = "Low Fat";
                                  },
                                  child: const Text("Low Fat"),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ShadButton.outline(
                                  onPressed: () {
                                    currentSelected.value = "Keto";
                                  },
                                  child: const Text("Keto"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Column(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: currentSelected,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: const TextStyle(fontSize: 16),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
