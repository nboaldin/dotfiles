vim.api.nvim_create_user_command("BlameTimeline", function()
    local source_win = vim.api.nvim_get_current_win()
    local file = vim.fn.expand("%:p")
    if file == "" then
        vim.notify("BlameTimeline: current buffer has no file path", vim.log.levels.WARN)
        return
    end

    local logs = vim.fn.systemlist({
        "git",
        "log",
        "--follow",
        "--date=short",
        "--pretty=format:%H %ad %an %s",
        "--",
        file,
    })

    if vim.v.shell_error ~= 0 then
        vim.notify("BlameTimeline: failed to read git history", vim.log.levels.ERROR)
        return
    end

    if #logs == 0 then
        vim.notify("BlameTimeline: no history found for file", vim.log.levels.INFO)
        return
    end

    local max_height = math.max(1, math.floor(vim.o.lines / 3))
    local height = math.min(#logs, max_height)
    vim.cmd("botright " .. height .. "new")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.bo.modifiable = true
    vim.bo.filetype = "git"
    vim.api.nvim_buf_set_name(bufnr, "BlameTimeline: " .. vim.fn.fnamemodify(file, ":t"))
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, logs)
    vim.bo.modifiable = false
    vim.keymap.set("n", "<CR>", function()
        local hash = vim.fn.matchstr(vim.fn.getline("."), "^\\x\\+")
        if hash == "" then
            vim.notify("BlameTimeline: no commit hash on this line", vim.log.levels.WARN)
            return
        end

        if vim.api.nvim_win_is_valid(source_win) then
            vim.api.nvim_set_current_win(source_win)
        end

        local blame_lines = vim.fn.systemlist({ "git", "blame", hash, "--", file })
        if vim.v.shell_error ~= 0 then
            vim.notify("BlameTimeline: failed to run git blame", vim.log.levels.ERROR)
            return
        end

        vim.cmd("enew")
        local blame_buf = vim.api.nvim_get_current_buf()
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "hide"
        vim.bo.buflisted = true
        vim.bo.swapfile = false
        vim.bo.modifiable = true
        vim.bo.filetype = "fugitiveblame"
        vim.api.nvim_buf_set_name(blame_buf, "Blame: " .. vim.fn.fnamemodify(file, ":t") .. " @ " .. string.sub(hash, 1, 8))
        vim.api.nvim_buf_set_lines(blame_buf, 0, -1, false, blame_lines)
        vim.bo.modifiable = false
        vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = blame_buf, silent = true, desc = "Close blame buffer" })
    end, { buffer = bufnr, silent = true, desc = "Blame selected commit for file" })

    vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = bufnr, silent = true, desc = "Close blame timeline" })
end, { desc = "Show file commit timeline and blame selected version" })

vim.keymap.set("n", "<leader>gb", "<cmd>BlameTimeline<CR>", { desc = "Blame timeline" })
