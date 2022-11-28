import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:ns_read_story/generated/l10n.dart';
import 'package:ns_read_story/model/author.dart';
import 'package:ns_read_story/model/category_model.dart';
import 'package:ns_read_story/model/detail_chapter.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/home_repository.dart';
import 'package:ns_read_story/repository/news_repository.dart';
import 'package:ns_read_story/repository/personal_repository.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/shared/photo_view.dart';
import 'package:ns_read_story/ui/login/forgot_password/forgot_password_screen.dart';
import 'package:ns_read_story/ui/login/forgot_password/forgot_password_viewmodel.dart';
import 'package:ns_read_story/ui/login/login_screen.dart';
import 'package:ns_read_story/ui/login/login_viewmodel.dart';
import 'package:ns_read_story/ui/login/register/register3_viewmodel.dart';
import 'package:ns_read_story/ui/login/register/register_screen3.dart';
import 'package:ns_read_story/ui/main/home/category/category_story.dart';
import 'package:ns_read_story/ui/main/home/category/category_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/category/list_story_by_cate/list_story_by_cate.dart';
import 'package:ns_read_story/ui/main/home/category/list_story_by_cate/list_story_by_cate_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/detail_story/detail_story.dart';
import 'package:ns_read_story/ui/main/home/detail_story/detail_story_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/detail_story/rate_story/rate_story.dart';
import 'package:ns_read_story/ui/main/home/detail_story/rate_story/rate_story_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_screen.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/list_story_completed/list_story_completed.dart';
import 'package:ns_read_story/ui/main/home/list_story_completed/list_story_completed_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/list_story_new/list_story_new_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/list_story_new/list_storys_new.dart';
import 'package:ns_read_story/ui/main/home/list_storys_hot/list_story_hot.dart';
import 'package:ns_read_story/ui/main/home/list_storys_hot/list_story_hot_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/news/detail_news/detail_news.dart';
import 'package:ns_read_story/ui/main/home/news/news_page.dart';
import 'package:ns_read_story/ui/main/home/policy/policy.dart';
import 'package:ns_read_story/ui/main/home/ranking/ranking_page.dart';
import 'package:ns_read_story/ui/main/home/ranking/ranking_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/detail_user.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/detail_user_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/list_story_of_user.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/view_follow.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/view_follow_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/search_story/search_story.dart';
import 'package:ns_read_story/ui/main/home/search_story/search_viewmodel.dart';
import 'package:ns_read_story/ui/main/main_page.dart';
import 'package:ns_read_story/ui/main/main_page_viewmodel.dart';
import 'package:ns_read_story/ui/onboarding/onboarding.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:ns_read_story/ultils/pref_data.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'api/response_model/response_message.dart';
import 'ui/main/home/news/news_page_view_model.dart';
import 'ui/main/personal_page/author_regis/author_regis.dart';
import 'ui/main/personal_page/change_password/change_password_page.dart';
import 'ui/main/personal_page/change_password/change_password_viewmodel.dart';
import 'ui/main/personal_page/manage_story/add_chapter/add_chapter.dart';
import 'ui/main/personal_page/manage_story/add_chapter/add_chapter_viewmodel.dart';
import 'ui/main/personal_page/manage_story/list_manage_story.dart';
import 'ui/main/personal_page/manage_story/manage_story.dart';
import 'ui/main/personal_page/manage_story/manager_story_viewmodel.dart';
import 'ui/main/personal_page/menu.dart';
import 'ui/main/personal_page/personal_page.dart';
import 'ui/main/personal_page/personal_page_viewmodel.dart';
import 'ui/main/personal_page/post_story/post_story_screen.dart';
import 'ui/main/personal_page/post_story/post_story_viewmodel.dart';
import 'ui/main/personal_page/update_profile/update_profile_screen.dart';
import 'ui/main/personal_page/update_profile/update_profile_viewmodel.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
BuildContext? buildContext;

void main() async {
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceManager.init();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  messaging.getToken().then((value) async {
    AppProvider.instance.firebaseToken = value!;
    // await PreferenceManager.setString(PreferenceManager.firebaseToken, value);
    // print("token là $value");
  });

  // lấy ngôn ngữ đã lưu
  AppProvider.instance.languageCode = await PreferenceManager.getLanguage();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(StoryAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(AuthorAdapter());

  //custom loading
  customLoading();

  runApp(MultiProvider(providers: [
    Provider(create: (_) => UserRepository()),
    Provider(create: (_) => StoryRepository()),
    Provider(create: (_) => HomeRepository()),
    Provider(create: (_) => PersonalRepository()),
    Provider(create: (_) => NewsRepository()),
  ], child: const MyApp()));
}

_showNotification(RemoteMessage message) async {
  var android = const AndroidNotificationDetails(
    'channel_id',
    "CHANNEL NAME",
    channelDescription: "Channel Description",
    importance: Importance.max,
    playSound: true,
    styleInformation: DefaultStyleInformation(true, true),
  );
  var iOS = const IOSNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
  var platform = NotificationDetails(android: android, iOS: iOS);
  // Read Data
  String? title = message.notification?.title;
  String? description = message.notification?.body;

  // payLoad
  Map<dynamic, dynamic> payLoad = message.data;

  String objectId = payLoad['objectId'] ?? '';

  // TODO LocalNotification goi thi se co su kien tra ve payload khi click notification, chua biet neu notification binh thuong se bat su kien the nao
  await flutterLocalNotificationsPlugin!.show(
      objectId.hashCode, title, description, platform,
      payload: jsonEncode(payLoad));
}

void customLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..userInteractions = true
    ..dismissOnTap = true
    ..maskType = EasyLoadingMaskType.black
    ..boxShadow = [const BoxShadow(color: Colors.white)];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        builder: EasyLoading.init(),
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeListResolutionCallback: (locales, supportedLocales) {
          if (AppProvider.instance.languageCode.isNotEmpty) {
            return Locale(AppProvider.instance.languageCode);
          } else {
            // for (Locale locale in locales!) {
            // if device language is supported by the app,
            // just return it to set it as current app language
            // kiểm tra xem có ngôn ngữ hỗ trợ ko
            // if (supportedLocales
            //     .toString()
            //     .contains(locale.toString().split("_")[0])) {
            //   if (supportedLocales.toString().contains("vi")) {
            //     globalBloc.languageCode = "vi";
            //   }
            //   if (supportedLocales.toString().contains("en")) {
            //     globalBloc.languageCode = "en";
            //   }
            //   return locale;
            // }
            // }
          }
          // nếu không có thì trả mặc định là tiếng anh
          // if device language is not supported by the app,
          // the app will set it to english but return this to set to Bahasa instead
          return const Locale('vi');
        },
        routes: _pageMap(),
        initialRoute: PageRoutes.intro,
      ),
    );
  }
}

_pageMap() {
  return <String, WidgetBuilder>{
    PageRoutes.login: (BuildContext context) {
      int index = ModalRoute.of(context)!.settings.arguments as int;
      return ChangeNotifierProvider(
          create: (_) => LoginViewModel(
              userRepository: context.read<UserRepository>(), indexTab: index),
          child: const LoginScreen());
    },
    PageRoutes.intro: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => LoginViewModel(
              userRepository: context.read<UserRepository>(), indexTab: 0),
          child: const SpashsScreen());
    },
    PageRoutes.mainPage: (BuildContext context) {
      int index = ModalRoute.of(context)!.settings.arguments as int;
      return ChangeNotifierProvider(
          create: (_) => MainPageViewModel(
              userRepository: context.read<UserRepository>(), index: index),
          child: ChangeNotifierProvider.value(
              value: AppProvider.instance, child: const MainPage()));
    },
    PageRoutes.viewFollow: (BuildContext context) {
      List<String?> list =
          ModalRoute.of(context)!.settings.arguments as List<String?>;
      return ChangeNotifierProvider(
          create: (_) => ViewFollowViewModel(
              storyRepository: context.read<StoryRepository>(),
              userId: list[0]!,
              initIndexTab: int.parse(list[1]!)),
          child: const ViewFollow());
    },
    PageRoutes.register3: (BuildContext context) {
      String phone = ModalRoute.of(context)!.settings.arguments as String;
      return ChangeNotifierProvider(
        create: (_) => Register3ViewModel(
            userRepository: context.read<UserRepository>()),
        child: const RegisterScreen3(),
      );
    },
    PageRoutes.onboarding: (BuildContext context) {
      return const OnboardingScreen();
    },
    PageRoutes.detailUser: (BuildContext context) {
      String idUser = ModalRoute.of(context)!.settings.arguments as String;
      return ChangeNotifierProvider(
          create: (_) => DetailUserViewModel(
              storyRepository: context.read<StoryRepository>(), idUser: idUser),
          child: const DetailUser());
    },
    PageRoutes.personalPage: (BuildContext context) {
      bool? showBackButton =
          ModalRoute.of(context)!.settings.arguments as bool?;
      return ChangeNotifierProvider(
        create: (_) => PersonalPageViewModel(
          showBackButton: showBackButton,
          personalRepository: context.read<PersonalRepository>(),
        ),
        child: const PersonalPage(),
      );
    },
    PageRoutes.detailStory: (BuildContext context) {
      Story story = ModalRoute.of(context)!.settings.arguments as Story;
      return ChangeNotifierProvider(
          create: (_) => DetailStoryViewModel(
                storyRepository: context.read<StoryRepository>(),
                detailStory: story,
              ),
          child: const DetailStoryScreen());
    },
    PageRoutes.readStory: (BuildContext context) {
      ModelReadStory model =
          ModalRoute.of(context)!.settings.arguments as ModelReadStory;
      return ChangeNotifierProvider(
          create: (_) => ReadStoryViewModel(
              storyRepository: context.read<StoryRepository>(),
              modelReadStory: model),
          child: const ReadStory());
    },
    PageRoutes.postStory: (BuildContext context) {
      String idBook = ModalRoute.of(context)!.settings.arguments as String;
      return ChangeNotifierProvider(
        create: (_) => PostStoryViewModel(
            personalRepository: context.read<PersonalRepository>(),
            idBook: idBook),
        child: const PostStory(),
      );
    },
    PageRoutes.news: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) =>
              NewsPageViewModel(newsRepository: context.read<NewsRepository>()),
          child: const NewsPage());
    },
    PageRoutes.category: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) =>
              CategoryViewModel(homeRepository: context.read<HomeRepository>()),
          child: const CategoryStory());
    },
    PageRoutes.forgotPass: (BuildContext context) {
      List<String> list =
          ModalRoute.of(context)!.settings.arguments as List<String>;
      return ChangeNotifierProvider(
          create: (context) => ForgotPassViewModel(
              userRepository: context.read<UserRepository>(),
              username: list[0],
              token: list[1]),
          child: const ForgotPasswordScreen());
    },
    PageRoutes.manageStory: (BuildContext context) {
      String idBook = ModalRoute.of(context)!.settings.arguments as String;
      return MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => ManagerStoryViewModel(
              personalRepository: context.read<PersonalRepository>(),
              idBook: idBook),
        ),
        ChangeNotifierProvider(
          create: (_) => PersonalPageViewModel(
            personalRepository: context.read<PersonalRepository>(),
          ),
        )
      ], child: const ManageStory());
    },
    PageRoutes.rankingPage: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => RankingViewModel(
              storyRepository: context.read<StoryRepository>()),
          child: const RankingPage());
    },
    PageRoutes.changePassword: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => ChangePasswordViewModel(
              userRepository: context.read<UserRepository>()),
          child: const ChangePasswordScreen());
    },
    PageRoutes.listStoryByCate: (BuildContext context) {
      List<String?> list =
          ModalRoute.of(context)!.settings.arguments as List<String?>;
      return ChangeNotifierProvider(
          create: (_) => ListStoryByCateViewModel(
              storyRepository: context.read<StoryRepository>(),
              idCateSelected: list[0] ?? '',
              nameCateSelected: list[1] ?? ''),
          child: const ListStoryByCate());
    },
    PageRoutes.listStoryHot: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => ListStoryHotViewModel(
              storyRepository: context.read<StoryRepository>()),
          child: const ListStoryHot());
    },
    PageRoutes.listStoryNew: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => ListStoryNewViewModel(
              storyRepository: context.read<StoryRepository>()),
          child: const ListStoryNew());
    },
    PageRoutes.listStoryCompleted: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => ListStoryCompletedViewModel(
              storyRepository: context.read<StoryRepository>()),
          child: const ListStoryCompleted());
    },
    PageRoutes.listStoryOfUser: (BuildContext context) {
      String idUser = ModalRoute.of(context)!.settings.arguments as String;
      return ChangeNotifierProvider(
          create: (_) => DetailUserViewModel(
              idUser: idUser, storyRepository: context.read<StoryRepository>()),
          child: ListStoryOfUser());
    },
    PageRoutes.addChapter: (BuildContext context) {
      List<String?> list =
          ModalRoute.of(context)!.settings.arguments as List<String?>;
      return ChangeNotifierProvider(
          create: (_) => AddChapterViewModel(
              personalRepository: context.read<PersonalRepository>(),
              idChapter: list[0] ?? '',
              isEdit: list[1] ?? '',
              idBook: list[2] ?? '',
              canEnterPrice: list[3] ?? ''),
          child: const AddChapter());
    },
    PageRoutes.search: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) =>
              SearchViewModel(storyRepository: context.read<StoryRepository>()),
          child: const SearchStory());
    },
    PageRoutes.updateProfile: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => UpdateProfileViewModel(
              personalRepository: context.read<PersonalRepository>()),
          child: const UpdateProfile());
    },
    PageRoutes.rateStory: (BuildContext context) {
      final detailStory = ModalRoute.of(context)!.settings.arguments as Story;
      return ChangeNotifierProvider(
          create: (_) => RateStoryViewModel(
              detailStory: detailStory,
              storyRepository: context.read<StoryRepository>()),
          child: const RateStory());
    },
    PageRoutes.detailNews: (BuildContext context) {
      return const DetailNewsPage();
    },
    PageRoutes.listStoryManage: (BuildContext context) {
      return ChangeNotifierProvider(
          create: (_) => PersonalPageViewModel(
              personalRepository: context.read<PersonalRepository>()),
          child: const ListStoryManage());
    },
    PageRoutes.photoViewPage: (BuildContext context) {
      final result =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return PhotoViewPage(
          listImage: result['listImage'], initialIndex: result['index']);
    },
    PageRoutes.authorRegis: (BuildContext context) {
      return ChangeNotifierProvider(
          child: const AuthorRegis(),
          create: (_) => PersonalPageViewModel(
              personalRepository: context.read<PersonalRepository>()));
    },
    PageRoutes.menuPersonalPage: (BuildContext context) {
      return ChangeNotifierProvider(
          child: const MenuPersonalPage(),
          create: (_) => PersonalPageViewModel(
              personalRepository: context.read<PersonalRepository>()));
    },
    PageRoutes.policyPage: (BuildContext context) {
      return const PolicyPage();
    },
  };
}

void processNotificationData(Map valueMap) async {
  if (valueMap.isEmpty) {
    print('valueMap error');
  } else {
    String objectId = valueMap['objectId'];
    if (objectId.isNotEmpty) {
      print("obj id khac null");
      switch (valueMap['type']) {
        case 'FOLLOW_USER':
          await Navigator.of(buildContext!, rootNavigator: true)
              .pushNamed(PageRoutes.detailUser, arguments: objectId);
          break;
        case 'NEW_BOOK':
          Navigator.of(buildContext!, rootNavigator: true).pushNamed(
              PageRoutes.detailStory,
              arguments: Story(id: objectId));
          break;
        default:
          break;
      }
    }
  }
}

Future? onSelectNotification(String payload) {
  print('payload: $payload');
  /*Fluttertoast.showToast(
      msg: "payload: $payload",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );*/
  Map valueMap = json.decode(payload);
  processNotificationData(valueMap);
}

class SpashsScreen extends StatefulWidget {
  const SpashsScreen({Key? key}) : super(key: key);

  @override
  _SpashsScreenState createState() => _SpashsScreenState();
}

class _SpashsScreenState extends State<SpashsScreen> {
  @override
  void initState() {
    super.initState();
    navigator();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin?.initialize(initSetttings,
        onSelectNotification: (payload) => onSelectNotification(payload!));

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        AppProvider.instance.user.notificationCount =
            AppProvider.instance.user.notificationCount! + 1;
        AppProvider.instance.notifyListeners();
        print(
            '>>> AppProvider.instance.user.notificationCount: ${AppProvider.instance.user.notificationCount}');
        _showNotification(message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        AppProvider.instance.user.notificationCount =
            AppProvider.instance.user.notificationCount! + 1;
        AppProvider.instance.notifyListeners();
        print(
            '>>> AppProvider.instance.user.notificationCount: ${AppProvider.instance.user.notificationCount}');
        processNotificationData(message.data);
      },
    );

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        AppProvider.instance.user.notificationCount =
            AppProvider.instance.user.notificationCount! + 1;
        AppProvider.instance.notifyListeners();

        print(
            '>>> AppProvider.instance.user.notificationCount: ${AppProvider.instance.user.notificationCount}');
        // i++;

        Future.delayed(const Duration(milliseconds: 1500), () {
          processNotificationData(value.data);
        });
      }
    });
  }

  Future navigator() async {
    bool isRememberLogin =
        PreferenceManager.getBool(PreferenceManager.remember, false);
    bool isFirstLogin =
        PreferenceManager.getBool(PreferenceManager.isFirstLogin, true);
    await context.read<UserRepository>().getConfig();
    Future.delayed(const Duration(seconds: 2), () async {
        if (isRememberLogin) {
          String phone =
              PreferenceManager.getString(PreferenceManager.username);
          String pass = PreferenceManager.getString(PreferenceManager.password);
          final ResponseMessage? res = await context
              .read<LoginViewModel>()
              .login(context, phone, pass, isRememberLogin);
          if (res?.code == 200) {
            await context.read<UserRepository>().getInfoUser(res?.data2 ?? '');
            Navigator.pushNamedAndRemoveUntil(
                context, PageRoutes.mainPage, (route) => false,
                arguments: 0);
          } else {
            // Fluttertoast.showToast(
            //     msg: 'Tài khoản hoặc mật khẩu không đúng',
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            Navigator.pushNamedAndRemoveUntil(
                context, PageRoutes.mainPage, (route) => false,
                arguments: 0);
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, PageRoutes.mainPage, (route) => false,
              arguments: 0);
        }
    });
  }

  // Future<ResponseMessage?> login(BuildContext context,String username, String password,bool remember) async {
  //   EasyLoading.show();
  //   LoginRequest loginRequest = LoginRequest()
  //     ..username = username
  //     ..password = password;
  //   final res = await userRepository.login(loginRequest);
  //   print("22222222222222${res.code}");
  //   if (res.code == 200) {
  //     await PreferenceManager.setString(PreferenceManager.username, username);
  //     await PreferenceManager.setString(PreferenceManager.password, password);
  //     await PreferenceManager.setBool(PreferenceManager.remember, remember);
  //     EasyLoading.dismiss();
  //     return res;
  //   } else {
  //     EasyLoading.dismiss();
  //     return res;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
