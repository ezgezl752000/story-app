import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/ui/onboarding/onboarding1.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/pref_data.dart';

import '../../shared/button.dart';
import '../../ultils/constants.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  
  int page = 0;
  PageController controller = PageController(initialPage: 0);


  @override
  void initState() {  
    super.initState();
    PreferenceManager.setBool(PreferenceManager.isFirstLogin,false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
              'assets/background.png',
              width: context.getWidth(),
              height: context.getHeight(),
              fit: BoxFit.fill
          ),
          Column(
            children: [
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      page = value;
                    });
                  },
                  children:const [
                     OnboardingScreen1(icon: "assets/logo.png",banner: 'assets/reading_books.png', tittle: "Hàng ngàn truyện tiểu thuyết",
                      description: "Hấp dẫn, đa dạng, phong phú về thể loại, truyện mới được cập nhật mỗi ngày.",),
                     OnboardingScreen1(icon: "assets/logo.png",banner: 'assets/discussion_with_the_customer.png', tittle: "Đam mê và thoả sức sáng tạo",
                      description: "Viết ra những tác phẩm tiểu thuyết, chia sẻ những tâm tư của chính mình.",),
                     OnboardingScreen1(icon: "assets/logo.png",banner: 'assets/girl_needs_a_phone.png', tittle: "Kết bạn và chia sẻ tiếng nói",
                      description: "Tận hưởng trải nghiệm kể chuyện, giao lưu cùng các bạn độc giả.",),
                  ],
                  controller: controller,
                ),
              ),
              SizedBox(
                height: 10,
                width: 42,
                child: ListView.separated(
                  itemCount: 3,
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  primary: true,
                  separatorBuilder: (context, index) => const SizedBox(width: 4,),
                  itemBuilder: (context, index) {
                    return   Container(
                      alignment: Alignment.center,
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: page == index ? const Color(0xff4FABE8) : const Color(0xffA9D6F4),
                          borderRadius: BorderRadius.circular(50)
                      ),
                    );
                  },
                ),
              ),
              sizeBox15,

              NormalButton(
                height: 40,
                width: context.getWidth()-50,
                text: "Tiếp tục",
                action: (){
                  if(page == 2){
                    Navigator.pushNamedAndRemoveUntil(context, PageRoutes.mainPage, (route) => false,arguments: 0);
                  }else{
                    setState(() {
                      page ++;
                      controller.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    });
                  }
                },
              ),
              sizeBox10,
              SizedBox(
                  width: context.getWidth()-50,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, PageRoutes.mainPage, (route) => false,arguments: 0);
                  },
                  child: const Text(
                    "Bỏ qua",
                    style: TextStyle(
                      color: colorBlack,
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    backgroundColor:
                    MaterialStateColor.resolveWith((states) => const Color(0xffE8F4FC)),
                  ),
                ),
              ),
              sizeBox15,
            ],
          ),
        ],
      ),
    );
  }
}

