class VersionInfo {
  final String downloadUrl;
  var forceUpdate = false;
  String? updateInfo;
  final String version;

  VersionInfo.fromJson(Map<String, dynamic> json)
      : downloadUrl = json['downloadUrl'],
        forceUpdate = json['forceUpdate'],
        updateInfo = json['updateInfo'],
        version = json['version'];
}