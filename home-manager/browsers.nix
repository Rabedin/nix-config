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
    # mullvad-browser
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
          updateUrl = "https://raw.githubusercontent.com/NeverDecaf/chromium-web-store/master/updates.xml";
        }
        {
          # uBlock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          # updateUrl = "";
        }
        {
          # Proton pass
          id = "ghmbeldphafepmbegfdlkpapadhbakde";
          # updateUrl = "";
        }
        {
          # Proton VPN
          id = "jplgfhpmjnbigmhklmmbgecoobifkmpa";
          # updateUrl = "";
        }
        {
          # Catppuccin Mocha theme
          id = "bkkmolkhemgaeaeggcmfbghljjjoofoh";
          version = "4.1";
        }
      ];
    };
  };

}
