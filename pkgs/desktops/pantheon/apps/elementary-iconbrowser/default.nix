{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
  meson,
  ninja,
  pkg-config,
  vala,
  wrapGAppsHook4,
  elementary-gtk-theme,
  elementary-icon-theme,
  glib,
  granite7,
  gtk4,
  gtksourceview5,
}:

stdenv.mkDerivation rec {
  pname = "elementary-iconbrowser";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = "iconbrowser";
    rev = version;
    sha256 = "sha256-T0VCpk3pdq+2gr/UblLu8mRX7TKJrAtyyFk4i+tAVfI=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    wrapGAppsHook4
  ];

  buildInputs = [
    elementary-icon-theme
    glib
    granite7
    gtk4
    gtksourceview5
  ];

  preFixup = ''
    gappsWrapperArgs+=(
      # The GTK theme is hardcoded.
      --prefix XDG_DATA_DIRS : "${elementary-gtk-theme}/share"
      # The icon theme is hardcoded.
      --prefix XDG_DATA_DIRS : "$XDG_ICON_DIRS"
    )
  '';

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    homepage = "https://github.com/elementary/iconbrowser";
    description = "Browse and find system icons";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    teams = [ teams.pantheon ];
    mainProgram = "io.elementary.iconbrowser";
  };
}
