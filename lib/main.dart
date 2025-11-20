import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/riverpodCounterApp.dart';

void main() {
  runApp(
    const ProviderScope(child: RiverpodCounterApp())
  );
}
