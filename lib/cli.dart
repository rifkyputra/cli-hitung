int calculate() {
  return 6 * 7;
}

class PriceCalculator {
  double pricePerTime({
    required double totalSpent,
    required DateTime buyTime,
  }) {
    final now = DateTime.now();

    final difference =
        ((now.millisecondsSinceEpoch - buyTime.millisecondsSinceEpoch) /
                1000 /
                60 /
                60 /
                24)
            .floor();

    return totalSpent / difference;
  }

  // int epochDifference() {

  // }
}

int findGcd(List<int> numbers) =>
    numbers.reduce((next, prev) => next.gcd(prev));

class Shape {
  static List triangle({required String char, int? trim, required lines}) {
    final list = List.generate(lines, (index) {
      return [
        ...List.generate(lines - (index + 1),
            (_) => List.generate(char.length, (_) => '_').join('')),
        ...List.generate((index + (index + 1)), (_) => '$char'),
      ].join('');
    });

    if (trim != null) {
      for (var i = 1; i <= trim; i++) {
        list.removeAt(0);
      }
    }

    return list;
  }
}

enum Direction {
  Left,
  Top,
  Right,
  Bottom,
}
