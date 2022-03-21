" Notes {
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc of Carsten Seeger.
"
"   Copyright 2022 Carsten Seeger
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }

" Environment {

  " Defaults {
      set nocompatible  " be iMproved, required
      set shell=/bin/sh
  " }

"}

" Use before config if available {

  if filereadable(expand("~/.vimrc.before"))
      source ~/.vimrc.before
  endif

" }

" Use bundles config {

  filetype off          " required
  if filereadable(expand("~/.vimrc.bundles"))
      source ~/.vimrc.bundles
  endif

" }

" General {

  set background=dark " Assume a dark background

  " Allow to trigger background
  function! ToggleBG()
      let s:tbg = &background
      " Inversion
      if s:tbg == "dark"
          set background=light
      else
          set background=dark
      endif
  endfunction
  noremap <leader>bg :call ToggleBG()<CR>

  filetype plugin indent on
  syntax on                                       "Syntax highlighing
  set mouse=a                                     " Automatically enable mouse usage
  set mousehide                                   " Hide the mouse cursor while typing
  scriptencoding utf-8
  set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set virtualedit=onemore                         " Allow for cursor beyond last character
  set history=1000                                " Store a ton of history (default is 20)
  set completeopt=longest,menuone
  set paste!
  set spell                                       " Spell checking on
  set hidden                                      " Allow buffer switching without saving

  " ui {

    set showmode                    " Display the current mode
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                                           " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)  " format it  
        set showcmd                                         " Show partial commands in status line and selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

  " }

  " formatting {

    set tabpagemax=15               " Only show 15 tabs
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 2 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

    autocmd FileType tex setlocal spell spelllang=en_us
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer>
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

  " }

  " key mappings {

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

  " }

  " plugins {

    " golang {

      let g:go_fmt_command = "goimports"
      let g:go_def_mode='gopls'
      let g:go_info_mode='gopls'
      let g:go_highlight_functions = 1
      let g:go_highlight_methods = 1
      let g:go_highlight_structs = 1
      let g:go_highlight_operators = 1
      let g:go_highlight_build_constraints = 1

    " }

    " ycm {

      let g:ycm_server_log_level = 'error'
      let g:ycm_server_keep_logfiles = 1
      let g:ycm_server_use_vim_stdout = 0

      let g:acp_enableAtStartup = 0

      " enable completion from tags
      let g:ycm_collect_identifiers_from_tags_files = 1

      " remap Ultisnips for compatibility for YCM
      let g:UltiSnipsExpandTrigger = '<C-j>'
      let g:UltiSnipsJumpForwardTrigger = '<C-j>'
      let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

    " }

    " dart {

      let dart_html_in_string=v:true
      let g:dart_style_guide = 2
      let g:dart_format_on_save = 1
      let g:lsc_auto_map = v:true

    " }

    " prettier {

      let g:prettier#config#bracket_spacing = 'true'
      let g:prettier#config#jsx_bracket_same_line = 'false'
      let g:prettier#autoformat = 0

    " }

  " }


  " set curser to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  " mutt buffers
  au BufRead /tmp/mutt-* set tw=72
  au BufRead ~/tmp/mutt-* set tw=72


  " Dart specifics {

    augroup dart_save | au!
        autocmd BufWritePost *.dart :DartOrganizeImports
    augroup end

  " }

" }
