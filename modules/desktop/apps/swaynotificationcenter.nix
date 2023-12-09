{config, lib, pkgs, ...}:

let
  cfg = config.host.home.applications.sway-notification-center;
in
  with lib;
{
  options = {
    host.home.applications.sway-notification-center = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Notification Center for Wayland";
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs;
        [
          swaynotificationcenter
        ];
    };

    xdg.configFile."swaync/config.json".text = ''
{
  "$schema": "/etc/xdg/swaync/configSchema.json",
  "positionX": "right",
  "positionY": "top",
  "control-center-margin-top": 2,
  "control-center-margin-bottom": 2,
  "control-center-margin-right": 1,
  "control-center-margin-left": 0,
  "notification-icon-size": 48,
  "notification-body-image-height": 160,
  "notification-body-image-width": 90,
  "timeout": 6,
  "timeout-low": 4,
  "timeout-critical": 0,
  "fit-to-screen": true,
  "control-center-width": 380,
  "notification-window-width": 366,
  "keyboard-shortcuts": true,
  "image-visibility": "when-available",
  "transition-time": 100,
  "hide-on-clear": false,
  "hide-on-action": true,
  "script-fail-notify": true,
  "scripts": {
    "example-script": {
      "exec": "echo 'Do something...'",
      "urgency": "Normal"
    }
  },
  "notification-visibility": {
    "example-name": {
      "state": "muted",
      "urgency": "Low",
      "app-name": "Spotify"
    }
  },
  "widgets": [
    "label",
    "menubar",
    "buttons-grid",
    "volume",
    "mpris",
    "title",
    "dnd",
    "notifications"
  ],
  "widget-config": {
    "title": {
      "text": "Notifications",
      "clear-all-button": true,
      "button-text": "Clear All"
    },
    "dnd": {
      "text": "Do Not Disturb"
    },
    "label": {
      "max-lines": 1,
      "text": "Control Center"
    },
    "mpris": {
      "image-size": 96,
      "image-radius": 6
    },
    "backlight": {
      "label": "",
      "device": "intel_backlight",
      "min": 10
    },
    "backlight#KB": {
      "label": " ",
      "device": "asus::kbd_backlight",
      "subsystem": "leds"
    },
    "volume": {
      "label": ""
    },
    "menubar": {
      "menu#power-buttons": {
        "label": "",
        "position": "right",
        "actions": [
          {
            "label": "   Lock",
            "command": "swaylock -C ~/.config/swaylock/swaylock.conf -S --effect-pixelate 5"
          },
          {
            "label": "   Pause",
            "command": "systemctl suspend"
          },
          {
            "label": "   Logout",
            "command": "loginctl terminate-session ''${XDG_SESSION_ID-}"
          },
          {
            "label": "   Reboot",
            "command": "systemctl reboot"
          },
          {
            "label": "   Shut down",
            "command": "systemctl poweroff"
          }
        ]
      },
      "menu#powermode-buttons": {
        "label": "",
        "position": "right",
        "actions": [
          {
            "label": "Performance",
            "command": "powerprofilesctl set performance"
          },
          {
            "label": "Balanced",
            "command": "powerprofilesctl set balanced"
          },
          {
            "label": "Power-saver",
            "command": "powerprofilesctl set power-saver"
          }
        ]
      },
      "menu#screenshot-buttons": {
        "label": "",
        "position": "left",
        "actions": [
          {
            "label": "   Entire screen",
            "command": "swaync-client -cp && sleep 1 && grim - | wl-copy"
          },
          {
            "label": "   Select a region",
            "command": "swaync-client -cp && sleep 1 && grim -g "$(slurp)" - | wl-copy"
          },
        ]
      },
      "menu#screencast-buttons": {
        "label": "",
        "position": "left",
        "actions": [
          {
            "label": "   Entire screen",
            "command": "swaync-client -cp && sleep 1 && recording.sh toggle fullscreen"
          },
          {
            "label": "   Select a region",
            "command": "swaync-client -cp && sleep 1 && recording.sh toggle region"
          },
          {
            "label": "   Stop",
            "command": "swaync-client -cp && recording.sh stop"
          },
          {
            "label": "   Open screencast folder",
            "command": "$XDG_VIDEOS_DIR/Screencasts"
          }
        ]
      }
    },
    "buttons-grid": {
      "actions": [
        {
          "label": "",
          "command": "nmtui"
        },
        {
          "label": "",
          "command": "blueman"
        },
        {
          "label": "",
          "command": "nwg-look"
        },
        {
          "label": "",
          "command": "thunar ~/"
        },
        {
          "label": "",
          "command": "firefox"
        }
      ]
    }
  }
}
    '';

    xdg.configFile."swaync/style.css".text = ''
      @define-color noti-border-color rgba(255, 255, 255, 0.15);
      @define-color noti-bg rgba(51,51,51,1);
      @define-color noti-bg-hover-alt #454545;
      @define-color noti-bg-alt rgba(43,43,43,0.7);
      @define-color noti-fg white;
      @define-color noti-bg-hover rgba(255, 255, 255, 0.1);
      @define-color noti-bg-focus rgba(255, 255, 255, 0.1);
      @define-color noti-close-bg rgba(255, 255, 255, 0.1);
      @define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
      @define-color noti-urgent rgba(255,0,80,0.8);
      @define-color bg-selected #26A69A;

      *{
        font-family: "Noto Sans NF";
        color: @noti-fg;
      }

      .notification-row {
        outline: none;
      }

      .notification-row:focus,
      .notification-row:hover {
        background: @noti-bg-focus;
      }

      .notification {
        border: 1px solid @bg-selected;
        background: transparent;
        border-radius: 4px;
        margin: 6px 12px;
        box-shadow: none;
        padding: 0;
      }

      /* Uncomment to enable specific urgency colors */
      /* .low {
        background: yellow;
      }
      .normal {
        background: green;
      } */

      .critical {
        border: 1px solid @noti-urgent;
      }


      .notification-content {
        background: transparent;
        padding: 6px;
        border-radius: 4px;
      }

      .close-button {
        background: @noti-close-bg;
        color: white;
        text-shadow: none;
        padding: 0;
        border-radius: 100%;
        margin-top: 10px;
        margin-right: 16px;
        box-shadow: none;
        border: none;
        min-width: 24px;
        min-height: 24px;
      }

      .close-button:hover {
        box-shadow: none;
        background: @noti-close-bg-hover;
        transition: all 0.15s ease-in-out;
        border: none;
      }

      .notification-default-action,
      .notification-action {
        padding: 4px;
        margin: 0;
        box-shadow: none;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        color: white;
      }

      .notification-default-action:hover,
      .notification-action:hover {
        -gtk-icon-effect: none;
        background: @noti-bg-alt;
      }

      .notification-default-action {
        border-radius: 4px;
      }

      /* When alternative actions are visible */
      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
      }

      .notification-action {
        border-radius: 0px;
        border-top: none;
        border-right: none;
      }

      /* add bottom border radius to eliminate clipping */
      .notification-action:first-child {
        border-bottom-left-radius: 4px;
      }

      .notification-action:last-child {
        border-bottom-right-radius: 4px;
        border-right: 1px solid @noti-border-color;
      }

      .image {}

      .body-image {
        margin-top: 6px;
        background-color: white;
        border-radius: 6px;
      }

      .summary {
        font-size: 14px;
        font-weight: bold;
        background: transparent;
        color: white;
        text-shadow: none;
      }

      .time {
        font-size: 13px;
        font-weight: bold;
        background: transparent;
        color: white;
        text-shadow: none;
        margin-right: 18px;
      }

      .body {
        font-size: 12px;
        font-weight: normal;
        background: transparent;
        color: white;
        text-shadow: none;
      }

      /* The "Notifications" and "Do Not Disturb" text widget */
      .top-action-title {
        color: white;
        text-shadow: none;
      }

      .control-center {
        background-color: @noti-bg-alt;
        border-radius: 6px;
        border: 1px solid @bg-selected;
      }

      .control-center-list {
        background: transparent;
      }

      .floating-notifications {
        background: transparent;
      }

      /* Window behind control center and on all other monitors */
      .blank-window {
        background: transparent;
      }

      /*** Widgets ***/

      /* Title widget */
      .widget-title {
        margin: 8px;
        font-size: 16px;
      }

      .widget-title>button {
        font-size: initial;
        color: white;
        text-shadow: none;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        box-shadow: none;
        border-radius: 4px;
      }

      .widget-title>button:hover {
        background: @noti-bg-hover;
      }

      /* DND widget */
      .widget-dnd {
        margin: 8px;
        font-size: 1.1rem;
      }

      .widget-dnd>switch {
        font-size: initial;
        border-radius: 4px;
        background: @noti-bg;
        border: 1px solid @noti-border-color;
        box-shadow: none;
      }

      .widget-dnd>switch:checked {
        background: @bg-selected;
      }

      .widget-dnd>switch slider {
        background: @noti-bg-hover;
        border-radius: 4px;
      }

      /* Label widget */
      .widget-label {
        margin: 4px 8px 8px;
      }

      .widget-label>label {
        font-size: 16px;
      }

      /* Mpris widget */
      .widget-mpris {
        /* The parent to all players */
      }

      .widget-mpris-player {
        padding: 8px;
        margin: 8px;
      }

      .widget-mpris-title {
        font-weight: bold;
        font-size: 1.25rem;
      }

      .widget-mpris-subtitle {
        font-size: 1.1rem;
      }

      /* Volume and Brightness Widget*/

      .widget-volume {
        background-color: @noti-bg;
        padding: 4px 4px 4px 20px;
        margin: 0px 8px 8px 8px;
        border-radius: 4px;
        font-size: 14px;
      }

      .widget-backlight {
        background-color: @noti-bg;
        padding: 8px 8px 4px 8px;
        margin: 8px 8px 0px 8px;
        border-top-left-radius: 12px;
        border-top-right-radius: 12px;
      }

      .KB {
        padding: 4px 8px 4px 8px;
        margin: 0px 8px 0px 8px;
        border-radius: 0;
      }

      .widget-menubar>box{
        padding: 8px 0px 4px;
        margin: 0px 8px;
        border-radius: 4px 4px 0px 0px;
        background-color: @noti-bg;
      }

      .widget-menubar>box>.menu-button-bar>button{
        border: 1px solid @noti-border-color;
        background: @noti-bg;
        border-radius: 4px;
        margin: 4px 12px;
      }

      .widget-buttons-grid{
        padding: 0px 8px 8px;
        margin: 0px 8px 8px;
        border-radius: 0px 0px 4px 4px;
        background-color: @noti-bg;
        font-size: 14px;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button{
        background: @noti-bg;
        border-radius: 4px;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button:hover {
        background: @noti-bg-hover;
      }

      .screenshot-buttons,
      .screencast-buttons,
      .powermode-buttons,
      .power-buttons{
        border-radius: 4px;
      }

      .screenshot-buttons>button,
      .screencast-buttons>button,
      .powermode-buttons>button,
      .power-buttons>button{
        background: transparent;
        padding: 2px 0px;
        margin: 5px 70px 3px;
        border: 1px solid @noti-border-color;
      }

      .screenshot-buttons>button:hover,
      .screencast-buttons>button:hover,
      .powermode-buttons>button:hover,
      .power-buttons>button:hover{
        background: @noti-bg-hover;
      }

    '';
  };
}
