import 'dart:convert';
import 'dart:io';

Never fail(String message) {
  stderr.writeln('PPP drift check failed: $message');
  exit(1);
}

void main(List<String> args) {
  if (args.length != 2) {
    fail('usage: dart run tool/check_ppp_snapshot.dart SNAPSHOT CURRENT');
  }
  final expected =
      jsonDecode(File(args[0]).readAsStringSync()) as Map<String, dynamic>;
  final current =
      jsonDecode(File(args[1]).readAsStringSync()) as Map<String, dynamic>;
  final prices = <String, Map<String, dynamic>>{
    for (final item in (current['prices'] as List<dynamic>).cast<Map>())
      item['territory'] as String: item.cast<String, dynamic>(),
  };

  final checks = <Map<String, dynamic>>[
    ...(expected['territoryOverrides'] as List<dynamic>).cast<Map>().map(
      (item) => item.cast<String, dynamic>(),
    ),
    ...(expected['unchangedSpotChecks'] as List<dynamic>).cast<Map>().map(
      (item) => item.cast<String, dynamic>(),
    ),
  ];
  for (final check in checks) {
    final territory = check['territory'] as String;
    final actual = prices[territory];
    if (actual == null) fail('$territory is missing from the live schedule');
    if (actual['currency'] != check['currency']) {
      fail(
        '$territory currency changed from ${check['currency']} '
        'to ${actual['currency']}',
      );
    }
    final expectedAmount = num.parse(check['amount'] as String);
    final actualAmount = num.parse(actual['customerPrice'] as String);
    if (expectedAmount != actualAmount) {
      fail(
        '$territory price changed from $expectedAmount to $actualAmount '
        '${actual['currency']}',
      );
    }
  }
  stdout.writeln(
    'PPP drift check passed for ${checks.length} territory prices; '
    'no price write was made.',
  );
}
