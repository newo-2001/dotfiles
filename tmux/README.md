# tmux cheatsheet
Leader is `<C-a>`.
Sessions and windows start counting from 1.

## General
| Chord / Command | Action 
| ----- | ----- |
| `<Leader> :` | Open command window |
| `<Leader> w` | Show sessions and **w**indows |

## Sessions
| Chord / Command | Action |
| ----- | ----- |
| `tmux [-s <name>]` | Create a new session |
| `:new [-s <name>]` | Creates a new session from within a tmux session |
| `tmux a` | **A**ttach to last session |
| `tmux a -t <name>` | **A**ttach to the session with the given name |
| `:kill-session` | Kill the active session |
| `<Leader> (` | Next session |
| `<Leader> )` | Previous session |
| `<Leader> d` | **D**etach from the current session |
| `<Leader> $` | Rename current session |

## Windows
| Chord / Command | Action |
| ----- | ----- |
| `<Leader> c` | **C**reate window |
| `<Leader> ,` | Rename current window |
| `<Leader> &` | Close current window |
| `<Leader> n` | **N**ext window |
| `<Leader> p` | **P**revious window |
| `<Leader> <0-9>` | Select window with give number |
| `<Leader> <Space>` | Toggle last active window |
