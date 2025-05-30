// import 'dart:nativewrappers/_internal/vm/lib/ffi_dynamic_library_patch.dart';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rust/bloc/counter_bloc.dart';
import 'package:flutter_rust/bloc/counter_event.dart';
import 'package:flutter_rust/bloc/counter_state.dart';
import 'dart:ffi';
import 'package:flutter_rust/bridge_generated.dart/frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// final dylib = () {
//   if (Platform.isAndroid || Platform.isIOS) {
//     return DynamicLibrary.open("flutterrust"); // no "lib" or ".so"
//   } else if (Platform.isMacOS) {
//     return DynamicLibrary.open("libflutterrust.dylib");
//   } else if (Platform.isWindows) {
//     return DynamicLibrary.open("flutterrust.dll");
//   } else {
//     return DynamicLibrary.open("libflutterrust.so");
//   }
// }();

final dylibPath =
    'native/target/x86_64-unknown-linux-gnu/debug/libflutterrust.so';
final dylib = DynamicLibrary.open(dylibPath);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RustLib.init(externalLibrary: ExternalLibrary.open(dylibPath));

  runApp(BlocProvider(create: (_) => CounterBloc(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Rust Flutter Counter")),
        body: Center(
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Counter from Rust:',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text('${state.count}', style: const TextStyle(fontSize: 48)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(IncrementPressed());
                    },
                    child: const Text('Increment via Rust'),
                  ),
                  const Padding(padding: EdgeInsets.all(20)),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CounterBloc>().add(DecrementPressed());
                    },
                    child: const Text('Decrement via Rust'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
