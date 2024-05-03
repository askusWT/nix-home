{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
  ];

  host = {
    home = {
      applications = {
        android-tools.enable = mkDefault true;
        bleachbit.enable = mkDefault true;
        cliphist.enable = mkDefault true;
        comma.enable = mkDefault true;
        czkawka.enable = mkDefault true;
        drawio = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        eog = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        ferdium.enable = mkDefault true;
        geeqie.enable = mkDefault true;
        gnome-system-monitor.enable = mkDefault true;
        libreoffice.enable = mkDefault true;   
        meld = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        nmap.enable = mkDefault true;
        peazip = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        pinta.enable = mkDefault true;
        seahorse.enable = mkDefault true;
        shellcheck.enable = mkDefault true;
        shfmt.enable = mkDefault true;
        smartgit.enable = mkDefault true;
        thunar.enable = mkDefault true;
        thunderbird.enable = mkDefault true;
        virt-manager.enable = mkDefault true;
        visual-studio-code = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        vlc = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        warp-terminal.enable = mkDefault true;
        xdg-ninja.enable = mkDefault true;
        xmlstarlet.enable = mkDefault true;
        yq.enable = mkDefault true;
        yt-dlp.enable = mkDefault true;
        zathura = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        zenity.enable = mkDefault true;
        service = {
      };
    };
  };
}