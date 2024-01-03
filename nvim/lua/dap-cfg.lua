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

