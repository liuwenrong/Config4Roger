" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }
"
" Environment {
    set foldmarker={,}
    set foldlevel=0 
    set foldmethod=marker
    set fdm=marker      "文件折叠模式 输入zf%创建折叠"

    " Leader & localLeader {
        let mapleader = ' '
        "let mapleader="\<Space>"
        let maplocalleader = '\'
    "}

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          "set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    
    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        "if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            "inoremap <silent> <C-[>OC <RIGHT>
        "endif
    " }

" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before"))
        source ~/.vimrc.before
    endif
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
    "if has('gui')
        "if filereadable(expand("~/.vimrc.bundles"))
            "source ~/.vimrc.bundles
        "endif
    "endif
" }

" General {
    "安装匹配括号的插件"
    packadd! matchit

    "fileencoding & fileformat{
        set termencoding=utf-8
        set encoding=utf8
        set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
        scriptencoding utf-8
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        set fileformat=unix
        set fileformats=unix,dos
    " }

    "Edit {
        set autowrite   " Automatically write a file when leaving a modified buffer
        set autoread
        set nobackup    "禁止生成临时文件
        set noswapfile
        set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
        set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
        set virtualedit=onemore             " Allow for cursor beyond last character
        set history=1000                    " Store a ton of history (default is 20)
        set spell                           " Spell checking on
        set hidden                          " Allow buffer switching without saving
        set iskeyword-=.                    " '.' is an end of word designator
        set iskeyword-=#                    " '#' is an end of word designator
        set iskeyword-=-                    " '-' is an end of word designator

    "}
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:spf13_no_restore_cursor = 1
    if !exists('g:spf13_no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                silent! normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories {
        "set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

" }

" Vim UI {
    if WINDOWS()
        set rtp+=E:/0SoftInstall/msys2_64/usr/share/vim/vim80/colors
        set rtp+=E:/0SoftInstall/msys2_64/usr/share/vim/vim80
    endif


" GUI & term Settings {

    " GVIM- (here instead of .gvimrc)
    "if has('gui_running')
        "set lines=40                " 40 lines of text instead of 24
        "if !exists("g:spf13_no_big_font")
            "if LINUX() && has("gui_running")
                "set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
            "elseif OSX() && has("gui_running")
                "set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            "elseif WINDOWS() && has("gui_running")
                "set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
            "endif
        "endif
    "else
    "
    if !has('gui')
        set term=$TERM          " Make arrow and other keys work
    endif
    if &term == 'xterm' || &term == 'screen'
        "导致cmder-vim 一片黄
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work"打开导致颜色不显示
    "
    "Font Settings 字体的设置 {
        set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI
        "set cul "高亮光标所在行
        "set cuc "高亮列"
        "autocmd InsertEnter * se cul    " 用浅色高亮当前行
        "autocmd InsertLeave * se nocul  " 用浅色高亮当前行
        "black, brown, grey, blue, green, cyan, magenta, yellow, white
        "开启高亮光标行
        "set cursorline
        "hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
        "开启高亮光标列
        "set cursorcolumn
        "hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    "}
    if has('gui_running')
        ""echo "is gui_runnig gvim"
        set guioptions-=T           " 隐藏工具栏
        set guioptions-=m           " 隐藏菜单栏
        set lines=52 columns=99    "set win Size
        winpos 780 0          " Set Win Position
        "set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
        filetype plugin indent on   " Automatically detect file types.
        syntax on                   " Syntax highlighting
    else
        filetype plugin indent on   " Automatically detect file types.
        winpos 0 0
        set lines=42 columns=99    "set win Size
        syntax on                   " Syntax highlighting
        ""Allow to trigger background
        "function! ToggleBG()
            "let s:tbg = &background
            "" Inversion
            "if s:tbg == "dark"
                "set background=light
            "else
                "set background=dark
            "endif
        "endfunction
        "noremap <leader>bg :call ToggleBG()<CR>
    endif


" }

        "Cursor Style 光标样式{
            "普通模式下用块状光标，在插入模式下用条状光标（形状类似英文 "I" 的样子），然后在替换模式中使用下划线形状的光标"
            if !empty($TERM)
                "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
                "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
                "let &t_SR = "\<Esc>]50;CursorShape=2\x7"
                let &t_EI = "\<Esc>]12;yellow\x7"
                let &t_SI = "\<Esc>]12;blue\x7"
                let &t_SR = "\<Esc>]12;red\x7"
            endif

            "if &term =~ "xterm"
                "let &t_EI = "\<Esc>]12;yellow\x7"
                "let &t_SI = "\<Esc>]12;blue\x7"
                "let &t_SR = "\<Esc>]12;red\x7"
                ""let &t_EI = "\<Esc>]12;yellow;CursorType=block\x7"
                ""let &t_EI = "\<Esc>]12;CursorShape=0\x7"
                ""let &t_SI = "\<Esc>]12;CursorShape=1\x7"
                ""let &t_SI = "\<Esc>]12;CursorType=vertical" "unavialable"
                ""let &t_SI = "\<Esc>]12;purple\x7"
                ""let &t_SR = "\<Esc>]12;CursorBlinks=yes"
            "endif
            if &term =~ "xterm\\|rxvt\\|xterm-256color"
                 "silent !echo -ne "\033]12;green\007"
                 "let &t_SI = "\033]12;gray\007"
                 let &t_SI = "\033]12;blue\007"
                 let &t_EI = "\033]12;green\007"
                 let &t_SR = "\033]12;red\007"
                 "autocmd VimLeave * :!echo -ne "\033]12;green\007"
            endif
            if !has('gui')
            "if empty($TMUX)
                "echo "empty tmux"
                "echo "no gui"
                "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
                "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
                "let &t_SR = "\<Esc>]50;CursorShape=2\x7"
            else
                "set guicursor=n-c-v:block-nCursor "Available"
               "set guicursor=i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150
                "let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
                "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
                "let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
            endif
         "}
         "
    "Others {
        "

    set ignorecase  "搜索忽略大小写
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if !exists('g:override_spf13_bundles')
            if has('gui')
                "set statusline+=%{fugitive#statusline()} " Git Hotness
            endif
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

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

    "}
" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spf13_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

" Key (re)Mappings {

    "vimrc & Write & Quit {
        "按 ,ev静默(不回显信息)打开配置文件"   "重载 配置文件 .vimrc"
        nmap <silent> <leader>ev :e $MYVIMRC<CR>
        nmap <silent> <leader>sv :so $MYVIMRC<CR>
        "保存文件"       "退出文件 但不强制退出"
        noremap <localLeader>w :w<CR>
        noremap! <localLeader>w <Esc>:w<CR>
        noremap <localLeader>q :q<CR>
        if has('gui')
            noremap <A-w> :w<CR>
            noremap! <A-w> <Esc>:w<CR>
            nmap <A-q> :q<CR>
        else        "Terminal"
            "noremap <Leader>w :w<CR>
            noremap <Leader>q :q<CR>
            "noremap <ESC>]{0}q~ :q<CR>  "unuseable"
            "nmap <A-q> :q<CR>   "unuseable"
            "nmap <M-q> :q<CR>      "unuseable"
            "noremap <C-q> :q<CR>    "unuseable"
        endif
    "}
    "
    "cursor &Window move 光标窗口移动 {
        imap <Tab> <S-Tab>
        map <CR> gg
        imap <C-h> <Left>
        imap <C-j> <Down>
        imap <C-l> <Right>
        imap <C-k> <Up>
        imap <C-i> <Esc>
       "fj同时按相当于临时退出编辑模式
        "inoremap fj <C-o>
       "回到句首"   "回到句末"
        imap <C-a> <Esc>^
        imap <C-e> <Esc>$
        set scrolloff=8     " 光标移动到buffer的顶部和底部时保持3行距离 
        "map <C-w> <C-w>w
        nmap <C-j> <C-W>j
        nmap <C-k> <C-W>k
        map <C-h> <C-W>h
        nmap <C-l> <C-W>l

        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv

        " Adjust viewports to the same size
        map <Leader>= <C-w>=

        " Easier horizontal scrolling
        map zl zL
        map zh zH
    " }
    "
    "Copy & Paste {
        if has('clipboard')
            if has('unnamedplus')  " When possible use + register for copy-paste
                set clipboard=unnamed,unnamedplus
            else         " On mac and Windows, use * register for copy-paste
                "set clipboard=unnamed
                set clipboard=unnamed,unnamedplus
            endif
        endif

        " Yank from the cursor to the end of the line, to be consistent with C and D."Y复制到行尾
        nnoremap Y y$
        "自动跳转到文本的最后"     "使用pppp进行多行多次粘贴操作"
        vnoremap <silent> y y`]
        vnoremap <silent> p p`]
        nnoremap <silent> p p`]
        "在全模式中使用Shift+Insert粘贴全局剪贴板内容,选择模式先替换后粘贴
        inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
        vmap <S-Insert> "-d"+p
        map <S-Insert> "+p

        "在Visual模式中使用Ctrl+Insert复制内容到全局剪贴板
        vnoremap <C-c> "+y
        map <C-y> "+y
        map <C-Insert> "+y
        vmap <C-Insert> "+y

        "在Visual模式中使用Ctrl+x剪切内容到全局剪贴板
        vnoremap <C-x> "+x

        :nmap <silent> <F9> <ESC>:Tlist<RETURN>
        map! <C-Z> <Esc>zzi
        "map! <C-O> <C-Y>,  
        "全选复制
        map <Leader>a ggVG$"+y
        "全屏identited 缩进
        map <F12> gg=G
        "imap <C-k> <C-y>,
        "imap <C-t> <C-q><TAB>
        "imap <C-j> <ESC>
        " 选中状态下 Ctrl+c 复制
        "map <C-v> "*pa
        "imap <C-v> <Esc>"*pa
    "}
    "
    "tab Config{
                " keymap to switch tab in gui
                if has('gui') 
                    imap <M-/> <C-n>
                    set winaltkeys=no
                    "set macmeta
                    map <A-t> :tabnew<CR>       "新建一个标签"
                    map! <A-T> <Esc>:tabnew<CR>
                    "map <A-e> :tabe<CR> "打开指定文件"
                    map <A-e> :browse tabnew<CR>    "浏览打开"
                    map <A-c> :tabc<CR> "关闭当前tab"

                    map <silent><A-h> :tabprev<CR>  ":tabp 或gT  前一个"
                    map! <silent><A-h> <ESC>:tabprev<CR>
                    map <A-l> gt    ":tabn 或gt  后一个"
                    map! <A-l> <Esc>gt
                    noremap <silent><m-1> :tabn 1<cr>
                    noremap <silent><m-2> :tabn 2<cr>
                    noremap <silent><m-3> :tabn 3<cr>
                    noremap <silent><m-4> :tabn 4<cr>
                    noremap <silent><m-5> :tabn 5<cr>
                    noremap <silent><m-6> :tabn 6<cr>
                    noremap <silent><m-7> :tabn 7<cr>
                    noremap <silent><m-8> :tabn 8<cr>
                    noremap <silent><m-9> :tabn 9<cr>
                    noremap <silent><m-0> :tabn 10<cr>
                    inoremap <silent><m-1> <ESC>:tabn 1<cr>
                    inoremap <silent><m-2> <ESC>:tabn 2<cr>
                    inoremap <silent><m-3> <ESC>:tabn 3<cr>
                    inoremap <silent><m-4> <ESC>:tabn 4<cr>
                    inoremap <silent><m-5> <ESC>:tabn 5<cr>
                    inoremap <silent><m-6> <ESC>:tabn 6<cr>
                    inoremap <silent><m-7> <ESC>:tabn 7<cr>
                    inoremap <silent><m-8> <ESC>:tabn 8<cr>
                    inoremap <silent><m-9> <ESC>:tabn 9<cr>
                    inoremap <silent><m-0> <ESC>:tabn 10<cr>
                else
                    noremap <Leader>h gT
                    noremap <Leader>l gt
                endif
                "设置标签页显示序号"
                set tabline=%!MyTabLine()  " custom tab pages line  
                function! MyTabLine()  
                    let s = '' " complete tabline goes here  
                    " loop through each tab page  
                    for t in range(tabpagenr('$'))  
                        " set highlight  
                        if t + 1 == tabpagenr()  
                            let s .= '%#TabLineSel#'  
                        else  
                            let s .= '%#TabLine#'  
                        endif  
                        " set the tab page number (for mouse clicks)  
                        let s .= '%' . (t + 1) . 'T'  
                        let s .= ' '  
                        " set page number string  
                        let s .= t + 1 . ' '  
                        " get buffer names and statuses  
                        let n = ''      "temp string for buffer names while we loop and check buftype  
                        let m = 0       " &modified counter  
                        let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '  
                        " loop through each buffer in a tab  
                        for b in tabpagebuflist(t + 1)  
                            " buffer types: quickfix gets a [Q], help gets [H]{base fname}  
                            " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname  
                            if getbufvar( b, "&buftype" ) == 'help'  
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )  
                            elseif getbufvar( b, "&buftype" ) == 'quickfix'  
                                let n .= '[Q]'  
                            else  
                                let n .= pathshorten(bufname(b))  
                            endif  
                            " check and ++ tab's &modified count  
                            if getbufvar( b, "&modified" )  
                                let m += 1  
                            endif  
                            " no final ' ' added...formatting looks better done later  
                            if bc > 1  
                                let n .= ' '  
                            endif  
                            let bc -= 1  
                        endfor  
                        " add modified label [n+] where n pages in tab are modified  
                        if m > 0  
                            let s .= '[' . m . '+]'  
                        endif  
                        " select the highlighting for the buffer names  
                        " my default highlighting only underlines the active tab  
                        " buffer names.  
                        if t + 1 == tabpagenr()  
                            let s .= '%#TabLineSel#'  
                        else  
                            let s .= '%#TabLine#'  
                        endif  
                        " add buffer names  
                        if n == ''  
                            let s.= '[New]'  
                        else  
                            let s .= n  
                        endif  
                        " switch to no underlining and add final space to buffer list  
                        let s .= ' '  
                    endfor  
                    " after the last tab fill with TabLineFill and reset tab page nr  
                    let s .= '%#TabLineFill#%T'  
                    " right-align the label to close the current tab page  
                    if tabpagenr('$') > 1  
                        let s .= '%=%#TabLineFill#999Xclose'  
                    endif  
                    return s  
                endfunction

            "}

    "C，C++ py Press F5 Run {
            map <F5> :call CompileRunGcc()<CR>
            func! CompileRunGcc()
                exec "w"
                if &filetype == 'c'
                    exec "!g++ % -o %<"
                    exec "!time ./%<"
                elseif &filetype == 'cpp'
                    exec "!g++ % -std=c++11 -o %<"
                    exec "!time ./%<"
                elseif &filetype == 'java' 
                    exec "!javac %" 
                    exec "!time java %<"
                elseif &filetype == 'sh'
                    :!time bash %
                elseif &filetype == 'python'
                    exec "! python2.7 %"
                    "exec "!time python2.7 %"
                elseif &filetype == 'html'
                    exec "!firefox % &"
                elseif &filetype == 'go'
                    "        exec "!go build %<"
                    exec "!time go run %"
                elseif &filetype == 'mkd'
                    exec "!~/.vim/markdown.pl % > %.html &"
                    exec "!firefox %.html &"
                endif
            endfunc
            "C,C++的调试
            map <F8> :call Rungdb()<CR>
            func! Rungdb()
                exec "w"
                exec "!g++ % -std=c++11 -g -o %<"
                exec "!gdb ./%<"
            endfunc
       "}

    "spf13 {
    " The default mappings for editing and applying the spf13 configuration
    " are <leader>ev and <leader>sv respectively. Change them to your preference
    " by adding the following to your .vimrc.before.local file:
    "   let g:spf13_edit_config_mapping='<leader>ec'
    "   let g:spf13_apply_config_mapping='<leader>sc'
    "
    "if !exists('g:spf13_edit_config_mapping')
        "let s:spf13_edit_config_mapping = '<leader>ev'
    "else
        "let s:spf13_edit_config_mapping = g:spf13_edit_config_mapping
    "endif
    "if !exists('g:spf13_apply_config_mapping')
        "let s:spf13_apply_config_mapping = '<leader>sv'
    "else
        "let s:spf13_apply_config_mapping = g:spf13_apply_config_mapping
    "endif

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_easyWindows = 1
    "if !exists('g:spf13_no_easyWindows')
        "map <C-J> <C-W>j<C-W>_
        "map <C-K> <C-W>k<C-W>_
        "map <C-L> <C-W>l<C-W>_
        "map <C-H> <C-W>h<C-W>_
    "endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_wrapRelMotion = 1
    if !exists('g:spf13_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_no_fastTabs = 1
    if !exists('g:spf13_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:spf13_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif
    "}

    " Code folding options {
        "nmap <leader>f0 :set foldlevel=0<CR>
        "nmap <leader>f1 :set foldlevel=1<CR>
        "nmap <leader>f2 :set foldlevel=2<CR>
        "nmap <leader>f3 :set foldlevel=3<CR>
        "nmap <leader>f4 :set foldlevel=4<CR>
        "nmap <leader>f5 :set foldlevel=5<CR>
        "nmap <leader>f6 :set foldlevel=6<CR>
        "nmap <leader>f7 :set foldlevel=7<CR>
        "nmap <leader>f8 :set foldlevel=8<CR>
        "nmap <leader>f9 :set foldlevel=9<CR>
    "}

    "nohlsearch & invhlserach {
    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:spf13_clear_search_highlight = 1
    "if exists('g:spf13_clear_search_highlight')
        "nmap <silent> <leader>/ :nohlsearch<CR>
    "else
        "nmap <silent> <leader>/ :set invhlsearch<CR>
    "endif
    "}

    " Shortcuts
    " Change Working Directory to that of the current file
    "cmap cwd lcd %:p:h
    "cmap cd. lcd %:p:h

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    "cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    "nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier formatting
    "nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }

" Plugins {

    " GoLang {
        "if count(g:spf13_bundle_groups, 'go')
            "let g:go_highlight_functions = 1
            "let g:go_highlight_methods = 1
            "let g:go_highlight_structs = 1
            "let g:go_highlight_operators = 1
            "let g:go_highlight_build_constraints = 1
            "let g:go_fmt_command = "goimports"
            "let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
            "let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
            "au FileType go nmap <Leader>s <Plug>(go-implements)
            "au FileType go nmap <Leader>i <Plug>(go-info)
            "au FileType go nmap <Leader>e <Plug>(go-rename)
            "au FileType go nmap <leader>r <Plug>(go-run)
            "au FileType go nmap <leader>b <Plug>(go-build)
            "au FileType go nmap <leader>t <Plug>(go-test)
            "au FileType go nmap <Leader>gd <Plug>(go-doc)
            "au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
            "au FileType go nmap <leader>co <Plug>(go-coverage)
        "endif
        " }


    " TextObj Sentence {
        "if count(g:spf13_bundle_groups, 'writing')
            "augroup textobj_sentence
              "autocmd!
              "autocmd FileType markdown call textobj#sentence#init()
              "autocmd FileType textile call textobj#sentence#init()
              "autocmd FileType text call textobj#sentence#init()
            "augroup END
        "endif
    " }

    " TextObj Quote {
        "if count(g:spf13_bundle_groups, 'writing')
            "augroup textobj_quote
                "autocmd!
                "autocmd FileType markdown call textobj#quote#init()
                "autocmd FileType textile call textobj#quote#init()
                "autocmd FileType text call textobj#quote#init({'educate': 0})
            "augroup END
        "endif
    " }

    " PIV {
        "if isdirectory(expand("~/.vim/bundle/PIV"))
            "let g:DisableAutoPHPFolding = 0
            "let g:PIVAutoClose = 0
        "endif
    " }

    " Misc {
        "if isdirectory(expand("~/.vim/bundle/nerdtree"))
            "let g:NERDShutUp=1
        "endif
        "if isdirectory(expand("~/.vim/bundle/matchit.zip"))
            "let b:match_ignorecase = 1
        "endif
    " }

    " OmniComplete {
        " To disable omni complete, add the following to your .vimrc.before.local file:
        "   let g:spf13_no_omni_complete = 1
        "if !exists('g:spf13_no_omni_complete')
            "if has("autocmd") && exists("+omnifunc")
                "autocmd Filetype *
                    "\if &omnifunc == "" |
                    "\setlocal omnifunc=syntaxcomplete#Complete |
                    "\endif
            "endif

            "hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
            "hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
            "hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

            "" Some convenient mappings
            ""inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
            "if exists('g:spf13_map_cr_omni_complete')
                "inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"
            "endif
            "inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
            "inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
            "inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            "inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

            "" Automatically open and close the popup menu / preview window
            "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
            "set completeopt=menu,preview,longest
        "endif
    " }

    " Ctags {
        "set tags=./tags;/,~/.vimtags

        "" Make tags placed in .git/tags file available in all levels of a repository
        "let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        "if gitroot != ''
            "let &tags = &tags . ',' . gitroot . '/.git/tags'
        "endif
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        "au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        "nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        "let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
    " }

    " NerdTree {
        "if isdirectory(expand("~/.vim/bundle/nerdtree"))
            "map <C-e> <plug>NERDTreeTabsToggle<CR>
            "map <leader>e :NERDTreeFind<CR>
            "nmap <leader>nt :NERDTreeFind<CR>

            "let NERDTreeShowBookmarks=1
            "let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            "let NERDTreeChDirMode=0
            "let NERDTreeQuitOnOpen=1
            "let NERDTreeMouseMode=2
            "let NERDTreeShowHidden=1
            "let NERDTreeKeepTreeInNewTab=1
            "let g:nerdtree_tabs_open_on_gui_startup=0
        "endif
    " }

    " Tabularize {
        "if isdirectory(expand("~/.vim/bundle/tabular"))
            "nmap <Leader>a& :Tabularize /&<CR>
            "vmap <Leader>a& :Tabularize /&<CR>
            "nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            "vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            "nmap <Leader>a=> :Tabularize /=><CR>
            "vmap <Leader>a=> :Tabularize /=><CR>
            "nmap <Leader>a: :Tabularize /:<CR>
            "vmap <Leader>a: :Tabularize /:<CR>
            "nmap <Leader>a:: :Tabularize /:\zs<CR>
            "vmap <Leader>a:: :Tabularize /:\zs<CR>
            "nmap <Leader>a, :Tabularize /,<CR>
            "vmap <Leader>a, :Tabularize /,<CR>
            "nmap <Leader>a,, :Tabularize /,\zs<CR>
            "vmap <Leader>a,, :Tabularize /,\zs<CR>
            "nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            "vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        "endif
    " }

    " Session List {
        "set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        "if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            "nmap <leader>sl :SessionList<CR>
            "nmap <leader>ss :SessionSave<CR>
            "nmap <leader>sc :SessionClose<CR>
        "endif
    " }

    " JSON {
        "nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        "let g:vim_json_syntax_conceal = 0
    " }

    " PyMode {
        " Disable if python support not present
        "if !has('python') && !has('python3')
            "let g:pymode = 0
        "endif

        "if isdirectory(expand("~/.vim/bundle/python-mode"))
            "let g:pymode_lint_checkers = ['pyflakes']
            "let g:pymode_trim_whitespaces = 0
            "let g:pymode_options = 0
            "let g:pymode_rope = 0
        "endif
    " }

    " ctrlp {
        "if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            "let g:ctrlp_working_path_mode = 'ra'
            "nnoremap <silent> <D-t> :CtrlP<CR>
            "nnoremap <silent> <D-r> :CtrlPMRU<CR>
            "let g:ctrlp_custom_ignore = {
                "\ 'dir':  '\.git$\|\.hg$\|\.svn$',
                "\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            "if executable('ag')
                "let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            "elseif executable('ack-grep')
                "let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            "elseif executable('ack')
                "let s:ctrlp_fallback = 'ack %s --nocolor -f'
            "" On Windows use "dir" as fallback command.
            "elseif WINDOWS()
                "let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            "else
                "let s:ctrlp_fallback = 'find %s -type f'
            "endif
            "if exists("g:ctrlp_user_command")
                "unlet g:ctrlp_user_command
            "endif
            "let g:ctrlp_user_command = {
                "\ 'types': {
                    "\ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    "\ 2: ['.hg', 'hg --cwd %s locate -I .'],
                "\ },
                "\ 'fallback': s:ctrlp_fallback
            "\ }

            "if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                "" CtrlP extensions
                "let g:ctrlp_extensions = ['funky']

                ""funky
                "nnoremap <Leader>fu :CtrlPFunky<Cr>
            "endif
        "endif
    "}

    " TagBar {
        "if isdirectory(expand("~/.vim/bundle/tagbar/"))
            "nnoremap <silent> <leader>tt :TagbarToggle<CR>
        "endif
    "}

    " Rainbow {
        "if isdirectory(expand("~/.vim/bundle/rainbow/"))
            "let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
        "endif
    "}

    " Fugitive {
        "if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            "nnoremap <silent> <leader>gs :Gstatus<CR>
            "nnoremap <silent> <leader>gd :Gdiff<CR>
            "nnoremap <silent> <leader>gc :Gcommit<CR>
            "nnoremap <silent> <leader>gb :Gblame<CR>
            "nnoremap <silent> <leader>gl :Glog<CR>
            "nnoremap <silent> <leader>gp :Git push<CR>
            "nnoremap <silent> <leader>gr :Gread<CR>
            "nnoremap <silent> <leader>gw :Gwrite<CR>
            "nnoremap <silent> <leader>ge :Gedit<CR>
            "" Mnemonic _i_nteractive
            "nnoremap <silent> <leader>gi :Git add -p %<CR>
            "nnoremap <silent> <leader>gg :SignifyToggle<CR>
        "endif
    "}

    " YouCompleteMe {
        "if count(g:spf13_bundle_groups, 'youcompleteme')
            "let g:acp_enableAtStartup = 0

            "" enable completion from tags
            "let g:ycm_collect_identifiers_from_tags_files = 1

            "" remap Ultisnips for compatibility for YCM
            "let g:UltiSnipsExpandTrigger = '<C-j>'
            "let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            "let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            "" Enable omni completion.
            "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            "autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            "" Haskell post write lint and check with ghcmod
            "" $ `cabal install ghcmod` if missing and ensure
            "" ~/.cabal/bin is in your $PATH.
            "if !executable("ghcmod")
                "autocmd BufWritePost *.hs GhcModCheckAndLintAsync
            "endif

            "" For snippet_complete marker.
            "if !exists("g:spf13_no_conceal")
                "if has('conceal')
                    "set conceallevel=2 concealcursor=i
                "endif
            "endif

            "" Disable the neosnippet preview candidate window
            "" When enabled, there can be too much visual noise
            "" especially when splits are used.
            "set completeopt-=preview
        "endif
    " }

    " neocomplete {
        "if count(g:spf13_bundle_groups, 'neocomplete')
            "let g:acp_enableAtStartup = 0
            "let g:neocomplete#enable_at_startup = 1
            "let g:neocomplete#enable_smart_case = 1
            "let g:neocomplete#enable_auto_delimiter = 1
            "let g:neocomplete#max_list = 15
            "let g:neocomplete#force_overwrite_completefunc = 1


            "" Define dictionary.
            "let g:neocomplete#sources#dictionary#dictionaries = {
                        "\ 'default' : '',
                        "\ 'vimshell' : $HOME.'/.vimshell_hist',
                        "\ 'scheme' : $HOME.'/.gosh_completions'
                        "\ }

            "" Define keyword.
            "if !exists('g:neocomplete#keyword_patterns')
                "let g:neocomplete#keyword_patterns = {}
            "endif
            "let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            "" Plugin key-mappings {
                "" These two lines conflict with the default digraph mapping of <C-K>
                "if !exists('g:spf13_no_neosnippet_expand')
                    "imap <C-k> <Plug>(neosnippet_expand_or_jump)
                    "smap <C-k> <Plug>(neosnippet_expand_or_jump)
                "endif
                "if exists('g:spf13_noninvasive_completion')
                    "inoremap <CR> <CR>
                    "" <ESC> takes you out of insert mode
                    "inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    "" <CR> accepts first, then sends the <CR>
                    "inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    "" <Down> and <Up> cycle like <Tab> and <S-Tab>
                    "inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    "inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    "" Jump up and down the list
                    "inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    "inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                "else
                    "" <C-k> Complete Snippet
                    "" <C-k> Jump to next snippet point
                    "imap <silent><expr><C-k> neosnippet#expandable() ?
                                "\ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                "\ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    "smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    "inoremap <expr><C-g> neocomplete#undo_completion()
                    "inoremap <expr><C-l> neocomplete#complete_common_string()
                    ""inoremap <expr><CR> neocomplete#complete_common_string()

                    "" <CR>: close popup
                    "" <s-CR>: close popup and save indent.
                    "inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

                    "function! CleverCr()
                        "if pumvisible()
                            "if neosnippet#expandable()
                                "let exp = "\<Plug>(neosnippet_expand)"
                                "return exp . neocomplete#smart_close_popup()
                            "else
                                "return neocomplete#smart_close_popup()
                            "endif
                        "else
                            "return "\<CR>"
                        "endif
                    "endfunction

                    "" <CR> close popup and save indent or expand snippet
                    "imap <expr> <CR> CleverCr()
                    "" <C-h>, <BS>: close popup and delete backword char.
                    "inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                    "inoremap <expr><C-y> neocomplete#smart_close_popup()
                "endif
                "" <TAB>: completion.
                "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

                "" Courtesy of Matteo Cavalleri

                "function! CleverTab()
                    "if pumvisible()
                        "return "\<C-n>"
                    "endif
                    "let substr = strpart(getline('.'), 0, col('.') - 1)
                    "let substr = matchstr(substr, '[^ \t]*$')
                    "if strlen(substr) == 0
                        "" nothing to match on empty string
                        "return "\<Tab>"
                    "else
                        "" existing text matching
                        "if neosnippet#expandable_or_jumpable()
                            "return "\<Plug>(neosnippet_expand_or_jump)"
                        "else
                            "return neocomplete#start_manual_complete()
                        "endif
                    "endif
                "endfunction

                "imap <expr> <Tab> CleverTab()
            "" }

            "" Enable heavy omni completion.
            "if !exists('g:neocomplete#sources#omni#input_patterns')
                "let g:neocomplete#sources#omni#input_patterns = {}
            "endif
            "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            "let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            "let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    "" }
    "" neocomplcache {
        "elseif count(g:spf13_bundle_groups, 'neocomplcache')
            "let g:acp_enableAtStartup = 0
            "let g:neocomplcache_enable_at_startup = 1
            "let g:neocomplcache_enable_camel_case_completion = 1
            "let g:neocomplcache_enable_smart_case = 1
            "let g:neocomplcache_enable_underbar_completion = 1
            "let g:neocomplcache_enable_auto_delimiter = 1
            "let g:neocomplcache_max_list = 15
            "let g:neocomplcache_force_overwrite_completefunc = 1

            "" Define dictionary.
            "let g:neocomplcache_dictionary_filetype_lists = {
                        "\ 'default' : '',
                        "\ 'vimshell' : $HOME.'/.vimshell_hist',
                        "\ 'scheme' : $HOME.'/.gosh_completions'
                        "\ }

            "" Define keyword.
            "if !exists('g:neocomplcache_keyword_patterns')
                "let g:neocomplcache_keyword_patterns = {}
            "endif
            "let g:neocomplcache_keyword_patterns._ = '\h\w*'

            "" Plugin key-mappings {
                "" These two lines conflict with the default digraph mapping of <C-K>
                "imap <C-k> <Plug>(neosnippet_expand_or_jump)
                "smap <C-k> <Plug>(neosnippet_expand_or_jump)
                "if exists('g:spf13_noninvasive_completion')
                    "inoremap <CR> <CR>
                    "" <ESC> takes you out of insert mode
                    "inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    "" <CR> accepts first, then sends the <CR>
                    "inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    "" <Down> and <Up> cycle like <Tab> and <S-Tab>
                    "inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    "inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    "" Jump up and down the list
                    "inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    "inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                "else
                    "imap <silent><expr><C-k> neosnippet#expandable() ?
                                "\ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                "\ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    "smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    "inoremap <expr><C-g> neocomplcache#undo_completion()
                    "inoremap <expr><C-l> neocomplcache#complete_common_string()
                    ""inoremap <expr><CR> neocomplcache#complete_common_string()

                    "function! CleverCr()
                        "if pumvisible()
                            "if neosnippet#expandable()
                                "let exp = "\<Plug>(neosnippet_expand)"
                                "return exp . neocomplcache#close_popup()
                            "else
                                "return neocomplcache#close_popup()
                            "endif
                        "else
                            "return "\<CR>"
                        "endif
                    "endfunction

                    "" <CR> close popup and save indent or expand snippet
                    "imap <expr> <CR> CleverCr()

                    "" <CR>: close popup
                    "" <s-CR>: close popup and save indent.
                    "inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
                    ""inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

                    "" <C-h>, <BS>: close popup and delete backword char.
                    "inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
                    "inoremap <expr><C-y> neocomplcache#close_popup()
                "endif
                "" <TAB>: completion.
                "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
            "" }

            "" Enable omni completion.
            "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            "autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            "" Enable heavy omni completion.
            "if !exists('g:neocomplcache_omni_patterns')
                "let g:neocomplcache_omni_patterns = {}
            "endif
            "let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            "let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            "let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            "let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            "let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            "let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
    "" }
    "" Normal Vim omni-completion {
    "" To disable omni complete, add the following to your .vimrc.before.local file:
    ""   let g:spf13_no_omni_complete = 1
        "elseif !exists('g:spf13_no_omni_complete')
            "" Enable omni-completion.
            "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            "autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            "autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

        "endif
    " }

    " Snippets {
        "if count(g:spf13_bundle_groups, 'neocomplcache') ||
                    "\ count(g:spf13_bundle_groups, 'neocomplete')

            "" Use honza's snippets.
            "let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

            "" Enable neosnippet snipmate compatibility mode
            "let g:neosnippet#enable_snipmate_compatibility = 1

            "" For snippet_complete marker.
            "if !exists("g:spf13_no_conceal")
                "if has('conceal')
                    "set conceallevel=2 concealcursor=i
                "endif
            "endif

            "" Enable neosnippets when using go
            "let g:go_snippet_engine = "neosnippet"

            "" Disable the neosnippet preview candidate window
            "" When enabled, there can be too much visual noise
            "" especially when splits are used.
            "set completeopt-=preview
        "endif
    " }

    " FIXME: Isn't this for Syntastic to handle?
    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " ~/.cabal/bin is in your $PATH.
    "if !executable("ghcmod")
        "autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    "endif

    " UndoTree {
        "if isdirectory(expand("~/.vim/bundle/undotree/"))
            "nnoremap <Leader>u :UndotreeToggle<CR>
            "" If undotree is opened, it is likely one wants to interact with it.
            "let g:undotree_SetFocusWhenToggle=1
        "endif
    " }

    " indent_guides {
        "if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            "let g:indent_guides_start_level = 2
            "let g:indent_guides_guide_size = 1
            "let g:indent_guides_enable_on_vim_startup = 1
        "endif
    " }

    " Wildfire {
    let g:wildfire_objects = {
                \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
                \ "html,xml" : ["at"],
                \ }
    " }

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        "if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
            "if !exists('g:airline_theme')
                "let g:airline_theme = 'solarized'
            "endif
            "if !exists('g:airline_powerline_fonts')
                "" Use the default set of separators with a few customizations
                "let g:airline_left_sep='›'  " Slightly fancier than '>'
                "let g:airline_right_sep='‹' " Slightly fancier than '<'
            "endif
        "endif
    " }


" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    function! s:IsSpf13Fork()
        let s:is_fork = 0
        let s:fork_files = ["~/.vimrc.fork", "~/.vimrc.before.fork", "~/.vimrc.bundles.fork"]
        for fork_file in s:fork_files
            if filereadable(expand(fork_file, ":p"))
                let s:is_fork = 1
                break
            endif
        endfor
        return s:is_fork
    endfunction
     
    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . " " . expand(a:file, ":p")
    endfunction
     
    function! s:EditSpf13Config()
        call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc")
        call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.before")
        call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.bundles")
     
        execute bufwinnr(".vimrc") . "wincmd w"
        call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.local")
        wincmd l
        call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.before.local")
        wincmd l
        call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.bundles.local")
     
        if <SID>IsSpf13Fork()
            execute bufwinnr(".vimrc") . "wincmd w"
            call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.fork")
            wincmd l
            call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.before.fork")
            wincmd l
            call <SID>ExpandFilenameAndExecute("split", "~/.vimrc.bundles.fork")
        endif
     
        execute bufwinnr(".vimrc.local") . "wincmd w"
    endfunction
     
    "execute "noremap " . s:spf13_edit_config_mapping " :call <SID>EditSpf13Config()<CR>"
    "execute "noremap " . s:spf13_apply_config_mapping . " :source ~/.vimrc<CR>"
" }

" Use fork vimrc if available {
    if filereadable(expand("~/.vimrc.fork"))
        source ~/.vimrc.fork
    endif
" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }
"
        "auto complete()"" 自动补全括号,引号 {{{
            "inoremap ( ()<Esc>i
            "inoremap [ []<Esc>i
            "inoremap { {}<Esc>i
            ""inoremap { {<CR>}<Esc>O "{{"{{{
            ""autocmd Syntax html,vim    "导致进入vim会弹框AutoC...
            "inoremap < <lt>><Esc>i| 
            "inoremap > <c-r>=ClosePair('>')<CR>
            "inoremap ) <c-r>=ClosePair(')')<CR>
            "inoremap ] <c-r>=ClosePair(']')<CR>
            "inoremap } <c-r>=ClosePair('}')<CR>
            ""inoremap } <c-r>=CloseBracket()<CR>
            "inoremap " <c-r>=QuoteDelim('"')<CR>
            "inoremap ' <c-r>=QuoteDelim("'")<CR>

            "function! ClosePair(char)
                "if getline('.')[col('.') - 1] == a:char
                    "return "\<Right>"
                "else
                    "return a:char
                "endif
            "endf

            "function! CloseBracket()
                "if match(getline(line('.') + 1), '\s*}') < 0
                    "return "\<CR>}"
                "else
                    "return "\<Esc>j0f}a"}
                "endif
            "endf

            "function! QuoteDelim(char)
                "let line = getline('.')
                "let col = col('.')
                "if line[col - 2] == "\\"
                    "return a:char
                "elseif line[col - 1] == a:char
                    "return "\<Right>"
                "else
                    "return a:char.a:char."\<Esc>i"
                "endif
            "endf
            "filetype plugin indent on 
            ""打开文件类型检测, 加了这句才可以用智能补全
            "set completeopt=longest,menu
    "}}}

    " Find merge conflict markers
    "map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
    imap <Tab> <S-Tab>
