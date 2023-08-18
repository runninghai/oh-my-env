install:
	ln -s ${CODEPATH}/git/oh-my-env/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml
	ln -s ${CODEPATH}/git/oh-my-env/nvim ${HOME}/.config/nvim
	source ${CODEPATH}/git/oh-my-env/zsh

clean:
	rm ${HOME}/.config/alacritty/alacritty.yml
	rm ${HOME}/.config/nvim

.PHONY: install
