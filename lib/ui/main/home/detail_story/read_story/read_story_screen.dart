import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/header.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_viewmodel.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../../../ultils/app_config.dart';
import '../../../../../ultils/constants.dart';

class ReadStory extends StatefulWidget {
  const ReadStory({Key? key}) : super(key: key);

  @override
  _ReadStoryState createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReadStoryViewModel>();
    return WillPopScope(
      onWillPop: () async {
        print("okokokok");
        viewModel.idChapter = '';
        viewModel.myTimer!.cancel();
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppConfig.colorBgValue,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            controller: viewModel.controller,
                            child: GestureDetector(
                              onTap: () => viewModel.showEvent(),
                              child: Column(
                                children: [
                                  const HeaderReadStory(),
                                  sizeBox10,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: Text(
                                              viewModel.detailChapter?.name ?? '',
                                              style: TextStyle(
                                                  color: AppConfig.colorBgValue ==
                                                          Colors.black
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: fontSize20,
                                                  fontFamily: AppConfig.fontValue,
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        sizeBox15,
                                        CoverLoading(
                                          showLoading: viewModel.isLoading,
                                          child: HtmlWidget(
                                            "<span align='justify'>${viewModel.detailChapter?.content?.replaceStyleFromHtml() ?? ''}",
                                            textStyle: TextStyle(
                                                fontSize:
                                                    AppConfig.fontSizeValue,
                                                color: AppConfig.colorBgValue ==
                                                        Colors.black
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    AppConfig.lineHeightValue,
                                                fontFamily:
                                                    AppConfig.fontValue),
                                          ),
                                        ),
                                        sizeBox20,
                                        // Text(viewModel.detailChapter?.content ??'',style: const TextStyle(fontSize: fontSize14),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                child: child, opacity: animation);
                          },
                          switchInCurve: Curves.bounceOut,
                          switchOutCurve: Curves.bounceOut,
                          child: viewModel.showButton
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  key: UniqueKey(),
                                  decoration: const BoxDecoration(
                                      color: colorWhite,
                                      border: Border(
                                          top: BorderSide(color: colorGrey))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (viewModel.canBackChapter)
                                              viewModel.backChapter(context);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_sharp,
                                            size: 35,
                                            color: viewModel.canBackChapter
                                                ? blueColor
                                                : colorGrey,
                                          )),
                                      InkWell(
                                          onTap: () {
                                            if (AppProvider.instance.token !=
                                                null) {
                                              if (viewModel.canNextChapter) {
                                                viewModel.nextChapter(context);
                                              }
                                            } else {
                                              if (viewModel.count > 8 ||
                                                  viewModel.page != 0) {
                                                AppProvider.instance
                                                    .showDialogLogin(context,
                                                        'Bạn cần đăng nhập để đọc tiếp');
                                              } else {
                                                if (viewModel.canNextChapter) {
                                                  viewModel
                                                      .nextChapter(context);
                                                }
                                              }
                                            }
                                          },
                                          child: Icon(Icons.arrow_forward_sharp,
                                              size: 35,
                                              color: viewModel.canNextChapter
                                                  ? blueColor
                                                  : colorGrey)),
                                      InkWell(
                                        onTap: () {
                                        },
                                        child: Icon(
                                          viewModel.isLikeChapter
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 35,
                                          color: blueColor,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            if (AppProvider.instance.token ==
                                                null) {
                                              AppProvider.instance.showDialogLogin(
                                                  context,
                                                  'Bạn cần đăng nhập để sử dụng tính năng này');
                                            } else {
                                              print(
                                                  '>>> idChapter: ${viewModel.modelReadStory.idChapter}');
                                            }
                                          },
                                          icon: SvgPicture.asset(
                                            "assets/ic_comment_story.svg",
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showSettingSheet();
                                          },
                                          icon: SvgPicture.asset(
                                            "assets/ic_setting.svg",
                                            color: blueColor,
                                          )),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                child: child, opacity: animation);
                          },
                          switchInCurve: Curves.easeInOutBack,
                          child: viewModel.showButton
                              ? Container(
                                  key: UniqueKey(),
                                  height: kToolbarHeight,
                                  width: context.getWidth(),
                                  decoration: const BoxDecoration(
                                    color: colorWhite,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      sizeBox10,
                                      InkWell(
                                          onTap: () {
                                            viewModel.idChapter = '';
                                            viewModel.myTimer!.cancel();
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(
                                              Icons.arrow_back_sharp)),
                                      sizeBox10,
                                      Expanded(
                                        child: Text(
                                          viewModel.nameStory ?? '',
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: fontSize18),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSettingSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        enableDrag: true,
        builder: (contextModel) {
          final viewModel = context.watch<ReadStoryViewModel>();
          return StatefulBuilder(
            builder: (context, setState) => Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                    const Divider(),
                    sizeBox10,
                    const Text(
                      "Độ sáng",
                      style: textNormal,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/min-light.svg",
                          width: 20,
                        ),
                        Expanded(
                          child: Slider(
                            value: AppConfig.brightnessValue,
                            max: 1,
                            min: 0,
                            divisions: 100,
                            label: (AppConfig.brightnessValue * 100)
                                .round()
                                .toString(),
                            onChanged: (double value) {
                              setState(() {
                                viewModel.setBrightnessValue(value);
                              });
                            },
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/max-light.svg",
                          width: 20,
                        ),
                      ],
                    ),
                    sizeBox10,
                    const Text("Size", style: textNormal),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/min-font.svg",
                          width: 20,
                        ),
                        Expanded(
                          child: Slider(
                            value: AppConfig.fontSizeValue,
                            max: 23,
                            min: 12,
                            divisions: 11,
                            label: AppConfig.fontSizeValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                viewModel.setFontSizeValue(value);
                              });
                            },
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/max-font.svg",
                          width: 20,
                        ),
                      ],
                    ),
                    sizeBox10,
                    const Text("Cách dòng", style: textNormal),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/max-spacing.svg",
                          width: 20,
                        ),
                        Expanded(
                          child: Slider(
                            value: AppConfig.lineHeightValue,
                            max: 5,
                            min: 1,
                            divisions: 8,
                            label: AppConfig.lineHeightValue.toString(),
                            onChanged: (double value) {
                              setState(() {
                                viewModel.setLineHeightValue(value);
                              });
                            },
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/max-spacing.svg",
                          width: 20,
                        ),
                      ],
                    ),
                    sizeBox10,
                    const Text("Màu nền", style: textNormal),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(),
                        ...[Colors.white, const Color(0xe4fff8cf), Colors.black]
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    viewModel.setBgColor(e);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppConfig.colorBgValue == e
                                              ? Colors.blue
                                              : e),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      color: e),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            )
                            .toList(),
                        const SizedBox(),
                      ],
                    ),
                    sizeBox10,
                    const Text("Font", style: textNormal),
                    Column(
                      children: [
                        ...[
                          "Roboto",
                          "OpenSans",
                          "Verdana",
                          "TimesNewRoman",
                          "Palatino",
                          "Arial",
                          "Helvetica"
                        ]
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  setState(() {
                                    viewModel.setFontValue(e);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width / 4,
                                      vertical: 5),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppConfig.fontValue == e
                                              ? Colors.blue
                                              : Colors.grey),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100)),
                                      color: AppConfig.fontValue == e
                                          ? Colors.white
                                          : Colors.grey),
                                  child: Text(
                                    e,
                                    style:
                                        TextStyle(fontSize: 13, fontFamily: e),
                                  ),
                                ),
                              ),
                            )
                            .toList()
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
