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

"""  Vundle plugin manager {{{

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

	"==========================================  
	" Auto Complete
	"========================================== 
    """ YouCompleteMe {{{
        Plugin 'Valloric/YouCompleteMe'
        """ settings {{{
            " 默認配置文件路徑
            " 引入，可以补全系统，以及python的第三方包
            let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
            let g:ycm_key_invoke_completion = ''
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
            let g:ycm_min_num_of_chars_for_completion=1
            "補全後自動關機預覽窗口"
            let g:ycm_autoclose_preview_window_after_completion=1
            " 禁止緩存匹配項,每次都重新生成匹配項"
            let g:ycm_cache_omnifunc=0
            "字符串中也開啟補全"
            let g:ycm_complete_in_strings = 1
            let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
            let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure

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
            " let g:ycm_error_symbol = '❌'
            " let g:ycm_warning_symbol = '😱'

        """ }}}
    """ }}}

    "==============================
	" ultisnips
	"==============================
    Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'

    "--> UltiSnips模板生成
	"￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

	let g:UltiSnipsExpandTrigger       = "<tab>"
	let g:UltiSnipsJumpForwardTrigger  = "<tab>"
	let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
	let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
    let g:UltiSnipsSnippetDirectories = ['UltiSnips']

    let g:UltiSnipsUsePythonVersion = 3

	function! g:UltiSnips_Complete()
	    call UltiSnips#ExpandSnippet()
	    if g:ulti_expand_res == 0
	        if pumvisible()
	            return "\<C-n>"
	        else
	            call UltiSnips#JumpForwards()
	            if g:ulti_jump_forwards_res == 0
	               return "\<TAB>"
	            endif
	        endif
	    endif
	    return ""
	endfunction
	autocmd BufNewFile,BufRead *.snippets setf snippets
	" 自动调用 UltiSnipsAddFileTypes filetype
	" autocmd FileType * call UltiSnips#FileTypeChanged()
	autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<CR>"
	augroup Filetype_Specific
	    autocmd FileType javascript nnoremap <buffer> <leader>j :call JsBeautify()<CR>
	    autocmd FileType html nnoremap <buffer> <leader>j :call HtmlBeautify()<CR>
	    autocmd FileType css nnoremap <buffer> <leader>j :call CSSBeautify()<CR>
	    autocmd FileType json nnoremap <buffer> <leader>j :call JsonBeautify()<CR>
	    autocmd FileType javascript vnoremap <buffer>  <leader>j :call RangeJsBeautify()<cr>
	    autocmd FileType html vnoremap <buffer> <leader>j :call RangeHtmlBeautify()<cr>
	    autocmd FileType css vnoremap <buffer> <leader>j :call RangeCSSBeautify()<cr>
	    autocmd FileType json vnoremap <buffer> <leader>j :call RangeCSSBeautify()<cr>
	augroup END

	"==========================================  
	" JavaScript  
	"==========================================  
    " This is a Vim plugin that provides Tern-based JavaScript editing
    " support.
    Plugin 'ternjs/tern_for_vim'
    "## Installation
    "#### Manual
    "If you use [Pathogen][path] or something similar, you can clone this
    "repository to your `~/.vim/bundle` (or equivalent) directory. Make
    "sure you have [node.js][node] and [npm][npm] installed (Tern is a
    "JavaScript program), and install the tern server by running `npm
    "install` in the `bundle/tern_for_vim` directory.

    """ tern {{{
        "http://efe.baidu.com/blog/vim-javascript-completion/
        "http://yogeshpowar.blogspot.tw/2016/02/vim-javascript-and-tern.html
        "http://usevim.com/2013/05/24/tern/
        set omnifunc=syntaxcomplete#Complete
        let g:tern_map_keys=1
        " 鼠标停留在方法内时显示参数提示
        let g:tern_show_argument_hints = 'on_hold'
        " 补全时显示函数类型定义
        let g:tern_show_signature_in_pum = 1
         "跳转到浏览器
        "nnoremap <leader>tb :TernDocBrowse<cr>
        " 显示变量定义
        "nnoremap <leader>tt :TernType<cr>
        " 跳转到定义处
        "nnoremap <leader>tf :TernDef<cr>
        " 显示文档
        "nnoremap <leader>td :TernDoc<cr>
        "Look up definition in new split
        "nnoremap <leader>tsd :TernDefSplit<cr>
        " 预览窗口显示定义处代码
        "nnoremap <leader>tp :TernDefPreview<cr>
        " 变量重命名
        "nnoremap <leader>tr :TernRename<cr>
        " location 列表显示全部引用行
        "nnoremap <leader>ts :TernRefs<cr>
    """ }}}

	"==========================================  
	"  Syntax Highlight for js lib
	"==========================================  
    Plugin 'othree/javascript-libraries-syntax.vim'
    "let g:used_javascript_libs = 'underscore,backbone,jquery,vue,react'


	"==========================================  
    "Vim syntax highlighting for pug , html
	"==========================================  
    Plugin 'digitaltoad/vim-pug'
    Plugin 'tpope/vim-haml'
    
	"==========================================  
	" Nerdtree  
	"==========================================  

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

		""" Vim-nerdtree-tabs - This plugin aims at making NERDTree feel like a true panel, independent of tabs. {{{
		    " http://hatemegalaxy.blogspot.tw/2016/05/linux-nerdtree-tabs-install-nerdtree.html
		    	"\t  # 於新頁籤中呈現所選檔案
		    	":q # 關閉視窗
		    	"Ctrl + ww # 於目前頁籤中切換操作區塊
		    Plugin 'jistr/vim-nerdtree-tabs'
		    """ NERDTree-Tabs {{{
		        let g:nerdtree_tabs_open_on_console_startup=1       "設置打開vim的時候默認打開目錄樹
		    """ }}}
		""" }}}


	"==========================================  
	" TAGBAR[大綱式導航]
	" http://wklken.me/posts/2015/06/07/vim-plugin-tagbar.html
	" 1.先安裝ctags : brew install ctags
	"==========================================		
	Plugin 'majutsushi/tagbar'

	" Settings
		nmap <F9> :TagbarToggle<CR>
		" 啟動時自動focus
		let g:tagbar_autofocus = 1

	" 使用
		" 在vim中配置快捷鍵為F9, 編輯文件時按F9, 進入, 上下移動(jk)), 選中回車後會跳轉

	"==========================================  
	" EASYMOTION[快速跳轉]
	" http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html
	"==========================================
	Plugin 'Lokaltog/vim-easymotion'

	" Settings

		let g:EasyMotion_smartcase = 1
		"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
		map <Leader><leader>h <Plug>(easymotion-linebackward)
		map <Leader><Leader>j <Plug>(easymotion-j)
		map <Leader><Leader>k <Plug>(easymotion-k)
		map <Leader><leader>l <Plug>(easymotion-lineforward)
		" 重複上一次操作, 類似repeat插件, 很強大
		map <Leader><leader>. <Plug>(easymotion-repeat)

	"==========================================  
	"   indent
	"========================================== 

		"""  縮進指示線" {{{
		Plugin 'Yggdroot/indentLine'
			""" settings {{{
				let g:indentLine_char='┆'
				let g:indentLine_enabled = 1
			""" }}}
		""" }}}

	"==========================================  
	" Coding 必備
	"========================================== 

		""" 自動格式化工具" {{{
			Plugin 'tell-k/vim-autopep8'  
			""" settings {{{
				let g:autopep8_disable_show_diff=1
				autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
			""" }}}

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

		""" }}}

		""" 括號和引號自動補全，輸入左引號和左括號自動補全另外一半 {{{
			Plugin 'jiangmiao/auto-pairs'
		""" }}}

		""" Super easy commenting, toggle comments etc {{{
			Plugin 'scrooloose/nerdcommenter'
			""" settings {{{
				map <Leader><Leader>\ <leader>ci <CR>
			""" }}}

			"單行註解：在normal模式下, 連按 '\\' 
			"多行註釋: 只需要在normal模式下按v並移動光標選擇需要註釋的行,
			"         連按 '\\' 就可以為所有選中的行添加註釋

		""" }}}

		""" Vim PlantUML
			Plugin 'aklt/plantuml-syntax'

			" I have already set alies of plantuml in ~/.bashrc
			" alies plantuml='java -jar $HOME/.local/lib/java/plantuml.jar -tsvg'
			" let g:plantuml_executable_script='~/.vim/shell/plantuml.sh'

			" Usage
			" open *.pu, *.uml or *.plantuml files or if the first line of a file contains @startuml , and command ':make'

		""" buffer {{{
		    "http://www.study-area.org/tips/vim/Vim-6.html
		    "http://bearsu.logdown.com/posts/305966-vim-buffer-window
		        ":bn     跳下一個buffer
		        ":bp     往上一個buffer
		        ":b n    跳往第n個buffer
		        ":bd     關掉目前buffer
		        ":ls     Show all open buffers and their status
		    nmap <C-n> :bn<CR>
			"nmap <c-b>  :bp<CR>
		    nmap <C-d>  :bd<CR>
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

		    "多文件下关键字搜索  (簡易版的 vimgrep)  [ http://vim.wikia.com/wiki/Find_in_files_within_Vim ]
		    " :vim[grep][!] /{pattern}/[g][j] {file} ...
		    " :lvim[grep][!] /{pattern}/[g][j] {file} ...

		    " The 'pattern' : regular expressions
		    " The 'g' option specifies that all matches for a search will be returned instead of just one per line, 
		    " The 'j' option specifies that Vim will not jump to the first match automatically.

			" 'vim'/'grep'/'vimgrep' fill the "quickfix list", which can be opened with :cw or :copen, and is a list shared between ALL windows.
		    " 'lvim'/'lgrep'/'lvimgrep' fill the "location list," which is local to the current window, and can be opened with :lw or :lopen

		    " For example, to search for the words "house" or "home" in all .txt files in the current directory, use:
			" :lvim /\<\(house\|home\)\>/gj *.txt
			" :lw

			" Recursive search
			" You can use ** in the file pattern to search recursively. 
			" For example, to search for all lines containing "dostuff()" in all .c files in the parent directory and all its subdirectories, use:
			" :vimgrep /dostuff()/j ../**/*.c

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

	"==========================================  
	"  Vdebug is a new, fast, powerful debugger client for Vim. 
    "  It's multi-language, and has been tested with 
    "  PHP, Python, Ruby, Perl, Tcl and NodeJS. 
    "  It interfaces with any debugger that faithfully uses the
    "  DBGP protocol, such as Xdebug for PHP.
    "  
    "   https://github.com/joonty/vdebug
	"========================================== 
        "Plugin 'joonty/vdebug'

        "Quick guide

        "Set up any DBGP protocol debugger, e.g. Xdebug. (See :help VdebugSetUp). Start Vdebug with <F5>, which will make it wait for an incoming connection. Run the script you want to debug, with the debugging engine enabled. A new tab will open with the debugging interface.

        "Once in debugging mode, the following default mappings are available:

        "<F5>: start/run (to next breakpoint/end of script)
        "<F2>: step over
        "<F3>: step into
        "<F4>: step out
        "<F6>: stop debugging (kills script)
        "<F7>: detach script from debugger
        "<F9>: run to cursor
        "<F10>: toggle line breakpoint
        "<F11>: show context variables (e.g. after "eval")
        "<F12>: evaluate variable under cursor
        ":Breakpoint <type> <args>: set a breakpoint of any type (see :help VdebugBreakpoints)
        ":VdebugEval <code>: evaluate some code and display the result
        "<Leader>e: evaluate the expression under visual highlight and display the result
        "To stop debugging, press <F6>. Press it again to close the debugger interface.

        "If you can't get a connection, then chances are you need to spend a bit of time setting up your environment. Type :help Vdebug for more information.
        "
        "
        "Debugging

        "If you have a problem, and would like to see what's going on under the hood or raise an issue, it's best to create a log file. You can do this by setting these options before you start debugging:

        ":VdebugOpt debug_file ~/vdebug.log
        ":VdebugOpt debug_file_level 2
	"==========================================  
	"  語法檢查
	" http://www.wklken.me/posts/2015/06/07/vim-plugin-syntastic.html
	"========================================== 
	    " 可以做到即時錯誤檢查
	    Plugin 'vim-syntastic/syntastic'

	    """ settings
        " Automatic checking for active, only when :SyntasticCheck for passive
        " 被動使用 syntastic，不要自動 check，下 :SyntasticCheck 才會 check
        let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes':
                \ ['c', 'cpp', 'perl', 'python','javascript'] }

	    let g:syntastic_error_symbol='❌'
		let g:syntastic_warning_symbol='😱'
		let g:syntastic_check_on_open=1
		let g:syntastic_check_on_wq=0   			 " Skip check on :wq, :x, :ZZ etc
		let g:syntastic_enable_highlighting=1
		
		" python
		let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
		
		" html
		let g:syntastic_html_checkers=['tidy', 'jshint']

		" javascript
        let g:syntastic_javascript_checkers = ['standard']
        let g:syntastic_javascript_standard_generic = 1
        "let g:syntastic_javascript_checkers = ['eslint']
        "let g:syntastic_javascript_eslint_exec = 'eslint'

		" 修改高亮的背景色, 适应主题
		highlight SyntasticErrorSign guifg=white guibg=black

		" statusline
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

		" to see error location list
		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_auto_loc_list = 1
		let g:syntastic_loc_list_height = 5
		function! ToggleErrors()
		    let old_last_winnr = winnr('$')
		    lclose
		    if old_last_winnr == winnr('$')
		        " Nothing was closed, open syntastic error location panel
		        Errors
		    endif
		endfunction
		nnoremap <Leader>s :call ToggleErrors()<cr>
		" nnoremap <Leader>sn :lnext<cr>
		" nnoremap <Leader>sp :lprevious<cr>
	"==========================================  
	" Git  
	"==========================================  

	    """ nerdtree-git-plugin {{{
		    Plugin 'Xuyuanp/nerdtree-git-plugin'
		    """ settings {{{
		    let g:NERDTreeIndicatorMapCustom = {
		        \ "Modified"  : "~",
		        \ "Staged"    : "✚",
		        \ "Untracked" : "✹",
		        \ "Renamed"   : "➜",
		        \ "Unmerged"  : "═",
		        \ "Deleted"   : "✖",
		        \ "Dirty"     : "!",
		        \ "Clean"     : "✔︎",
		        \ "Unknown"   : "?"
		        \ }
		    """ }}}
	    """ }}}

	    " A Vim plugin which shows a git diff in the 'gutter' (sign column).
	    Plugin 'airblade/vim-gitgutter'

	    " Git wrapper inside Vim
	    Plugin 'tpope/vim-fugitive'
        """ setting
        " Signify ------------------------------

        " this first setting decides in which order try to guess your current vcs
        " UPDATE it to reflect your preferences, it will speed up opening files
        let g:signify_vcs_list = [ 'git', 'hg' ]
        " mappings to jump to changed blocks
        nmap sn (signify-next-hunk)
        nmap sp (signify-prev-hunk)
        " nicer colors
        highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
        highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
        highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
        highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
        highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
        highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
	"==========================================  
	"   Status Line - airline
	"   狀態列顯示的好幫手
	"   http://terrychen.logdown.com/posts/2014/10/18/vim-airline-status-bar-helper
	"==========================================  
	
	Plugin 'vim-airline/vim-airline'
	Plugin 'Lokaltog/powerline-fonts.git'  " 需要 'cd powerline-fonts/'  並執行 './install.sh'
	" All Powerline fonts installed to /Users/Jeffery/Library/Fonts at 2017/3/10

    """ {{{
        "http://terrychen.logdown.com/posts/2014/10/18/vim-airline-status-bar-helper
        " set cmdheight=1 " 設定命令行的行數為 1
        set laststatus=2 " 顯示狀態欄 (默認值為 1, 無法顯示狀態欄)
        " set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\  " 設置在狀態行顯示的信息
        
        let g:airline#extensions#syntastic#enabled = 1

		" show buffer number
		let g:airline#extensions#tabline#buffer_nr_show = 1


		" enable tabline
        let g:airline#extensions#tabline#enabled = 1

		" enable powerline-fonts
		let g:airline_powerline_fonts = 1
		set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h14
		" vi 另外需要在 item2中設定: Preferences > Profile > Text > Font > Change Font ==> set Meslo\ LG\ S\ Regular\ for\ Powerline:h14
		"                                                       > Non-Ascii Font > Change Font ==> set Meslo\ LG\ S\ Regular\ for\ Powerline:h14

		" vim-airline
		if !exists('g:airline_symbols')
		  let g:airline_symbols = {}
		endif

		if !exists('g:airline_powerline_fonts')
			let g:airline#extensions#tabline#left_sep = ' '
			let g:airline#extensions#tabline#left_alt_sep = '|'
			let g:airline_left_sep          = '⫸'
			let g:airline_left_alt_sep      = '»'
			let g:airline_right_sep         = '⫷'
			let g:airline_right_alt_sep     = '«'
			let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
			let g:airline#extensions#readonly#symbol   = '⊘'
			let g:airline#extensions#linecolumn#prefix = '¶'
			let g:airline#extensions#paste#symbol      = 'ρ'
			let g:airline_symbols.linenr    = '␊'
			let g:airline_symbols.branch    = '⎇'
			let g:airline_symbols.paste     = 'ρ'
			let g:airline_symbols.paste     = 'Þ'
			let g:airline_symbols.paste     = '∥'
			let g:airline_symbols.whitespace = 'Ξ'
		else
			let g:airline#extensions#tabline#left_sep = ''
			let g:airline#extensions#tabline#left_alt_sep = ''

			" powerline symbols
			let g:airline_left_sep = ''
			let g:airline_left_alt_sep = ''
			let g:airline_right_sep = ''
			let g:airline_right_alt_sep = ''
			let g:airline_symbols.branch = ''
			let g:airline_symbols.readonly = ''
			let g:airline_symbols.linenr = ''
		endif

    """ }}}

    "==============================
	" vim-airliUsing a Theme
	"==============================

    " Once installed, use :AirlineTheme <theme> to set the theme, e.g. :AirlineTheme simpl
    " To set in .vimrc, use let g:airline_theme='<theme>', e.g. let g:airline_theme='simple'ne 
    " If you want to change the vim-airline theme , you can refrence this website:
    " 	https://github.com/vim-airline/vim-airline/wiki/Screenshots

	Plugin 'vim-airline/vim-airline-themes'
    """ {{{
        let g:airline_theme='vice'
    """ }}}


	"==========================================  
	"  Color Scheme
	"==========================================  
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

	""" Finish Vundle stuff {{{
	    call vundle#end()
	""" }}}

	""" Installing plugins the first time, quits when done {{{
	    if has_vundle == 0
	        :silent! PluginInstall
	        :qa
	    endif
	""" }}}
""" }}}


"==========================================  
" set the settings
"========================================== 
source ~/.vim/vimrc_settings


"==========================================  
"Vim syntax highlighting for Vue components.
"==========================================  
autocmd BufNewFile,BufEnter *.vue setfiletype vue
autocmd FileType vue setlocal autoindent expandtab shiftwidth=2 softtabstop=2 commentstring=//\ %s comments=:// iskeyword+=-
\ | syntax keyword htmlArg contained v-text v-html v-if v-show v-else v-for v-on v-bind v-model v-pre v-cloak v-once
\ | syntax keyword htmlArg contained key ref slot
\ | syntax keyword htmlTagName contained component transition transition-group keep-alive slot
\ | syntax include @PUG syntax/pug.vim | unlet b:current_syntax
\ | syntax include @JS syntax/javascript.vim | unlet b:current_syntax
\ | syntax include @SASS syntax/sass.vim | unlet b:current_syntax
\ | syntax region vueTemplate matchgroup=vueTag start=/^<template.*>$/ end='</template>' contains=@PUG keepend
\ | syntax region vueScript matchgroup=vueTag start=/^<script.*>$/ end='</script>' contains=@JS keepend
\ | syntax region vueStyle matchgroup=vueTag start=/^<style.*>$/ end='</style>' contains=@SASS keepend
\ | syntax sync fromstart
highlight vueTag ctermfg=Blue

"==========================================  
" Auto-Reload Your Vimrc
"========================================== 
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
