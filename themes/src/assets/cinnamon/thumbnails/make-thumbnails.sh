#! /usr/bin/env bash

for theme in '' '-Blue' '-Flamingo' '-Grey' '-Green' '-Lavender' '-Maroon' '-Mauve' '-Peach' '-Pink' '-Red' '-Rosewater' '-Sapphire' '-Sky' '-Teal' '-Yellow'; do
	for type in '' '-Frappe' '-Macchiato'; do
		case "$theme" in
		'')
			theme_color_dark='#27a1b9'  # Mocha Default
			theme_color_light='#006a83' # Latte Default
			;;
		-Blue)
			theme_color_dark='#7aa2f7'  # Mocha Blue
			theme_color_light='#2e7de9' # Latte Blue
			;;
		-Flamingo)
			theme_color_dark='#f2cdcd'  # Mocha Flamingo
			theme_color_light='#f0bfc0' # Latte Flamingo
			;;
		-Grey)
			theme_color_dark='#585b70'  # Macchiato Grey
			theme_color_light='#a6adc8' # Latte Grey
			;;
		-Green)
			theme_color_dark='#9ece6a'  # Mocha Green
			theme_color_light='#587539' # Latte Green
			;;
		-Lavender)
			theme_color_dark='#b4befe'  # Mocha Lavender
			theme_color_light='#7c83d2' # Latte Lavender
			;;
		-Maroon)
			theme_color_dark='#eba0ac'  # Mocha Maroon
			theme_color_light='#d27e88' # Latte Maroon
			;;
		-Mauve)
			theme_color_dark='#cba6f7'  # Mocha Mauve
			theme_color_light='#a084ca' # Latte Mauve
			;;
		-Peach)
			theme_color_dark='#fab387'  # Mocha Peach
			theme_color_light='#b15c00' # Latte Peach
			;;
		-Pink)
			theme_color_dark='#ff007c'  # Mocha Pink
			theme_color_light='#d20065' # Latte Pink
			;;
		-Red)
			theme_color_dark='#f7768e'  # Mocha Red
			theme_color_light='#f52a65' # Latte Red
			;;
		-Rosewater)
			theme_color_dark='#f5e0dc'  # Mocha Rosewater
			theme_color_light='#f2d5cf' # Latte Rosewater
			;;
		-Sapphire)
			theme_color_dark='#74c7ec'  # Mocha Sapphire
			theme_color_light='#4aa5d4' # Latte Sapphire
			;;
		-Sky)
			theme_color_dark='#89dceb'  # Mocha Sky
			theme_color_light='#5db4c0' # Latte Sky
			;;
		-Teal)
			theme_color_dark='#94e2d5'  # Mocha Teal
			theme_color_light='#5fb3a1' # Latte Teal
			;;
		-Yellow)
			theme_color_dark='#e0af68'  # Mocha Yellow
			theme_color_light='#8c6c3e' # Latte Yellow
			;;
		esac

		if [[ "$type" == '-Frappe' ]]; then
			panel_dark='#303446'
			panel_light='#eff1f5'

			case "$theme" in
			'')
				theme_color_dark='#29a4bd'  # Frappe Default
				theme_color_light='#006a83' # Latte Default
				;;
			-Blue)
				theme_color_dark='#7aa2f7'  # Frappe Blue
				theme_color_light='#2e7de9' # Latte Blue
				;;
			-Flamingo)
				theme_color_dark='#eebebe'  # Frappe Flamingo
				theme_color_light='#e3a9a9' # Latte Flamingo
				;;
			-Grey)
				theme_color_dark='#585b70'  # Macchiato Grey
				theme_color_light='#a6adc8' # Latte Grey
				;;
			-Green)
				theme_color_dark='#9ece6a'  # Frappe Green
				theme_color_light='#587539' # Latte Green
				;;
			-Lavender)
				theme_color_dark='#babbf1'  # Frappe Lavender
				theme_color_light='#7c83d2' # Latte Lavender
				;;
			-Maroon)
				theme_color_dark='#ea999c'  # Frappe Maroon
				theme_color_light='#d27e88' # Latte Maroon
				;;
			-Mauve)
				theme_color_dark='#ca9ee6'  # Frappe Mauve
				theme_color_light='#a084ca' # Latte Mauve
				;;
			-Peach)
				theme_color_dark='#ef9f76'  # Frappe Peach
				theme_color_light='#b15c00' # Latte Peach
				;;
			-Pink)
				theme_color_dark='#ff007c'  # Frappe Pink
				theme_color_light='#d20065' # Latte Pink
				;;
			-Red)
				theme_color_dark='#f7768e'  # Frappe Red
				theme_color_light='#f52a65' # Latte Red
				;;
			-Rosewater)
				theme_color_dark='#f2cdcd'  # Frappe Rosewater
				theme_color_light='#eac2c2' # Latte Rosewater
				;;
			-Sapphire)
				theme_color_dark='#85c1dc'  # Frappe Sapphire
				theme_color_light='#4aa5d4' # Latte Sapphire
				;;
			-Sky)
				theme_color_dark='#99d1db'  # Frappe Sky
				theme_color_light='#5db4c0' # Latte Sky
				;;
			-Teal)
				theme_color_dark='#81c8be'  # Frappe Teal
				theme_color_light='#5fb3a1' # Latte Teal
				;;
			-Yellow)
				theme_color_dark='#e0af68'  # Frappe Yellow
				theme_color_light='#8c6c3e' # Latte Yellow
				;;
			esac
		fi

		if [[ "$type" == '-Macchiato' ]]; then
			panel_dark='#24273a'
			panel_light='#eff1f5'

			case "$theme" in
			'')
				theme_color_dark='#589ed7'  # Macchiato Default
				theme_color_light='#006a83' # Latte Default
				;;
			-Blue)
				theme_color_dark='#3e68d7'  # Macchiato Blue
				theme_color_light='#2e7de9' # Latte Blue
				;;
			-Flamingo)
				theme_color_dark='#f0c6c6'  # Macchiato Flamingo
				theme_color_light='#e3a9a9' # Latte Flamingo
				;;
			-Grey)
				theme_color_dark='#585b70'  # Macchiato Grey
				theme_color_light='#a6adc8' # Latte Grey
				;;
			-Green)
				theme_color_dark='#c3e88d'  # Macchiato Green
				theme_color_light='#587539' # Latte Green
				;;
			-Lavender)
				theme_color_dark='#b7bdf8'  # Macchiato Lavender
				theme_color_light='#7c83d2' # Latte Lavender
				;;
			-Maroon)
				theme_color_dark='#ee99a0'  # Macchiato Maroon
				theme_color_light='#d27e88' # Latte Maroon
				;;
			-Mauve)
				theme_color_dark='#c6a0f6'  # Macchiato Mauve
				theme_color_light='#a084ca' # Latte Mauve
				;;
			-Peach)
				theme_color_dark='#f5a97f'  # Macchiato Peach
				theme_color_light='#b15c00' # Latte Peach
				;;
			-Pink)
				theme_color_dark='#fca7ea'  # Macchiato Pink
				theme_color_light='#d20065' # Latte Pink
				;;
			-Red)
				theme_color_dark='#ff757f'  # Macchiato Red
				theme_color_light='#f52a65' # Latte Red
				;;
			-Rosewater)
				theme_color_dark='#f4dbd6'  # Macchiato Rosewater
				theme_color_light='#eac2c2' # Latte Rosewater
				;;
			-Sapphire)
				theme_color_dark='#7dc4e4'  # Macchiato Sapphire
				theme_color_light='#4aa5d4' # Latte Sapphire
				;;
			-Sky)
				theme_color_dark='#91d7e3'  # Macchiato Sky
				theme_color_light='#5db4c0' # Latte Sky
				;;
			-Teal)
				theme_color_dark='#8bd5ca'  # Macchiato Teal
				theme_color_light='#5fb3a1' # Latte Teal
				;;
			-Yellow)
				theme_color_dark='#ffc777'  # Macchiato Yellow
				theme_color_light='#8c6c3e' # Latte Yellow
				;;
			esac
		fi

		if [[ "$type" != '' ]]; then
			rm -rf "thumbnail${theme}${type}.svg"
			cp -rf "thumbnail.svg" "thumbnail${theme}${type}.svg"
			sed -i "s/#27a1b9/${theme_color_dark}/g" "thumbnail${theme}${type}.svg"
			sed -i "s/#006a83/${theme_color_light}/g" "thumbnail${theme}${type}.svg"
			sed -i "s/#eff1f5/${panel_light}/g" "thumbnail${theme}${type}.svg"
			sed -i "s/#1e1e2e/${panel_dark}/g" "thumbnail${theme}${type}.svg"
			sed -i "s/thumbnail/thumbnail${theme}${type}/g" "thumbnail${theme}${type}.svg"
		elif [[ "$theme" != '' ]]; then
			rm -rf "thumbnail${theme}.svg"
			cp -rf "thumbnail.svg" "thumbnail${theme}.svg"
			sed -i "s/#27a1b9/${theme_color_dark}/g" "thumbnail${theme}.svg"
			sed -i "s/#006a83/${theme_color_light}/g" "thumbnail${theme}.svg"
			sed -i "s/thumbnail/thumbnail${theme}/g" "thumbnail${theme}.svg"
		fi
	done
done

echo -e "DONE!"
