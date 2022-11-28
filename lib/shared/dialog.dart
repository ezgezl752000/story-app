import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/shared/circle_view.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/shared/textfield.dart';
import 'package:ns_read_story/ui/main/main_page_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'button.dart';

class DialogConfirm extends StatelessWidget {
  final String mess;
  final Function() action;

  const DialogConfirm({Key? key, required this.mess, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        width: MediaQuery.of(context).size.width / 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/canh_bao.svg"),
            const SizedBox(
              height: 20,
            ),
            Text(
              mess,
              style: const TextStyle(
                fontSize: fontSize15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hotline: 123456",
              style: TextStyle(
                fontSize: fontSize13,
                color: blueColor,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            NormalButton(
              text: 'Đóng',
              width: MediaQuery.of(context).size.width / 2,
              height: 56,
              action: action,
            )
          ],
        ),
      ),
    );
  }
}

class DialogConfirmQuestion extends StatelessWidget {
  final String mess;
  final Function()? action;
  final String? coin;

  const DialogConfirmQuestion(
      {Key? key, required this.mess, required this.action, this.coin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(diaLogRadius))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            if (coin != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/ic_coin.png",
                      width: 30,
                    ),
                    sizeBox5,
                    Text(
                      coin ?? '',
                      style: textBoldBlack.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
            Text(
              mess,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: context.getWidth() / 3,
                  height: heightTextField,
                  child: ElevatedButton(
                    onPressed: action,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => blueColor),
                    ),
                    child: const Text(
                      "Xác nhận",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.getWidth() / 3,
                  height: heightTextField,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: const BorderSide(color: blueColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Hủy",
                      style: TextStyle(
                        color: blueColor,
                        fontSize: fontSize15,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogSuccess extends StatelessWidget {
  final String mess;
  final Function action;

  const DialogSuccess({Key? key, required this.mess, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(diaLogRadius))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/success.svg"),
            const SizedBox(
              height: 20,
            ),
            Text(
              mess,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: heightTextField,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        action();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: blueColor, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Đóng",
                        style: TextStyle(
                          color: blueColor,
                          fontSize: fontSize15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogError extends StatelessWidget {
  final String mess;
  final Function()? action;

  const DialogError({Key? key, required this.mess, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(diaLogRadius))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/canh_bao.svg"),
            const SizedBox(
              height: 20,
            ),
            Text(
              mess,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    height: heightTextField,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: blueColor, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Đóng",
                        style: TextStyle(
                          color: blueColor,
                          fontSize: fontSize15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogLogin extends StatelessWidget {
  final Function() action;
  final String mess;
  const DialogLogin({Key? key, required this.action, required this.mess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sizeBox10,
          Text(
            mess,
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          sizeBox20,
          SizedBox(
            width: context.getWidth() / 1.5,
            height: heightTextField,
            child: ElevatedButton(
              onPressed: () {
                action();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(color: blueColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Đăng nhập",
                style: TextStyle(
                  color: blueColor,
                  fontSize: fontSize15,
                ),
              ),
            ),
          ),
          sizeBox10
        ],
      ),
    );
  }
}

class DialogReport extends StatefulWidget {
  final String mess;
  final Function()? action;

  const DialogReport(
      {Key? key,
      required this.mess,
      required this.action})
      : super(key: key);

  @override
  State<DialogReport> createState() => _DialogReportState();
}

class _DialogReportState extends State<DialogReport> {
  String? selectedValue;
  bool? other;
  TextEditingController textController = TextEditingController();

  List<String> reportStory = [
    'Đạo truyện',
    'Vi phạm bản quyền',
    'Ảnh khỏa thân',
    'Bạo lực',
    'Quấy rối',
    'Tự tử/Tự gây thương tích',
    'Thông tin sai sự thật',
    'Spam',
    'Bán hàng trái phép',
    'Ngôn từ gây thù ghét',
    'Khủng bố',
    'Vấn đề khác'
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(diaLogRadius))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.mess,
              style: textBoldBlack,
              textAlign: TextAlign.center,
            ),
            sizeBox10,
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Vui lòng chọn lý do")),
            sizeBox10,
            CustomDropdownButton2(
              buttonWidth: 300,
              dropdownWidth: 250,
              hint: '',
              dropdownItems: reportStory,
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                  value == 'Vấn đề khác' ? other = true : other = false;
                });
              },
            ),
            sizeBox10,
            if (other ?? false)
              TextFieldCustom(
                hintText: 'Nhập lý do',
                maxLine: 5,
                minLine: 1,
                controller: textController,
              ),
            sizeBox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: context.getWidth() / 3,
                  height: heightTextField,
                  child: ElevatedButton(
                    onPressed: selectedValue == null ||
                            (other == true && textController.text.isEmpty)
                        ? () {
                            EasyLoading.showError('Vui lòng nhập lý do');
                          }
                        : widget.action,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => blueColor),
                    ),
                    child: const Text(
                      "Gửi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.getWidth() / 3,
                  height: heightTextField,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: const BorderSide(color: blueColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Hủy",
                      style: TextStyle(
                        color: blueColor,
                        fontSize: fontSize15,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogCheckVersion extends StatefulWidget {
  const DialogCheckVersion({Key? key}) : super(key: key);

  @override
  State<DialogCheckVersion> createState() => _DialogCheckVersionState();
}

class _DialogCheckVersionState extends State<DialogCheckVersion> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(diaLogRadius),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/bg_attend.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
            border: Border.all(color: blueColor, width: 1),
            borderRadius: BorderRadius.circular(diaLogRadius)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        width: context.getWidth() / 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sizeBox15,
            Text('Đã có phiên bản mới',
                style: textBoldBlue.copyWith(fontSize: 20)),
            sizeBox10,
            const Text('Vui lòng cập nhật lên phiên bản mới nhật để trải nghiệm ứng dụng tốt hơn'),
            sizeBox10,
            NormalButton(
              text: 'Cập nhật',
              width: context.getWidth() / 1.5,
              height: 35,
              colorButton: blueColor,
              action: () async {
                DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                String urlAndroid = 'https://play.google.com/store/apps/details?id=haivuongtruyen.nextsol.vn';
                String urlIOS = 'https://apps.apple.com/vn/app/h%E1%BA%A3i-v%C6%B0%C6%A1ng-truy%E1%BB%87n/id1611886588?l=vi';
                if(Platform.isIOS){
                  if (await canLaunchUrlString(urlIOS)) {
                    await launchUrlString(urlIOS);
                  } else {
                    print('Could not launch $urlIOS');
                  }
                }else{
                  if(androidInfo.model!.contains("huawei")){
                    if (await canLaunchUrlString(urlAndroid)) {
                      await launchUrlString(urlAndroid);
                    } else {
                      print('Could not launch $urlAndroid');
                    }
                  }else{
                    if (await canLaunchUrlString(urlAndroid)) {
                      await launchUrlString(urlAndroid);
                    } else {
                      print('Could not launch $urlAndroid');
                    }
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}