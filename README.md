# Terminal Workspace

Switch between project sessions with a popup selector.

```
┌─────────────────────────────────────────────┐
│ Session: "terminal-view"                    │
│  Tabs: [editor] [server] [tests]            │
│  ┌─────────────────────────────────────────┐│
│  │                                         ││
│  │        ┌──────────────┐                 ││
│  │        │ Projects     │ ← Ctrl+p        ││
│  │        │ > term-view  │                 ││
│  │        │   md-viewer  │                 ││
│  │        │   openspec   │                 ││
│  │        └──────────────┘                 ││
│  │                                         ││
│  └─────────────────────────────────────────┘│
└─────────────────────────────────────────────┘
```

Each project is a separate tmux session with its own tabs. Press `Ctrl+p` to switch.

## Install

```bash
brew install tmux fzf yq
```

## Usage

```bash
./bin/workspace
```

| Key | Action |
|-----|--------|
| `Ctrl+p` | Switch project |
| `Ctrl+Space c` | New tab |
| `Ctrl+Space n/p` | Next/prev tab |
| `Ctrl+Space 1-9` | Jump to tab |

## Configure

Edit `config/projects.yml`:

```yaml
projects:
  - name: "my-app"
    path: "/path/to/my-app"
```
