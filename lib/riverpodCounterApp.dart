import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RiverpodCounterApp extends StatelessWidget{
  const RiverpodCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterScreen());
  }
}


/// Provider 정의 >>
/// int 타입의 counter에 대한 상태를 정의하는 StateNotifier 정의
/// Riverpod 2.0부터는 StateNotifierProvider 대신 AsyncNotifierProvider 사용 권장
///  --> AsyncValue 반환해줌
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(this.ref) : super(0);

  final Ref ref;

  Future<void> increment() async {
    state++;
  }
  Future<void> decrement() async {
    state--;
  }
}

final counterStateProvider = StateNotifierProvider<CounterNotifier, int>((ref){
  return CounterNotifier(ref);
});
/// << Provider 정의


class CounterScreen extends ConsumerWidget{
  const CounterScreen({super.key});
  
  Widget txtCounter(){
    return Consumer(builder: (context, ref, widget){
      print("Consumer build");
      final count = ref.watch(counterStateProvider);
      return Text("$count", style: const TextStyle(fontSize: 32));
    });
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider 읽기 위해서는 ref 객체 필요
    // ref는 위젯, provider에서 provider를 읽을 수 있게 해줌
    // ref를 얻으려면 ConsumerWidget을 사용하거나, 사용하고 싶은 위젯 부분에서 Consumer 위젯으로 감싸야함
    // build 내에서 선언한 count는 ref의 watch로 counterStateProvider의 상태값 수신
    // 값이 변할때마다 감지되어 리빌드됨
    //  >> build 내에서 사용할 경우, text 뿐만 아니라 전체 화면이 갱신됨
    //  >> Consumer를 통해 해당 영역만 갱신될 수 있도록 작성
    // final count = ref.watch(counterStateProvider);
    print("CounterScreen build run");

    return Scaffold(
      body: Center(
        // child: Text('$count', style: const TextStyle(fontSize: 32))
        child: txtCounter()
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (){
              ref.read(counterStateProvider.notifier).increment();
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: (){
              ref.read(counterStateProvider.notifier).decrement();
            },
          ),
        ],
      ),
    );
  }


}