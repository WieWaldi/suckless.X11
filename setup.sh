#!/bin/sh
#
# +-------------------------------------------------------------------------+
# | Setup for .dotfiles                                                     |
# +-------------------------------------------------------------------------+
# | Copyright © 1996-2019 Waldemar Schroeer                                 |
# |                       lassmichinruhe@rz-amper.de                        |
# +-------------------------------------------------------------------------+

make=/bin/make        

while :
do
    printf "\n\n Install Desktop and Suckless Tolls? >> "
    read antwoord
    case $antwoord in
        [yY] | [yY][Ee][Ss] )
            printf "\n Installing Desktop and Suckless Tools to your home directory."
            declare -a sucklesstools=( "dwm" "dmenu" "st" "slock" )
            for i in "${sucklesstools[@]}"
            do
                cd ~/.dotfiles/suckless/$i
                $make clean install
                $make clean
            done
            cd ~/.dotfiles/suckless/dwm
            cp -r ~/.dotfiles/.fonts ~/.fonts
            break
            ;;
        [nN] | [n|N][O|o] )
            printf "\n Oh Boy, you should reconsider your decision."
            break
            ;;
        *)
            printf "\n Wut?\n\n"
    esac
done


printf "\n\n I'm done\n\n"
exit 0
