{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "source-serif-4";
  version = "0.1";
  src = /home/seabert/.local/share/fonts/source-serif-4;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Source Serif 4";
    homepage = "google fots lol";
    platforms = platforms.all;
  };
}
