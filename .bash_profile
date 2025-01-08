#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#Prevent flickering using NVIDIA dedicated GPU
export WLR_DRM_DEVICES=/dev/dri/card1:/dev/dri/card2
# allow hotplugging
# export WLR_NO_HARDWARE_CURSORS=1
# export WLR_DRM_NO_MODIFIERS=1
export WLR_RENDERER=vulkan

# claude told me so
# export LIBVA_DRIVER_NAME=nvidia
# export GBM_BACKEND=nvidia-drm
# export __GLX_VENDOR_LIBRARY_NAME=nvidia

#for IME support
export XMODIFIERS=@im=fcitx
# export QT_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

export XDG_CURRENT_DESKTOP=sway

export EDITOR="/bin/nvim"

# if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
# 	exec sway --unsupported-gpu
# fi


# Added by Toolbox App
export PATH="$PATH:/home/seabert/.local/share/JetBrains/Toolbox/scripts"

# allow nvm to work
source /usr/share/nvm/init-nvm.sh

. "$HOME/.cargo/env"
