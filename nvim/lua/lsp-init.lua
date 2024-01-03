local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
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
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-8), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(8), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
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
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
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

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>g', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

  -- None of this semantics tokens business.
  -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
  client.server_capabilities.semanticTokensProvider = nil

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local rt = require("rust-tools")

rt.setup({
  tools = {
    inlay_hints = {
      only_current_line = true
    }
  },
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- Hover actions
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.ccls.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    init_options = {
        compilationDatabaseDirectory = "build";
        highlight = {
            lsRanges = true;
        }
    },
    root_dir = lspconfig.util.root_pattern(
        ".ccls-root", "compile_commands.json", ".ccls", "build", "bin");
    capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- More flexible debugging beyond just Termdebug
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

