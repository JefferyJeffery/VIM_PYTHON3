" Pro version Vimrc
" I kept all other settings in plugins/settings directory
"
" Eddie Kao
" http://blog.eddie.com.tw
" eddie@digik.com.tw

" reload vimrc
" :source ~/.vimrc
" install vim
"  :PluginInstall
" Clear vim
"  :PluginClean
"
" To Install Plugins from command line:
"   vim +PluginInstall +qall

" Vundle plugin manager
""" Automatically setting up Vundle {{{
	" http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
    let has_vundle=1
    if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
        echo "Installing Vundle..."
        echo ""
        silent !mkdir -p $HOME/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
        let has_vundle=0
    endif
""" }}}

""" Initialize Vundle {{{
    filetype off                                " required to init
    set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
    call vundle#begin()                         " init vundle
""" }}}

""" Plugin {{{
    Plugin 'VundleVim/Vundle.vim'

    """ YouCompleteMe {{{
		Plugin 'Valloric/YouCompleteMe'
		""" settings {{{
			"默認配置文件路徑"
			let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
			"打開vim時不再詢問是否加載ycm_extra_conf.py配置"
			let g:ycm_confirm_extra_conf=0
			set completeopt=longest,menu
			"python解釋器路徑"
			let g:ycm_path_to_python_interpreter='/usr/local/bin/python3.6'
			"是否開啟語義補全"
			let g:ycm_seed_identifiers_with_syntax=1
			"是否在註釋中也開啟補全"
			let g:ycm_complete_in_comments=1
			let g:ycm_collect_identifiers_from_comments_and_strings = 0
			"開始補全的字符數"
			let g:ycm_min_num_of_chars_for_completion=2
			"補全後自動關機預覽窗口"
			let g:ycm_autoclose_preview_window_after_completion=1
			" 禁止緩存匹配項,每次都重新生成匹配項"
			let g:ycm_cache_omnifunc=0
			"字符串中也開啟補全"
			let g:ycm_complete_in_strings = 1
			"離開插入模式後自動關閉預覽窗口"
			autocmd InsertLeave * if pumvisible() == 0|pclose|endif
			"回車即選中當前項"
			inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '<CR>'     
			"上下左右鍵行為"
			inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
			inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
			inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
			inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'

			"跳轉到聲明
			nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>

			"跳轉到定義
			nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>

			"跳轉到定義&聲明
			nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

			"YCM還支持語義診斷 , 不合法的語句，在行首會顯示錯誤
			let g:ycm_error_symbol = '❌'
			let g:ycm_warning_symbol = '😱'

		""" }}}
	""" }}}


	""" Nerdtree - A tree explorer plugin for navigating the filesystem {{{
	 "使用
	    "1、在linux命令行界面，輸入vim
	    "2、輸入  :NERDTree ，enter
	    "3、進入當前目錄的樹形界面，通過小鍵盤上下鍵，能移動選中的目錄或文件
	    "4、目錄前面有+號，摁Enter會展開目錄，文件前面是-號，摁Enter會在右側窗口展現該文件的內容，並光標的焦點focus右側。
	    "5、ctr+w+h  光標focus左側樹形目錄，ctrl+w+l 光標focus右側文件顯示窗口。多次摁 ctrl+w，光標自動在左右側窗口切換
	    "6、光標focus左側樹形窗口，按 ? 彈出NERDTree的幫助，再次按 ？關閉幫助顯示
	    "7、輸入:q ，關閉光標所在窗口

	    "進階用法
	      "o 打開關閉文件或者目錄
	      "t 在標籤頁中打開
	      "T 在後台標籤頁中打開
	      "! 執行此文件
	      "p 到上層目錄
	      "P 到根目錄
	      "K 到第一個節點
	      "J 到最後一個節點
	      "u 打開上層目錄
	      "m 顯示文件系統菜單（添加、刪除、移動操作）
	     "? 幫助
	     "q 關閉

	Plugin 'scrooloose/nerdtree'    
	    """ settings {{{

			" NERDTree config
			" open a NERDTree automatically when vim starts up
			autocmd vimenter * NERDTree

			"open a NERDTree automatically when vim starts up if no files were specified
			autocmd StdinReadPre * let s:std_in=1
			autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
			
			"open NERDTree automatically when vim starts up on opening a directory
			autocmd StdinReadPre * let s:std_in=1
			autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
			
			"map F2 to open NERDTree
			map <F2> :NERDTreeToggle<CR>
			
			"close vim if the only window left open is a NERDTree
			autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


	        nnoremap <silent><leader>nn :NERDTreeToggle<CR>:wincmd =<CR>
	        nnoremap <silent><leader>nf :NERDTreeFind<CR>:wincmd =<CR>
	        let g:NERDTreeShowBookmarks = 1 "顯示書籤"
	        let g:NERDTreeChDirMode = 1
	        let g:NERDTreeMinimalUI = 0
	        let g:NERDTreeHighlightCursorline = 1
	        let NERDTreeShowHidden = 1  " To enable this behavior by default, add this line to your .vimrc file
			
			"窗口大小"
			let NERDTreeWinSize=25

	        let NERDTreeIgnore = [
	          \'\.DS_Store$',
	          \'\.bundle$',
	          \'\.capistrano$',
	          \'\.git$',
	          \'\.gitkeep$',
	          \'\.keep$',
	          \'\.localized$',
	          \'\.routes$',
	          \'\.sass-cache$',
	          \'\.swo$',
	          \'\.swp$',
	          \'tags$'
	        \]

	    """ }}}
    """ }}}

    """ nerdtree-git-plugin {{{
	    Plugin 'Xuyuanp/nerdtree-git-plugin'
	    """ settings {{{
	    let g:NERDTreeIndicatorMapCustom = {
	        \ "Modified"  : "✹",
	        \ "Staged"    : "✚",
	        \ "Untracked" : "✭",
	        \ "Renamed"   : "➜",
	        \ "Unmerged"  : "═",
	        \ "Deleted"   : "✖",
	        \ "Dirty"     : "✗",
	        \ "Clean"     : "✔︎",
	        \ "Unknown"   : "?"
	        \ }
	    """ }}}
    """ }}}

	""" Vim-nerdtree-tabs - This plugin aims at making NERDTree feel like a true panel, independent of tabs. {{{
	    " http://hatemegalaxy.blogspot.tw/2016/05/linux-nerdtree-tabs-install-nerdtree.html
	    	"\t  # 於新頁籤中呈現所選檔案
	    	":q # 關閉視窗
	    	"Ctrl + ww # 於目前頁籤中切換操作區塊
	    Plugin 'jistr/vim-nerdtree-tabs'
	    """ NERDTree-Tabs {{{
	        let g:nerdtree_tabs_open_on_console_startup=1       "設置打開vim的時候默認打開目錄樹

	        " 開啟或關閉 NERDTree Tabs，快捷鍵: \t "
	        "nmap <silent> <leader>t :NERDTreeTabsToggle
	    """ }}}
	""" }}}
	
	""" Status Line {{{

		" 狀態列顯示的好幫手
		Plugin 'vim-airline/vim-airline'
	    """ {{{
	        "http://terrychen.logdown.com/posts/2014/10/18/vim-airline-status-bar-helper
	        " set cmdheight=1 " 設定命令行的行數為 1
	        set laststatus=2 " 顯示狀態欄 (默認值為 1, 無法顯示狀態欄)
	        "set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\  " 設置在狀態行顯示的信息
	        let g:airline#extensions#tabline#enabled = 1
	        let g:airline#extensions#tabline#left_sep = ' '
	        let g:airline#extensions#tabline#left_alt_sep = '|'
	        let g:airline_powerline_fonts = 1
	        let g:airline#extensions#syntastic#enabled = 1
	    """ }}}

		" vim-airliUsing a Theme
	    " Once installed, use :AirlineTheme <theme> to set the theme, e.g. :AirlineTheme simpl
        " To set in .vimrc, use let g:airline_theme='<theme>', e.g. let g:airline_theme='simple'ne 
		Plugin 'vim-airline/vim-airline-themes'
	    """ {{{
	        let g:airline_theme='vice'
	    """ }}}
	""" }}}

	"""  縮進指示線" {{{
	Plugin 'Yggdroot/indentLine'
		""" settings {{{
			let g:indentLine_char='┆'
			let g:indentLine_enabled = 1
		""" }}}
	""" }}}

	""" 自動格式化工具" {{{
	"使用
		"shortcut
	      "Open Python file.
	      "Press <F8> to run autopep8 on it
	    "call function
	      ":Autopep8
	    "with arguments
	      ":Autopep8 --range 1 5
	    "or
	      ":call Autopep8(" --range 1 5")	

	 Plugin 'tell-k/vim-autopep8'  
		""" settings {{{
			let g:autopep8_disable_show_diff=1
		""" }}}
	""" }}}


	" 括號和引號自動補全，輸入左引號和左括號自動補全另外一半 "
	Plugin 'jiangmiao/auto-pairs'


	""" Super easy commenting, toggle comments etc {{{
		"單行註解：在normal模式下, 連按 '\\' 
		"多行註釋: 只需要在normal模式下按v並移動光標選擇需要註釋的行,
		"         連按 '\\' 就可以為所有選中的行添加註釋
	Plugin 'scrooloose/nerdcommenter'
		""" settings {{{
			map <leader>\ <leader>ci <CR>
		""" }}}
	""" }}}

	""" buffer {{{
	    "http://www.study-area.org/tips/vim/Vim-6.html
	    "http://bearsu.logdown.com/posts/305966-vim-buffer-window
	        ":bn     跳下一個buffer
	        ":bp     往上一個buffer
	        ":b n    跳往第n個buffer
	        ":bd     關掉目前buffer
	        ":ls     Show all open buffers and their status
	    nmap <leader>bn :bn<CR>
	    nmap <leader>bp  :bp<CR>
	    nmap <leader>bd  :bd<CR>
	    nmap <leader>bl :ls<CR>
	    nmap <leader>1 :b 1<CR>
	    nmap <leader>2 :b 2<CR>
	    nmap <leader>3 :b 3<CR>
	    nmap <leader>4 :b 4<CR>
	    nmap <leader>5 :b 5<CR>
	    nmap <leader>6 :b 6<CR>
	    nmap <leader>7 :b 7<CR>
	    nmap <leader>8 :b 8<CR>
	    nmap <leader>9 :b 9<CR>
	    nmap <leader>0 :b 0<CR>

	    " This allows buffers to be hidden if you've modified a buffer.
	    " This is almost a must if you wish to use buffers in this way.
	    "set hidden

	""" }}}

	""" search {{{
	    "查找文件
	    "http://www.jianshu.com/p/SRsmZW
	    " ctrl - p : 打開列表， 然后输入你要寻找的文件就行了
	    " 还有其他一些快捷查找键，如正则查找等
	    "Press <c-r> to switch to regexp mode.
	    "Press <F5> to purge the cache for the current directory to get new files,
	    "           remove deleted files and apply new ignore options.
	    "Press <c-f> and <c-b> to cycle between modes.
	    "Press <c-d> to switch to filename only search instead of full path.
	    "Use <c-j>, <c-k> or the arrow keys to navigate the result list.
	    "Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
	    "Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
	    "Use <c-y> to create a new file and its parent directories.
	    "Use <c-z> to mark/unmark multiple files and <c-o> to open them.
	    "
	    "Run :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.
	    "Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.
	    Plugin 'kien/ctrlp.vim'
	    """ search {{{
	      "let g:ctrlp_map = '<leader>'
	        let g:ctrlp_map = '<c-p>'
	        let g:ctrlp_cmd = 'CtrlP'
	        set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
	        set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

	        let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
	        let g:ctrlp_custom_ignore = {
	        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
	        \ 'file': '\v\.(exe|so|dll)$',
	        \ 'link': 'some_bad_symbolic_links',
	        \ }

	        let g:ctrlp_working_path_mode = 'ra'
	      "'c' - the directory of the current file.
	      "'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
	      "'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of
	      "      the directory of the current file.
	      "0 or '' (empty string) - disable this feature.
	    """ }}}

	    "多文件下关键字搜索  (簡易版的 vimgrep)
	    " :vim[grep][!] /{pattern}/[g][j] {file} ...
	    " :vimgrep /hello/j **
	    "<leader>預設值是對應到"\"
	    "<leader>vv - Grep for the word under the cursor | grep 游標位置
	    "<Leader>vV - Grep for the word under the cursor, match whole word, like  |star|
	    "<leader>va - Like vv, but add to existing list | grep 游標位置並加入清單
	    "<Leader>vA  - Like vV, but add to existing list
	    "<Leader>vr  - Perform a global search search on the word under the cursor
	    "              and prompt for a pattern with which to replace it.
	    "<leader>vo - Select the files to search in and set grep options | Easygrep 選項
	    "              * 列出所有自訂選項
	    "              ? 列出所有選項
	    "  進入選單後，上下方向鍵可以選擇search模式
	    "  //All: 全部文件, Beffers: 只在Buffers中的文件

	    " commands:
	        ":Grep [arg]
	            "Search for the specified arg, like <Leader>vv.  When an ! is added,
	            "search like <Leader>vV
	        ":GrepAdd [arg]
	            "Search for the specified arg, add to existing file list, as in
	            "<Leader>va.  When an ! is added, search like <Leader>vA
	        ":Replace [target] [replacement]
	            "Perform a global search and replace.  The function searches
	            "the same set of files a grep for the desired target and opens a dialog to
	            "confirm replacement.
	        ":ReplaceUndo
	            "Undoes the last :Replace operation.  Does not stack successive
	            "searches; only the last replace may be undone.  This function may not
	            "work well when edits are made between a call to Replace and a call to
	            "ReplaceUndo.
	        ":GrepOptions [arg]
	            "Open a window to set grep options.
	            "
	    "搜尋結果列在quickfix
	    " http://rickey-nctu.blogspot.tw/2009/02/vim-quickfix.html
	    ":copen " 打開QF視窗
	    ":cclose " 關閉QF視窗

	    ":cnext | :cn [nCount] " 移到下一行(QF中),編輯視窗游標也會移到被搜尋行,
	    ""                       若 nCount設為 3 ,代表會從QF HighLight處(ex :
	    ""                       1),移到往下數第 nCount 行(QF中)(ex: 4)
	    ":cprev | :cp [nCount] " 移到前一個錯誤,編輯視窗游標也會移到被搜尋行,
	    "                        nCount描述如上
	    "注意:  如果QF  HighLight為最後一個，要用 :cp 往回找，他沒有支援循環搜尋

	    ":cnewer " 若有多個QF buffer，移到下一個錯誤訊息列表
	    ":colde " 若有多個QF buffer，移到前一個錯誤訊息列表
	    Plugin 'vim-scripts/EasyGrep'

	""" }}}

""" }}}
""" Finish Vundle stuff {{{
    call vundle#end()
""" }}}
""" Installing plugins the first time, quits when done {{{
    if has_vundle == 0
        :silent! PluginInstall
        :qa
    endif
""" }}}

""" User interface {{{

	""" Color Scheme for Vim {{{

	    "T-H-E colorscheme
	    Plugin 'altercation/vim-colors-solarized'
	    " Molokai Color Scheme
	    Plugin 'tomasr/molokai'
	    """ color  {{{
	      colorscheme molokai
	      let g:molokai_original = 1
	      let g:rehash256 = 1
	    """}}}

	    " Glorious colorscheme
	    "Plugin 'nanotech/jellybeans.vim'

	""" }}}

""" }}}

"==========================================  
"General  
"==========================================  
" history存儲長度。  
set history=1000    

"檢測文件類型  
filetype on  

" 針對不同的文件類型採用不同的縮進格式    
filetype indent on                 

" 允許插件    
filetype plugin on  

" 啟動自動補全  
filetype plugin indent on  

" syntax highlighting
syntax on                                  

"兼容vi模式。去掉討厭的有關vi一致性模式，避免以前版本的一些bug和侷限  
set nocompatible        
set autoread          " 文件修改之後自動載入。  
set shortmess=atI       " 啟動的時候不顯示那個援助索馬里兒童的提示  

" 取消備份。  
"urn backup off, since most stuff is in SVN, git et.c anyway...  
set nobackup  
set nowb  
set noswapfile  

"貼時保持格式  
" set paste  
"- 則點擊光標不會換,用於複製  
set mouse-=a           " 在所有的模式下面打開鼠標。  
set selection=exclusive    
set selectmode=mouse,key  

" No annoying sound on errors  
" 去掉輸入錯誤的提示聲音  
set noerrorbells  
set novisualbell  
set t_vb=  
set tm=500    

set background=dark                         " we're using a dark bg
"==========================================  
" highlighting 
"========================================== 
""" Force behavior and filetypes, and by extension highlighting {{{
    augroup FileTypeRules
        autocmd!
        autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
        autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
        autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
    augroup END
""" }}}

""" 256 colors for maximum jellybeans bling. See commit log for info {{{
    if (&term =~ "xterm") || (&term =~ "screen")
        set t_Co=256
    endif
""" }}}

""" Custom highlighting, where NONE uses terminal background {{{
    function! CustomHighlighting()
        highlight Normal ctermbg=NONE
        highlight NonText ctermbg=NONE
        highlight LineNr ctermbg=NONE
        highlight SignColumn ctermbg=NONE
        highlight SignColumn guibg=#151515
        highlight CursorLine ctermbg=235
    endfunction

    call CustomHighlighting()
""" }}}

"==========================================  
" show and format  
"==========================================  
"顯示行號：  
set number  
set nowrap                    " 取消換行。  
"為方便複製，用<F6>開啟/關閉行號顯示:  
nnoremap <F6> :set nonumber!<CR>:set foldcolumn=0<CR>  

"括號配對情況  
set showmatch  
" How many tenths of a second to blink when matching brackets  
set mat=2  

"設置文內智能搜索提示  
" 高亮search命中的文本。  
set hlsearch            
" 搜索時忽略大小寫  
set ignorecase  
" 隨著鍵入即時搜索  
set incsearch  
" 有一個或以上大寫字母時仍大小寫敏感  
set smartcase  

" 代碼摺疊  
set foldenable  
" 摺疊方法  
" manual    手工摺疊  
" indent    使用縮進表示摺疊  
" expr      使用表達式定義摺疊  
" syntax    使用語法定義摺疊  
" diff      對沒有更改的文本進行摺疊  
" marker    使用標記進行摺疊, 默認標記是 {{{ 和 }}}  
set foldmethod=syntax  
" 在左側顯示摺疊的層次  
"set foldcolumn=4  

set tabstop=4                " 設置Tab鍵的寬度        [等同的空格個數]  
set shiftwidth=4  
set expandtab                " 將Tab自動轉化成空格    [需要輸入真正的Tab鍵時，使用 Ctrl+V + Tab]  
" 按退格鍵時可以一次刪掉 4 個空格  
set softtabstop=4  
set backspace=2

set ai "Auto indent  
set si "Smart indent  

"==========================================  
" status  
"==========================================  
"顯示當前的行號列號：  
set ruler  
"在狀態欄顯示正在輸入的命令  
set showcmd  

" Set 7 lines to the cursor - when moving vertically using j/k 上下滾動,始終在中間  
set so=7    
"set cursorline              " 突出顯示當前行


" 按F5運行python"
map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
