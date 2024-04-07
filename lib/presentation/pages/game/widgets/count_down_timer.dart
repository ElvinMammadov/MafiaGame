part of game;

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final AudioPlayer player = AudioPlayer();

  String get timerString {
    final Duration remainingTime =
        controller.duration! * (1 - controller.value);
    // print('${remainingTime.inSeconds % 60}');
    return '${remainingTime.inSeconds % 60}';
  }

  @override
  void initState()  {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    controller.forward(
      from: controller.value == 0.0 ? controller.value : 1.0,
    );
    controller.addListener(() async {
      await player.setSource(AssetSource('sounds/clock.mp3'));
      if (controller.status == AnimationStatus.forward &&
          controller.value == 1) {
        // If animation reaches 10 seconds, play audio
        if (controller.duration! * controller.value ==
            const Duration(
              seconds: 10,
            )) {
          await player.resume();
        }
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
      width: 150.0,
      height: 150.0,
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) => Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  timerString,
                                  style: const TextStyle(
                                    fontSize: 46.0,
                                    color: Colors.white,
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
              ],
            ),
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
