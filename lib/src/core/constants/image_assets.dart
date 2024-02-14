class ImageAssets {
  const ImageAssets._();

  //:::::::::::::::::: IMAGE SETS ::::::::::::::::::
  static String get icLogo => 'logo'.png;
  static String get imgPlaceholder => 'placeholder'.png;
  static String get imgEmptyProfile => 'user_profile'.png;
  static String get imageHome => 'home'.png;
  static String get imgModule1 => 'Illustrator_Module_1'.png;
  static String get imgModule2 => 'Illustrator_Module_2'.png;
  static String get imgModule3 => 'Illustrator_Module_3'.png;
  static String get imgModule4 => 'Illustrator_Module_4'.png;
  static String get imgModule5 => 'illustration_module_drawer_2'.png;
  static String get imgModule6 => 'illustration_module_drawer_3'.png;
  static String get report => 'Report'.png;

  static String get imgIllustration => 'illustration'.svg;

  static String get icBook => 'book'.svg;
  static String get icSocialLearning => 'social_learning'.svg;
  static String get icLockOpenRight => 'lock_open_right'.svg;
  static String get icEdit => 'edit'.svg;
  static String get icDelete => 'delete'.svg;
  static String get icTag => 'tag'.svg;
  static String get icAddNotes => 'add_notes'.svg;
  static String get icApproval => 'approval_delegation'.svg;
  static String get icProgress => 'progress'.svg;

  static String get animEmpty => 'Animation - 1706009676891'.json;
  static String get filterAnim => 'filter'.json;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get svg => 'assets/images/icons/$this.svg';
  String get json => 'assets/$this.json';
}
