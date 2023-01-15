import 'package:hooks_riverpod/hooks_riverpod.dart';

const names = [
  'John',
  'Paul',
  'George',
  'Ringo',
  'Pete',
  'Stuart',
  'Mick',
  'Keith',
  'Ronnie',
  'Charlie',
  'Brian',
  'Noé'
];

final tickerProvider = StreamProvider(
    (ref) => Stream.periodic(const Duration(seconds: 1), (x) => x + 1));

final namesProvider = StreamProvider((ref) {
  final count = ref.watch(tickerProvider.stream).map((x) => x % names.length + 1);
  return count.map((c) => names.getRange(0, c));
});
