" For more information:
"    - http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
"    - :help t_ku - for a list of Vim internal keycodes.
"    - :help termcap - other terminal information.

if !has("gui_running")
  if &term == "screen" || &term == "screen-256color"
    set <S-F1>=[25~
    set <S-F2>=[26~
    set <S-F3>=[28~
    set <S-F4>=[29~
    set <S-F5>=[31~
    set <S-F6>=[32~
    set <S-F7>=[33~
    set <S-F8>=[34~
    " The following needs to be mapped in iTerm2 and beyond.
    "set <S-F9>=
    "set <S-F10>=
    "set <S-F11>=
    "set <S-F12>=

  elseif &term == "xterm-256color" || &term == "xterm"
    set <S-F1>=[1;2P
    set <S-F2>=[1;2Q
    set <S-F3>=[1;2R
    set <S-F4>=[1;2S
    set <S-F5>=[15;2~
    set <S-F6>=[17;2~
    set <S-F7>=[18;2~
    set <S-F8>=[19;2~
    set <S-F9>=[20;2~
    set <S-F10>=[21;2~
    set <S-F11>=[23;2~
    set <S-F12>=[24;2~
  endif
endif

