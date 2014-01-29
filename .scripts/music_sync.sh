#! /bin/bash

# rsync music from trace to inverse
# doin it the sloppy way because the clean way is too tedious

# FIXME rsync doesn't correctly handle non-ascii characters in filenames (sorry bjork and sigur ros, or any artist/song title containing an accent/umlaut/tilde)
#/usr/bin/nice -n 20 /usr/bin/rsync --rsh="/usr/bin/ssh -l rsyncer -i /Users/cole/.ssh/id_rsa_nopass -oPreferredAuthentications=publickey -oBatchMode=yes" --progress --recursive --links --times --delete-after rsyncer@trace:/music/ /Users/cole/Music/SynchedMusic

# FIXME much better than the above, but still breaks on (greek letter mu), (pound sterling sign) and (a with umlauts)
#/usr/bin/nice -n 20 /opt/local/bin/rsync --rsh="/usr/bin/ssh -l rsyncer -i /Users/cole/.ssh/id_rsa_nopass -oPreferredAuthentications=publickey -oBatchMode=yes" --progress --recursive --links --times --delete-after --iconv=UTF-8-MAC,UTF-8 rsyncer@trace:/music/ /Users/cole/Music/SynchedMusic

# FIXME 
/usr/bin/nice -n 20 /usr/local/bin/rsync --rsh="/usr/bin/ssh -l rsyncer -i /Users/cole/.ssh/id_rsa_nopass -oPreferredAuthentications=publickey -oBatchMode=yes" --progress --recursive --links --times --delete-after --iconv=UTF-8-MAC,UTF-8 rsyncer@trace:/music/ /Users/cole/Music/SynchedMusic
