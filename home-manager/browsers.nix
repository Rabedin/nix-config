{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Browsers without HM options
  home.packages = with pkgs; [
    mullvad-browser
  ];

  # Browsers with HM options
  programs = {
  # Librewolf
    librewolf = {
      enable = true;
      package = pkgs.librewolf-wayland;
      settings = {
        # TODO add specific settings here
      };
    };
    # Chromium
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [
        "--extension-mime-request-handling=always-prompt-for-install"
      ];
      extensions = [
        {
          # Chromium web store
          id = "ocaahdebbfolfmndjeplogmgcagdmblk";
          updateURL = "https://raw.githubusercontent.com/NeverDecaf/chromium-web-store/master/updates.xml";
        }
        {
          # uBlock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          # updateURL = "";
        }
        {
          # Proton pass
          id = "ghmbeldphafepmbegfdlkpapadhbakde";
          # updateURL = "";
        }
        {
          # Proton VPN
          id = "jplgfhpmjnbigmhklmmbgecoobifkmpa";
          # updateURL = "";
        }
      ];
    };
  };

}
