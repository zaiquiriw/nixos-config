{
  # Starship Prompt
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship.enable = true;

  programs.starship.settings = {
    # See docs here: https://starship.rs/config/
    # Symbols config configured ./starship-symbols.nix.

    directory.fish_style_pwd_dir_length = 1; # turn on fish directory truncation
    directory.truncation_length = 2; # number of directories not to truncate
    gcloud.disabled = true; # annoying to always have on
    hostname.style = "bold green"; # don't like the default
    memory_usage.disabled = true; # because it includes cached memory...
    shlvl.disabled = false;
    format = "([](#)$os$username[](bg:orange fg:white)$directory[](fg:white bg:yellow)$git_branch$git_status[](fg:white bg:blue)$c$elixir$elm$golang$gradle$haskell$java$julia$nodejs$nim$rust$scala[](fg:white bg:blue)$docker_context[](fg:#06969A bg:#33658A)$time[ ](fg:#33658A))";

  username = {
    show_always = true;
    style_user = "bg:#9A348E";
    style_root = "bg:#9A348E";
    format = "([$user ]($style))";
    disabled = false;
  };

  };
}
