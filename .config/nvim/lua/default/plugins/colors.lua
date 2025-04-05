local time = tonumber(os.date("%H"))
if time > 20 or time < 6 then
    vim.cmd("colorscheme kanagawa-dragon")
else
    vim.cmd("colorscheme kanagawa-wave")
end

local color_tbl = {
    ["lotus"] = function() vim.cmd("colorscheme kanagawa-lotus") end,
    ["dragon"] = function() vim.cmd("colorscheme kanagawa-dragon") end,
    ["wave"] = function() vim.cmd("colorscheme kanagawa-wave") end,
}

vim.api.nvim_create_user_command("ColorSet", function(args)
    local color_fn = color_tbl[args.fargs[1]]
    if (color_fn) then
        color_fn()
    else
        color_tbl["wave"]()
    end
end, {
    desc = "change the colorway of nvim based on kanagawa.nvim",
    nargs = 1,
})
