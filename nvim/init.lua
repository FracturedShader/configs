-- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "


-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------

-- disable netrw for file viewing since we have nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.foldcolumn = '1'
-- fully expand folds by default
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
-- smarter indenting
vim.opt.smartindent = true
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = false
-- except for markup languages
vim.api.nvim_create_autocmd('Filetype', { pattern = 'markdown,rst,typst', command = 'setlocal wrap' })
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = 'yes'
-- sweet sweet relative line numbers
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo! (except for tmp files)
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '/tmp/*', command = 'setlocal noundofile' })
-- no swapfiles
vim.opt.swapfile = false
-- Decent wildmenu
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'
-- when opening a file with a command (like :e),
-- don't suggest files like these:
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'
-- 1 tab == 4 spaces
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- preview changes throughout the buffer
vim.opt.inccommand = "split"
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append('iwhite')
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')
-- show a column at 100 characters as a guide for long lines
vim.opt.colorcolumn = '100'
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'
vim.opt.list = true
-- refine buffer switching behavior
vim.opt.switchbuf = 'useopen,usetab,newtab'


-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------

-- quick-open
vim.keymap.set('', '<C-p>', '<cmd>Files<cr>')
-- quick-save session
vim.keymap.set('n', '<C-q>', ':mks!<CR>:confirm qall<CR>')
-- search buffers
vim.keymap.set('n', '<leader>;', '<cmd>Buffers<cr>')
-- quick-save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
-- smart window navigation
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')
-- easier way to stop searching
vim.keymap.set({'n', 'v'}, '<leader><cr>', '<cmd>nohlsearch<cr>', { silent = true })
-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')
-- <leader><leader> toggles between buffers
vim.keymap.set({ 'n', 'v' }, '<leader><leader>', '<c-^>')
-- <leader>, shows/hides hidden characters
vim.keymap.set({ 'n', 'v' }, '<leader>,', ':set invlist<cr>')
-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%s/\\v')
vim.keymap.set('c', 's/', 's/\\v')
-- open new file adjacent to current file
vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
-- arrow keys in insert mode are fine for many cases, so move by visual line
vim.keymap.set('i', '<up>', '<c-o>gk')
vim.keymap.set('i', '<down>', '<c-o>gj')
-- close the current buffer
vim.keymap.set({ 'n', 'v' }, '<leader>bd', '<cmd>bd<cr>')
-- close all buffers
vim.keymap.set({ 'n', 'v' }, '<leader>ba', '<cmd>bufdo bd<cr>')
-- navigate buffers directly
vim.keymap.set({ 'n', 'v' }, '<leader>bh', '<cmd>bnext<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>bl', '<cmd>bprevious<cr>')
-- Useful mappings for managing tabs
vim.keymap.set({ 'n', 'v' }, '<leader>tn', '<cmd>tabnew<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>to', '<cmd>tabonly<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>tc', '<cmd>tabclose<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>tm', ':tabmove ')
-- Opens a new tab with current buffer's path. Super useful when editing neighboring files
vim.keymap.set({ 'n', 'v' }, '<leader>te', ':tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/')
-- switch cwd to the directory of the open buffer
vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')
-- allow block selection with ALT+v when terminals hijack CTRL+v
vim.keymap.set('', '<M-v>', '<C-v>')
-- easier spellchecking
vim.keymap.set('n', '<leader>ss', '<cmd>setlocal spell!<cr>')
vim.keymap.set('n', '<leader>sn', ']s')
vim.keymap.set('n', '<leader>sp', '[s')
vim.keymap.set('n', '<leader>sa', 'zg')
vim.keymap.set('n', '<leader>s?', 'z=')
-- easier navigation of quickfix list
vim.keymap.set('n', '<leader>cw', '<cmd>cope<cr>')
vim.keymap.set('n', '<leader>cc', '<cmd>cc<cr>')
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>')
vim.keymap.set('n', '<leader>cp', '<cmd>cp<cr>')
vim.keymap.set('n', '<leader>ca', '<cmd>cabove<cr>')
vim.keymap.set('n', '<leader>cb', '<cmd>cbelow<cr>')
vim.keymap.set('n', '<leader>cl', '<cmd>cl<cr>')

-------------------------------------------------------------------------------
--
-- configuring diagnostics
--
-------------------------------------------------------------------------------
-- Allow virtual text
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.HINT] = "󰌵",
            [vim.diagnostic.severity.INFO] = "󰋼",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.ERROR] = "󰅙",
        },
        numhl = {
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        },
    },
    virtual_text = true,
    virtual_lines = { current_line = true },
    severity_sort = true
})

-------------------------------------------------------------------------------
--
-- autocommands
--
-------------------------------------------------------------------------------

-- highlight yanked text
vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        pattern = '*',
        command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })'
    }
)
-- jump to last edit position on opening file
vim.api.nvim_create_autocmd(
    'BufReadPost',
    {
        pattern = '*',
        callback = function(ev)
            if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
                -- except for in git commit messages
                -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
                if not vim.fn.expand('%:p'):find('.git', 1, true) then
                    vim.cmd('exe "normal! g\'\\""')
                end
            end
        end
    }
)
-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })
-- help filetype detection (add as needed)
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.ext', command = 'set filetype=someft' })


-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
-- languages without LSP configurations
local treesitter_hl_langs = {
    'bibtex',
    'cmake',
    'comment',
    'css',
    'cuda',
    'git_config',
    'gitattributes',
    'gitignore',
    'glsl',
    'hlsl',
    'html',
    'ini',
    'javadoc',
    'javascript',
    'json',
    'just',
    'make',
    'printf',
    'regex',
    'scss',
    'sql',
    'ssh_config',
    'xml',
}
local treesitter_langs = {
    'bash',
    'c',
    'cpp',
    'python',
    'rust',
    'tsx',
    'typescript',
    'typst',
    'yaml',
    unpack(treesitter_hl_langs)
}
-- first, grab the manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- then, setup!
require("lazy").setup({
    -- main color scheme
    {
        'morhetz/gruvbox',
        lazy = false, -- load at start
        priority = 1000, -- load first
        config = function()
            vim.g.gruvbox_contrast_dark = 'hard'
            vim.o.termguicolors = true
            vim.cmd([[colorscheme gruvbox]])
            vim.o.background = 'dark'
            -- XXX: hi Normal ctermbg=NONE
            -- Make comments more prominent -- they are important.
            local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
            vim.api.nvim_set_hl(0, 'Comment', bools)
            -- Make it clearly visible which argument we're at.
            local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
            vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
            -- XXX
            -- Would be nice to customize the highlighting of warnings and the like to make
            -- them less glaring. But alas
            -- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
            -- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
        end
    },
    -- nice bar at the bottom
    {
        'itchyny/lightline.vim',
        lazy = false, -- also load at start since it's UI
        config = function()
            -- no need to also show mode in cmd line when we have bar
            vim.o.showmode = false
            vim.g.lightline = {
                active = {
                    left = {
                        { 'mode', 'paste' },
                        { 'readonly', 'filename', 'modified' }
                    },
                    right = {
                        { 'lineinfo' },
                        { 'percent' },
                        { 'fileencoding', 'filetype' }
                    },
                },
                component_function = {
                    filename = 'LightlineFilename'
                },
            }
            function LightlineFilenameInLua(opts)
                if vim.fn.expand('%:t') == '' then
                    return '[No Name]'
                else
                    return vim.fn.getreg('%')
                end
            end
            -- https://github.com/itchyny/lightline.vim/issues/657
            vim.api.nvim_exec(
                [[
                function! g:LightlineFilename()
                    return v:lua.LightlineFilenameInLua()
                endfunction
                ]],
                true
            )
        end
    },
    -- better git integration
    {
        'tpope/vim-fugitive'
    },
    -- even better git integration
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                -- Navigation
                vim.keymap.set('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                vim.keymap.set('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk)
                vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)

                vim.keymap.set('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                vim.keymap.set('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer)
                vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer)
                vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk)
                vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline)

                vim.keymap.set('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end)

                vim.keymap.set('n', '<leader>hd', gitsigns.diffthis)

                vim.keymap.set('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end)

                vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                vim.keymap.set('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                vim.keymap.set('n', '<leader>gs', gitsigns.toggle_signs)
                vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame)
                vim.keymap.set('n', '<leader>gW', gitsigns.toggle_word_diff)

                -- Text object
                vim.keymap.set({'o', 'x'}, 'ih', gitsigns.select_hunk)
            end
        }
    },
    -- better %
    {
        'andymass/vim-matchup',
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    -- easily surround text with brackets/tags
    {
        "kylechui/nvim-surround",
        version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
    },
    -- quickly seek ahead with multiple characters (enhanced f/F, t/T)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            highlight = { backdrop = false },
            modes = {
                char = {
                    highlight = { backdrop = false },
                    jump_labels = true,
                },
            },
        },
        ---@type Flash.Config
        keys = {
            { "s", mode = { "n", "x" }, function() require("flash").jump() end, desc = "Flash" },
            -- `ds` taken by nvim-surround, use 'm' (does nothing in 'o' mode) for "motion"
            { "m", mode = "o", function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    -- move lines/selection around with ALT and home row keys
    {
        'nvim-mini/mini.nvim',
        version = '*'
    },
    -- auto-cd to root of git project
    {
        'notjedi/nvim-rooter.lua',
        opts = {
            -- Except when there's no filetype, handy for `rg --vimgrep ... | nvim -c cb` when not in project root
            exclude_filetypes = { '' }
        },
    },
    -- fzf support for ^p
    {
        'junegunn/fzf.vim',
        dependencies = {
            { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
        },
        config = function()
            -- stop putting a giant window over my editor
            vim.g.fzf_layout = { down = '~20%' }
            -- when using :Files, pass the file list through
            --
            --   https://github.com/jonhoo/proximity-sort
            --
            -- to prefer files closer to the current file.
            function list_cmd()
                local base = vim.fn.fnamemodify(vim.fn.expand('%'), ':h:.:S')
                if base == '.' then
                    -- if there is no current file,
                    -- proximity-sort can't do its thing
                    return 'fd --hidden --type file --follow'
                else
                    return vim.fn.printf('fd --hidden --type file --follow | proximity-sort %s', vim.fn.shellescape(vim.fn.expand('%')))
                end
            end
            vim.api.nvim_create_user_command('Files', function(arg)
                vim.fn['fzf#vim#files'](arg.qargs, { source = list_cmd(), options = '--scheme=path --tiebreak=index' }, arg.bang)
            end, { bang = true, nargs = '?', complete = "dir" })
        end
    },
    -- File browser tree
    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            view = {
                float = {
                    enable = true,
                },
            },
        },
        init = function()
            vim.keymap.set({ 'n', 'v' }, '<leader>nt', '<cmd>NvimTreeFindFile<cr>')
        end
    },
    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = 'TSUpdate',
        branch = 'main',
        config = function()
            local ts = require("nvim-treesitter")

            ts.setup({})

            ts.install(treesitter_langs)

            -- treesitter elements all languages benefit from
            vim.api.nvim_create_autocmd('FileType', {
                pattern = treesitter_langs,
                callback = function()
                    -- treesitter-based folding
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo.foldmethod = 'expr'

                    -- treesitter-based indent
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            -- languages without semantic highlighting (LSP-based) also get syntax highlighting
            vim.api.nvim_create_autocmd('FileType', {
                pattern = treesitter_hl_langs,
                callback = function()
                    -- enable treesitter highlighting
                    vim.treesitter.start()
                end,
            })
        end
    },
    -- treesitter text objects
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            move = {
                set_jumps = true,
            },
            select = {
                -- do linewise selection where appropriate
                selection_modes = {
                    ['@class.inner'] = 'V',
                    ['@class.outer'] = 'V',
                    ['@function.inner'] = 'V',
                    ['@function.outer'] = 'V',
                    ['@loop.inner'] = 'V',
                    ['@loop.outer'] = 'V',
                },
                include_surrounding_whitespace = true,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = treesitter_langs,
                callback = function()
                    -- treesitter-based object selection
                    vim.keymap.set({ "x", "o" }, "am", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
                    end)
                    vim.keymap.set({ "x", "o" }, "im", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
                    end)
                    vim.keymap.set({ "x", "o" }, "ac", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
                    end)
                    vim.keymap.set({ "x", "o" }, "ic", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
                    end)
                    vim.keymap.set({ "x", "o" }, "as", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
                    end)
                    vim.keymap.set({ "x", "o" }, "ae", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
                    end)
                    vim.keymap.set({ "x", "o" }, "ie", function()
                        require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
                    end)

                    -- treesitter-based motions
                    vim.keymap.set({ "n", "x", "o" }, "]m", function()
                        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]]", function()
                        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]o", function()
                        require("nvim-treesitter-textobjects.move").goto_next_start({"@loop.inner", "@loop.outer"}, "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]s", function()
                        require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]z", function()
                        require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]e", function()
                        require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
                    end)

                    vim.keymap.set({ "n", "x", "o" }, "]M", function()
                        require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "][", function()
                        require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]O", function()
                        require("nvim-treesitter-textobjects.move").goto_next_end({"@loop.inner", "@loop.outer"}, "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]S", function()
                        require("nvim-treesitter-textobjects.move").goto_next_end("@local.scope", "locals")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]Z", function()
                        require("nvim-treesitter-textobjects.move").goto_next_end("@fold", "folds")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "]E", function()
                        require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects")
                    end)

                    vim.keymap.set({ "n", "x", "o" }, "[m", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[[", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[o", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_start({"@loop.inner", "@loop.outer"}, "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[s", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[z", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[e", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
                    end)

                    vim.keymap.set({ "n", "x", "o" }, "[M", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[]", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[O", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_end({"@loop.inner", "@loop.outer"}, "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[S", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[Z", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_end("@fold", "folds")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[E", function()
                        require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects")
                    end)


                    -- Go to either the start or the end, whichever is closer.
                    vim.keymap.set({ "n", "x", "o" }, "]i", function()
                        require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
                    end)
                    vim.keymap.set({ "n", "x", "o" }, "[i", function()
                        require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
                    end)

                    local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

                    -- Repeat movement with ; and ,
                    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
                    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
                end
            })
        end
    },
    -- LSP
    {
       'neovim/nvim-lspconfig',
        config = function()
            -- Setup language servers.

            -- Rust
            if vim.fn.executable('rust-analyzer') == 1 then
                vim.lsp.config('rust_analyzer', {
                    -- Server-specific settings. See `:help lspconfig-setup`
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                            },
                            completion = {
                                postfix = {
                                    enable = false,
                                },
                            },
                        },
                    },
                })
                vim.lsp.enable('rust_analyzer')
            end

            -- C++ LSP
            if vim.fn.executable('clangd') == 1 then
                vim.lsp.config('clangd', {
                    cmd = {
                        -- see clangd --help-hidden
                        "clangd",
                        "--background-index",
                        -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
                        -- to add more checks, create .clang-tidy file in the root directory
                        -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
                        "--clang-tidy",
                        "--completion-style=bundled",
                        "--cross-file-rename",
                        "--header-insertion=iwyu",
                    },
                    init_options = {
                        clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
                        usePlaceholders = true,
                        completeUnimported = true,
                        semanticHighlighting = true,
                    },
                })
                vim.lsp.enable('clangd')
            end

            -- Bash LSP
            if vim.fn.executable('bash-language-server') == 1 then
                vim.lsp.config('bash_lsp', {
                    cmd = { 'bash-language-server', 'start' },
                    filetypes = { 'sh' },
                    root_dir = vim.lsp.config.util.find_git_ancestor,
                    init_options = {
                        settings = {
                            args = {}
                        }
                    }
                })
                vim.lsp.enable('bash_lsp')
            end

            -- Python LSP Server for Python
            if vim.fn.executable('pylsp') == 1 then
                vim.lsp.enable('pylsp')
            end

            -- Typst LSP
            if vim.fn.executable('tinymist') == 1 then
                vim.lsp.enable('tinymist')
            end

            -- Typescript LSP Server
            if vim.fn.executable('typescript-language-server') == 1 then
                vim.lsp.enable('ts_ls')
            end

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', function()
                        vim.lsp.buf.declaration { reuse_win = true }
                    end, opts)
                    vim.keymap.set('n', 'gd', function()
                        vim.lsp.buf.definition { reuse_win = true }
                    end, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gh', vim.lsp.buf.typehierarchy, opts)
                    vim.keymap.set('n', '<leader>ci', vim.lsp.buf.incoming_calls, opts)
                    vim.keymap.set('n', '<leader>co', vim.lsp.buf.outgoing_calls, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
                    -- *and* there's some way to make it only apply to the current line.
                    -- if client.server_capabilities.inlayHintProvider then
                    --     vim.lsp.inlay_hint(ev.buf, true)
                    -- end
                end,
            })
        end
    },
    -- LSP-based code-completion
    {
        'saghen/blink.cmp',
        version = '1.*',
        opts = {
            completion = {
                documentation = { auto_show = true },
                ghost_text = { enabled = true },
                -- completions without context are just noise
                trigger = { show_on_keyword = false },
            },
        },
    },
    -- inline function signatures
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        -- Get signatures (and _only_ signatures) when in argument lists.
        opts = {
            doc_lines = 0,
            handler_opts = {
                border = "none"
            },
        },
    },
    -- better quickfix
    {
        'kevinhwang91/nvim-bqf',
        opts = {
            ft = 'qf'
        },
    },
    -- DAP: More flexible debugging beyond just Termdebug
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio'
        },
        config = function()
            local dap = require("dap")

            -- Shared/common configurations
            dap.adapters.gdb = {
              type = "executable",
              command = "gdb",
              args = { "-i", "dap" }
            }

            dap.configurations.cpp = {
                {
                    type = "gdb",
                    request = "launch",
                    name = "Launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "gdb",
                    request = "attach",
                    name = "Attach to process",
                    pid = require('dap.utils').pick_process,
                }
            }

            -- Leverage Unicode for better indicators
            vim.fn.sign_define('DapBreakpoint', {text='●', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapBreakpointCondition', {text='◆', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapLogPoint', {text='▤', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='►', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapBreakpointRejected', {text='◌', texthl='', linehl='', numhl=''})

            -- Debugging keys almost exactly like Visual Studio with some extensions (repl, hit/log points)
            vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
            vim.keymap.set('n', '<S-F5>', function() require('dap').terminate() end)
            vim.keymap.set('n', '<C-S-F5>', function() require('dap').restart() end)
            vim.keymap.set('n', '<M-F5>', function() require('dap').pause() end)
            vim.keymap.set('n', '<F6>', function() require('dap').repl.open() end)
            vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<C-F9>', function() require('dap').set_breakpoint(vim.fn.input('Condition: ')) end)
            vim.keymap.set('n', '<S-F9>', function() require('dap').set_breakpoint(nil, vim.fn.input('Hit condition: ')) end)
            vim.keymap.set('n', '<M-F9>', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message (allows {varname} interpolation): ')) end)
            vim.keymap.set('n', '<M-S-F9>', function() require('dap').set_breakpoint(nil, vim.fn.input('Hit condition: '), vim.fn.input('Log point message (allows {varname} interpolation): ')) end)
            vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<C-F10>', function() require('dap').run_to_cursor() end)
            vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<S-F11>', function() require('dap').step_out() end)

            -- Easily allow temporary overriding of keys while debugging
            local override_keys = {
                n = {
                    ["K"] = function() require('dap.ui.widgets').hover() end,
                },
                v = {
                    ["K"] = function() require('dap.ui.widgets').hover() end,
                },
            }
            local keymap_restore = {}

            dap.listeners.after.event_initialized["key_overrides"] = function()
                for mode, _ in pairs(override_keys) do
                    keymap_restore[mode] = {}
                end

                for _, buf in pairs(vim.api.nvim_list_bufs()) do
                    for mode, overrides in pairs(override_keys) do
                        local keymaps = vim.api.nvim_buf_get_keymap(buf, mode)

                        for _, keymap in pairs(keymaps) do
                            if overrides[keymap.lhs] ~= nil then
                                table.insert(keymap_restore, keymap)
                                api.nvim_buf_del_keymap(buf, mode, keymap.lhs)
                            end
                        end
                    end
                end

                for mode, overrides in pairs(override_keys) do
                    for lhs, rhs in pairs(overrides) do
                        api.nvim_set_keymap(mode, lhs, rhs)
                    end
                end
            end

            dap.listeners.after.event_terminated["key_overrides"] = function()
                for mode, keymaps in pairs(keymap_restore) do
                    for _, keymap in pairs(keymaps) do
                        vim.api.nvim_buf_set_keymap(
                            keymap.buffer,
                            keymap.mode,
                            keymap.lhs,
                            keymap.rhs,
                            { silent = keymap.silent == 1 }
                        )
                    end
                end

                keymap_restore = {}
            end

            -- Automatically open nvim-dap-ui when debugging for a more complete debugging experience
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close()
            end

        end
    },
    -- language support
    -- yaml
    {
        "cuducos/yaml.nvim",
        ft = { "yaml" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    -- rust
    {
        'rust-lang/rust.vim',
        ft = { "rust" },
        config = function()
            vim.g.rustfmt_autosave = 1
            vim.g.rustfmt_emit_files = 1
            vim.g.rustfmt_fail_silently = 0
        end
    },
    -- markdown
    {
        'plasticboy/vim-markdown',
        ft = { "markdown" },
        dependencies = {
            'godlygeek/tabular',
        },
        config = function()
            -- support front-matter in .md files
            vim.g.vim_markdown_frontmatter = 1
            -- 'o' on a list item should insert at same level
            vim.g.vim_markdown_new_list_item_indent = 0
            -- don't add bullets when wrapping:
            -- https://github.com/preservim/vim-markdown/issues/232
            vim.g.vim_markdown_auto_insert_bullets = 0
            -- support for math
            vim.g.vim_markdown_math = 1
        end
    },
})
