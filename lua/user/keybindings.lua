local M = {}

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

M.config = function()
    map("i", "jk", "<Esc>")

    map("n", "W", "5w")
    map("n", "B", "5b")

    map("n", "L", "<cmd>BufferLineCycleNext<cr>")
    map("n", "H", "<cmd>BufferLineCyclePrev<cr>")

    map("n", "se", "<cmd>split<cr>")
    map("n", "si", "<cmd>vsplit<cr>")
    map("n", "ye", "<cmd>%y+<cr>")
    map("n", "df", "<cmd>DiffviewOpen<cr>")

    lvim.lsp.buffer_mappings.normal_mode['K'] = nil
    map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>")

    map("v", "K", ":m '<-2<cr>gv=gv")
    map("v", "J", ":m '>+1<cr>gv=gv")


    -- debug
    map("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>")
    map("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>")
    map("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>")
    map("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>")
    map("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>")

    -- customize keymap
    lvim.builtin.which_key.mappings["a"] = {
        name = "Application",
        c = { "<cmd>lua require('persistence').load()<cr>", "Restore Session" },
        l = { "<cmd>Lf<cr>", "Lf" },
    }

    lvim.builtin.which_key.mappings.s = vim.tbl_extend("keep", lvim.builtin.which_key.mappings.s, {
        e = { "<cmd>Telescope projects<cr>", "Open Recently Projects" },
        s = { "<cmd>lua require('spectre').open()<cr>", "Open Spectre" },
        m = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search Current Word" },
        n = { "viw<cmd>lua require('spectre').open_file_search()<cr>", "Search on Current File" },
        o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    })


    lvim.builtin.which_key.mappings["m"] = {
        name = "M",
        a = { "<cmd>MarksListAll<cr>", "Show All Marks" },
        b = { "<cmd>MarksListBuf<cr>", "Show Marks in Buffer" },
        g = { "<cmd>MarksListGlobal<cr>", "Show Marks Global" },
        d = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown" },
    }

    lvim.builtin.which_key.mappings["t"] = {
        name = "Trouble",
        t = { "<cmd>TroubleToggle<cr>", "Toggle" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace_diagnostics" },
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document_diagnostics" },
        l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
        s = { "<cmd>TroubleToggle lsp_references<cr>", "lsp_references" },
    }

    -- disable keymap
    lvim.builtin.which_key.mappings['h'] = {}
    lvim.builtin.which_key.mappings['f'] = {}
    lvim.builtin.which_key.mappings['T'] = {}

    -- Adding a key to an existing menu/submenu.
    -- lvim.builtin.which_key.mappings.s.t  = { "<cmd>FzfLua live_grep<cr>", "FzfLua grep_project" }
    -- lvim.builtin.which_key.mappings.b.f  = { "<cmd>FzfLua buffers<cr>", "FzfLua buffers" }
    -- lvim.builtin.which_key.mappings["bb"] = { "<cmd>FzfLua blines<cr>", "Find text in Current File" }
    -- 这样写不能覆盖原有的 <leader>bb, 会造成confusion, 通过导出命令可以看到看到mappings.b.b["1"]和mappings.bb["1"]
    -- 通过下面命令去查看插件是如何配置的
    -- lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}
    -- lvim.builtin.which_key.mappings.b.b  = { "<cmd>FzfLua blines<cr>", "FzfLua blines" }
    -- lvim.builtin.which_key.mappings.s.r  = { "<cmd>FzfLua oldfiles<cr>", "FzfLua oldfiles" }

    lvim.builtin.which_key.mappings["f"] = {
        name = "FzfLua",
        f = { "<cmd>FzfLua files<cr>", "files" },
        t = { "<cmd>FzfLua live_grep<cr>", "live grep current project" },
        b = { "<cmd>FzfLua buffers<cr>", "open buffers" },
        l = { "<cmd>FzfLua blines<cr>", "current buffer lines" },
        o = { "<cmd>FzfLua oldfiles<cr>", "opened files history" },
    }

    -- terminal
    lvim.builtin.terminal.open_mapping   = "<c-t>"
end

return M
