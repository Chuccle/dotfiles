all: 
		# as of now, "dot-"" prefix doesn't work with dirs i.e:"~/.config/"
		stow --verbose --dotfiles --target=$$HOME --restow */

delete:
		stow --verbose --target=$$HOME --delete */