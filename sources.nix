let
  nivSrc = fetchTarball {
    url = "https://github.com/nmattia/niv/tarball/dd13098d01eaa6be68237e7e38f96782b0480755";
    sha256 = "1cfjdbsn0219fjzam1k7nqzkz8fb1ypab50rhyj026qbklqq2kvq";
  };
in

import "${nivSrc}/nix/sources.nix" {
  sourcesFile = ./sources.json;
}
