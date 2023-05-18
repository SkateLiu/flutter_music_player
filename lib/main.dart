import 'package:flutter/material.dart';
import 'package:flutter_music_player/model/music_controller.dart';
import 'package:flutter_music_player/utils/shared_preference_util.dart';
import 'package:provider/provider.dart';
import 'dao/api_cache.dart';
import 'model/color_provider.dart';
import 'model/video_controller.dart';
import 'pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initBeforeRunApp().then((re) {
    runApp(_buildProvider());
    _doSomethingInBackground();
  });
}

/// 在启动之前要做的异步任务
/// 获取主题颜色
Future<bool> _initBeforeRunApp() async {
  // 要去SharedPrefrence里面去颜色数据，但是为异步任务，修改main方法，首先完成异步任务再启动app；
  await SharedPreferenceUtil.init();
  ColorStyleProvider.initColorStyle();
  return true;
}

/// 启动时要进行的后台任务
/// 这里简单用async，如果任务比较耗时，考虑Isolate方案。
_doSomethingInBackground() async {
  // 清理缓存
  await APICache.clearCache();
}

_buildProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<ColorStyleProvider>.value(
          value: ColorStyleProvider()),
      ChangeNotifierProvider<MusicController>.value(value: MusicController()),
      ChangeNotifierProvider<VideoControllerProvider>.value(
          value: VideoControllerProvider()),
    ],
    child: MyApp(),
  );
}

class MyApp extends StatefulWidget {
  //通过顶层视图的key，可以获取OverlayState对象
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ColorStyleProvider colorStyleProvider =
        Provider.of<ColorStyleProvider>(context);

    return MaterialApp(
      title: '网抑云',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay:
          colorStyleProvider.showPerformanceOverlay, // 是否打开性能测试层
      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xFF282626),
          appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
              textTheme: TextTheme(title: TextStyle(color: Colors.white))),
          primarySwatch:
              colorStyleProvider.getCurrentColor(color: 'mainColor')),
      darkTheme: ThemeData(
        //未配置 默认暗黑模式
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
