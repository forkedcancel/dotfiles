{ pkgs, vars, config, ... }: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    # autosuggestion = {
    #   enable = true;
    # };
    #shellAliases = import ../bash/aliases.nix;
    shellAliases = {
      l = "ls -Glah";
      nixswitch = "darwin-rebuild switch --flake ~/.dotfiles#$(hostname -s)";
      #nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
    };
    history = {
      ignoreDups = true;
      share = true;
      save = 100000;
    };

    oh-my-zsh= {
      enable = true;
      plugins = [ "dircycle" "zsh-navigation-tools" "ssh-agent" "z" ];
      /* ugly hack: oh my zsh only wants a relative path, so lets go back to the system root */
      theme = "robbyrussell";
      #theme = "../../../../../../../../../../../${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k";
      extraConfig = ''
        zstyle :omz:plugins:ssh-agent identities id_ed25519
      '';
    };

    sessionVariables = config.home.sessionVariables;

    initExtra = ''
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

      ## END NIX
      ## The previous part of this ZSHRC is generated by nix and configured in ~/.config/nixpkgs/zsh/zsh.nix
      ## The following part of this  ZSHRC is read from ~/.config/nixpkgs/zsh/zshrc

      ${builtins.readFile ./zshrc}
    '';

    profileExtra = ''
      export PATH=$HOME/scripts:$HOME/bin:/opt/local/bin:/usr/local/bin:$PATH

      # set TERMINFO to the terminfos delivered by the ncurses nix package
      if [ ! -f /etc/NIXOS ]; then
        export TERMINFO=$HOME/.nix-profile/share/terminfo
        # source system wide zshrc, for nix configuration if it exists
        # so that the nix profile variables get set (e.g. NIX_REMOTE)
        # (this might be MacOS/"Darwin" specific, or also work the same way other linux distributions)
        [ -f /etc/zshrc ] && source /etc/zshrc
      fi
      
      # Added by Toolbox App
      export PATH="$PATH:/Users/${vars.user}/Library/Application Support/JetBrains/Toolbox/scripts"
      source $HOME/.sde/profile/profile.sh
      
      
      eval "$(/opt/homebrew/bin/brew shellenv)"

    '';
  };
}
