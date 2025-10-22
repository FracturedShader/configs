-- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "


-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------

vim.opt.foldcolumn = '1'
-- smarter indenting
vim.opt.smartindent = true
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = false
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
--" Decent wildmenu
-- in completion, when there is more than one match,
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
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })
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
-- make missing : less annoying
vim.keymap.set('n', ';', ':')
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
-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
vim.keymap.set('n', '<leader>p', '<cmd>read !wl-paste<cr>')
vim.keymap.set('n', '<leader>c', '<cmd>w !wl-copy<cr><cr>')
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
vim.keymap.set('c', '%s/', '%sm/')
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
vim.keymap.set({ 'n', 'v' }, '<leader>h', '<cmd>bnext<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>l', '<cmd>bprevious<cr>')
-- Useful mappings for managing tabs
vim.keymap.set({ 'n', 'v' }, '<leader>tn', '<cmd>tabnew<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>to', '<cmd>tabonly<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>tc', '<cmd>tabclose<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>tm', ':tabmove ')
-- Opens a new tab with current buffer's path. Super useful when editing neighboring files
vim.keymap.set({ 'n', 'v' }, '<leader>te', ':tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/')
-- switch cwd to the directory of the open buffer
vim.keymap.set({ 'n', 'v' }, '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')
-- move lines of text using ALT+[jk]
vim.keymap.set('n', '<M-j>', 'mz:m+<cr>`z')
vim.keymap.set('n', '<M-k>', 'mz:m-2<cr>`z')
vim.keymap.set('v', '<M-j>', ":m'>+<cr>`<my`>mzgv`yo`z")
vim.keymap.set('v', '<M-k>', ":m'<-2<cr>`>my`<mzgv`yo`z")
-- allow block selection with ALT+v when terminals hijack CTRL+v
vim.keymap.set('', '<M-v>', '<C-v>')
-- easier spellchecking
vim.keymap.set('n', '<leader>ss', '<cmd>setlocal spell!<cr>')
vim.keymap.set('n', '<leader>sn', ']s')
vim.keymap.set('n', '<leader>sp', '[s')
vim.keymap.set('n', '<leader>sa', 'zg')
vim.keymap.set('n', '<leader>s?', 'z=')
-- easier navigation of quickfix list
vim.keymap.set('n', '<leader>cc', '<cmd>cc<cr>')
vim.keymap.set('n', '<leader>cn', '<cmd>cn<cr>')
vim.keymap.set('n', '<leader>cp', '<cmd>cp<cr>')
vim.keymap.set('n', '<leader>ca', '<cmd>cabove<cr>')
vim.keymap.set('n', '<leader>cb', '<cmd>cbelow<cr>')
vim.keymap.set('n', '<leader>cl', '<cmd>cl<cr>')


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
    -- quick navigation
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').create_default_mappings()
        end
    },
    -- better %
    {
        'andymass/vim-matchup',
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    -- auto-cd to root of git project
    -- 'airblade/vim-rooter'
    {
        'notjedi/nvim-rooter.lua',
        config = function()
            -- Except when there's no filetype, handy for `rg --vimgrep ... | nvim -c cb` when not in project root
            require('nvim-rooter').setup { exclude_filetypes = { '' } }
        end
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
    -- LSP
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- Setup language servers.

            -- Rust
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

            -- C++ LSP
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

            -- Python LSP Server + Ruff for Python
            if vim.fn.executable('pylsp') == 1 then
                vim.lsp.config('pylsp', {
                    settings = {
                        pylsp = {
                            plugins = {
                                ruff = {
                                    enabled = true,
                                    formatEnabled = true,
                                }
                            }
                        }
                    }
                })
                vim.lsp.enable('pylsp')
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
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
        "hrsh7th/nvim-cmp",
        -- load cmp in appropriate contexts
        event = { "InsertEnter", "CmdlineEnter" },
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            'neovim/nvim-lspconfig',
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require'cmp'
            cmp.setup({
                snippet = {
                    -- REQUIRED by nvim-cmp. get rid of it once we can
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
                    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
                    ['<C-n>'] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                fallback()
                            end
                        end
                    }),
                    ['<C-p>'] = cmp.mapping({
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                fallback()
                            end
                        end
                    }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = cmp.mapping({
                        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
                            else
                                fallback()
                            end
                        end
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'path' },
                }),
                experimental = {
                    ghost_text = true,
                },
            })

            -- Enable completing paths in :
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                })
            })
        end
    },
    -- inline function signatures
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            -- Get signatures (and _only_ signatures) when in argument lists.
            require "lsp_signature".setup({
                doc_lines = 0,
                handler_opts = {
                    border = "none"
                },
            })
        end
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

            -- Override defaults by loading from '.vscode/launch.json' in the current working directory
            require('dap.ext.vscode').load_launchjs()

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
    -- toml
    'cespare/vim-toml',
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
            vim.g.rust_clip_command = 'wl-copy'
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
            -- never ever fold!
            vim.g.vim_markdown_folding_disabled = 1
            -- support front-matter in .md files
            vim.g.vim_markdown_frontmatter = 1
            -- 'o' on a list item should insert at same level
            vim.g.vim_markdown_new_list_item_indent = 0
            -- don't add bullets when wrapping:
            -- https://github.com/preservim/vim-markdown/issues/232
            vim.g.vim_markdown_auto_insert_bullets = 0
        end
    },
})
