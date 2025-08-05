make_gtkrc() {
	local dest="${1}"
	local name="${2}"
	local theme="${3}"
	local color="${4}"
	local size="${5}"
	local ctype="${6}"
	local window="${7}"

	[[ "${color}" == '-Light' ]] && local ELSE_LIGHT="${color}"
	[[ "${color}" == '-Dark' ]] && local ELSE_DARK="${color}"

	local GTKRC_DIR="${SRC_DIR}/main/gtk-2.0"
	local THEME_DIR="${1}/${2}${3}${4}${5}${6}"

	if [[ "${color}" != '-Dark' ]]; then
	    # Mocha (default flavor)
	    case "$theme" in
			'')         theme_color='#27a1b9' ;;
			-Blue)      theme_color='#89b4fa' ;;
			-Flamingo)  theme_color='#f2cdcd' ;;
			-Green)     theme_color='#a6e3a1' ;;
			-Lavender)  theme_color='#b4befe' ;;
			-Maroon)    theme_color='#eba0ac' ;;
			-Mauve)     theme_color='#cba6f7' ;;
			-Peach)     theme_color='#fab387' ;;
			-Pink)      theme_color='#f5c2e7' ;;
			-Red)       theme_color='#f38ba8' ;;
			-Rosewater) theme_color='#f5e0dc' ;;
			-Sapphire)  theme_color='#74c7ec' ;;
			-Sky)       theme_color='#89dceb' ;;
			-Teal)      theme_color='#94e2d5' ;;
			-Yellow)    theme_color='#f9e2af' ;;
	    esac

	    if [[ "$ctype" == '-Frappe' ]]; then
	        case "$theme" in
				'')         theme_color='#27a1b9' ;;
				-Blue)      theme_color='#8caaee' ;;
				-Flamingo)  theme_color='#eebebe' ;;
				-Green)     theme_color='#a6d189' ;;
				-Lavender)  theme_color='#babbf1' ;;
				-Maroon)    theme_color='#ea999c' ;;
				-Mauve)     theme_color='#ca9ee6' ;;
				-Peach)     theme_color='#ef9f76' ;;
				-Pink)      theme_color='#f4b8e4' ;;
				-Red)       theme_color='#e78284' ;;
				-Rosewater) theme_color='#f2d5cf' ;;
				-Sapphire)  theme_color='#85c1dc' ;;
				-Sky)       theme_color='#99d1db' ;;
				-Teal)      theme_color='#81c8be' ;;
				-Yellow)    theme_color='#e5c890' ;;
	        esac
	    fi

	    if [[ "$ctype" == '-Macchiato' ]]; then
	        case "$theme" in
				'')         theme_color='#27a1b9' ;;
				-Blue)      theme_color='#8aadf4' ;;
				-Flamingo)  theme_color='#f0c6c6' ;;
				-Green)     theme_color='#a6da95' ;;
				-Lavender)  theme_color='#b7bdf8' ;;
				-Maroon)    theme_color='#ee99a0' ;;
				-Mauve)     theme_color='#c6a0f6' ;;
				-Peach)     theme_color='#f5a97f' ;;
				-Pink)      theme_color='#f5bde6' ;;
				-Red)       theme_color='#ed8796' ;;
				-Rosewater) theme_color='#f4dbd6' ;;
				-Sapphire)  theme_color='#7dc4e4' ;;
				-Sky)       theme_color='#91d7e3' ;;
				-Teal)      theme_color='#8bd5ca' ;;
				-Yellow)    theme_color='#eed49f' ;;
	        esac
	    fi
	else
	    # Light theme (Latte, Frappé, Macchiato)
	    if [[ "$ctype" == '-Frappe' ]]; then
	        case "$theme" in
				'')         theme_color='#27a1b9' ;;
				-Blue)      theme_color='#8caaee' ;;
				-Flamingo)  theme_color='#eebebe' ;;
				-Green)     theme_color='#a6d189' ;;
				-Lavender)  theme_color='#babbf1' ;;
				-Maroon)    theme_color='#ea999c' ;;
				-Mauve)     theme_color='#ca9ee6' ;;
				-Peach)     theme_color='#ef9f76' ;;
				-Pink)      theme_color='#f4b8e4' ;;
				-Red)       theme_color='#e78284' ;;
				-Rosewater) theme_color='#f2d5cf' ;;
				-Sapphire)  theme_color='#85c1dc' ;;
				-Sky)       theme_color='#99d1db' ;;
				-Teal)      theme_color='#81c8be' ;;
				-Yellow)    theme_color='#e5c890' ;;
	        esac
	    elif [[ "$ctype" == '-Macchiato' ]]; then
	        case "$theme" in
				'')         theme_color='#27a1b9' ;;
				-Blue)      theme_color='#8aadf4' ;;
				-Flamingo)  theme_color='#f0c6c6' ;;
				-Green)     theme_color='#a6da95' ;;
				-Lavender)  theme_color='#b7bdf8' ;;
				-Maroon)    theme_color='#ee99a0' ;;
				-Mauve)     theme_color='#c6a0f6' ;;
				-Peach)     theme_color='#f5a97f' ;;
				-Pink)      theme_color='#f5bde6' ;;
				-Red)       theme_color='#ed8796' ;;
				-Sapphire)  theme_color='#7dc4e4' ;;
				-Rosewater) theme_color='#f4dbd6' ;;
				-Sky)       theme_color='#91d7e3' ;;
				-Teal)      theme_color='#8bd5ca' ;;
				-Yellow)    theme_color='#eed49f' ;;
	        esac
	    else
	        # Latte (default light flavor)
	        case "$theme" in
				'')         theme_color='#006a83' ;;
				-Blue)      theme_color='#1e66f5' ;;
				-Flamingo)  theme_color='#dd7878' ;;
				-Green)     theme_color='#40a02b' ;;
				-Lavender)  theme_color='#7287fd' ;;
				-Maroon)    theme_color='#e64553' ;;
				-Mauve)     theme_color='#8839ef' ;;
				-Peach)     theme_color='#fe640b' ;;
				-Pink)      theme_color='#ea76cb' ;;
				-Red)       theme_color='#d20f39' ;;
				-Rosewater) theme_color='#dc8a78' ;;
				-Sapphire)  theme_color='#209fb5' ;;
				-Sky)       theme_color='#04a5e5' ;;
				-Teal)      theme_color='#179299' ;;
				-Yellow)    theme_color='#df8e1d' ;;
	        esac
	    fi
	fi


	if [[ "$blackness" == 'true' ]]; then
		case "$ctype" in
		'')
			background_light='#eff1f5'
			background_dark='#010101'
			background_darker='#000000'
			background_alt='#020202'
			titlebar_light='#ccd0da'
			titlebar_dark='#11111b'
			;;
		-Frappe)
			background_light='#eff1f5'
			background_dark='#010101'
			background_darker='#000000'
			background_alt='#020202'
			titlebar_light='#ccd0da'
			titlebar_dark='#11111b'
			;;
		-Macchiato)
			background_light='#eff1f5'
			background_dark='#010101'
			background_darker='#000000'
			background_alt='#020202'
			titlebar_light='#ccd0da'
			titlebar_dark='#11111b'
			;;
		esac
	else
		case "$ctype" in
		'')
			background_light='#eff1f5'
			background_dark='#1e1e2e'
			background_darker='#11111b'
			background_alt='#24273a'
			titlebar_light='#ccd0da'
			titlebar_dark='#232634'
			;;
		-Frappe)
			background_light='#eff1f5'
			background_dark='#303446'
			background_darker='#11111b'
			background_alt='#313244'
			titlebar_light='#ccd0da'
			titlebar_dark='#232634'
			;;
		-Macchiato)
			background_light='#eff1f5'
			background_dark='#24273a'
			background_darker='#11111b'
			background_alt='#292c3c'
			titlebar_light='#ccd0da'
			titlebar_dark='#1f2029'
			;;
		esac
	fi

	mkdir -p "${THEME_DIR}/gtk-2.0"

	cp -r "${GTKRC_DIR}/gtkrc${ELSE_DARK:-}-default" "${THEME_DIR}/gtk-2.0/gtkrc"
	sed -i "s/#eff1f5/${background_light}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	sed -i "s/#1e1e2e/${background_dark}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	sed -i "s/#414559/${background_alt}/g" "${THEME_DIR}/gtk-2.0/gtkrc"

	if [[ "${color}" == '-Dark' ]]; then
		sed -i "s/#27a1b9/${theme_color}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
		sed -i "s/#11111b/${background_darker}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
		sed -i "s/#232634/${titlebar_dark}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	else
		sed -i "s/#006a83/${theme_color}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
		sed -i "s/#ccd0da/${titlebar_light}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	fi
}
