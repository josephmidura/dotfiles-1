#!/bin/sh

# TODO : Delete symlinks to deleted files
# Is this where rsync shines?
# TODO - add support for -f and --force
link () {
	echo "This utility will symlink the files in this repo to the home directory"
	echo "Proceed? (y/n)"
	read resp
	# TODO - regex here?
	if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
		for file in $( ls -A | grep -vE '\.exclude*|\.git|\.gitignore|.*.md' ) ; do
			ln -sv "$PWD/$file" "$HOME"
		done
		echo "Symlinking complete"
	else
		echo "Symlinking cancelled by user"
		return 1
	fi
}

install_tools () {
	if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
		echo "This utility will install useful utilities using brew"
		echo "Proceed? (y/n)"
		read resp
		# TODO - regex here?
		if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
			echo "Installing useful stuff using brew. This may take a while..."
			sh brew.exclude.sh
		else
			echo "Brew installation cancelled by user" && return 1
		fi
	else
		echo "Skipping installations using Homebrew because MacOS was not detected..."
	fi
}

link
install_tools