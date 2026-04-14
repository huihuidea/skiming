import 'package:babay_pro/Utils/hive_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'Utils/Storage.dart';
import 'config/app_pages.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.init();
  await HiveStorage.init();
  await HiveStorage.openHive();
  runApp(
    ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  int currentIndex = 0;
  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: Scaffold(
        body: AppPages.pages[currentIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
        builder: (context, child) {
          return EasyLoading.init()(
            context,
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: child!,
              ),
            ),
          );
        }
    );
  }
}
