#! /usr/bin/env bash

for theme in '' '-Rosewater' '-Flamingo' '-Pink' '-Red' '-Maroon' '-Mauve' '-Lavender' '-Blue' '-Sapphire' '-Sky' '-Teal' '-Green' '-Yellow' '-Peach' '-Grey'; do
    for color in '' '-Dark'; do
        for type in '' '-Frappe' '-Macchiato'; do
            if [[ "$color" == '' ]]; then
                case "$theme" in
                    '')
                        theme_color='#27a1b9'
                        ;;
                    -Pink)
                        theme_color='#ff007c'
                        ;;
                    -Red)
                        theme_color='#f7768e'
                        ;;
                    -Yellow)
                        theme_color='#e0af68'
                        ;;
                    -Green)
                        theme_color='#9ece6a'
                        ;;
                    -Blue)
                        theme_color='#7aa2f7'
                        ;;
                    -Grey)
                        theme_color='#1a1b26'
                        ;;
                    -Rosewater)
                        theme_color='#f5e0dc'
                        ;;
                    -Flamingo)
                        theme_color='#f2cdcd'
                        ;;
                    -Maroon)
                        theme_color='#eba0ac'
                        ;;
                    -Mauve)
                        theme_color='#cba6f7'
                        ;;
                    -Lavender)
                        theme_color='#b4befe'
                        ;;
                    -Sapphire)
                        theme_color='#74c7ec'
                        ;;
                    -Sky)
                        theme_color='#89dceb'
                        ;;
                    -Teal)
                        theme_color='#94e2d5'
                        ;;
                    -Peach)
                        theme_color='#fab387'
                        ;;

                esac

                if [[ "$type" == '-Frappe' ]]; then
                    background_color='#c0caf5'

                    case "$theme" in
                        '')
                            theme_color='#29a4bd'
                            ;;
                        -Pink)
                            theme_color='#ff007c'
                            ;;
                        -Red)
                            theme_color='#f7768e'
                            ;;
                        -Yellow)
                            theme_color='#e0af68'
                            ;;
                        -Green)
                            theme_color='#9ece6a'
                            ;;
                        -Blue)
                            theme_color='#7aa2f7'
                            ;;
                        -Grey)
                            theme_color='#24283b'
                            ;;
                        -Rosewater)
                            theme_color='#f2cdcd'
                            ;;
                        -Flamingo)
                            theme_color='#eebebe'
                            ;;
                        -Maroon)
                            theme_color='#ea999c'
                            ;;
                        -Mauve)
                            theme_color='#ca9ee6'
                            ;;
                        -Lavender)
                            theme_color='#babbf1'
                            ;;
                        -Sapphire)
                            theme_color='#85c1dc'
                            ;;
                        -Sky)
                            theme_color='#99d1db'
                            ;;
                        -Teal)
                            theme_color='#81c8be'
                            ;;
                        -Peach)
                            theme_color='#ef9f76'
                            ;;

                    esac
                fi

                if [[ "$type" == '-Macchiato' ]]; then
                    background_color='#c8d3f5'

                    case "$theme" in
                        '')
                            theme_color='#589ed7'
                            ;;
                        -Pink)
                            theme_color='#fca7ea'
                            ;;
                        -Red)
                            theme_color='#ff757f'
                            ;;
                        -Yellow)
                            theme_color='#ffc777'
                            ;;
                        -Green)
                            theme_color='#c3e88d'
                            ;;
                        -Blue)
                            theme_color='#3e68d7'
                            ;;
                        -Grey)
                            theme_color='#222436'
                            ;;
                        -Rosewater)
                            theme_color='#f4dbd6'
                            ;;
                        -Flamingo)
                            theme_color='#f0c6c6'
                            ;;
                        -Maroon)
                            theme_color='#ee99a0'
                            ;;
                        -Mauve)
                            theme_color='#c6a0f6'
                            ;;
                        -Lavender)
                            theme_color='#b7bdf8'
                            ;;
                        -Sapphire)
                            theme_color='#7dc4e4'
                            ;;
                        -Sky)
                            theme_color='#91d7e3'
                            ;;
                        -Teal)
                            theme_color='#8bd5ca'
                            ;;
                        -Peach)
                            theme_color='#f5a97f'
                            ;;

                    esac
                fi
            else
                case "$theme" in
                    '')
                        theme_color='#006a83'
                        ;;
                    -Pink)
                        theme_color='#d20065'
                        ;;
                    -Red)
                        theme_color='#f52a65'
                        ;;
                    -Yellow)
                        theme_color='#8c6c3e'
                        ;;
                    -Green)
                        theme_color='#587539'
                        ;;
                    -Blue)
                        theme_color='#7aa2f7'
                        ;;
                    -Grey)
                        theme_color='#c0caf5'
                        ;;
                    -Rosewater)
                        theme_color='#f2d5cf'
                        ;;
                    -Flamingo)
                        theme_color='#f0bfc0'
                        ;;
                    -Maroon)
                        theme_color='#d27e88'
                        ;;
                    -Mauve)
                        theme_color='#a084ca'
                        ;;
                    -Lavender)
                        theme_color='#7c83d2'
                        ;;
                    -Sapphire)
                        theme_color='#4aa5d4'
                        ;;
                    -Sky)
                        theme_color='#5db4c0'
                        ;;
                    -Teal)
                        theme_color='#5fb3a1'
                        ;;
                    -Peach)
                        theme_color='#b15c00'
                        ;;

                esac

                if [[ "$type" == '-Frappe' ]]; then
                    background_color='#24283b'

                    case "$theme" in
                        '')
                            theme_color='#006a83'
                            ;;
                        -Pink)
                            theme_color='#d20065'
                            ;;
                        -Red)
                            theme_color='#f52a65'
                            ;;
                        -Yellow)
                            theme_color='#8c6c3e'
                            ;;
                        -Green)
                            theme_color='#587539'
                            ;;
                        -Blue)
                            theme_color='#2e7de9'
                            ;;
                        -Grey)
                            theme_color='#c0caf5'
                            ;;
                        -Rosewater)
                            theme_color='#f2cdcd'
                            ;;
                        -Flamingo)
                            theme_color='#eebebe'
                            ;;
                        -Maroon)
                            theme_color='#ea999c'
                            ;;
                        -Mauve)
                            theme_color='#ca9ee6'
                            ;;
                        -Lavender)
                            theme_color='#babbf1'
                            ;;
                        -Sapphire)
                            theme_color='#85c1dc'
                            ;;
                        -Sky)
                            theme_color='#99d1db'
                            ;;
                        -Teal)
                            theme_color='#81c8be'
                            ;;
                        -Peach)
                            theme_color='#ef9f76'
                            ;;

                    esac
                fi

                if [[ "$type" == '-Macchiato' ]]; then
                    background_color='#222436'

                    case "$theme" in
                        '')
                            theme_color='#006a83'
                            ;;
                        -Pink)
                            theme_color='#d20065'
                            ;;
                        -Red)
                            theme_color='#f52a65'
                            ;;
                        -Yellow)
                            theme_color='#8c6c3e'
                            ;;
                        -Green)
                            theme_color='#587539'
                            ;;
                        -Blue)
                            theme_color='#2e7de9'
                            ;;
                        -Grey)
                            theme_color='#c8d3f5'
                            ;;
                        -Rosewater)
                            theme_color='#f4dbd6'
                            ;;
                        -Flamingo)
                            theme_color='#f0c6c6'
                            ;;
                        -Maroon)
                            theme_color='#ee99a0'
                            ;;
                        -Mauve)
                            theme_color='#c6a0f6'
                            ;;
                        -Lavender)
                            theme_color='#b7bdf8'
                            ;;
                        -Sapphire)
                            theme_color='#7dc4e4'
                            ;;
                        -Sky)
                            theme_color='#91d7e3'
                            ;;
                        -Teal)
                            theme_color='#8bd5ca'
                            ;;
                        -Peach)
                            theme_color='#f5a97f'
                            ;;

                    esac
                fi
            fi

            if [[ "$type" != '' ]]; then
                cp -r "assets${color}.svg" "assets${theme}${color}${type}.svg"
                if [[ "$color" == '' ]]; then
                    sed -i "s/#27a1b9/${theme_color}/g" "assets${theme}${color}${type}.svg"
                else
                    sed -i "s/#006a83/${theme_color}/g" "assets${theme}${color}${type}.svg"
                fi
            elif [[ "$theme" != '' ]]; then
                cp -r "assets${color}.svg" "assets${theme}${color}.svg"
                if [[ "$color" == '' ]]; then
                    sed -i "s/#27a1b9/${theme_color}/g" "assets${theme}${color}.svg"
                else
                    sed -i "s/#006a83/${theme_color}/g" "assets${theme}${color}.svg"
                fi
            fi

        done
    done
done

echo -e "DONE!"
