#! /usr/bin/env bash

for theme in '' '-Blue' '-Flamingo' '-Grey' '-Green' '-Lavender' '-Maroon' '-Mauve' '-Peach' '-Pink' '-Red' '-Rosewater' '-Sapphire' '-Sky' '-Teal' '-Yellow'; do
    for color in '' '-Dark'; do
        for type in '' '-Frappe' '-Macchiato'; do
            if [[ "$color" == '' ]]; then
                case "$theme" in
                    '')
                        theme_color='#27a1b9'
                        ;;
                    -Blue)
                        theme_color='#7aa2f7'
                        ;;
                    -Flamingo)
                        theme_color='#f2cdcd'
                        ;;
                    -Grey)
                        theme_color='#a6adc8'
                        ;;
                    -Green)
                        theme_color='#9ece6a'
                        ;;
                    -Lavender)
                        theme_color='#b4befe'
                        ;;
                    -Maroon)
                        theme_color='#eba0ac'
                        ;;
                    -Mauve)
                        theme_color='#cba6f7'
                        ;;
                    -Peach)
                        theme_color='#fab387'
                        ;;
                    -Pink)
                        theme_color='#ff007c'
                        ;;
                    -Red)
                        theme_color='#f7768e'
                        ;;
                    -Rosewater)
                        theme_color='#f5e0dc'
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
                    -Yellow)
                        theme_color='#e0af68'
                        ;;
                esac

                if [[ "$type" == '-Frappe' ]]; then
                    background_color='#f8fafc'

                    case "$theme" in
                        '')
                            theme_color='#29a4bd'
                            ;;
                        -Blue)
                            theme_color='#7aa2f7'
                            ;;
                        -Flamingo)
                            theme_color='#eebebe'
                            ;;
                        -Grey)
                            theme_color='#a6adc8'
                            ;;
                        -Green)
                            theme_color='#9ece6a'
                            ;;
                        -Lavender)
                            theme_color='#babbf1'
                            ;;
                        -Maroon)
                            theme_color='#ea999c'
                            ;;
                        -Mauve)
                            theme_color='#ca9ee6'
                            ;;
                        -Peach)
                            theme_color='#ef9f76'
                            ;;
                        -Pink)
                            theme_color='#ff007c'
                            ;;
                        -Red)
                            theme_color='#f7768e'
                            ;;
                        -Rosewater)
                            theme_color='#f2cdcd'
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
                        -Yellow)
                            theme_color='#e0af68'
                            ;;
                    esac
                fi

                if [[ "$type" == '-Macchiato' ]]; then
                    background_color='#f9f9fb'

                    case "$theme" in
                        '')
                            theme_color='#589ed7'
                            ;;
                        -Blue)
                            theme_color='#3e68d7'
                            ;;
                        -Flamingo)
                            theme_color='#f0c6c6'
                            ;;
                        -Grey)
                            theme_color='#a6adc8'
                            ;;
                        -Green)
                            theme_color='#c3e88d'
                            ;;
                        -Lavender)
                            theme_color='#b7bdf8'
                            ;;
                        -Maroon)
                            theme_color='#ee99a0'
                            ;;
                        -Mauve)
                            theme_color='#c6a0f6'
                            ;;
                        -Peach)
                            theme_color='#f5a97f'
                            ;;
                        -Pink)
                            theme_color='#fca7ea'
                            ;;
                        -Red)
                            theme_color='#ff757f'
                            ;;
                        -Rosewater)
                            theme_color='#f4dbd6'
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
                        -Yellow)
                            theme_color='#ffc777'
                            ;;
                    esac
                fi
            else
                case "$theme" in
                    '')
                        theme_color='#006a83'
                        ;;
                    -Blue)
                        theme_color='#7aa2f7'
                        ;;
                    -Flamingo)
                        theme_color='#f0bfc0'
                        ;;
                    -Grey)
                        theme_color='#585b70'
                        ;;
                    -Green)
                        theme_color='#587539'
                        ;;
                    -Lavender)
                        theme_color='#7c83d2'
                        ;;
                    -Maroon)
                        theme_color='#d27e88'
                        ;;
                    -Mauve)
                        theme_color='#a084ca'
                        ;;
                    -Peach)
                        theme_color='#b15c00'
                        ;;
                    -Pink)
                        theme_color='#d20065'
                        ;;
                    -Red)
                        theme_color='#f52a65'
                        ;;
                    -Rosewater)
                        theme_color='#f2d5cf'
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
                    -Yellow)
                        theme_color='#8c6c3e'
                        ;;
                esac

                if [[ "$type" == '-Frappe' ]]; then
                    background_color='#242932'

                    case "$theme" in
                        '')
                            theme_color='#006a83'
                            ;;
                        -Blue)
                            theme_color='#2e7de9'
                            ;;
                        -Flamingo)
                            theme_color='#eebebe'
                            ;;
                        -Grey)
                            theme_color='#585b70'
                            ;;
                        -Green)
                            theme_color='#587539'
                            ;;
                        -Lavender)
                            theme_color='#babbf1'
                            ;;
                        -Maroon)
                            theme_color='#ea999c'
                            ;;
                        -Mauve)
                            theme_color='#ca9ee6'
                            ;;
                        -Peach)
                            theme_color='#ef9f76'
                            ;;
                        -Pink)
                            theme_color='#d20065'
                            ;;
                        -Red)
                            theme_color='#f52a65'
                            ;;
                        -Rosewater)
                            theme_color='#f2cdcd'
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
                        -Yellow)
                            theme_color='#8c6c3e'
                            ;;
                    esac
                fi

                if [[ "$type" == '-Macchiato' ]]; then
                    background_color='#242632'

                    case "$theme" in
                        '')
                            theme_color='#006a83'
                            ;;
                        -Blue)
                            theme_color='#2e7de9'
                            ;;
                        -Flamingo)
                            theme_color='#f0c6c6'
                            ;;
                        -Grey)
                            theme_color='#585b70'
                            ;;
                        -Green)
                            theme_color='#587539'
                            ;;
                        -Lavender)
                            theme_color='#b7bdf8'
                            ;;
                        -Maroon)
                            theme_color='#ee99a0'
                            ;;
                        -Mauve)
                            theme_color='#c6a0f6'
                            ;;
                        -Peach)
                            theme_color='#f5a97f'
                            ;;
                        -Pink)
                            theme_color='#d20065'
                            ;;
                        -Red)
                            theme_color='#f52a65'
                            ;;
                        -Rosewater)
                            theme_color='#f4dbd6'
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
                        -Yellow)
                            theme_color='#8c6c3e'
                            ;;
                    esac
                fi
            fi

            if [[ "$type" != '' ]]; then
                cp -r "assets${color}.svg" "assets${theme}${color}${type}.svg"
                # cp -r "assets-common${color}.svg" "assets-common${color}${type}.svg"
                if [[ "$color" == '' ]]; then
                    sed -i "s/#006a83/${theme_color}/g" "assets${theme}${color}${type}.svg"
                    # sed -i "s/#eff1f5/${background_color}/g" "assets-common${color}${type}.svg"
                else
                    sed -i "s/#27a1b9/${theme_color}/g" "assets${theme}${color}${type}.svg"
                    # sed -i "s/#1e1e2e/${background_color}/g" "assets-common${color}${type}.svg"
                fi
            elif [[ "$theme" != '' ]]; then
                cp -r "assets${color}.svg" "assets${theme}${color}.svg"
                if [[ "$color" == '' ]]; then
                    sed -i "s/#006a83/${theme_color}/g" "assets${theme}${color}.svg"
                else
                    sed -i "s/#27a1b9/${theme_color}/g" "assets${theme}${color}.svg"
                fi
            fi

        done
    done
done

echo -e "DONE!"
