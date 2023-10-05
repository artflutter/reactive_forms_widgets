part of 'reactive_animated_toggle_switch_rolling.dart';

const _defaultIndicatorAppearingAnimationDuration = Duration(milliseconds: 350);
const _defaultIndicatorAppearingAnimationCurve = Curves.easeOutBack;

Widget _defaultIndicatorAppearingBuilder(
    BuildContext context, double value, Widget indicator) {
  return Transform.scale(scale: value, child: indicator);
}

Widget _defaultLoadingIconBuilder(BuildContext context,
        DetailedGlobalToggleProperties<dynamic> properties) =>
    const _MyLoading();

class _MyLoading extends StatelessWidget {
  const _MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).iconTheme.color;
    final size = IconTheme.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme.of(context).platform.isApple
          ? CupertinoActivityIndicator(color: color)
          : SizedBox.square(
              dimension: size,
              child: CircularProgressIndicator(color: color, strokeWidth: 3.0),
            ),
    );
  }
}

extension _XTargetPlatform on TargetPlatform {
  bool get isApple =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}

extension _XColorToGradient on Color {
  Gradient toGradient() => LinearGradient(colors: [this, this]);
}
