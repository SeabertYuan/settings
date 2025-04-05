{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "source-sans-3";
  version = "0.1";
  src = /home/seabert/.local/share/fonts/source-sans-3;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "Source Sans 3";
    homepage = "google fots lol";
    platforms = platforms.all;
  };
}
