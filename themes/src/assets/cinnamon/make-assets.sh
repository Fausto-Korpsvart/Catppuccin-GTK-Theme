#! /usr/bin/env bash

for theme in '' '-Rosewater' '-Flamingo' '-Pink' '-Red' '-Maroon' '-Mauve' '-Lavender' '-Blue' '-Sapphire' '-Sky' '-Teal' '-Green' '-Yellow' '-Peach' '-Grey'; do
    for type in '' '-Frappe' '-Macchiato'; do
        case "$theme" in
            '')
                theme_color_dark='#27a1b9' # Mocha Default
                theme_color_light='#006a83' # Latte Default
                ;;
            -Rosewater)
                theme_color_dark='#f5e0dc' # Mocha Rosewater
                theme_color_light='#f2d5cf' # Latte Rosewater
                ;;
            -Flamingo)
                theme_color_dark='#f2cdcd' # Mocha Flamingo
                theme_color_light='#f0bfc0' # Latte Flamingo
                ;;
            -Pink)
                theme_color_dark='#ff007c' # Mocha Pink
                theme_color_light='#d20065' # Latte Pink
                ;;
            -Red)
                theme_color_dark='#f7768e' # Mocha Red
                theme_color_light='#f52a65' # Latte Red
                ;;
            -Maroon)
                theme_color_dark='#eba0ac' # Mocha Maroon
                theme_color_light='#d27e88' # Latte Maroon
                ;;
            -Mauve)
                theme_color_dark='#cba6f7' # Mocha Mauve
                theme_color_light='#a084ca' # Latte Mauve
                ;;
            -Lavender)
                theme_color_dark='#b4befe' # Mocha Lavender
                theme_color_light='#7c83d2' # Latte Lavender
                ;;
            -Blue)
                theme_color_dark='#7aa2f7' # Mocha Blue
                theme_color_light='#2e7de9' # Latte Blue
                ;;
            -Sapphire)
                theme_color_dark='#74c7ec' # Mocha Sapphire
                theme_color_light='#4aa5d4' # Latte Sapphire
                ;;
            -Sky)
                theme_color_dark='#89dceb' # Mocha Sky
                theme_color_light='#5db4c0' # Latte Sky
                ;;
            -Teal)
                theme_color_dark='#94e2d5' # Mocha Teal
                theme_color_light='#5fb3a1' # Latte Teal
                ;;
            -Green)
                theme_color_dark='#9ece6a' # Mocha Green
                theme_color_light='#587539' # Latte Green
                ;;
            -Yellow)
                theme_color_dark='#e0af68' # Mocha Yellow
                theme_color_light='#8c6c3e' # Latte Yellow
                ;;
            -Peach)
                theme_color_dark='#fab387' # Mocha Peach
                theme_color_light='#b15c00' # Latte Peach
                ;;
            -Grey)
                theme_color_dark='#1a1b26' # Mocha Grey
                theme_color_light='#c0caf5' # Latte Grey
                ;;
        esac

        if [[ "$type" == '-Frappe' ]]; then
            case "$theme" in
                '')
                    theme_color_dark='#29a4bd' # Frappe Default
                    theme_color_light='#006a83' # Latte Default
                    ;;
                -Rosewater)
                    theme_color_dark='#f2cdcd' # Frappe Rosewater
                    theme_color_light='#eac2c2' # Latte Rosewater
                    ;;
                -Flamingo)
                    theme_color_dark='#eebebe' # Frappe Flamingo
                    theme_color_light='#e3a9a9' # Latte Flamingo
                    ;;
                -Pink)
                    theme_color_dark='#ff007c' # Frappe Pink
                    theme_color_light='#d20065' # Latte Pink
                    ;;
                -Red)
                    theme_color_dark='#f7768e' # Frappe Red
                    theme_color_light='#f52a65' # Latte Red
                    ;;
                -Maroon)
                    theme_color_dark='#ea999c' # Frappe Maroon
                    theme_color_light='#d27e88' # Latte Maroon
                    ;;
                -Mauve)
                    theme_color_dark='#ca9ee6' # Frappe Mauve
                    theme_color_light='#a084ca' # Latte Mauve
                    ;;
                -Lavender)
                    theme_color_dark='#babbf1' # Frappe Lavender
                    theme_color_light='#7c83d2' # Latte Lavender
                    ;;
                -Blue)
                    theme_color_dark='#7aa2f7' # Frappe Blue
                    theme_color_light='#2e7de9' # Latte Blue
                    ;;
                -Sapphire)
                    theme_color_dark='#85c1dc' # Frappe Sapphire
                    theme_color_light='#4aa5d4' # Latte Sapphire
                    ;;
                -Sky)
                    theme_color_dark='#99d1db' # Frappe Sky
                    theme_color_light='#5db4c0' # Latte Sky
                    ;;
                -Teal)
                    theme_color_dark='#81c8be' # Frappe Teal
                    theme_color_light='#5fb3a1' # Latte Teal
                    ;;
                -Green)
                    theme_color_dark='#9ece6a' # Frappe Green
                    theme_color_light='#587539' # Latte Green
                    ;;
                -Yellow)
                    theme_color_dark='#e0af68' # Frappe Yellow
                    theme_color_light='#8c6c3e' # Latte Yellow
                    ;;
                -Peach)
                    theme_color_dark='#ef9f76' # Frappe Peach
                    theme_color_light='#b15c00' # Latte Peach
                    ;;
                -Grey)
                    theme_color_dark='#24283b' # Frappe Grey
                    theme_color_light='#c0caf5' # Latte Grey
                    ;;
            esac
        fi

        if [[ "$type" == '-Macchiato' ]]; then
            case "$theme" in
                '')
                    theme_color_dark='#589ed7' # Macchiato Default
                    theme_color_light='#006a83' # Latte Default
                    ;;
                -Rosewater)
                    theme_color_dark='#f4dbd6' # Macchiato Rosewater
                    theme_color_light='#eac2c2' # Latte Rosewater
                    ;;
                -Flamingo)
                    theme_color_dark='#f0c6c6' # Macchiato Flamingo
                    theme_color_light='#e3a9a9' # Latte Flamingo
                    ;;
                -Pink)
                    theme_color_dark='#fca7ea' # Macchiato Pink
                    theme_color_light='#d20065' # Latte Pink
                    ;;
                -Red)
                    theme_color_dark='#ff757f' # Macchiato Red
                    theme_color_light='#f52a65' # Latte Red
                    ;;
                -Maroon)
                    theme_color_dark='#ee99a0' # Macchiato Maroon
                    theme_color_light='#d27e88' # Latte Maroon
                    ;;
                -Mauve)
                    theme_color_dark='#c6a0f6' # Macchiato Mauve
                    theme_color_light='#a084ca' # Latte Mauve
                    ;;
                -Lavender)
                    theme_color_dark='#b7bdf8' # Macchiato Lavender
                    theme_color_light='#7c83d2' # Latte Lavender
                    ;;
                -Blue)
                    theme_color_dark='#3e68d7' # Macchiato Blue
                    theme_color_light='#2e7de9' # Latte Blue
                    ;;
                -Sapphire)
                    theme_color_dark='#7dc4e4' # Macchiato Sapphire
                    theme_color_light='#4aa5d4' # Latte Sapphire
                    ;;
                -Sky)
                    theme_color_dark='#91d7e3' # Macchiato Sky
                    theme_color_light='#5db4c0' # Latte Sky
                    ;;
                -Teal)
                    theme_color_dark='#8bd5ca' # Macchiato Teal
                    theme_color_light='#5fb3a1' # Latte Teal
                    ;;
                -Green)
                    theme_color_dark='#c3e88d' # Macchiato Green
                    theme_color_light='#587539' # Latte Green
                    ;;
                -Yellow)
                    theme_color_dark='#ffc777' # Macchiato Yellow
                    theme_color_light='#8c6c3e' # Latte Yellow
                    ;;
                -Peach)
                    theme_color_dark='#f5a97f' # Macchiato Peach
                    theme_color_light='#b15c00' # Latte Peach
                    ;;
                -Grey)
                    theme_color_dark='#222436' # Macchiato Grey
                    theme_color_light='#c8d3f5' # Latte Grey
                    ;;
            esac
        fi

        if [[ "$type" != '' ]]; then
            cp -rf "theme" "theme${theme}${type}"
            sed -i "s/#27a1b9/${theme_color_dark}/g" "theme${theme}${type}"/*.svg
            sed -i "s/#006a83/${theme_color_light}/g" "theme${theme}${type}"/*.svg
        elif [[ "$theme" != '' ]]; then
            cp -rf "theme" "theme${theme}"
            sed -i "s/#27a1b9/${theme_color_dark}/g" "theme${theme}"/*.svg
            sed -i "s/#006a83/${theme_color_light}/g" "theme${theme}"/*.svg
        fi
    done
done

echo -e "DONE!"
