class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get icLogo => 'logo'.png;
  static String get imgPlaceholder => 'placeholder'.png;
  static String get imgEmptyProfile => 'user_profile'.png;

  static String get imgModule1 => 'Illustrator_Module_1'.png;
  static String get imgModule2 => 'Illustrator_Module_2'.png;
  static String get imgModule3 => 'Illustrator_Module_3'.png;
  static String get imgModule4 => 'Illustrator_Module_4'.png;
  static String get icBook => 'book'.svg;
  static String get icSocialLearning => 'social_learning'.svg;
  static String get icLockOpenRight => 'lock_open_right'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/icons/$this.svg';
}
