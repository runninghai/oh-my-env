install:
	ln -s ${CODEPATH}/git/oh-my-env/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml
	ln -s ${CODEPATH}/git/oh-my-env/nvim ${HOME}/.config/nvim
	ln -s ${CODEPATH}/git/oh-my-env/tmux ${HOME}/.tmux.conf

clean:
	rm ${HOME}/.config/alacritty/alacritty.yml
	rm ${HOME}/.config/nvim
	rm ${HOME}/.tmux.conf

.PHONY: install
