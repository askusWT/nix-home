{lib, ...}:

with lib;
{
  imports = [
    ./diffuse.nix
    ./eog.nix
    ./file-roller.nix
    ./libreoffice.nix
    ./pinta.nix
    ./smartgit.nix
    ./thunderbird.nix
    ./vivaldi.nix
    ./wpsoffice.nix
    ./zoom.nix
  ];
}
