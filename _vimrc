"环境 {{{
    "设置{{{
        "安装匹配括号的插件"
        packadd! matchit
        "界面相关{{{
            set number      " 显示行号
            set go=             " 不要图形按钮  
            set ruler           " 显示标尺  
            set showcmd         " 输入的命令显示出来，看的清楚些  
            winpos 0 0          " 设定窗口位置  
            set lines=52 columns=99    " 设定窗口大小   
            "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
            "set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
            "set cmdheight=2		" 总是显示状态行
        " "}}}
        set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  

        "语言格式{{{
            if version >= 603
                "set helplang=cn
                set encoding=utf-8
            endif
            "set langmenu=zh_CN.UTF-8	"语言设置
            "set helplang=cn
            set fileformats=unix,dos "unix文件格式作为第一选择
        " "}}}
        " 缩进相关{{{
            "set autoindent
            "set cindent
            " Tab键的宽度
            set tabstop=4
            " 统一缩进为4
            set softtabstop=4
            set shiftwidth=4
            " 使用空格代替制表符
            set expandtab
            " 在行和段开始处使用制表符
            set smarttab
        "  "}}}
        set history=1000    " 历史记录数
        set hlsearch    "搜索逐字符高亮
        set incsearch
        set viminfo+=!		" 保存全局变量
        set iskeyword+=_,$,@,%,#,-	" 带有如下符号的单词不要被换行分割
        " 字符间插入的像素行数目
        "markdown配置
        au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
        au BufRead,BufNewFile *.{go}   set filetype=go
        au BufRead,BufNewFile *.{js}   set filetype=javascript
        "set foldenable      " 允许折叠              
        set fdm=marker      "文件折叠模式 输入zf%创建折叠"
        set sw=4
        set ts=4
        set et
        set smarttab
        set smartindent
        set lbr
        set fo+=mB
        set sm
        set selection=inclusive
        set wildmenu
        set mousemodel=popup
        let g:fencview_autodetect=0
        set rtp+=$VIM
        set iskeyword+=.
        set termencoding=utf-8
        set encoding=utf8
        set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
        autocmd FileType python set omnifunc=pythoncomplete#Complete
    "}}}
    "Colors 颜色显示{{{{
        set rtp+=E:/0SoftInstall/msys2_64/usr/share/vim/vim80/colors
        set rtp+=E:/0SoftInstall/msys2_64/usr/share/vim/vim80
        if has('gui_running')
            "echo "is gui_runnig gvim"
            "set background=dark    "背景黑色
            set cul "高亮光标所在行
            set cuc "高亮列"
            autocmd InsertEnter * se cul    " 用浅色高亮当前行  
            set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
            set guifont=Courier_New:h10:cANSI   " 设置字体  
            autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
            syntax on
            colorscheme solarized   "主题黑色,很漂亮,护眼
        else
            "echo "not gui or gvim"
            "colorscheme Zenburn
            syntax off
        endif
        call togglebg#map("<F7>")   "黑色和护眼色切换"
    "}}}}
        "光标类型{{{
        "普通模式下用块状光标，在插入模式下用条状光标（形状类似英文 "I" 的样子），然后在替换模式中使用下划线形状的光标"
                if empty($TMUX)
                  "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
                  "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
                  "let &t_SR = "\<Esc>]50;CursorShape=2\x7"
                else
                  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
                  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
                  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
                endif
         "}}}
    "新文件各类型模板{{{
        "新建.c,.h,.sh,.java文件，自动插入文件头 
        autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
        ""定义函数SetTitle，自动插入文件头 
        func SetTitle() 
            "如果文件类型为.sh文件 
            if &filetype == 'sh' 
                call setline(1,"\#!/bin/bash") 
                call append(line("."), "") 
            elseif &filetype == 'python'
                call setline(1,"#!/usr/bin/python")
                call append(line("."),"# coding=utf-8")
                call append(line(".")+1, "") 

            elseif &filetype == 'ruby'
                call setline(1,"#!/usr/bin/env ruby")
                call append(line("."),"# encoding: utf-8")
                call append(line(".")+1, "")

                "    elseif &filetype == 'mkd'
                "        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
            else 
                call setline(1, "/*************************************************************************") 
                call append(line("."), "	> File Name: ".expand("%")) 
                call append(line(".")+1, "	> Author: ") 
                call append(line(".")+2, "	> Mail: ") 
                call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
                call append(line(".")+4, " ************************************************************************/") 
                call append(line(".")+5, "")
            endif
            if expand("%:e") == 'cpp'
                call append(line(".")+6, "#include<iostream>")
                call append(line(".")+7, "using namespace std;")
                call append(line(".")+8, "")
            endif
            if &filetype == 'c'
                call append(line(".")+6, "#include<stdio.h>")
                call append(line(".")+7, "")
            endif
            if expand("%:e") == 'h'
                call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
                call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
                call append(line(".")+8, "#endif")
            endif
            if &filetype == 'java'
                call append(line(".")+6,"public class ".expand("%:r"))
                call append(line(".")+7,"")
            endif
            "新建文件后，自动定位到文件末尾
        endfunc 
        autocmd BufNewFile * normal G
    "}}}

        "KeyMap 键盘命令 {{{
            let mapleader="\<Space>"     "使用的时候要按住空格 不放"
            "vimrc和保存退出{{{
                nmap <silent> <leader>ev :e $MYVIMRC<CR>    "按 ,ev静默(不回显信息)打开配置文件"
                nmap <silent> <leader>sv :so $MYVIMRC<CR>   "重载 配置文件 .vimrc"
               "保存文件"
                noremap <A-w> :w<CR>
                noremap! <A-w> <Esc>:w<CR>
                nmap <A-q> :q<CR>       "退出文件 但不强制退出"
            "}}}

            "光标移动{{{
                map <CR> gg         "6 Enter 跳到第6行"
                imap <C-h> <Left>
                imap <C-j> <Down>
                imap <C-l> <Right>
                imap <C-k> <Up>
                imap <C-i> <Esc>
               "fj同时按相当于临时退出编辑模式
                inoremap fj <C-o>
               "回到句首"   "回到句末"
                imap <C-a> <Esc>^
                imap <C-e> <Esc>$
                set mouse=v
                "set clipboard=unnamed
                "set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
                set scrolloff=8     " 光标移动到buffer的顶部和底部时保持3行距离  
                "打开Vim时恢复光标"
                if has("autocmd")
                    autocmd BufReadPost *
                                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                                \   exe "normal g`\"" |
                                \ endif
                endif
            "}}}


            " 切换窗口Smart way to move between windows{{{
                map <C-w> <C-w>w    "切换窗口"
                nmap <C-j> <C-W>j
                nmap <C-k> <C-W>k
                map <C-h> <C-W>h
                nmap <C-l> <C-W>l
                "nmap <C-/> <leader>c<Space>    "无效"
            "}}}


            "复制相关{{{
                vnoremap <silent> y y`]     "自动跳转到文本的最后"
                vnoremap <silent> p p`]     "使用pppp进行多行多次粘贴操作"
                nnoremap <silent> p p`]
                nnoremap Y y$       "Y复制到行尾
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
            "}}}

            """"""""""""""""""""""""
            """"Alt 映射 Alt键可以使用<M-key>或<A-key>来表示
            imap <M-/> <C-n>
            "tab 标签{{{
                " keymap to switch tab in gui
                if has('gui_running') 
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
                endif
                "设置标签页显示序号"
                set tabline=%!MyTabLine()  " custom tab pages line  
                function MyTabLine()  
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

                " set terminal and map alt+n or alt+shift+n to "<ESC>]{0}n~"
                " 终端Alt得用自定义按键发送特定字符串
                if !has('gui_running')
                    noremap <silent><ESC>]{0}1~ :tabn 1<cr>
                    noremap <silent><ESC>]{0}2~ :tabn 2<cr>
                    noremap <silent><ESC>]{0}3~ :tabn 3<cr>
                    noremap <silent><ESC>]{0}4~ :tabn 4<cr>
                    noremap <silent><ESC>]{0}5~ :tabn 5<cr>
                    noremap <silent><ESC>]{0}6~ :tabn 6<cr>
                    noremap <silent><ESC>]{0}7~ :tabn 7<cr>
                    noremap <silent><ESC>]{0}8~ :tabn 8<cr>
                    noremap <silent><ESC>]{0}9~ :tabn 9<cr>
                    noremap <silent><ESC>]{0}0~ :tabn 10<cr>
                    inoremap <silent><ESC>]{0}1~ <ESC>:tabn 1<cr>
                    inoremap <silent><ESC>]{0}2~ <ESC>:tabn 2<cr>
                    inoremap <silent><ESC>]{0}3~ <ESC>:tabn 3<cr>
                    inoremap <silent><ESC>]{0}4~ <ESC>:tabn 4<cr>
                    inoremap <silent><ESC>]{0}5~ <ESC>:tabn 5<cr>
                    inoremap <silent><ESC>]{0}6~ <ESC>:tabn 6<cr>
                    inoremap <silent><ESC>]{0}7~ <ESC>:tabn 7<cr>
                    inoremap <silent><ESC>]{0}8~ <ESC>:tabn 8<cr>
                    inoremap <silent><ESC>]{0}9~ <ESC>:tabn 9<cr>
                    inoremap <silent><ESC>]{0}0~ <ESC>:tabn 10<cr>
                endif
            "}}}

            "便捷{{{
                "如果你希望 n 始终为向后搜索，N 始终为向前搜索，那么只需要这样设置：
                nnoremap <expr> n  'Nn'[v:searchforward]
                nnoremap <expr> N  'nN'[v:searchforward]
                "Vim 用户都不愿意去按方向键，事实上我们也不需要去按，只需要设置这样的映射：
                cnoremap <c-n> <down>
                cnoremap <c-p> <up>
             "}}}

            "其他{{{
                "rkdown to HTML  
                nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
                nmap fi :!firefox %.html & <CR><CR>
                nmap \ \cc
                vmap \ \cc
                "将tab替换为空格
                nmap tt :%s/\t/    /g<CR>
                "去空行  
                nnoremap <F2> :g/^\s*$/d<CR>
                "比较文件  
                nnoremap <C-d> :vert diffsplit
                "nnoremap <Leader>fu :CtrlPFunky<Cr>
                "nnoremap <C-n> :CtrlPFunky<Cr>
                :autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
             "}}}

            "}}}

"C，C++ py 按F5编译运行{{{
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
       "}}}

        "F6代码格式优化 {{{
            map <F6> :call FormartSrc()<CR><CR>

            "定义FormartSrc()
            func FormartSrc()
                exec "w"
                if &filetype == 'c'
                    exec "!astyle --style=ansi -a --suffix=none %"
                elseif &filetype == 'cpp' || &filetype == 'hpp'
                    exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
                elseif &filetype == 'perl'
                    exec "!astyle --style=gnu --suffix=none %"
                elseif &filetype == 'py'||&filetype == 'python'
                    exec "r !autopep8 -i --aggressive %"
                elseif &filetype == 'java'
                    exec "!astyle --style=java --suffix=none %"
                elseif &filetype == 'jsp'
                    exec "!astyle --style=gnu --suffix=none %"
                elseif &filetype == 'xml'
                    exec "!astyle --style=gnu --suffix=none %"
                else
                    exec "normal gg=G"
                    return
                endif
                exec "e! %"
            endfunc
            "结束定义FormartSrc
        "}}}
        
        ""实用设置{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

            " 设置当文件被改动时自动载入
            set autoread
            " quickfix模式
            "autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
            "代码补全 
            set completeopt=preview,menu 
            "共享剪贴板  
            "set clipboard+=unnamed 

            set autowrite  			"自动保存
            "set ruler                   " 打开状态栏标尺
            "set cursorline              " 突出显示当前行
            set magic                   " 设置魔术
            set guioptions-=T           " 隐藏工具栏
            set guioptions-=m           " 隐藏菜单栏
            ""set foldcolumn=0
            ""set foldmethod=indent 
            ""set foldlevel=3 

            set nocompatible		" 不要使用vi的键盘模式，而是vim自己的

            set noeb		" 去掉输入错误的提示声音

            set confirm		" 在处理未保存或只读文件的时候，弹出确认

            set nobackup	"禁止生成临时文件
            set noswapfile

            set ignorecase	"搜索忽略大小写

            set linespace=0
            " 增强模式中的命令行自动完成操作
            set wildmenu
            " 使回格键（backspace）正常处理indent, eol, start等
            set backspace=2
            " 允许backspace和光标键跨越行边界
            set whichwrap+=<,>,h,l
            " 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
            set mouse=a
            set selection=exclusive
            set selectmode=mouse,key
            " 通过使用: commands命令，告诉我们文件的哪一行被改变过
            set report=0
            " 在被分割的窗口间显示空白，便于阅读
            set fillchars=vert:\ ,stl:\ ,stlnc:\
            " 高亮显示匹配的括号
            set showmatch
            " 匹配括号高亮的时间（单位是十分之一秒）
            set matchtime=1
        "}}}

        "自动补全括号,引号{{{
            inoremap ( ()<Esc>i
            inoremap [ []<Esc>i
            inoremap { {<CR>}<Esc>O
            autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
            inoremap ) <c-r>=ClosePair(')')<CR>
            inoremap ] <c-r>=ClosePair(']')<CR>
            inoremap } <c-r>=CloseBracket()<CR>
            inoremap " <c-r>=QuoteDelim('"')<CR>
            inoremap ' <c-r>=QuoteDelim("'")<CR>

            function ClosePair(char)
                if getline('.')[col('.') - 1] == a:char
                    return "\<Right>"
                else
                    return a:char
                endif
            endf

            function CloseBracket()
                if match(getline(line('.') + 1), '\s*}') < 0
                    return "\<CR>}"
                else
                    return "\<Esc>j0f}a"
                endif
            endf

            function QuoteDelim(char)
                let line = getline('.')
                let col = col('.')
                if line[col - 2] == "\\"
                    return a:char
                elseif line[col - 1] == a:char
                    return "\<Right>"
                else
                    return a:char.a:char."\<Esc>i"
                endif
            endf
            filetype plugin indent on 
            "打开文件类型检测, 加了这句才可以用智能补全
            set completeopt=longest,menu
        "}}}

    "}}}
"Bundle插件配置{{{
    "路径配置{{{
        set nocompatible               " be iMproved
        filetype off                   " required!

        " 插件配置
        set rtp+=$VIM/bundle/vundle
        set rtp+=$VIM/bundle/python-imports.vim
        set rtp+=$VIM/bundle/pydiction      "代码补全工具, Tab自动出提示"

        "set rtp+=$VIM/bundle/*
        set rtp+=$VIM/bundle/vim-fugitive
        set rtp+=$VIM/bundle/ctrlp.vim      "快速搜索文件"
        "set rtp+=$VIM/bundle/powerline      "状态栏插件
        set rtp+=$VIM/bundle/vim-airline      "状态栏插件-美化-漂亮
    "}}}

        "EasyMotion配置{{{
            set rtp+=$VIM/bundle/vim-easymotion     "easymotion 快速定位跳转"
            nmap <Leader>w <Plug>(easymotion-overwin-w)
            "快速查找单词之后的word"没有bd就是之后,有bd就是前后的单词           
            " <Leader>f{char} to move to {char}
            "map  <Leader>f <Plug>(easymotion-bd-f)
            nmap <Leader>; <Plug>(easymotion-overwin-f)
            "nmap <Leader>f <Plug>(easymotion-overwin-f)

            "s{char}{char} to move to {char}{char}
            nmap <Leader>f <Plug>(easymotion-overwin-f2)

            " Move to line
            nmap <Leader><leader>h <Plug>(easymotion-linebackward)
            nmap <Leader><leader>l <Plug>(easymotion-lineforward)
            "map <Leader>L <Plug>(easymotion-bd-jk)
            "nmap <Leader>L <Plug>(easymotion-overwin-line)
            "map <Leader><Leader>j <Plug>(easymotion-j)
            "map <Leader><Leader>k <Plug>(easymotion-k)

            " Move to word
            "map  <Leader>s <Plug>(easymotion-bd-w)
            "nmap <Leader>s <Plug>(easymotion-overwin-w)
        "}}}

    "NerdCommenter快速注释<Leader>/{{{
        set rtp+=$VIM/bundle/The-NERD-Commenter     "快速注释 <leader>c<SPACE> 运行 <leader>cc 注释， <leader>cu 反注释
        nmap <Leader>/ <plug>NERDCommenterToggle
        vmap <Leader>/ <plug>NERDCommenterToggle
        imap <Leader>/ <Esc><plug>NERDCommenterToggle
     "}}}

    "启动Bundle{{{
        " Pathogen load  python-mdoe 配置
        "call pathogen#infect()
        "call pathogen#helptags()       "pathogen 插件管理利器 类似vundle"
        "
        "Plugin 'easymotion/vim-easymotion'     "安装easymotion 快速定位跳转"


        "call vundle#rc()           "旧版"
        "call vundle#begin()        "新版"

        "Bundle 'gmarik/vundle'      " let Vundle manage Vundle  必须 required!

        " My Bundles here:
        "
        " original repos on github  用户名/仓库名
        "Bundle 'easymotion/vim-easymotion'     "安装easymotion 快速定位跳转"
        "Bundle 'tpope/vim-fugitive'
        "Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
        "Bundle 'Yggdroot/indentLine'
        "let g:indentLine_char = '┊'
        "ndle 'tpope/vim-rails.git'

        " vim-scripts repos
        "Bundle 'L9'
        "Bundle 'FuzzyFinder'
        " non github repos
        "Bundle 'https://github.com/wincent/command-t.git'
        "Bundle 'Auto-Pairs'
        "Bundle 'python-imports.vim'
        "Bundle 'CaptureClipboard'
        "Bundle 'ctrlp-modified.vim'
        "Bundle 'last_edit_marker.vim'
        "Bundle 'synmark.vim'
        "Bundle 'Python-mode-klen'
        "Bundle 'SQLComplete.vim'
        "Bundle 'Javascript-OmniCompletion-with-YUI-and-j'
        "Bundle 'JavaScript-Indent'
        "Bundle 'Better-Javascript-Indentation'
        "Bundle 'jslint.vim'
        "Bundle "pangloss/vim-javascript"
        "Bundle 'Vim-Script-Updater'
        "Bundle 'ctrlp.vim'
        "Bundle 'tacahiroy/ctrlp-funky'
        "Bundle 'jsbeautify'
        "Bundle 'The-NERD-Commenter'
        "django
        "Bundle 'django_templates.vim'
        "Bundle 'Django-Projects'

        "Bundle 'FredKSchott/CoVim'
        "Bundle 'djangojump'
        " ...
        "let g:html_indent_inctags = "html,body,head,tbody"
        "let g:html_indent_script1 = "inc"
        "let g:html_indent_style1 = "inc"
        filetype on			" 侦测文件类型
        filetype plugin on	" 载入文件类型插件
        filetype indent on	" 为特定文件类型载入相关缩进文件
    "}}}

    "v选择扩展{{{
        set rtp+=$VIM/bundle/vim-expand-region  "快速扩展选择 字符-单词-段落"
        vmap v <Plug>(expand_region_expand)
        vmap <A-v> <Plug>(expand_region_shrink)
    "}}}

        "NerdTree{{{
            "set rtp+=$VIM/bundle/nerdtree       "左侧文件夹管理"
            "set rtp+=$VIM/bundle/vim-nerdtree-tabs       "左侧文件夹tab插件,tab共享"
            "" 显示行号
            "let NERDTreeShowLineNumbers=1
            "let NERDTreeAutoCenter=1
            "" 显示书签列表
            ""let NERDTreeShowBookmarks=1
            "" 是否显示隐藏文件
            "let NERDTreeShowHidden=1
            "" 设置宽度
            "let NERDTreeWinSize=31
            "" 在终端启动vim时，共享NERDTree
            "let g:nerdtree_tabs_open_on_console_startup=1
            ""列出当前目录文件  
            "map <F3> :NERDTreeToggle<CR>
            "map! <F3> <ESC> :NERDTreeToggle<CR>
            ""退出时只剩NerdTree时退出Vim"
            "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
            ""打开树状文件目录  
            "map <C-F3> \be  
            "let NERDTreeIgnore=['\.pyc']
            "autocmd vimenter * NERDTree     "打开Vim自动打开NerdTree"
            "当打开vim且没有文件时自动打开NERDTree
            "autocmd vimenter * if !argc() | NERDTree | endif
        "}}}

    "superSearch{{{
        "放在vim/plugin中才有效
        "set rtp+=$VIM/bundle/supersearch    "插件搜索貌似单独一个.vim 放在bundle中没用"
        "nnoremap ,s :call KeySearch()<cr>
        "vnoremap ,s :call SelectSearch()<cr>
        "nnoremap ,f :call FormatFile()<cr>
        "map <F8> :call TestProject()<CR>
        "map <F9> :call MakeProject()<CR>
    "}}}

    "Gundo历史记录回退<F4>{{{
        set rtp+=$VIM/bundle/gundo.vim          "历史记录 版本控制
        map <F4> :GundoToggle<CR>     "历史记录 版本控制
        map! <F4> <Esc>:GundoToggle<CR>     "历史记录 版本控制
        "nnoremap <Leader>u :GundoToggle<CR>     "历史记录 版本控制
    "}}}

    "ctrlp设置{{{
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
        set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows
        let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
        let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
        let g:ctrlp_extensions = ['funky']
    "}}}

        " CTags & TagList的设定 {{{ 
            "let Tlist_Sort_Type = "name"    " 按照名称排序  
            "let Tlist_Use_Right_Window = 1  " 在右侧显示窗口  
            "let Tlist_Compart_Format = 1    " 压缩方式  
            "let Tlist_Exist_OnlyWindow = 1  " 如果只有一个buffer，kill窗口也kill掉buffer  
            """let Tlist_File_Fold_Auto_Close = 0  " 不要关闭其他文件的tags  
            """let Tlist_Enable_Fold_Column = 0    " 不要显示折叠树  
            ""let Tlist_Show_One_File=1            "不同时显示多个文件的tag，只显示当前文件的
            ""设置tags  
            "set tags=tags;  
            "set autochdir 
            ""默认打开Taglist 
            "let Tlist_Auto_Open=0 
            """"""""""""""""""""""""""""""" 
            "" Tag list (ctags) 
            """"""""""""""""""""""""""""""""" 
            "let Tlist_Ctags_Cmd = 'ctags' 
            "let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的 
            "let Tlist_File_Fold_Auto_Close = 1
            "let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim 
            "let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
            "nmap tl :Tlist<cr>
        "}}}

        " minibufexpl插件的一般设置{{{
            "let g:miniBufExplMapWindowNavVim = 1
            "let g:miniBufExplMapWindowNavArrows = 1
            "let g:miniBufExplMapCTabSwitchBufs = 1
            "let g:miniBufExplModSelTarget = 1  
        "}}}

        "python补全{{{
            let g:pydiction_location = '$VIM/bundle/pydiction/complete-dict'
            let g:pydiction_menu_height = 20
            let Tlist_Ctags_Cmd='$MSYS2_HOME/usr/bin/ctags'
        "}}}

        "YouCompleteMe{{{ "自动补全 配置"
            "set rtp+=$VIM/bundle/YouCompleteMe  "自动补全"
            "let g:ycm_keep_logfiles = 1
            "let g:ycm_log_level = 'debug'
        "}}}

    "配置python-mode{{{
            if has('gui_running')
                set rtp+=$VIM/bundle/python-mode      "强大的python编辑器"
                let g:pymod = 1 "Turn on the whole plugin"
                let g:pymode_warnings = 1   "When =1, Turn off plugin's warnigs"
                let g:pymod_paths = []      "add paths to sys.path"
                let g:pymode_trim_whitespaces = 1 "保存时去空格"
                let g:pymode_python = 'python'    "配置python 版本为python 或者python3"
                let g:pymode_indent = 1           "配置缩进 PEP8风格"
                let g:pymode_motion = 1           "移动方式 ]] ]M aC "
                let g:pymode_doc = 1 " 通过命令:PymodeDoc arg查阅文档
            "　　let g:pymode_doc_bind = ‘K‘ "Help Doc光标移到参数上面按快捷键K 没有该命令
                "let g:pymode_rope_ropefolder=‘pythonSrc‘ “项目文件在的目录
                "光标下单词查阅文档 '''显示注释的内容'''
                let g:pymode_rope_show_doc_bind = '<leader>d'
                "项目修改后重新生成缓存
                let g:pymode_rope_regenerate_on_write = 1
                "开启补全，并设置<A-\>为默认快捷键
                let g:pymode_rope_completion = 1
                let g:pymode_rope_complete_on_dot = 1
                let g:pymode_rope_completion_bind = '<C+/>'
                "跳转到定义处，同时新建竖直窗口打开
                let g:pymode_rope_goto_definition_bind = '<C-]>'
                let g:pymode_rope_goto_definition_cmd = 'tabnew' "or vnew"
                "重命名光标下的函数，方法，变量及类名
                let g:pymode_rope_rename_bind = '<leader>n'
                "重命名光标下的模块或包
                let g:pymode_rope_rename_module_bind = '<leader>nm'
                "开启python所有的语法高亮
                let g:pymode_syntax = 1
                let g:pymode_syntax_all = 1
                "高亮缩进错误
                let g:pymode_syntax_indent_errors = g:pymode_syntax_all
                "高亮空格错误
                let g:pymode_syntax_space_errors = g:pymode_syntax_all
            else
                syntax off
            endif

    "}}}
"}}}

