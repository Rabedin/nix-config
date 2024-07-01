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
      extensions = {

      };
    };
  };

}
