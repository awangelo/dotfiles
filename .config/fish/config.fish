set -g fish_greeting
fish_add_path ~/.local/bin

if status is-interactive
    function fish_prompt --description 'Write out the prompt'
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status
        set -l normal (set_color --reset)

        set -l color_cwd $fish_color_cwd
        set -l suffix 'λ'
        if functions -q fish_is_root_user; and fish_is_root_user
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            end
            set suffix '#'
        end

        # Write pipestatus
        # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
        set -l bold_flag --bold
        set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
        if test $__fish_prompt_status_generation = $status_generation
            set bold_flag
        end
        set __fish_prompt_status_generation $status_generation
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color $bold_flag $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        set -l current_pwd (prompt_pwd --dir-length=0)
        if test (string length -- "$current_pwd") -gt 50
            set current_pwd (prompt_pwd)
        end
        echo -n -s (set_color $color_cwd) $current_pwd $normal (fish_vcs_prompt) $normal " " $prompt_status" " $suffix " "
    end

    abbr -a gs git status
    abbr -a gc git commit -m
    abbr -a gpush git push
    abbr -a gpull git pull
    abbr -a ga git add .
    abbr -a gl git log --stat
    abbr -a glo git log --oneline --decorate --all --graph
    abbr -a gb git branch

    abbr -a s sudo
    abbr -a find fd
    abbr -a mkdir mkdir -p

    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr -a dotdot --regex '^\.\.+$' --function multicd

    function zai
        set -lx ANTHROPIC_BASE_URL "https://api.z.ai/api/anthropic"
        set -lx ANTHROPIC_AUTH_TOKEN "ZAI_API_KEY"
        set -lx ANTHROPIC_DEFAULT_SONNET_MODEL "glm-5.3[1m]"
        set -lx ANTHROPIC_DEFAULT_OPUS_MODEL "glm-5.3[1m]"
        set -lx ANTHROPIC_DEFAULT_HAIKU_MODEL "glm-5.3-flash[1m]"
        set -lx API_TIMEOUT_MS "3000000"
        set -lx CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1
        claude $argv
    end

    set -gx EDITOR "zeditor --wait"
    set -gx RIPGREP_CONFIG_PATH ~/.config/.ripgreprc
end
