{ lib, stdenv, fetchFromGitLab
, libdrm, json_c, pciutils
, meson, ninja, pkg-config, cmake, scdoc
}:

stdenv.mkDerivation rec {
  pname = "drm_info";
  version = "2.5.0";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "emersion";
    repo = "drm_info";
    rev = "v${version}";
    sha256 = "sha256-gNuBN4m7xdK7oGy1VD8zOGVPZFUaQDKSlLHI6yC6zp4=";
  };

  nativeBuildInputs = [ meson ninja pkg-config scdoc cmake ];
  buildInputs = [ libdrm json_c pciutils ];

  meta = with lib; {
    description = "Small utility to dump info about DRM devices";
    homepage = "https://gitlab.freedesktop.org/emersion/drm_info";
    license = licenses.mit;
    maintainers = with maintainers; [ tadeokondrak ];
    platforms = platforms.linux;
  };
}
