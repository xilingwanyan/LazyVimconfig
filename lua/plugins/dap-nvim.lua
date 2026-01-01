return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            -- 1. 覆盖或新增你想要的快捷键
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>dn",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over (Next)",
            },
            {
                "<leader>dq",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },

            {
                "<leader>dv",
                function()
                    local session = require("dap").session()
                    if not session or not session.current_frame then
                        return
                    end

                    local history_stack = {}
                    local buf = vim.api.nvim_create_buf(false, true)
                    local win = nil

                    -- 渲染核心：使用你指定的 @boolean.kotlin 组
                    local function render(target_buf, vars, title)
                        local lines = { "   " .. title, "" }
                        local hls = {}
                        local refs = {}

                        for _, v in ipairs(vars) do
                            local name = v.name or "unknown"
                            local val = v.value or "null"
                            local raw_type = v.type or "Unknown"

                            -- 1. 类型清洗
                            local kind = (v.variablesReference > 0) and "Obj" or "Var"
                            local display_type = raw_type:match("([^.]+)$") or raw_type
                            display_type = display_type:gsub("^%l", string.upper):gsub("Integer", "Int")

                            if (raw_type == "Unknown type" or raw_type == "unknown") and val == "null" then
                                display_type = "null"
                            end

                            local line_idx = #lines
                            local p_kind = string.format(" [%s] ", kind)
                            local p_name = string.format("%s: ", name)
                            local p_type = string.format("%s ", display_type)
                            local p_val = string.format("= %s", val)

                            table.insert(lines, p_kind .. p_name .. p_type .. p_val)
                            refs[line_idx + 1] = { ref = v.variablesReference, name = name, vars = vars, title = title }

                            -- 2. 高亮映射
                            local col = 0
                            -- [ (bracket)
                            table.insert(hls, { "@punctuation.bracket", line_idx, col + 1, col + 2 })
                            -- Kind (Blue)
                            table.insert(hls, { "RainbowDelimiterBlue", line_idx, col + 2, col + 2 + #kind })
                            -- ] (bracket)
                            table.insert(hls, { "@punctuation.bracket", line_idx, col + 2 + #kind, col + 3 + #kind })

                            col = col + #p_kind
                            -- Name
                            table.insert(hls, { "Identifier", line_idx, col, col + #name })
                            col = col + #p_name

                            -- Type (null 也会映射到 boolean 组以保持你要求的红色效果)
                            local t_grp = (display_type == "null") and "@boolean.kotlin" or "Type"
                            table.insert(hls, { t_grp, line_idx, col, col + #display_type })
                            col = col + #p_type

                            -- Value (使用你指定的 @boolean.kotlin 组)
                            local v_grp = "String"
                            if val == "null" or val == "true" or val == "false" then
                                v_grp = "@boolean.kotlin"
                            elseif tonumber(val) then
                                v_grp = "Number"
                            end
                            table.insert(hls, { v_grp, line_idx, col + 2, -1 })
                        end

                        vim.api.nvim_buf_set_lines(target_buf, 0, -1, false, lines)
                        vim.api.nvim_buf_add_highlight(target_buf, -1, "Title", 0, 0, -1)
                        for _, h in ipairs(hls) do
                            pcall(vim.api.nvim_buf_add_highlight, target_buf, -1, h[1], h[2], h[3], h[4])
                        end
                        return refs
                    end

                    -- 初始逻辑
                    session:request("scopes", { frameId = session.current_frame.id }, function(err, scopes_resp)
                        if err or not scopes_resp or not scopes_resp.scopes then
                            return
                        end
                        local scope = scopes_resp.scopes[1]

                        session:request(
                            "variables",
                            { variablesReference = scope.variablesReference },
                            function(v_err, vars_resp)
                                if v_err or not vars_resp then
                                    return
                                end

                                local current_refs = render(buf, vars_resp.variables, "Locals")

                                local width = math.floor(vim.o.columns * 0.85)
                                local height = math.min(#vars_resp.variables + 4, 18)
                                win = vim.api.nvim_open_win(buf, true, {
                                    relative = "editor",
                                    row = 4,
                                    col = math.floor(vim.o.columns * 0.075),
                                    width = width,
                                    height = height,
                                    border = "rounded",
                                    style = "minimal",
                                })

                                -- 交互：回车展开
                                vim.keymap.set("n", "<CR>", function()
                                    local row = vim.api.nvim_win_get_cursor(0)[1]
                                    local target = current_refs[row]
                                    if target and target.ref > 0 then
                                        session:request(
                                            "variables",
                                            { variablesReference = target.ref },
                                            function(re_err, re_resp)
                                                if not re_err and re_resp then
                                                    table.insert(
                                                        history_stack,
                                                        { vars = target.vars, title = target.title }
                                                    )
                                                    current_refs =
                                                        render(buf, re_resp.variables, "Object: " .. target.name)
                                                end
                                            end
                                        )
                                    end
                                end, { buffer = buf, silent = true })

                                -- 交互：Esc 返回或关闭
                                vim.keymap.set("n", "<Esc>", function()
                                    if #history_stack > 0 then
                                        local prev = table.remove(history_stack)
                                        current_refs = render(buf, prev.vars, prev.title)
                                    else
                                        if win and vim.api.nvim_win_is_valid(win) then
                                            vim.api.nvim_win_close(win, true)
                                        end
                                    end
                                end, { buffer = buf, silent = true })

                                vim.keymap.set("n", "q", "<C-W>c", { buffer = buf, silent = true })
                            end
                        )
                    end)
                end,
                desc = "All value",
            },
        },
    },
}
