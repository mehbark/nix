''
{
    "workbench.editor.enablePreviewFromQuickOpen": false,
    "rust-analyzer.checkOnSave.command": "clippy",
    "workbench.editor.enablePreview": false,
    "[rust]": {
        "editor.semanticHighlighting.enabled": true,
        "editor.defaultFormatter": "rust-lang.rust-analyzer"
    },
    "[latex]": {
        "editor.defaultFormatter": "nickfode.latex-formatter"
    },
    "[python]": {
        "editor.formatOnType": true
    },
    "[makefile]": {
        "editor.insertSpaces": false
    },
    "[c]": {
        "editor.insertSpaces": false,
        "editor.tabSize": 8,
        "editor.useTabStops": true,
        "editor.formatOnSave": false
    },
    "editor.renderWhitespace": "selection",
    "[java]": {
        "editor.suggest.snippetsPreventQuickSuggestions": false
    },
    "editor.formatOnSave": true,
    "editor.acceptSuggestionOnCommitCharacter": false,
    "git.autofetch": true,
    "files.eol": "\n",
    "vim.handleKeys": {
        "<C-t>": false
    },
    "vim.leader": ";",
    "vim.normalModeKeyBindings": [
        {
            "before": ["j"],
            "after": ["g", "j"]
        },
        {
            "before": ["k"],
            "after": ["g", "k"]
        },
        {
            "before": ["0"],
            "after": ["^"]
        },
        {
            "before": ["t", "j"],
            "commands": ["workbench.action.nextEditor"]
        },
        {
            "before": ["t", "k"],
            "commands": ["workbench.action.previousEditor"]
        },
        {
            "before": ["t", "w"],
            "commands": ["workbench.action.closeActiveEditor"]
        },
        {
            "before": ["f", "f"],
            "commands": ["workbench.action.quickOpen"]
        },
        {
            "before": ["f", "e"],
            "commands": ["workbench.action.showAllEditorsByMostRecentlyUsed"]
        },
        {
            "before": ["f", "s"],
            "commands": ["workbench.action.gotoSymbol"]
        },
        {
            "before": ["<leader>", "z"],
            "commands": ["workbench.action.toggleZenMode"]
        },
        {
            "before": ["<leader>", "w"],
            "commands": [":w"]
        },
        {
            "before": ["<leader>", "q"],
            "commands": [":q"]
        },
        {
            "before": ["<leader>", "d"],
            "commands": ["editor.action.showHover"]
        },
        {
            "before": ["<leader>", "f"],
            "commands": ["editor.action.quickFix"]
        },
        {
            "before": ["<leader>", "t"],
            "commands": ["editor.action.peekTypeDefinition"]
        },
        {
            "before": ["<leader>", "g"],
            "commands": ["editor.action.revealDefinition"]
        },
        {
            "before": ["<leader>", "c"],
            "commands": ["rust-analyzer.run"]
        },
        {
            "before": ["<leader>", "r", "n"],
            "commands": ["editor.action.rename"]
        },
        {
            "before": ["<c-j>"],
            "commands": ["editor.action.marker.nextInFiles"]
        },
        {
            "before": ["<c-k>"],
            "commands": ["editor.action.marker.prevInFiles"]
        },
        {
            "before": ["<leader>", "p", "c"],
            "commands": ["picat.run.document"]
        },
        // clojure
        {
            "before": ["<leader>", "s", "h"],
            "commands": ["paredit.slurpSexpBackward"]
        },
        {
            "before": ["<leader>", "s", "l"],
            "commands": ["paredit.slurpSexpForward"]
        },
        {
            "before": ["<leader>", "s", "w", "p"],
            "commands": ["paredit.wrapAroundParens"]
        },
        {
            "before": ["<leader>", "s", "w", "b"],
            "commands": ["paredit.wrapAroundSquare"]
        },
        {
            "before": ["<leader>", "s", "w", "c"],
            "commands": ["paredit.wrapAroundCurly"]
        },
        {
            "before": ["<leader>", "s", "w", "p"],
            "commands": ["paredit.wrapAroundParens"]
        },
        {
            "before": ["<leader>", "b", "h"],
            "commands": ["paredit.barfSexpBackward"]
        },
        {
            "before": ["<leader>", "b", "l"],
            "commands": ["paredit.barfSexpForward"]
        },
        {
            "before": ["<leader>", "s", "t"],
            "commands": ["paredit.transpose"]
        },
        {
            "before": ["<leader>", "s", "t"],
            "commands": ["paredit.transpose"]
        },
        {
            "before": ["<leader>", "s", "e"],
            "commands": ["calva.evaluateCurrentTopLevelForm"]
        },
        {
            "before": ["<leader>", "s", "s"],
            "commands": ["calva.evaluateSelection"]
        },
        {
            "before": ["<leader>", "s", "f"],
            "commands": ["calva.sendCurrentFormToOutputWindow"]
        },
        {
            "before": ["<leader>", "s", "o"],
            "commands": ["calva.showOutputWindow"]
        },
        // idris
        {
            "before": ["<leader>", "i", "l"],
            "commands": ["idris.make-lemma"]
        },
        {
            "before": ["<leader>", "i", "f", "h"],
            "commands": ["idris.proof-search"]
        },
        {
            "before": ["<leader>", "i", "c", "s"],
            "commands": ["idris.case-split"]
        },
        {
            "before": ["<leader>", "i", "t", "c"],
            "commands": ["idris.typecheck"]
        },
        {
            "before": ["<leader>", "i", "m"],
            "commands": ["idris.add-clause"]
        }
    ],
    "vim.useSystemClipboard": true,
    "vim.easymotion": true,
    "vim.highlightedyank.enable": true,
    "vim.smartRelativeLine": true,
    "[jsonc]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "editor.fontFamily": "JetBrainsMono Nerd Font",
    // "editor.fontFamily": "IntelOne Mono",
    // "editor.fontFamily": "CMU Serif",
    // "editor.fontFamily": "JuliaMono",
    "editor.fontLigatures": true,
    "git.confirmSync": false,
    "terminal.integrated.scrollback": 100000,
    "go.useLanguageServer": true,
    "[javascript]": {
        "editor.defaultFormatter": null,
        "editor.formatOnSave": true
    },
    "terminal.integrated.commandsToSkipShell": ["-workbench.action.quickOpen"],
    "[typescript]": {
        "editor.formatOnSave": true,
        "editor.defaultFormatter": "denoland.vscode-deno"
    },
    "[json]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "editor.rulers": [80, 100],
    "git.enableSmartCommit": true,
    "typescript.updateImportsOnFileMove.enabled": "always",
    "[typescriptreact]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[html]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "terminal.integrated.tabs.enabled": true,
    "terminal.integrated.defaultProfile.linux": "fish",
    //"workbench.preferredDarkColorTheme": "GitHub Dark",
    //"workbench.preferredLightColorTheme": "GitHub Light",
    "editor.tabSize": 4,
    "editor.cursorStyle": "line",
    "editor.lineNumbers": "on",
    "editor.wordSeparators": "/\\()\"':,.;<>~!@#$%^&*|+=[]{}`?-",
    "editor.wordWrap": "off",
    "window.restoreWindows": "none",
    "editor.quickSuggestions": {
        "other": "on",
        "comments": "off",
        "strings": "on"
    },
    "window.autoDetectColorScheme": true,
    "files.watcherExclude": {
        "**/.git/objects/**": true,
        "**/.git/subtree-cache/**": true,
        "**/node_modules/*/**": true,
        "**/.hg/store/**": true,
        "/target/**": true
    },
    "editor.inlineSuggest.enabled": true,
    "github.copilot.enable": {
        "*": true,
        "yaml": true,
        "plaintext": false,
        "markdown": false
    },
    "editor.bracketPairColorization.enabled": true,
    "security.workspace.trust.untrustedFiles": "open",
    "editor.inlayHints.enabled": "offUnlessPressed",
    "rust-analyzer.lens.run": false,
    "rust-analyzer.lens.debug": false,
    "rust-analyzer.lens.implementations": false,
    "editor.cursorSmoothCaretAnimation": "on",
    "editor.cursorBlinking": "solid",
    "workbench.iconTheme": "gruvbox-material-icon-theme",
    "window.titleBarStyle": "custom",
    "workbench.layoutControl.enabled": true,
    "workbench.layoutControl.type": "both",
    "files.insertFinalNewline": true,
    "editor.insertSpaces": true,
    "oneDarkPro.italic": false,
    "latex-workshop.view.pdf.viewer": "tab",
    "[handlebars]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "editor.fontSize": 16,
    "settingsSync.ignoredExtensions": [],
    "syntax.highlightLanguages": [
        "c",
        "cpp",
        "python",
        "typescript",
        "typescriptreact",
        "javascript",
        "go",
        "rust",
        "php",
        "ruby",
        "shellscript",
        "ocaml",
        "lua"
    ],
    "editor.suggest.localityBonus": true,
    // "rust-analyzer.inlayHints.chainingHints.enable": false,
    // "rust-analyzer.inlayHints.parameterHints.enable": false,
    // "rust-analyzer.inlayHints.typeHints.enable": false,
    "[css]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[markdown]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": false
    },
    "prettier.arrowParens": "avoid",
    "prettier.tabWidth": 4,
    "rust-analyzer.lens.enable": false,
    "workbench.startupEditor": "none",
    "workbench.editorAssociations": {
        "*.jpg": "imagePreview.previewEditor"
    },
    "gruvboxMaterial.italicComments": false,
    "rust-analyzer.inlayHints.maxLength": null,
    "rust-analyzer.debug.openDebugPane": true,
    "rust-analyzer.inlayHints.closureReturnTypeHints.enable": "always",
    "rust-analyzer.inlayHints.lifetimeElisionHints.enable": "always",
    "rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames": true,
    "rust-analyzer.inlayHints.reborrowHints.enable": "always",
    "rust-analyzer.checkOnSave.extraArgs": ["--", "-W", "clippy::pedantic"],
    "editor.unicodeHighlight.invisibleCharacters": false,
    "remote.extensionKind": {
        "pub.name": ["ui"]
    },
    "docker.commands.attach": "$${config:docker.dockerPath} exec -it $${containerId} $${shellCommand}",
    "C_Cpp.clang_format_fallbackStyle": "WebKit",
    "editor.stickyScroll.enabled": true,
    "workbench.colorTheme": "One Dark Pro Darker",
    "files.associations": {
        "*.h": "c",
        "*.pl": "prolog"
    },
    "editor.minimap.showSlider": "always",
    "haskell.formattingProvider": "stylish-haskell",
    "editor.minimap.enabled": false,
    "[haskell]": {
        "editor.defaultFormatter": "haskell.haskell"
    },
    "calva.highlight.matchedBracketStyle": {},
    "calva.paredit.defaultKeyMap": "original",
    "editor.autoIndent": "advanced",
    "calva.prettyPrintingOptions": {
        "printEngine": "pprint",
        "enabled": true,
        "width": 120,
        "maxLength": 50
    },
    "[javascriptreact]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "errorLens.excludeBySource": ["eslint(eqeqeq)", "ts(2551)"],
    "terminal.integrated.fontSize": 15,
    "dafny.verificationTimeLimit": 3600,
    "dafny.verificationVirtualCores": 0,
    "editor.defaultFormatter": "denoland.vscode-deno",
    "haskell.manageHLS": "GHCup",
    "haskell.ghcupExecutablePath": "/home/mbk/.ghcup/bin/ghcup",
    "haskell.plugin.tactics.config.auto_gas": 8,
    "markdown.editor.pasteUrlAsFormattedLink.enabled": "smart",
    "ocaml.server.extendedHover": true,
    "idris.warnPartial": true,
    "idris.numbersOfContinuousTypechecking": 50,
    "zig.zigPath": "",
    "debug.internalConsoleOptions": "neverOpen",
    "zig.zls.enabled": true,
    "zig.zls.path": "/home/mbk/.config/Code/User/globalStorage/ziglang.vscode-zig/zls_install/zls",
    "ruby.codeCompletion": "rcodetools",
    "ruby.intellisense": "rubyLocate",
    "ruby.format": "prettier",
    "window.commandCenter": false,
    "editor.suggest.showStatusBar": true,
    "twind.debug": true
}
''
