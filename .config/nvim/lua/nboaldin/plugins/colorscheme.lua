return {
    {
        "nboaldin/zephyr-nvim",
        name = "zephyr",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("zephyr")
        end,
    },
}
