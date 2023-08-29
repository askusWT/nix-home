{lib, ...}:

with lib;
{
  imports = [
    ./act.nix
    ./android-tools.nix
    ./bat.nix
    ./btop.nix
    ./diceware.nix
    ./duf.nix
    ./dust.nix
    ./encfs.nix
    ./fzf.nix
    ./gnupg.nix
    ./hugo.nix
    ./htop.nix
    ./jq.nix
    ./lazygit.nix
    ./less.nix
    ./liquidprompt.nix
    ./lsd.nix
    ./mp3gain.nix
    ./nano.nix
    ./neofetch.nix
    ./neovim.nix
    ./ncdu.nix
    ./nmap.nix
    ./rclone.nix
    ./tmux.nix
    ./wget.nix
    ./yt-dlp.nix
    ./zoxide.nix
  ];
}
