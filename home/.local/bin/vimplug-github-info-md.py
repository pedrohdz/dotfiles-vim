#! /usr/bin/env python3
"""
Takes an input file containing Vim plugin names and expands it a MarkDown list.

Example input `plugins.txt`:
    ```
    folke/which-key.nvim
    sudormrfbin/cheatsheet.nvim
    neovim/nvim-lspconfig
    ```

Then run:
    ```
    vimplug-github-info-md.py plugins.txt
    # or
    cat plugins.txt | vimplug-github-info-md.py plugins.txt
    ```

Would generate:
    ```
    - [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - 💥   Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
    - [sudormrfbin/cheatsheet.nvim](https://github.com/sudormrfbin/cheatsheet.nvim) - A cheatsheet plugin for neovim with bundled cheatsheets for the editor, multiple vim plugins, nerd-fonts, regex, etc. with a Telescope fuzzy finder interface !
    - [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP
    ```

Remeber to set the `GITHUB_TOKEN` environment variable to avoid `rate limit
exceeded`.
    export GITHUB_TOKEN='CHANGE_ME'
"""

from urllib.error import HTTPError as HTTPError
import fileinput
import json
import os
import sys
import urllib.request

GITHUB_URL = 'https://api.github.com/repos/'

def main():
    # Headers
    headers = {'Accept': 'application/vnd.github+json'}
    github_token = os.getenv('GITHUB_TOKEN')
    if github_token:
        headers['Authorization'] = 'token {}'.format(github_token)
    else:
        print_stderr('Warning - "GITHUB_TOKEN" environment variable not set.')

    for line in fileinput.input():
        project = line.rstrip()
        if not project:
            print()
            continue

        # Fetch
        req = urllib.request.Request(url=GITHUB_URL + project, headers=headers)
        try:
            contents = urllib.request.urlopen(req)
        except HTTPError as err:
            if err.code == 404:
                print('- {}: FIXME!!  Not found on GitHub!')
            else:
                raise

        # Print
        data = json.loads(contents.read())
        print('- [{full_name}]({html_url}): {description}'.format(**data))


def print_stderr(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


if __name__ == '__main__':
    main()
