#!/bin/sh

if [ ! -d ~/.config/animdl ]; then mkdir -p ~/.config/animdl; fi
if [ ! -f ~/.config/animdl/config.yml ]; then touch ~/.config/animdl/config.yml; fi
choice=$(printf "provider\nplayer\ndiscord"|fzf --cycle --height 10%)
case $choice in
    provider)
        provider=$(printf "9anime\nallanime\nanimepahe\nanimeout\nanimixplay\ncrunchyroll\nkawaiifu\ngogoanime\nhaho\ntenshi\ntwist\nzoro"|fzf --cycle --height 20%)
        if [ -z "$provider" ]; then echo "no provider selected"; exit 1; fi
        if grep -q "default_provider:" ~/.config/animdl/config.yml; then
            sed -ir "s/default_provider:.*/default_provider: $provider/g" ~/.config/animdl/config.yml
            bat ~/.config/animdl/config.yml|grep default_provider
        else
            printf "default_provider:%s" "$provider" >> ~/.config/animdl/config.yml
            printf "the following line was added to ~/.config/animdl/config.yml:\n"
            bat ~/.config/animdl/config.yml|grep default_provider
        fi
        ;;
    player)
        player=$(printf "mpv\nvlc\niina\ncelluloid\nffplay"|fzf --cycle --height 10%)
        if [ -z "$player" ]; then echo "no player selected"; exit 1; fi
        if grep -q "default_player:" ~/.config/animdl/config.yml; then
            sed -ir "s/default_player:.*/default_player: $player/g" ~/.config/animdl/config.yml
            bat ~/.config/animdl/config.yml|grep default_player
        else
            printf "default_player:%s" "$player" >> ~/.config/animdl/config.yml
            printf "the following line was added to ~/.config/animdl/config.yml:\n"
            bat ~/.config/animdl/config.yml|grep default_player
        fi
        ;;
    discord)
        discord=$(printf "true\nfalse"|fzf --cycle --height 10%)
        if [ -z "$discord" ]; then echo "no discord status selected"; exit 1; fi
        if [ "$discord" = "true" ]; then
            if [ "$(grep -c "discord_presence" ~/.config/animdl/config.yml)" -eq 0 ]; then
                printf "discord_presence: true" >> ~/.config/animdl/config.yml
            else
                sed -ir 's/discord_presence: .*/discord_presence: true/g' ~/.config/animdl/config.yml
                bat ~/.config/animdl/config.yml|grep discord_presence
            fi
        else
            if [ "$(grep -c "discord_presence" ~/.config/animdl/config.yml)" -eq 0 ]; then
                printf "discord_presence: false" >> ~/.config/animdl/config.yml
            else
                sed -ir 's/discord_presence: .*/discord_presence: false/g' ~/.config/animdl/config.yml
                bat ~/.config/animdl/config.yml|grep discord_presence
            fi
        fi
        ;;
esac
