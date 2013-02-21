#! /bin/bash

cd $HOME
filelist=`find .dotfiles -mindepth 1 -maxdepth 1 -not -name .git`

dotfile_bkp_dir=".dotfile_bak"

if [[ ! -d $dotfile_bkp_dir ]]; then
	mkdir $dotfile_bkp_dir
fi

for true_dotfile in $filelist; do
	if [[ `basename $true_dotfile` == `basename $0` ]]; then
		# don't symlink yourself
		continue
	fi

	symlink_dotfile=`echo $true_dotfile | sed 's,\\.dotfiles/,,g'`
	old_dotfile=$symlink_dotfile
	if [[ ! -h $symlink_dotfile ]]; then
		if [[ -e $old_dotfile ]]; then
			mv $old_dotfile $dotfile_bkp_dir
		fi

		ln -sf $true_dotfile $symlink_dotfile
		if [[ $? -ne 0 ]]; then
			echo "failed to symlink $symlink_dotfile to $true_dotfile"
		fi
	fi
done

