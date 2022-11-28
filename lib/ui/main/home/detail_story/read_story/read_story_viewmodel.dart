import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/detail_chapter.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/model/info_chapter.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../../../../shared/dialog.dart';
import '../../../../../ultils/global_bloc.dart';

class ReadStoryViewModel extends BaseViewModel{
  StoryRepository storyRepository;
  Chapter? detailChapter;
  ModelReadStory modelReadStory;
  String? idChapter;
  String? idBook;
  String? nameStory;
  String? imageHeader;


  bool canNextChapter = true;
  bool canBackChapter = true;

  ScrollController controller = ScrollController();
  bool showButton = false;
  bool isLikeChapter = false;


  int count = 0;
  int page = 0;

  InfoChapter? infoChapter;

  Timer? myTimer;


  ReadStoryViewModel({required this.storyRepository,required this.modelReadStory}) : super(storyRepository) {
    nameStory=modelReadStory.story?.name ?? '';
    imageHeader=modelReadStory.story?.thumbnail ?? '';
    idBook=modelReadStory.story?.id ?? '';
    idChapter = modelReadStory.idChapter ?? '';
    count = modelReadStory.index ?? 0;
    page = modelReadStory.page ?? 0;
    showEvent();
    getInfoChapter();
    readChapter();
    checkLikeChapter();
    scollListener();
    // lấy độ sáng hiện tại
    currentBrightness.then((value) {
      AppConfig.brightnessValue = value;
      ScreenBrightness().setScreenBrightness(value);
    });

  }

  showEvent() {
    showButton = !showButton;
    // Future.delayed(const Duration(seconds: 5),(){
    //   showButton = false;
    //   notifyListeners();
    // });
    notifyListeners();
  }

  Future<double> get currentBrightness async {
    try {
      return await ScreenBrightness().current;
    } catch (e) {
      throw 'Failed to get current brightness';
    }
  }


  seenChapter(String id)async{
       storyRepository.seenChapter(infoChapter!.bookId!, id);
  }



  nextChapter(BuildContext context){
    count++;
    myTimer?.cancel();
    idChapter = infoChapter?.nextChapterId ?? '';
    getInfoChapterNeedContext(context);
    controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    checkCanMoveChapter();
    readChapter();
    checkLikeChapter();
    notifyListeners();
  }

  backChapter(BuildContext context){
    count--;
    myTimer?.cancel();
    idChapter = infoChapter?.previousChapterId ?? '';
    getInfoChapterNeedContext(context);
    controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    checkCanMoveChapter();
    readChapter();
    checkLikeChapter();
    notifyListeners();
  }

  getDetailChapter(BuildContext context) async {
    setLoading = true;
    final res = await storyRepository.getDetailChapter(idChapter!);
    if(res.code==200 && res.data != null){
      detailChapter = res.data as  Chapter;
    }else{
      String idChapterNeedBuy = idChapter!;
      backChapter(context);// 6251902d265df0468bcfb9bf
      print("idChapterNeedbuy $idChapterNeedBuy}"); // 6252e1c9265df0468bcfba92

      InfoChapter e = (await storyRepository.getInfoChapter(idBook!, idChapterNeedBuy)).data as InfoChapter;
      if(AppProvider.instance.token == null){
        if(e.price !=0){
          AppProvider.instance.showDialogLogin(
              context,
              'Bạn cần đăng nhập để mua chương tiếp theo');
        }
      }else{
        print("áodkaoskdokasd");
          Future.delayed(Duration.zero)
              .then((_) => showDialog(
            context: context,
            builder: (context) =>
                DialogConfirmQuestion(
                  coin: e.price.toString(),
                  mess:
                  'Bạn có chắc chắn muốn mua chương tiếp theo?',
                  action: ()  {

                    Navigator.pop(context);
                  },
                ),
          ));
      }
 
    // EasyLoading.showError('Bạn cần mua chapter tiếp theo',dismissOnTap: true);
    }
    notifyListeners();
    setLoading = false;
  }

  readChapter() async {
     myTimer?.cancel();
    myTimer = Timer.periodic(const Duration(seconds: 1), (timer) async{
      print(">>>>>>>>>>>>>>>>${timer.tick}");
      if(timer.tick == 150) {
       await storyRepository.getDetailChapterView(idChapter ?? '');
       myTimer!.cancel();
      }
    });
  }

  getInfoChapterNeedContext(BuildContext context) async {
    final res = await storyRepository.getInfoChapter(idBook!,idChapter!);
    if(res.code==200 && res.data != null){
      infoChapter = res.data as  InfoChapter;
      getDetailChapter(context);
      checkCanMoveChapter();
      seenChapter(idChapter?? '');
    }
    notifyListeners();
  }

  getInfoChapter() async {
    final res = await storyRepository.getInfoChapter(idBook!,idChapter!);
    if(res.code==200 && res.data != null){
      infoChapter = res.data as  InfoChapter;
      final res2 = await storyRepository.getDetailChapter(idChapter!);
      if(res2.code==200 && res2.data != null){
        detailChapter = res2.data as  Chapter;
        print(">>>>>>>>>>>>>>>>>>> ${detailChapter?.content}");
      }
      checkCanMoveChapter();
      seenChapter(idChapter?? '');
    }
    notifyListeners();
  }


  likeChapter() async {
    final res = await storyRepository.likeChapter(idChapter!);
    if(res.code==200){
      checkLikeChapter();
    }
  }

    checkLikeChapter() async{
      final res = await storyRepository.checkIsLikedBool(idChapter!);
      if(res.code==200){
        isLikeChapter = res.dataBool ?? false;
        notifyListeners();
      }
    }


  checkCanMoveChapter(){
    if(infoChapter!.nextChapterId == null){
      canNextChapter=false;
    }else{
      canNextChapter = true;
    }

    if(infoChapter!.previousChapterId == null){
      canBackChapter = false;
    }else{
      canBackChapter=true;
    }
    notifyListeners();
  }


  void scollListener(){
    showButton=true;
    controller = ScrollController();
    controller.addListener(() {
      if(controller.position.userScrollDirection == ScrollDirection.forward){
        showButton=false;
      }else if(controller.position.userScrollDirection == ScrollDirection.reverse){
        showButton=false;
      }
      notifyListeners();
    });

  }

  void setBrightnessValue(double value) async{
    AppConfig.brightnessValue = value;
    await ScreenBrightness().setScreenBrightness(AppConfig.brightnessValue);
    notifyListeners();
  }

  void setFontSizeValue(double value) async{
    AppConfig.fontSizeValue = value;
    notifyListeners();
  }

  void setLineHeightValue(double value) {
    AppConfig.lineHeightValue = value;
    notifyListeners();
  }

  void setBgColor(Color e) {
    AppConfig.colorBgValue = e;
    notifyListeners();
  }

  void setFontValue(String e) {
    AppConfig.fontValue = e;
    notifyListeners();
  }

}






class ModelReadStory{
  Story? story;
  List<Chapter>? listChapter;
  String? nameChapter;
  String? idChapter;
  int? index;
  int? page;

  ModelReadStory({
    this.story,
    this.idChapter,
    this.nameChapter,
    this.listChapter,
    this.page,
    this.index
  });
}