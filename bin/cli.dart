import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:cli/cli.dart' as cli;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('total', abbr: 't')
    ..addOption('waktu', abbr: 'w')
    ..addFlag('save')
    ..addFlag('load');

  final result = parser.parse(arguments);

  var buyTime = DateTime.tryParse(result['waktu'].toString());
  var totalSpent = double.tryParse(result['total'].toString());

  final isSave = result['save'];
  final isLoad = result['load'];

  if (isSave) {
    final p = path.join('.', 'data.json');

    final myfile = File(p);
    final json = jsonEncode({
      'waktu': result['waktu'].toString(),
      'total': result['total'],
    });

    myfile.writeAsStringSync(json);
  }

  if (isLoad) {
    final p = path.join('.', 'data.json');

    final myfile = File(p);

    final rawString = await myfile.readAsString();

    final json = jsonDecode(rawString);

    buyTime = DateTime.tryParse(json['waktu'].toString());
    totalSpent = double.tryParse(json['total']);
  }

  if (buyTime == null || totalSpent == null) {
    print('format salah');
    return;
  }

  final pricePerDay = cli.PriceCalculator()
      .pricePerTime(totalSpent: totalSpent, buyTime: buyTime);

  final curr = NumberFormat.currency(locale: 'id', name: 'Rp ');

  print('Biaya : ${curr.format(pricePerDay)} per hari');
}
