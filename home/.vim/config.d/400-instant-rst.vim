"----
" InstantRst
"   - https://github.com/Rykka/InstantRst
"   - https://github.com/rykka/instant-rst.py
"----
let instant_rst_site=fnamemodify(expand("$MYVIMRC"), ":p:h") . '/.vim/sites/instant-rst'
let g:instant_rst_template=instant_rst_site . '/templates'
let g:instant_rst_static=instant_rst_site . '/static'
let g:instant_rst_port=8888
let g:instant_rst_localhost_only=1
let g:instant_rst_bind_scroll=1
