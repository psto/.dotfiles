# dotfiles

> A man's `$HOME` is his castle.

All my configs in one place. Use them at your own risk 😉

## Installation 

Requirements: `git` and `stow`.

Clone into your `$HOME` directory.

```bash
git clone https://github.com/psto/.dotfiles.git ~
```

Run `stow` to symlink everything

```bash
stow */ # (the '/' ignores the README)
```

Or just select what you want

```bash
stow nvim # neovim config only
```

## Programs

The `programs` directory contains an updated list of software I use.

## License

MIT
