```
  Git History                      :  https://github.com/DonJayamanne/gitHistoryVSCode
  Draw.io Integration              :  https://github.com/hediet/vscode-drawio
  Drawio Preview                   :  https://github.com/purocean/vscode-drawio-preview
  SystemVerilog - Language Support :  https://github.com/eirikpre/VSCode-SystemVerilog
  TerosHDL		                     :  https://github.com/TerosTechnology/vscode-terosHDL
  Git Graph                        :  https://github.com/mhutchie/vscode-git-graph
  Material Icon Theme              :  https://github.com/material-extensions/vscode-material-icon-theme
  Linux Themes for VS Code         :  https://github.com/rdnlsmith/vscode-linux-themes
```



{
  // Genel Editör Ayarları
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "editor.rulers": [100],
  "editor.formatOnSave": true,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,

  // Verilog / SystemVerilog Ayarları
  "[verilog]": {
    "editor.defaultFormatter": "mshr-h.VerilogHDL",
    "editor.formatOnSave": true
  },
  "[systemverilog]": {
    "editor.defaultFormatter": "mshr-h.VerilogHDL",
    "editor.formatOnSave": true
  },

  // Verilog-HDL Extension (mshr-h) Ayarları
  "verilog.formatCommand": "verible-verilog-format",
  "verilog.formatArgs": [
    "--indentation_spaces=2",
    "--max_search_distance=1000",
    "--wrap_spaces=0",
    "--line_length=100",
    "--min_space_between=1",
    "--alignment_style=preserve",
    "--format_alignment=align"
  ],

  "verilog.linting.linter": "verible",
  "verilog.linting.verible.veriblePath": "/home/kullaniciadi/tools/verible/bin/verible-verilog-lint",
  "verilog.linting.run": "onType",  // veya "onSave" tercihine göre

  // Terminal & Path Uyumları (eğer gerekiyorsa)
  "terminal.integrated.env.linux": {
    "PATH": "$HOME/tools/verible/bin:${env:"verilog.linting.verible.veriblePath": "BURAYA_YOL"





