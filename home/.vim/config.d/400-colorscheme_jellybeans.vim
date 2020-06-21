let g:jellybeans_use_term_italics = 0
" let g:jellybeans_use_lowcolor_black = 1


" `background` set to allow transparent backgrounds, image backgrounds, or a
" different color) instead of the background color that Jellybeans applies.
"
"   - https://github.com/nanotech/jellybeans.vim#terminal-background
"
let g:jellybeans_overrides = {
    \ 'background': { 'guibg': 'none', 'ctermbg': 'none', '256ctermbg': 'none' },
    \ }
