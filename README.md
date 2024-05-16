# dotfiles-vim

My NeoVim configuration dot files.


## Upgrade/update cheetsheet

Packer:
```vim
:PackerSnapshot ~/.homesick/repos/dotfiles-vim/vim-plug-snapshot.vim
:PackerClean
:PackerSync --preview
:PackerSync
:PackerStatus
```

nvim-treesitter:
```vim
:TSUpdate
```

Mason/LSPs:
```vim
:Mason
:MasonLog
```


## Appendix

- [Reference material](docs/reference.md)


### History

Consolidation of my old *Vim* *dotfiles*:

- [dr-vimfiles](https://github.com/pedrohdz/dr-vimfiles)
- [dr-vimfiles-devops](https://github.com/pedrohdz/dr-vimfiles-devops)
- [dr-vimfiles-python](https://github.com/pedrohdz/dr-vimfiles-python)
- [dr-vimfiles-nodejs](https://github.com/pedrohdz/dr-vimfiles-nodejs)
