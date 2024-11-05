#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | xmenu-openfile.sh                                                          |
# +----------------------------------------------------------------------------+
# |       Usage: ---                                                           |
# | Description: Wrapper script to open files using xdg-open                   |
# |    Requires: ---                                                           |
# |       Notes: ---                                                           |
# |      Author: Waldemar Schroeer                                             |
# |     Company: Rechenzentrum Amper                                           |
# |     Version: 3                                                             |
# |     Created: 30.11.2023                                                    |
# |    Revision: ---                                                           |
# |                                                                            |
# | Copyright © 2023 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

/usr/bin/xdg-open $(zenity --file-selection)
exit 0

# +----- End ------------------------------------------------------------------+
