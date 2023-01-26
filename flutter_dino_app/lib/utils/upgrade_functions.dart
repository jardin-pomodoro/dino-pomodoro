int getGrowTime(int initialGrowTime, int level) {
  return (initialGrowTime - (initialGrowTime * level * 0.1)).round();
}

int getIncome(int initialIncome, int level) {
  return (initialIncome + (initialIncome * level * 0.1)).round();
}

int nextUpgradePrice(int seedPrice, int level) {
  return (seedPrice * 0.1 + (seedPrice * level * 0.1)).round();
}

String durationString(int duration) {
  final minutes = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
  final seconds = (duration % 60).floor().toString().padLeft(2, '0');
  return '$minutes:$seconds';
}