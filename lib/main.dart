import 'package:flutter/material.dart';
import "dart:math" show pi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'R. A. D. A. R.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _currentSliderValue = 0;

  late final AnimationController _radarController;

  @override
  void initState() {
    _radarController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10), upperBound: 360)
      ..repeat();
    // _radarController.addListener(() {
    //   print(_radarController.value);
    // });
    // _radarController.addStatusListener((status) {
    //   print('Current status: ${status.name}');
    // });
    super.initState();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                // Разметка
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 1),
                        color: Colors.black,
                        shape: BoxShape.circle),
                  ),
                ),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 1),
                        color: Colors.black,
                        shape: BoxShape.circle),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 1),
                        shape: BoxShape.circle),
                  ),
                ),
                AnimatedBuilder(
                  animation: _radarController,
                  builder: (context, child) {
                    return Transform.rotate(
                      alignment: Alignment.bottomRight,
                      angle: _radarController.value * pi / 180,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          boxShadow: const [
                            BoxShadow(color: Colors.green, blurRadius: 50)
                          ],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(100)),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _radarController,
                  builder: (context, child) {
                    return Positioned(
                      top: 23,
                      left: 100,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: (_radarController.value > 0 &&
                                  _radarController.value < 90)
                              ? Colors.red
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  _radarController.stop();
                },
                child: const Icon(Icons.stop),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  _radarController.repeat();
                },
                child: const Icon(Icons.play_arrow),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Slider(
              activeColor: Colors.lightGreen,
              inactiveColor: Colors.greenAccent,
              secondaryActiveColor: Colors.greenAccent,
              thumbColor: Colors.green,
              min: 0,
              max: 360,
              value: _currentSliderValue,
              onChangeEnd: (newValue) {
                _radarController.repeat();
                setState(() {
                  _currentSliderValue = 0;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  _currentSliderValue = newValue;
                });
                _radarController.value = newValue;
              }),
        ],
      ),
    );
  }
}
