mixin Language {
  LanguageEn get en => LanguageEn.instance;
  LanguageBn get bn => LanguageBn.instance;
}

class LanguageEn {
  LanguageEn._();
  static LanguageEn? _instance;
  static LanguageEn get instance => _instance ?? (_instance = LanguageEn._());

  String appNameText = "CLMS";
  String appBarText = "E-Library";
  String splashScreenText = "Welcome To E-Library";

  String authScreenHeaderText = "About HSEP";
  String authScreenContentText =
      "CLMS is a self-contained large-scale learning management system. It includes LMS, e-library, e-teacher side, social learning platform or PLC and formative assessment the entire system is designed in such a way that it can play an effective role in improving the professional quality of teachers.";
  String authScreenContentText2 =
      "This system is designed only to improve the professional quality of teachers, apart from teachers it will also play an effective role in providing training to head teachers and assistant head teachers.";
  String authScreenContentText3 =
      "The main objective of the system is to improve the quality of secondary and higher secondary education in Bangladesh through the professional development of teachers.";
  String authScreenLoginText = "Login with your e-MIS ID password";
  String loginText = "Login";
  String logoutText = "Logout";
  String copyRightText = "Copyright © 2023 ";
  String copyRightText2 = "CLMS";
  String copyRightText3 = "All rights reserved";
  String copyRightText4 = "Privacy Policy";
  String copyRightText5 = "Conditions";

  String homeText = "Home";
  String homeHeaderText = "Enriching life with knowledge of the world";
  String categoriesText = "Categories";
  String bookmarkText = "Bookmark";
  String profileText = "Profile";

  String cancelText = "Cancel";
  String exitText = "Logout";
  String logoutWarningText = "Do you want to log out?";
  String noFileFoundText = "File not Found";
  String backToHomeText = "Return to Home";
  String noInternetText = "No Internet Connection";
  String noInternetContentText = "Try Again to Regain Connection";
  String noInternetStepText = "Check Your Internet Connection";
  String pageReloadText = "Reload The Page";
  String searchText = "Search..";
  String popularBookText = "Popular Books";
  String seeAllText = "See All";

  String learningManagementSystem = "Learning Management System (LMS)";
  String teachersGuide = "Teachers Guide";
  String eLibrary = "E-Library";
  String formativeAssessment = "Formative Assessment System";
  String socialLearningPlatform = "Social Learning Platform";

  String aboutUs = "About Us";
  String lms = "Learning Management System";
  String tutorial = "Tutorial";
  String messageText = "Message";
  String bookRequestText = "Book Request List";
  String notesText = "Notes";

  String profileAppBarText = "My Profile";
  String userNameText = "Mynul Islam"; //"User Name";
  String phoneNumberText = "+0123456789"; //"Phone Number";
  String emailText = "mynulislam@gmail.com"; //"Email";
  String regNoText = "2016810150"; //"Reg.No";
  String currentOrganizationNameText =
      "Dhaka College"; //"Name of the working organization";
  String positionNameText = "Professor";

  String ongoingModule = "Ongoing Module";
  String completed = "Completed";
  String ongoingCurriculum = "Ongoing Curriculum";
  String completedCurriculum = "Completed curriculum";
  String discussionArea = "Discussion area";
  String upcomingCurriculum = "Upcoming Curriculum";
  String notification = "Notification";
  String effectivePeriod = "Effective Period";
  String noticeBoard = "Notice Board";

  String courseText = "Course";
  String courseDetailsText = "Course Details";
  String curriculumDescription = "Curriculum Description";
  String curriculumContent = "Curriculum Content";
  String check = "Check";
  String see = "See";
  String join = "Join";
  String details = "Details";

  String takeNotes = "Take Notes";
  String transcript = "Transcript";
  String next = "Next";
  String seeMore = " See More";
  String seeLess = " See Less";

  String liveClass = "Live Class";
  String joinClass = "Join The Class";

  String allNotes = "All Notes";
  String noteContent =
      "জীবের মধ্যে সবচেয়ে সম্পূর্ণতা মানুষের। কিন্তু সবচেয়ে অসম্পূর্ণ হয়ে সে জন্মগ্রহণ করে। বাঘ ভালুক তার জীবনযাত্রার পনেরো- আনা মূলধন নিয়ে আসে প্রকৃতির মালখানা থেকে। জীবরঙ্গভূমিতে মানুষ এসে দেখা দেয় দুই শূন্য হাতে মুঠো বেঁধে মানুষ আসবার পূর্বেই জীবসৃষ্টিযজ্ঞে প্রকৃতির ভূরিব্যয়ের পালা শেষ হয়ে এসেছে। বিপুল মাংস, কঠিন বর্ম, প্রকাণ্ড লেজ নিয়ে জলে স্থলে পৃথুল দেহের যে অমিতাচার প্রবল হয়ে উঠেছিল তাতে ধরিত্রীকে দিলে ক্লান্ত করে। প্রমাণ হল আতিশয্যের পরাভব অনিবার্য। পরীক্ষায় এটাও স্থির হয়ে গেল যে, প্রশ্রয়ের পরিমাণ যত বেশি হয় দুর্বলতার বোঝাও তত দুর্বহ হয়ে ওঠে। নূতন পর্বে প্রকৃতি যথাসম্ভব মানুষের বরাদ্দ কম করে দিয়ে নিজে রইল নেপথ্যে।        মানুষকে দেখতে হল খুব ছোটো, কিন্তু সেটা একটা কৌশল মাত্র। এবারকার জীবযাত্রার পালায় বিপুলতাকে করা হল বহুলতায় পরিণত। মহাকায় জন্তু ছিল প্রকাণ্ড একলা, মানুষ হল দূরপ্রসারিত অনেক।";

  String discussion = "Discussion";
  String allDiscussion = "View All Discussions";
  String newDiscussion = "New Discussion";
  String detailedDiscussion = "Detailed Discussion";
  String yourOpinion = "Your Opinion";
  String discussionTitle = "Discussion Title";
  String writeHere = "Write here";
  String publishTheDiscussion = "Publish The Discussion";
  String writeYourOpinion = "Write Your Opinion";
}

class LanguageBn {
  LanguageBn._();
  static LanguageBn? _instance;
  static LanguageBn get instance => _instance ?? (_instance = LanguageBn._());

  String appNameText = "সিএলএমএস";
  String appBarText = "ই-লাইব্রেরি";
  String splashScreenText = "ই-লাইব্রেরিতে স্বাগতম";

  String authScreenHeaderText = "HSEP সম্পর্কে";
  String authScreenContentText =
      "সিএলএমএস একটি স্বয়ংসম্পূর্ণ বৃহৎ আকারের লার্নিং ম্যানেজমেন্ট সিস্টেম। এতে রয়েছে এলএমএস, ই লাইব্রেরী, ই টিচার সাইড, সোশ্যাল লার্নিং প্ল্যাটফর্ম অথবা পিএলসি এবং ফরমেটিভ অ্যাসেসমেন্ট পুরো সিস্টেমটিকে এমনভাবে তৈরি করা হয়েছে যেন এটি শিক্ষকদের পেশাগত মান উন্নয়নের ক্ষেত্রে কার্যকর ভূমিকা রাখতে পারে ।";
  String authScreenContentText2 =
      "এই সিস্টেমটি শুধুমাত্র শিক্ষকদের পেশাগত মান উন্নয়নকে লক্ষ্য করেই তৈরি করা হয়েছে, শিক্ষকদের পাশাপাশি এটি প্রধান শিক্ষক এবং সহকারী প্রধান শিক্ষকদেরকেও ট্রেনিং প্রদানে কার্যকর ভূমিকা পালন করবে ।";
  String authScreenContentText3 =
      "সিস্টেমটির মূল উদ্দেশ্য হলো শিক্ষকদের পেশাগত মানোন্নয়নের মাধ্যমে বাংলাদেশের মাধ্যমিক ও উচ্চমাধ্যমিক শিক্ষার মান উন্নয়ন ।";
  String authScreenLoginText = "আপনার ই-এমআইএস আইডি পাসওয়ার্ড দিয়ে লগইন করুন";
  String loginText = "প্রবেশ করুন";
  String logoutText = "প্রস্থান";
  String copyRightText = "কপিরাইট © ২০২৩ ";
  String copyRightText2 = "সিএলএমএস";
  String copyRightText3 = "সমস্ত অধিকার সংরক্ষিত";
  String copyRightText4 = "গোপনীয়তা নীতি";
  String copyRightText5 = "শর্তাবলী";

  String homeText = "হোম";
  String homeHeaderText = "বিশ্বের জ্ঞান দিয়ে জীবনকে সমৃদ্ধ করা";
  String categoriesText = "ক্যাটাগরি";
  String bookmarkText = "বুকমার্ক";
  String profileText = "প্রোফাইল";

  String cancelText = "বাতিল করুন";
  String exitText = "প্রস্থান করুন";
  String logoutWarningText = "আপনি কি লগ আউট করতে চান?";
  String noFileFoundText = "ফাইল পাওয়া যায়নি";
  String backToHomeText = "হোমে ফিরে যান";
  String noInternetText = "ইন্টারনেট সংযোগ নেই";
  String noInternetContentText = "সংযোগ ফিরে পেতে আবার চেষ্টা করুন";
  String noInternetStepText = "আপনার ইন্টারনেট সংযোগ চেক করুন";
  String pageReloadText = "পেজটি রিলোড দিন";
  String searchText = "অনুসন্ধান করুন..";
  String popularBookText = "জনপ্রিয় বই";
  String seeAllText = "সবগুলো দেখুন";

  String learningManagementSystem = "লার্নিং ম্যানেজমেন্ট সিস্টেম (এলএমএস)";
  String teachersGuide = "টিচার্স গাইড";
  String eLibrary = "ই-লাইব্রেরি";
  String formativeAssessment = "ফরম্যাটিভ এসেসমেন্ট সিস্টেম";
  String socialLearningPlatform = "সোস্যাল লার্নিং প্লাটফর্ম";

  String aboutUs = "আমাদের সম্পর্কে";
  String lms = "লার্নিং ম্যানেজমেন্ট সিস্টেম";
  String tutorial = "টিউটোরিয়াল";
  String messageText = "বার্তা";
  String bookRequestText = "বইয়ের অনুরোধের তালিকা";
  String notesText = "নোটস";

  String profileAppBarText = "আমার প্রোফাইল";
  String userNameText = "মাইনুল ইসলাম"; //"ব্যবহারকারীর নাম";
  String phoneNumberText = "+০১২৩৪৫৬৭৮৯০"; //"ফোন নম্বর";
  String emailText = "mynulislam@gmail.com"; //"ইমেইল";
  String regNoText = "২০১৬৮১০১৫০"; //"রেজিঃ নং";
  String currentOrganizationNameText = "ঢাকা কলেজ"; //"কর্মরত প্রতিষ্ঠানের নাম";
  String positionNameText = "অধ্যাপক"; //"আপনার পদবী";

  String ongoingModule = "চলমান মডিউল";
  String completed = "সম্পন্ন";
  String ongoingCurriculum = "চলমান পাঠ্যক্রম";
  String completedCurriculum = "সম্পন্ন পাঠ্যক্রম";
  String discussionArea = "আলোচনা ক্ষেত্র";
  String upcomingCurriculum = "আসন্ন পাঠ্যক্রম";
  String notification = "বিজ্ঞপ্তি";
  String effectivePeriod = "কার্যকম সময়কাল";
  String noticeBoard = "নোটিশবোর্ড";

  String courseText = "কোর্স";
  String courseDetailsText = "কোর্সের বিস্তারিত";
  String curriculumDescription = "পাঠ্যসূচীর বর্ণনা";
  String curriculumContent = "পাঠ্যক্রমের বিষয়বস্তু";
  String check = "চেক করুন";
  String see = "দেখুন";
  String join = "জয়েন করুন";
  String details = "বিস্তারিত";

  String takeNotes = "নোট নিন";
  String transcript = "প্রতিলিপি";
  String next = "পরবর্তী";
  String seeMore = " আরো দেখুন";
  String seeLess = " সংক্ষিপ্ত করুন";

  String liveClass = "লাইভ ক্লাস";
  String joinClass = "ক্লাসে জয়েন করুন";

  String allNotes = "অল নোটস";
  String noteContent = "";

  String discussion = "আলোচনা";
  String allDiscussion = "সকল আলোচনা দেখুন";
  String newDiscussion = "নতুন আলোচনা";
  String detailedDiscussion = "বিস্তারিত আলোচনা";
  String yourOpinion = "আপনার মতামত";
  String discussionTitle = "আলোচনার শিরোনাম";
  String writeHere = "এখানে লিখুন";
  String publishTheDiscussion = "আলোচনা প্রকাশ করুন";
  String writeYourOpinion = "আপনার মতামত লিখুন";
}
