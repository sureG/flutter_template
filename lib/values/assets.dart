class Assets {
  static String name(String name) {
    return 'assets/$name';
  }
}

class AssetsImages {
  static String png(String name) {
    return 'assets/images/$name.png';
  }

  static String iconLoading() => png('loading_icon');

}