{ rust-analyzer }:
{
  "C_Cpp.clang_format_fallbackStyle" = "WebKit";
  "[c]" = {
    "editor.formatOnSave" = false;
    "editor.insertSpaces" = false;
    "editor.tabSize" = 8;
    "editor.useTabStops" = true;
  };
  "[css]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[handlebars]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[haskell]" = { "editor.defaultFormatter" = "haskell.haskell"; };
  "[html]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[java]" = { "editor.suggest.snippetsPreventQuickSuggestions" = false; };
  "[javascript]" = {
    "editor.defaultFormatter" = null;
    "editor.formatOnSave" = true;
  };
  "[javascriptreact]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "[json]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[jsonc]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[latex]" = { "editor.defaultFormatter" = "nickfode.latex-formatter"; };
  "[makefile]" = { "editor.insertSpaces" = false; };
  "[markdown]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.formatOnSave" = false;
  };
  "[python]" = { "editor.formatOnType" = true; };
  "[rust]" = {
    "editor.defaultFormatter" = "rust-lang.rust-analyzer";
    "editor.semanticHighlighting.enabled" = true;
  };
  "[typescript]" = {
    "editor.defaultFormatter" = "denoland.vscode-deno";
    "editor.formatOnSave" = true;
  };
  "[typescriptreact]" = {
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
  };
  "calva.highlight.matchedBracketStyle" = { };
  "calva.paredit.defaultKeyMap" = "original";
  "calva.prettyPrintingOptions" = {
    enabled = true;
    maxLength = 50;
    printEngine = "pprint";
    width = 120;
  };
  "dafny.verificationTimeLimit" = 3600;
  "dafny.verificationVirtualCores" = 0;
  "debug.internalConsoleOptions" = "neverOpen";
  "docker.commands.attach" =
    "$${config:docker.dockerPath} exec -it $${containerId} $${shellCommand}";
  "editor.acceptSuggestionOnCommitCharacter" = false;
  "editor.autoIndent" = "advanced";
  "editor.bracketPairColorization.enabled" = true;
  "editor.cursorBlinking" = "solid";
  "editor.cursorSmoothCaretAnimation" = "on";
  "editor.cursorStyle" = "line";
  "editor.defaultFormatter" = "denoland.vscode-deno";
  "editor.fontFamily" = "JetBrainsMono Nerd Font";
  "editor.fontLigatures" = true;
  "editor.fontSize" = 16;
  "editor.formatOnSave" = true;
  "editor.inlayHints.enabled" = "offUnlessPressed";
  "editor.inlineSuggest.enabled" = true;
  "editor.insertSpaces" = true;
  "editor.lineNumbers" = "on";
  "editor.linkedEditing" = true;
  "editor.minimap.enabled" = false;
  "editor.minimap.showSlider" = "always";
  "editor.quickSuggestions" = {
    comments = "off";
    other = "on";
    strings = "on";
  };
  "editor.renderWhitespace" = "selection";
  "editor.rulers" = [ 80 100 ];
  "editor.stickyScroll.enabled" = true;
  "editor.suggest.localityBonus" = true;
  "editor.suggest.showStatusBar" = true;
  "editor.tabSize" = 4;
  "editor.unicodeHighlight.invisibleCharacters" = false;
  "editor.wordSeparators" = ''/\()"':,;<>~!@#$$%^&*|+=[]{}`?-'';
  "editor.wordWrap" = "off";
  "errorLens.excludeBySource" = [ "eslint(eqeqeq)" "ts(2551)" ];
  "files.associations" = {
    "*.h" = "c";
    "*.pl" = "prolog";
  };
  "files.eol" = "\n";
  "files.insertFinalNewline" = true;
  "files.watcherExclude" = {
    "**/.git/objects/**" = true;
    "**/.git/subtree-cache/**" = true;
    "**/.hg/store/**" = true;
    "**/node_modules/*/**" = true;
    "/target/**" = true;
  };
  "git.autofetch" = true;
  "git.confirmSync" = false;
  "git.enableSmartCommit" = true;
  "github.copilot.enable" = {
    "*" = true;
    markdown = false;
    plaintext = false;
    yaml = true;
  };
  "go.useLanguageServer" = true;
  "gruvboxMaterial.italicComments" = false;
  "haskell.formattingProvider" = "stylish-haskell";
  "haskell.ghcupExecutablePath" = "/home/mbk/.ghcup/bin/ghcup";
  "haskell.manageHLS" = "GHCup";
  "haskell.plugin.tactics.config.auto_gas" = 8;
  "idris.numbersOfContinuousTypechecking" = 50;
  "idris.warnPartial" = true;
  "latex-workshop.view.pdf.viewer" = "tab";
  "markdown.editor.pasteUrlAsFormattedLink.enabled" = "smart";
  "ocaml.server.extendedHover" = true;
  "oneDarkPro.italic" = false;
  "prettier.arrowParens" = "avoid";
  "prettier.tabWidth" = 4;
  "remote.extensionKind" = { "pub.name" = [ "ui" ]; };
  "ruby.codeCompletion" = "rcodetools";
  "ruby.format" = "prettier";
  "ruby.intellisense" = "rubyLocate";
  "rust-analyzer.server.path" = "${rust-analyzer}/bin/rust-analyzer";
  "rust-analyzer.checkOnSave.command" = "clippy";
  "rust-analyzer.checkOnSave.extraArgs" = [ "--" "-W" "clippy::pedantic" ];
  "rust-analyzer.debug.openDebugPane" = true;
  "rust-analyzer.inlayHints.closureReturnTypeHints.enable" = "always";
  "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "always";
  "rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames" = true;
  "rust-analyzer.inlayHints.maxLength" = null;
  "rust-analyzer.inlayHints.reborrowHints.enable" = "always";
  "rust-analyzer.lens.debug" = false;
  "rust-analyzer.lens.enable" = false;
  "rust-analyzer.lens.implementations" = false;
  "rust-analyzer.lens.run" = false;
  "security.workspace.trust.untrustedFiles" = "open";
  "settingsSync.ignoredExtensions" = [ ];
  "syntax.highlightLanguages" = [
    "c"
    "cpp"
    "python"
    "typescript"
    "typescriptreact"
    "javascript"
    "go"
    "rust"
    "php"
    "ruby"
    "shellscript"
    "ocaml"
    "lua"
  ];
  "terminal.integrated.commandsToSkipShell" = [ "-workbench.action.quickOpen" ];
  "terminal.integrated.defaultProfile.linux" = "fish";
  "terminal.integrated.fontSize" = 15;
  "terminal.integrated.scrollback" = 100000;
  "terminal.integrated.tabs.enabled" = true;
  "twind.debug" = true;
  "typescript.updateImportsOnFileMove.enabled" = "always";
  "vim.easymotion" = true;
  "vim.handleKeys" = { "<C-t>" = false; };
  "vim.highlightedyank.enable" = true;
  "vim.leader" = ";";
  "vim.normalModeKeyBindings" = [
    {
      after = [ "g" "j" ];
      before = [ "j" ];
    }
    {
      after = [ "g" "k" ];
      before = [ "k" ];
    }
    {
      after = [ "^" ];
      before = [ "0" ];
    }
    {
      before = [ "t" "j" ];
      commands = [ "workbench.action.nextEditor" ];
    }
    {
      before = [ "t" "k" ];
      commands = [ "workbench.action.previousEditor" ];
    }
    {
      before = [ "t" "w" ];
      commands = [ "workbench.action.closeActiveEditor" ];
    }
    {
      before = [ "f" "f" ];
      commands = [ "workbench.action.quickOpen" ];
    }
    {
      before = [ "f" "e" ];
      commands = [ "workbench.action.showAllEditorsByMostRecentlyUsed" ];
    }
    {
      before = [ "f" "s" ];
      commands = [ "workbench.action.gotoSymbol" ];
    }
    {
      before = [ "<leader>" "z" ];
      commands = [ "workbench.action.toggleZenMode" ];
    }
    {
      before = [ "<leader>" "w" ];
      commands = [ ":w" ];
    }
    {
      before = [ "<leader>" "q" ];
      commands = [ ":q" ];
    }
    {
      before = [ "<leader>" "d" ];
      commands = [ "editor.action.showHover" ];
    }
    {
      before = [ "<leader>" "f" ];
      commands = [ "editor.action.quickFix" ];
    }
    {
      before = [ "<leader>" "t" ];
      commands = [ "editor.action.peekTypeDefinition" ];
    }
    {
      before = [ "<leader>" "g" ];
      commands = [ "editor.action.revealDefinition" ];
    }
    {
      before = [ "<leader>" "c" ];
      commands = [ "rust-analyzer.run" ];
    }
    {
      before = [ "<leader>" "r" "n" ];
      commands = [ "editor.action.rename" ];
    }
    {
      before = [ "<c-j>" ];
      commands = [ "editor.action.marker.nextInFiles" ];
    }
    {
      before = [ "<c-k>" ];
      commands = [ "editor.action.marker.prevInFiles" ];
    }
    {
      before = [ "<leader>" "p" "c" ];
      commands = [ "picat.run.document" ];
    }
    {
      before = [ "<leader>" "s" "h" ];
      commands = [ "paredit.slurpSexpBackward" ];
    }
    {
      before = [ "<leader>" "s" "l" ];
      commands = [ "paredit.slurpSexpForward" ];
    }
    {
      before = [ "<leader>" "s" "w" "p" ];
      commands = [ "paredit.wrapAroundParens" ];
    }
    {
      before = [ "<leader>" "s" "w" "b" ];
      commands = [ "paredit.wrapAroundSquare" ];
    }
    {
      before = [ "<leader>" "s" "w" "c" ];
      commands = [ "paredit.wrapAroundCurly" ];
    }
    {
      before = [ "<leader>" "s" "w" "p" ];
      commands = [ "paredit.wrapAroundParens" ];
    }
    {
      before = [ "<leader>" "b" "h" ];
      commands = [ "paredit.barfSexpBackward" ];
    }
    {
      before = [ "<leader>" "b" "l" ];
      commands = [ "paredit.barfSexpForward" ];
    }
    {
      before = [ "<leader>" "s" "t" ];
      commands = [ "paredit.transpose" ];
    }
    {
      before = [ "<leader>" "s" "t" ];
      commands = [ "paredit.transpose" ];
    }
    {
      before = [ "<leader>" "s" "e" ];
      commands = [ "calva.evaluateCurrentTopLevelForm" ];
    }
    {
      before = [ "<leader>" "s" "s" ];
      commands = [ "calva.evaluateSelection" ];
    }
    {
      before = [ "<leader>" "s" "f" ];
      commands = [ "calva.sendCurrentFormToOutputWindow" ];
    }
    {
      before = [ "<leader>" "s" "o" ];
      commands = [ "calva.showOutputWindow" ];
    }
    {
      before = [ "<leader>" "i" "l" ];
      commands = [ "idris.make-lemma" ];
    }
    {
      before = [ "<leader>" "i" "f" "h" ];
      commands = [ "idris.proof-search" ];
    }
    {
      before = [ "<leader>" "i" "c" "s" ];
      commands = [ "idris.case-split" ];
    }
    {
      before = [ "<leader>" "i" "t" "c" ];
      commands = [ "idris.typecheck" ];
    }
    {
      before = [ "<leader>" "i" "m" ];
      commands = [ "idris.add-clause" ];
    }
  ];
  "vim.smartRelativeLine" = true;
  "vim.useSystemClipboard" = true;
  "window.autoDetectColorScheme" = true;
  "window.commandCenter" = false;
  "window.restoreWindows" = "none";
  "window.titleBarStyle" = "custom";
  "workbench.colorTheme" = "One Dark Pro Darker";
  "workbench.editor.enablePreview" = false;
  "workbench.editor.enablePreviewFromQuickOpen" = false;
  "workbench.editorAssociations" = { "*.jpg" = "imagePreview.previewEditor"; };
  "workbench.iconTheme" = "gruvbox-material-icon-theme";
  "workbench.layoutControl.enabled" = true;
  "workbench.layoutControl.type" = "both";
  "workbench.startupEditor" = "none";
  "zig.zigPath" = "";
  "zig.zls.enabled" = true;
  "zig.zls.path" =
    "/home/mbk/.config/Code/User/globalStorage/ziglang.vscode-zig/zls_install/zls";
}
