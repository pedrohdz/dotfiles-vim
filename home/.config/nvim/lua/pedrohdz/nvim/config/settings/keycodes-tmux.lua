-- ----------------------------------------------------------------------------
-- NeoVim
-- - The NeoVim ticket:
--      https://github.com/neovim/neovim/issues/7384
-- - Built in terminfo.  Handy for finding what key codes map to what keys in
--   Neovim:
--      https://github.com/neovim/neovim/blob/master/src/nvim/tui/terminfo_defs.h
-- - terminal codes and keycodes (<CR>, <Esc>, ...):
--      https://neovim.io/doc/user/intro.html#keycodes
-- - nvim_replace_termcodes(), might come in handy?
--      https://neovim.io/doc/user/api.html#nvim_replace_termcodes()
-- - NeoVim information on internal terminal 
--      https://neovim.io/doc/user/term.html#tui-input:
--
-- ----
-- - XTerm Control Sequences
--      https://invisible-island.net/xterm/ctlseqs/ctlseqs.txt:
-- - Terminfo data
--      https://invisible-island.net/xterm/terminfo.html:
--
-- ----
-- WezTerm
-- - Might be able to fix this via WezTerm:
--      https://wezfurlong.org/wezterm/escape-sequences.html
--      https://wezfurlong.org/wezterm/config/lua/keyassignment/SendString.html
-- - Setting `enable_csi_u_key_encoding` to `true` does not seem to work:
--      https://wezfurlong.org/wezterm/config/lua/config/enable_csi_u_key_encoding.html
--
-- ----
-- Old information from Vim:
--  - http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
--  - :help t_ku - for a list of Vim internal keycodes.
--  - :help termcap - other terminal information.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- To get the terminal key codes and other information:
--  ```
--  infocmp -1
--  ```
--
-- To show the codes for the pressed keys:
--  ```
--  showkey
--
--  # Or
--  cat > /dev/null
--  ```
--
-- This MIGHT be a way of sending escape codes to the terminal:
--  ```
--  echo -ne '\e[?1049$p'; cat
--  ```
--
-- ----------------------------------------------------------------------------

local function map(key, set)
  vim.api.nvim_set_keymap('', key, set, {
    noremap = false,
    nowait = true,
  })
end

-- TODO - Come up with a better long term solution.
--
-- Use the following and `showkey` to figure out the mappings:
--  - https://github.com/neovim/neovim/blob/master/src/nvim/tui/terminfo_defs.h
if vim.list_contains({ 'xterm-256color', 'tmux-256color' }, vim.env.TERM) then
  map('<F13>', '<S-F1>')
  map('<F14>', '<S-F2>')
  map('<F15>', '<S-F3>')
  map('<F16>', '<S-F4>')
end


-- ----------------------------------------------------------------------------
-- Old Vim solution
-- ----------------------------------------------------------------------------
-- vim.cmd([[
--   if !has("gui_running")
--     if &term == "screen" || &term == "screen-256color"
--       set <S-F1>=[25~
--       set <S-F2>=[26~
--       set <S-F3>=[28~
--       set <S-F4>=[29~
--       set <S-F5>=[31~
--       set <S-F6>=[32~
--       set <S-F7>=[33~
--       set <S-F8>=[34~
--       " The following needs to be mapped in iTerm2 and beyond.
--       "set <S-F9>=
--       "set <S-F10>=
--       "set <S-F11>=
--       "set <S-F12>=
--
--     elseif &term == "xterm-256color" || &term == "xterm"
--       set <S-F1>=[1;2P
--       set <S-F2>=[1;2Q
--       set <S-F3>=[1;2R
--       set <S-F4>=[1;2S
--       set <S-F5>=[15;2~
--       set <S-F6>=[17;2~
--       set <S-F7>=[18;2~
--       set <S-F8>=[19;2~
--       set <S-F9>=[20;2~
--       set <S-F10>=[21;2~
--       set <S-F11>=[23;2~
--       set <S-F12>=[24;2~
--     endif
--   endif
-- ]])
