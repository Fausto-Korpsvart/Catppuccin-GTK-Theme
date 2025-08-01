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
	        '')          theme_color='#89b4fa' ;; # Default: Blue
	        -Rosewater) theme_color='#f5e0dc' ;;
	        -Flamingo)  theme_color='#f2cdcd' ;;
	        -Pink)      theme_color='#f5c2e7' ;;
	        -Mauve)     theme_color='#cba6f7' ;;
	        -Red)       theme_color='#f38ba8' ;;
	        -Maroon)    theme_color='#eba0ac' ;;
	        -Peach)     theme_color='#fab387' ;;
	        -Yellow)    theme_color='#f9e2af' ;;
	        -Green)     theme_color='#a6e3a1' ;;
	        -Teal)      theme_color='#94e2d5' ;;
	        -Sky)       theme_color='#89dceb' ;;
	        -Sapphire)  theme_color='#74c7ec' ;;
	        -Blue)      theme_color='#89b4fa' ;;
	        -Lavender)  theme_color='#b4befe' ;;
	    esac
	
	    if [[ "$ctype" == '-Frappe' ]]; then
	        case "$theme" in
	            '')          theme_color='#8caaee' ;; # Default: Blue
	            -Rosewater) theme_color='#f2d5cf' ;;
	            -Flamingo)  theme_color='#eebebe' ;;
	            -Pink)      theme_color='#f4b8e4' ;;
	            -Mauve)     theme_color='#ca9ee6' ;;
	            -Red)       theme_color='#e78284' ;;
	            -Maroon)    theme_color='#ea999c' ;;
	            -Peach)     theme_color='#ef9f76' ;;
	            -Yellow)    theme_color='#e5c890' ;;
	            -Green)     theme_color='#a6d189' ;;
	            -Teal)      theme_color='#81c8be' ;;
	            -Sky)       theme_color='#99d1db' ;;
	            -Sapphire)  theme_color='#85c1dc' ;;
	            -Blue)      theme_color='#8caaee' ;;
	            -Lavender)  theme_color='#babbf1' ;;
	        esac
	    fi
	
	    if [[ "$ctype" == '-Macchiato' ]]; then
	        case "$theme" in
	            '')          theme_color='#8aadf4' ;; # Default: Blue
	            -Rosewater) theme_color='#f4dbd6' ;;
	            -Flamingo)  theme_color='#f0c6c6' ;;
	            -Pink)      theme_color='#f5bde6' ;;
	            -Mauve)     theme_color='#c6a0f6' ;;
	            -Red)       theme_color='#ed8796' ;;
	            -Maroon)    theme_color='#ee99a0' ;;
	            -Peach)     theme_color='#f5a97f' ;;
	            -Yellow)    theme_color='#eed49f' ;;
	            -Green)     theme_color='#a6da95' ;;
	            -Teal)      theme_color='#8bd5ca' ;;
	            -Sky)       theme_color='#91d7e3' ;;
	            -Sapphire)  theme_color='#7dc4e4' ;;
	            -Blue)      theme_color='#8aadf4' ;;
	            -Lavender)  theme_color='#b7bdf8' ;;
	        esac
	    fi
	else
	    # Light theme (Latte, Frappé, Macchiato)
	    if [[ "$ctype" == '-Frappe' ]]; then
	        case "$theme" in
	            '')          theme_color='#8caaee' ;; # Default: Blue
	            -Rosewater) theme_color='#f2d5cf' ;;
	            -Flamingo)  theme_color='#eebebe' ;;
	            -Pink)      theme_color='#f4b8e4' ;;
	            -Mauve)     theme_color='#ca9ee6' ;;
	            -Red)       theme_color='#e78284' ;;
	            -Maroon)    theme_color='#ea999c' ;;
	            -Peach)     theme_color='#ef9f76' ;;
	            -Yellow)    theme_color='#e5c890' ;;
	            -Green)     theme_color='#a6d189' ;;
	            -Teal)      theme_color='#81c8be' ;;
	            -Sky)       theme_color='#99d1db' ;;
	            -Sapphire)  theme_color='#85c1dc' ;;
	            -Blue)      theme_color='#8caaee' ;;
	            -Lavender)  theme_color='#babbf1' ;;
	        esac
	    elif [[ "$ctype" == '-Macchiato' ]]; then
	        case "$theme" in
	            '')          theme_color='#8aadf4' ;; # Default: Blue
	            -Rosewater) theme_color='#f4dbd6' ;;
	            -Flamingo)  theme_color='#f0c6c6' ;;
	            -Pink)      theme_color='#f5bde6' ;;
	            -Mauve)     theme_color='#c6a0f6' ;;
	            -Red)       theme_color='#ed8796' ;;
	            -Maroon)    theme_color='#ee99a0' ;;
	            -Peach)     theme_color='#f5a97f' ;;
	            -Yellow)    theme_color='#eed49f' ;;
	            -Green)     theme_color='#a6da95' ;;
	            -Teal)      theme_color='#8bd5ca' ;;
	            -Sky)       theme_color='#91d7e3' ;;
	            -Sapphire)  theme_color='#7dc4e4' ;;
	            -Blue)      theme_color='#8aadf4' ;;
	            -Lavender)  theme_color='#b7bdf8' ;;
	        esac
	    else
	        # Latte (default light flavor)
	        case "$theme" in
	            '')          theme_color='#1e66f5' ;; # Default: Blue
	            -Rosewater) theme_color='#dc8a78' ;;
	            -Flamingo)  theme_color='#dd7878' ;;
	            -Pink)      theme_color='#ea76cb' ;;
	            -Mauve)     theme_color='#8839ef' ;;
	            -Red)       theme_color='#d20f39' ;;
	            -Maroon)    theme_color='#e64553' ;;
	            -Peach)     theme_color='#fe640b' ;;
	            -Yellow)    theme_color='#df8e1d' ;;
	            -Green)     theme_color='#40a02b' ;;
	            -Teal)      theme_color='#179299' ;;
	            -Sky)       theme_color='#04a5e5' ;;
	            -Sapphire)  theme_color='#209fb5' ;;
	            -Blue)      theme_color='#1e66f5' ;;
	            -Lavender)  theme_color='#7287fd' ;;
	        esac
	    fi
	fi


	if [[ "$blackness" == 'true' ]]; then
		case "$ctype" in
		'')
			background_light='#FFFFFF'
			background_dark='#0F0F0F'
			background_darker='#121212'
			background_alt='#212121'
			titlebar_light='#F2F2F2'
			titlebar_dark='#030303'
			;;
		-Frappe)
			background_light='#f8fafc'
			background_dark='#0d0e11'
			background_darker='#0f1115'
			background_alt='#1c1f26'
			titlebar_light='#f0f1f4'
			titlebar_dark='#020203'
			;;
		-Macchiato)
			background_light='#f9f9fb'
			background_dark='#0d0d11'
			background_darker='#0f1015'
			background_alt='#1c1e26'
			titlebar_light='#f0f1f4'
			titlebar_dark='#020203'
			;;
		esac
	else
		case "$ctype" in
		'')
			background_light='#FFFFFF'
			background_dark='#2C2C2C'
			background_darker='#3C3C3C'
			background_alt='#464646'
			titlebar_light='#F2F2F2'
			titlebar_dark='#242424'
			;;
		-Frappe)
			background_light='#f8fafc'
			background_dark='#242932'
			background_darker='#333a47'
			background_alt='#3a4150'
			titlebar_light='#f0f1f4'
			titlebar_dark='#1e222a'
			;;
		-Macchiato)
			background_light='#f9f9fb'
			background_dark='#242632'
			background_darker='#343746'
			background_alt='#3c3f51'
			titlebar_light='#f0f1f4'
			titlebar_dark='#1f2029'
			;;
		esac
	fi

	mkdir -p "${THEME_DIR}/gtk-2.0"

	cp -r "${GTKRC_DIR}/gtkrc${ELSE_DARK:-}-default" "${THEME_DIR}/gtk-2.0/gtkrc"
	sed -i "s/#FFFFFF/${background_light}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	sed -i "s/#2C2C2C/${background_dark}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	sed -i "s/#464646/${background_alt}/g" "${THEME_DIR}/gtk-2.0/gtkrc"

	if [[ "${color}" == '-Dark' ]]; then
		sed -i "s/#5b9bf8/${theme_color}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
		sed -i "s/#3C3C3C/${background_darker}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
		sed -i "s/#242424/${titlebar_dark}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	else
		sed -i "s/#3c84f7/${theme_color}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
		sed -i "s/#F2F2F2/${titlebar_light}/g" "${THEME_DIR}/gtk-2.0/gtkrc"
	fi
}
