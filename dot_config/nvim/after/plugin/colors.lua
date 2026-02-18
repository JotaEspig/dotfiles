local vim = vim
require("jota.colors")


-- Apply saved theme on startup
if vim.fn.filereadable(colorscheme_file) == 1 then
    local data = vim.fn.readfile(colorscheme_file)
    if #data > 0 then
        local args = vim.split(data[1], "%s+")
        local colorscheme
        local transparent = false
        for _, arg in ipairs(args) do
            if arg == "--transparent" then
                transparent = true
            else
                colorscheme = arg
            end
        end
        if colorscheme then
            ApplyColors(colorscheme, transparent)
        end
    else
        -- Set default if nothing saved
        local default = "tokyonight-moon"
        SaveColors(default, true)
    end
else
    -- Set default if nothing saved
    local default = "tokyonight-moon"
    SaveColors(default, true)
end
