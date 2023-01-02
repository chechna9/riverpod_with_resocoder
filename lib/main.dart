import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// autodispose dispose the and reset the state automatically
final counterProvider = StateProvider.autoDispose<int>((ref) => 0);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Counter',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CounterPage(),
              ),
            );
          },
          child: const Text('Go to Counter Page'),
        ),
      ),
    );
  }
}

class CounterPage extends ConsumerWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch or read :  watch continusly listening and rebuild when value changes
    final int counter = ref.watch(counterProvider);
    // cant draw while build method need seperate function
    ref.listen<int>(
      counterProvider,
      (previous, next) {
        if (next >= 5) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Warning'),
                content: const Text(
                    'Counter is high , it would be better to reset it.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          IconButton(
              onPressed: () {
                // invalidate and refresh: reset the state
                // invalidate optimisez return void refresh return the init value
                ref.invalidate(counterProvider);
              },
              icon: const Icon(Icons.restart_alt))
        ],
      ),
      body: Center(
        child: Text(
          counter.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // this is mutable
          ref.read(counterProvider.notifier).state++;
        },
      ),
    );
  }
}
