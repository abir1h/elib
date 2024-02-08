import 'package:flutter/material.dart';

import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
import '../widgets/notification_card.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/constants/common_imports.dart';

class NotificationScreen extends StatelessWidget with AppTheme, Language {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: label(e: en.notification, b: bn.notification),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              NotificationCard(
                leading: Icon(
                  Icons.play_circle_outline,
                  color: clr.appSecondaryColorFlagRed,
                  size: size.r24,
                ),
                title: label(
                    e: "Video content of 'Learning Area 1: Education' of Education Policy and Management in Education will start at 9.30 am",
                    b: "শিক্ষা নীতি ও শিক্ষায় ব্যাবস্থাপনা এর “শিখন ক্ষেত্র ১: শিক্ষা” এর ভিডিও কনটেন্ট  সকাল ৯.৩০ ঘটিকায় শুরু হবে"),
                time: label(e: "1 hour ago", b: "১ ঘণ্টা পূর্বে"),
              ),
              NotificationCard(
                leading: Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.r24,
                ),
                title: label(
                    e: "Username replied to your comment on the “Video 1: Course Introduction” page",
                    b: "ব্যবহারকারীর নাম আপনার কমেন্টের রিপ্লাই দিয়েছে “ভিডিও ১: কোর্স পরিচিতি” পেজ এ"),
                time: label(e: "2 hours ago", b: "২ ঘণ্টা পূর্বে"),
                seen: true,
              ),
              NotificationCard(
                leading: Icon(
                  Icons.auto_stories,
                  color: clr.appSecondaryColorPurple,
                  size: size.r24,
                ),
                title: label(
                    e: "Learning Area 1: Reading of Education: “Name of Reading Material” is ready for you.",
                    b: "শিখন ক্ষেত্র ১: শিক্ষা এর রিডিং: “পড়ার উপাদানের নাম” আপনার জন্য প্রস্তুত  রয়েছে।"),
                time: label(e: "1 day ago", b: "১ দিন পূর্বে"),
              ),
              NotificationCard(
                leading: Icon(
                  Icons.assignment_add,
                  color: clr.appSecondaryColorPurple,
                  size: size.r24,
                ),
                title: label(
                    e: "Learning Area 1: Assessment of Education: The “Evaluation Title” is ready for you.",
                    b: "শিখন ক্ষেত্র ১: শিক্ষা এর মূল্যায়ন : “মূল্যায়নের শিরোনাম” আপনার জন্য প্রস্তুত  রয়েছে।"),
                time: label(e: "1 day ago", b: "১ দিন পূর্বে"),
              ),
              NotificationCard(
                leading: Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.r24,
                ),
                title: label(
                    e: "Username replied to your comment on Video 1: Course Introduction page",
                    b: "ব্যবহারকারীর নাম আপনার  কমেন্টের রিপ্লাই দিয়েছে ভিডিও ১: কোর্স পরিচিতি পেজ এ"),
                time: label(e: "2 days ago", b: "২ দিন পূর্বে"),
              ),
              NotificationCard(
                leading: Image.asset(
                  ImageAssets.imgEmptyProfile,
                  height: size.r24,
                ),
                title: label(
                    e: "Username replied to your comment on Video 1: Course Introduction page",
                    b: "ব্যবহারকারীর নাম আপনার  কমেন্টের রিপ্লাই দিয়েছে ভিডিও ১: কোর্স পরিচিতি পেজ এ"),
                time: label(e: "2 days ago", b: "২ দিন পূর্বে"),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.h20, bottom: size.h20),
                child: Center(
                  child: Text(
                    label(e: "See more", b: "আরো দেখুন"),
                    style: TextStyle(
                        fontSize: size.textSmall,
                        fontFamily: StringData.fontFamilyPoppins,
                        fontWeight: FontWeight.w600,
                        color: clr.appSecondaryColorPurple),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
