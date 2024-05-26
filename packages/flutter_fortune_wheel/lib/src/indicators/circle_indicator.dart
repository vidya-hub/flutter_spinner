part of 'indicators.dart';

class CircleIndicator extends StatelessWidget {
  final Color? color;
  final double radius;
  final double elevation;
  final VoidCallback? onTap;
  const CircleIndicator({
    Key? key,
    this.color,
    this.radius = 20,
    this.elevation = 2,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: _math.pi,
        child: SizedBox(
          child: _Circle(
            color: color ?? theme.colorScheme.secondary,
            elevation: elevation,
            radius: radius,
          ),
        ),
      ),
    );
  }
}
