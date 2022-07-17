#!/usr/bin/env bash
#
# +----------------------------------------------------------------------------+
# | slock_set_uid.sh                                                           |
# +----------------------------------------------------------------------------+
# | Copyright © 2019 Waldemar Schroeer                                         |
# |                  waldemar.schroeer(at)rz-amper.de                          |
# +----------------------------------------------------------------------------+

sudo chown root:root ~/.local/bin/slock
sudo chmod u+s ~/.local/bin/slock

exit 0
