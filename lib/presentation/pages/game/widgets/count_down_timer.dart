part of game;

class CountDownTimer extends StatefulWidget {
  final int durationTime;
  final Function(int)? changeTimer;

  const CountDownTimer({
    required this.durationTime,
    this.changeTimer,
  });

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  bool playTicking = false;

  String get timerString {
    final Duration remainingTime =
        controller.duration! * (1 - controller.value);
    return '${remainingTime.inSeconds}';
  }

  int get durationTime => widget.durationTime;

  Future<void> notify() async {
    if (timerString == '10' && !playTicking) {
      setState(() {
        playTicking = true;
      });
      await player.resume();
    }
  }

  void restartController() {
    if (controller.isCompleted) {
      setState(() {
        playTicking = false;
      });
      player.stop();
      controller.reset();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(CountDownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.durationTime != widget.durationTime) {
      _initializeController();
    }
  }

  Future<void> _initializeController() async {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.durationTime,
      ), // Use the updated durationTime
    );
    await player.setSource(AssetSource('sounds/clock2.wav'));
    player.setReleaseMode(ReleaseMode.loop);

    controller.addListener(() {
      notify();
      restartController();
      if (controller.isAnimating) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      width: 250.0,
      height: 300.0,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CustomPaint(
                          painter: CustomTimerPainter(
                            animation: controller,
                            backgroundColor: themeData.indicatorColor,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.isDismissed) {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              constraints: const BoxConstraints(
                                maxWidth: 400.0,
                              ),
                              builder: (BuildContext context) => SizedBox(
                                height: 700.0,
                                child: CupertinoTheme(
                                  data: const CupertinoThemeData(
                                    brightness: Brightness.dark,
                                  ),
                                  child: CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.ms,
                                    initialTimerDuration: controller.duration!,
                                    onTimerDurationChanged: (Duration time) {
                                      setState(() {
                                        controller.duration = time;
                                        widget.changeTimer!(
                                          controller.duration!.inSeconds,
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              timerString,
                              style: TextStyle(
                                fontSize: 70.0,
                                fontWeight: FontWeight.bold,
                                color:
                                    MafiaTheme.themeData.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (controller.isAnimating) {
                      controller.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      controller.forward();
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: RoundButton(
                    icon: isPlaying == true ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.reset();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                  child: const RoundButton(
                    icon: Icons.stop,
                  ),
                ),
              ],
            ).padding(top: 50.0),
          ],
        ),
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    final double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) =>
      animation.value != old.animation.value ||
      color != old.color ||
      backgroundColor != old.backgroundColor;
}
