{
  lib,
  fetchurl,
  appimageTools,
}:

let
  pname = "wechat-linux";
  version = "4.1.0";

  src = fetchurl {
    url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;

    postExtract = ''
      patchelf --replace-needed libtiff.so.5 libtiff.so $out/opt/wechat/wechat
    '';
  };

in
appimageTools.wrapType2 {
  inherit pname version;

  src = appimageContents;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${appimageContents}/wechat.desktop $out/share/applications/
    mkdir -p $out/share/pixmaps
    cp ${appimageContents}/wechat.png $out/share/pixmaps/

    substituteInPlace $out/share/applications/wechat.desktop --replace-fail AppRun wechat
  '';

  meta = with lib; {
    description = "微信电脑版 for Linux - 官方AppImage版本";
    homepage = "https://linux.weixin.qq.com/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
