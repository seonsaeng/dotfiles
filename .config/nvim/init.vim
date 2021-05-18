set fencs=utf-8
set tgc
let g:mapleader="\<Space>"
let g:maplocalleader="\<Space>"
set clipboard+=unnamedplus

" Kommentary Change default mappings {{{
lua vim.g.kommentary_create_default_mappings = false
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
" Theme and Styling Plugins {{{
Plug 'hoob3rt/lualine.nvim'
Plug 'sainnhe/everforest'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'luochen1990/rainbow'
Plug 'norcalli/nvim-colorizer.lua'
" }}}

" Telescope Plugins {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" }}}

" Editor Plugins {{{
Plug 'b3nj5m1n/kommentary'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
Plug 'mbbill/undotree'
Plug 'chaoren/vim-wordmotion'
Plug 'lambdalisue/suda.vim'
" }}}

" Tree Plugins {{{
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-ssh'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
"}}}

" Git Plugins {{{
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" }}}

" LSP and Syntax Plugins {{{
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
" }}}

" Ctags Plugin {{{
Plug 'liuchengxu/vista.vim'
" }}}

" Language Specific Plugins {{{
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'GoldsteinE/compe-latex-symbols'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" }}}

call plug#end()
" }}}

" General Settings {{{
set cul

" Colorscheme Settings{{{
set bg=light
let g:everforest_better_performance = 1
function ToggleBg()
  if &bg == "light"
    set bg=dark
  else
    set bg=light
  endif
endfunction
command BG call ToggleBg()
colorscheme everforest
"}}}

set nu rnu
set scl="number"
set sb spr
set mouse=invc
set mousehide
set lz acd
set hid
set udf
set ic scs
set et ts=2 sts=2 sw=2
set cin cino=N-s,g0,j1,J1,(0,t0,m1
set list lcs=tab:»\ ,trail:␣,extends:▶,precedes:◀,eol:↴
set tm=303
set popt+=paper:letter
set exrc
set so=10

au BufWritePre * %s/\s\+$//e
au BufEnter,FocusGained * :checkt

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

let g:vimsyn_embed='l'

" Major Keybindings {{{
noremap <silent><Leader>a gg"+yG<C-o>
noremap <silent><Leader>i gg=G<C-o>

" Make all delete related operation in * buffer{{{
noremap <Leader>d "*dd
noremap cc "*cc
noremap x "*x
" }}}

nnoremap <silent><C-Left> <C-w>h
nnoremap <silent><C-Right> <C-w>l
nnoremap <silent><C-Down> <C-w>j
nnoremap <silent><C-Up> <C-w>k
noremap <silent><S-Left> :vertical resize -3<CR>
noremap <silent><S-Right> :vertical resize +3<CR>
noremap <silent><S-Up> :resize +3<CR>
noremap <silent><S-Down> :resize -3<CR>
noremap <Leader>th <C-w>t<C-w>H
noremap <Leader>tk <C-w>t<C-w>K

nnoremap <silent><expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":nohl\<CR>\<CR>"
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
" }}}

" Wrap Settings {{{
noremap <silent><Leader>tw :call ToggleWrap()<CR>
function WrapOn()
  setlocal wrap linebreak
  setlocal display+=lastline
  noremap  <buffer> <silent><Up>   g<Up>
  noremap  <buffer> <silent><Down> g<Down>
endfunction
function WrapOff()
  setlocal nowrap
  silent! nunmap <buffer> <Up>
  silent! nunmap <buffer> <Down>
endfunction
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    call WrapOff()
  else
    echo "Wrap ON"
    call WrapOn()
  endif
endfunction
call WrapOn()
" }}}

tnoremap <S-Esc> <Esc>
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * setlocal nonu nornu bh=hide scl=no
autocmd TermOpen * startinsert
" }}}

" Special: Break Habits and Use keys for good{{{
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>
" }}}

" Telescope Settings {{{
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>tt <cmd>lua copy_template()<cr>
nnoremap <Leader>fq <cmd>Telescope quickfix<cr>
nnoremap <Leader>pr <cmd>Telescope registers<cr>
nnoremap <Leader>fl <cmd>Telescope loclist<cr>
nnoremap <Leader>rg <cmd>Telescope live_grep<cr>
nnoremap <Leader>fw <cmd>Telescope grep_string<cr>
nnoremap <Leader>fc <cmd>Telescope git_bcommits<cr>
nnoremap <Leader>mf <cmd>Telescope media_files<cr>
nnoremap <Leader>gb <cmd>Telescope git_branches<cr>
nnoremap <Leader>fg <cmd>Telescope git_files<cr>
nnoremap <Leader>sp <cmd>Telescope spell_suggest<cr>
nnoremap <Leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
lua << EOF
local function select_template(prompt_bufnr, map)
  local function copy_the_template()
    local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
    vim.fn.system("xclip -sel c < \"" .. content.cwd .. "/" .. content.value .. "\"")
    require('telescope.actions').close(prompt_bufnr)
  end

  map('i', '<CR>', function()
    copy_the_template()
  end)

  map('n', '<CR>', function()
    copy_the_template()
  end)

end

copy_template = function()
  require("telescope.builtin").find_files({
    prompt_title = "< Templates > ",
    cwd = "$HOME/programming/template",
    attach_mappings = function(prompt_bufnr, map)
      select_template(prompt_bufnr, map)
      return true
    end
  })
end
require('telescope').setup {
  extensions = {
    fzf = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
    },
  },
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')
EOF
" }}}

" Lualine Setup {{{
lua << EOF
require('lualine').setup{
  options = {theme = 'wombat'},
  extensions = {'fugitive'},
}
EOF
" }}}

" Barbar Setting {{{
let bufferline = get(g:, 'bufferline', {})
let bufferline.icons = "both"
let g:bufferline.no_name_title = "Empty Buffer"
nnoremap <silent>    <C-s> :BufferPick<CR>
nnoremap <silent>    <A-p> :BufferPrevious<CR>
nnoremap <silent>    <A-n> :BufferNext<CR>
function BufClose()
  if len(getbufinfo({'buflisted':1})) == 1
    :quit
  else
    :BufferClose
  endif
endfunction
nnoremap ZZ :call BufClose()<CR>
" }}}

" Colorizer Setup
lua require'colorizer'.setup()

" Rainbow Bracket Settings
let g:rainbow_active=1

" Fern Settings {{{
let g:fern#drawer_width = 30
let g:fern#default_hidden = 1

noremap <silent><C-f> :Fern . -drawer -toggle <CR>

function! s:init_fern() abort
  set nonu nornu
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer> N <Plug>(fern-action-new-path)
  nmap <buffer> T <Plug>(fern-action-new-file)
  nmap <buffer> D <Plug>(fern-action-new-dir)
  nmap <buffer> S <Plug>(fern-action-hidden-toggle)
  nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> <Leader> <Plug>(fern-action-mark)
endfunction

augroup fern-custom
  au! *
  au FileType fern call s:init_fern()
augroup END
let g:fern#renderer = "nerdfont"
" }}}

" Git Gutter Setting
set updatetime=500

" UndoTree Settings
noremap <silent><Leader>u :UndotreeToggle<CR>

" Kommentary Settings {{{
lua << EOF
-- NERD Commenter like Settings
vim.api.nvim_set_keymap("n", "<Leader>cu", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("v", "<Leader>cu", "<Plug>kommentary_visual_decrease", {})
vim.api.nvim_set_keymap("n", "<Leader>cc", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("v", "<Leader>cc", "<Plug>kommentary_visual_increase", {})
require('kommentary.config').configure_language("default", {
  prefer_single_line_comments = true,
})
EOF
" }}}

" Tree-Sitter Settings {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "python", "rust", "go", "query",
  "lua", "json", "javascript", "typescript", "regex", "bash", "toml"},
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}
EOF

set fdn=4
set fdm=expr
set fde=nvim_treesitter#foldexpr()
" }}}

" Nvim-Compe Settings{{{
set cot=menuone,noselect
set shm+=c
lua << EOF
require('compe').setup {
  enabled = true,
  autocomplete = true,
  preselect = 'enable',
  source = {
    path = true,
    buffer = true,
    spell = {filetypes={"markdown", "text", "vimwiki", "tex"}},
    tags = {filetypes={"html"}},
    emoji = {filetypes={"markdown", "text", "vimwiki"}},
    nvim_lsp = true,
    nvim_lua = true,
    latex_symbols = true,
  },
}
EOF
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-y>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" }}}

" NVIM LSP Config {{{
lua << EOF
virt_text_toggle = function()
  local virtual_text = vim.b.lsp_virtual_text_enabled
  virtual_text = not virtual_text
  vim.b.lsp_virtual_text_enabled = virtual_text
  vim.lsp.diagnostic.display(vim.lsp.diagnostic.get(0, 1), 0, 1, {virtual_text = virtual_text})
end
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.gopls.setup{
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.perlls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.hls.setup{}
require'lspconfig'.jsonls.setup{
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
EOF
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent><Leader>D   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent><Leader>ad  <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent><C-v> <cmd>lua virt_text_toggle()<CR>
" }}}

" Lspsaga Settings{{{
nnoremap <silent><Leader>lf :Lspsaga lsp_finder<CR>
nnoremap <silent><Leader>ca :Lspsaga code_action<CR>
vnoremap <silent><Leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <A-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <A-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent><Leader>rn :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>
nnoremap <silent> <Leader>ld :Lspsaga show_line_diagnostics<CR>
nnoremap <silent> <Leader>cd :Lspsaga show_cursor_diagnostics<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <A-t> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-t> <C-\><C-n>:Lspsaga close_floaterm<CR>i<Esc>
lua << EOF
require'lspsaga'.init_lsp_saga()
EOF
" }}}

" Ctags Config {{{
map <silent><F4> :Vista!!<CR>
" }}}

" Indent-blankline Settings {{{
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['help', 'vista', 'man']
let g:indent_blankline_bufname_exclude = ['checkhealth']
" }}}

" Language Specific Settings {{{
" LaTex Plugin Setting
let g:tex_flavor='latex'
if has('nvim')
  let g:vimtex_compiler_progname='nvr'
endif
if executable('zathura')
  let g:vimtex_view_method='zathura'
endif
let g:vimtex_quickfix_open_on_warning=0

" VimWiki Setting
au BufNewFile,BufReadPost *.md set filetype=markdown

" Pandoc settings
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0

" }}}

" Shortcuts for auto-brackets, ditching auto-pairs{{{
" inoremap {<CR> {<CR>}<Esc>O
" inoremap {;<CR> {<CR>};<Esc>O
" inoremap (<CR> (<CR>)<Esc>O
" inoremap [<CR> [<CR>]<Esc>O
" }}}

" vim:fenc=utf-8:ft=vim:fdm=marker
