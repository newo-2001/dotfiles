# Custom Neovim Cheatsheet
Leader is `\`.

## Mappings
| Chord | Context | Action |
| ----- | ----- | ----- |
| `<Leader>ff` | Normal | **F**ind **f**ile |
| `<Leader>fh` | Normal | **F**ind **h**idden file |
| `<Leader>fr` | Normal | **F**ind **r**ecent file |
| `<Leader>fg` | Normal | **F**ind **g**rep (find in text)|
| `<Leader>fi` | Normal | **F**ind (nerd font) **i**con|
| `<Leader>cd` | Normal | Open **c**hange **d**irectory menu using zoxide |
| `<Leader>gd` | Normal | **G**o to symbol **d**efinition |
| `<Leader>ca` | Normal | Open **c**ode **a**ctions menu |
| `<Leader>dd` | Normal | **D**isplay **d**iagnostic |
| `<Leader>dn` | Normal | **N**ext **d**iagnostic |
| `<Leader>dp` | Normal | **P**revious **d**iagnostic |
| `<Leader>hp` | Normal | **P**review git **h**unk |
| `<Leader>hs` | Normal | **S**tage git **h**unk |
| `<Leader>hu` | Normal | **U**ndo git **h**unk |
| `<Leader>tt` | Normal | **T**oggle **t**erminal |
| `<Leader>ll` | Normal | **L**aTeX **L**ive preview |
| `<Leader>li` | Normal | **L**aTeX debug **i**nfo |
| `<Leader>lq` | Normal | **L**aTeX **l**og |
| `<Leader>lc` | Normal | **L**aTeX **c**lean |
| `<C-t>` | Normal | Toggle file **t**ree |
| `<C-k>` | Normal | Show function signature |
| `<C-w> v` | Normal | Create **v**ertical split |
| `<C-w> s` | Normal | Create horizontal **s**plit |
| `<C-w> <Arrow>` | Normal | Move active window along the selected axis (also works for `hjkl`) |
| `<C-w> w` | Normal | Cycle through **w**indows |
| `<C-w> x` | Normal | Rotate window locations |
| `<C-Enter>` | Insert | Focus autocomplete menu |

## Commands
| Command | Action |
| ----- | ------ |
| `:messages` | Show startup errors |
| `:MarkdownPreview` | Live preview current markdown file in browser |
| `:Lazy` | Open plugin manager |
| `:LspInfo` | Show status of the currently active language servers |
| `:LspLog` | Open language server error log |
| `:Inspect` | View the source of the color under the cursor |
| `:q` | Close current window |
| `:q!` | Force close current window |
| `:w` | Save changes |
| `:wq` | Save changes and close window |
| `:cd` | Change root directory for session |
