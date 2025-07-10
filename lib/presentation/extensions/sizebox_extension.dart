part of 'extensions.dart';

extension SizeboxExtension on num {
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());
}
