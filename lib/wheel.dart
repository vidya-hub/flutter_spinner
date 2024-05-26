import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:spinner_wheel/spin_provider.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  void handleRoll() {
    context.read<SpinProvider>().roll();
  }

  @override
  void dispose() {
    context.read<SpinProvider>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpinProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<int>(
              stream: provider.spinStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Expanded(
                      child: FortuneWheel(
                        alignment: Alignment.center,
                        selected: provider.spinStream,
                        animateFirst: false,
                        onAnimationStart: () => provider.startAnimation(),
                        onAnimationEnd: () => provider.stopAnimation(),
                        onFling: handleRoll,
                        hapticImpact: HapticImpact.heavy,
                        indicators: const [
                          FortuneIndicator(
                            alignment: Alignment.center,
                            child: CircleIndicator(
                              elevation: 10,
                              color: Colors.white,
                              radius: 20,
                            ),
                          ),
                        ],
                        items: [
                          for (var rollValue in provider.rollValues)
                            FortuneItem(
                              style: FortuneItemStyle(
                                color: rollValue["color"],
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                                borderColor: Colors.black,
                                borderWidth: 2,
                              ),
                              child: Text(rollValue["value"]),
                              onTap: () {
                                print(rollValue);
                              },
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if ((!provider.isAnimating && snapshot.hasData))
                      Center(
                        child: Text(
                          "${provider.selectedValue}",
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      Text(
                        provider.isAnimating ? "Spinning..." : "Spin the wheel",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          handleRoll();
                        },
                        child: Text(
                          "Spin",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
        ),
      );
    });
  }
}
