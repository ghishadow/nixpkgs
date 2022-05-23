{ lib, stdenv, fetchFromGitHub, installShellFiles, rustPlatform, pkg-config, openssl, darwin }:

with rustPlatform;

buildRustPackage rec {
  pname = "git-ignore";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "sondr3";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Bfr+4zDi6QqirlqccW1jU95eb4q82ZFG9LtT2mCPYLc=";
  };

  cargoSha256 = "sha256-ehEUI4M2IxqS6QhyqOncwP+w6IGbIlSFNIP/FEVH/JI=";

  nativeBuildInputs = [ pkg-config installShellFiles ];
  buildInputs = [ openssl ]
  ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  outputs = [ "out" "man" ];
  preFixup = ''
    installManPage $releaseDir/build/git-ignore-*/out/git-ignore.1
  '';

  meta = with lib; {
    description = "Quickly and easily fetch .gitignore templates from gitignore.io";
    homepage = "https://github.com/sondr3/git-ignore";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sondr3 ghishadow ];
  };
}
