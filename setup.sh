#!/bin/sh
#
# +-------------------------------------------------------------------------+
# | Setup for suckless.X11 tools                                            |
# +-------------------------------------------------------------------------+
# | Copyright © 1996-2019 Waldemar Schroeer                                 |
# |                       lassmichinruhe@rz-amper.de                        |
# +-------------------------------------------------------------------------+

make=/bin/make        
cdir=$(pwd)

while :
do
    printf "\n\n Install Desktop and Suckless Tolls? >> "
    read antwoord
    case $antwoord in
        [yY] | [yY][Ee][Ss] )
            printf "\n Installing Desktop and Suckless Tools to your home directory.\n"
            declare -a sucklesstools=( "dwm" "dmenu" "st" "slock" "surf" )
            for i in "${sucklesstools[@]}"
            do
                cd ${cdir}/${i}
                $make clean install
                $make clean
            done
            declare -a Xres=( ".Xresources" ".xinitrc" ".slocktext" ".fonts" )
            for i in "${Xres[@]}"
            do
                cd ${cdir}
                cp -r ${cdir}/${i} ~
            done
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
