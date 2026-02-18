local vim = vim
colorscheme_file = vim.fn.stdpath("state") .. "/.colorscheme"

local function OverrideBG()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#11131a" })
end

function ApplyColors(colorscheme, transparent)
    colorscheme = colorscheme or "tokyonight-moon"
    vim.cmd.colorscheme(colorscheme)
    if transparent then
        OverrideBG()
    end
end

function SaveColors(colorscheme, transparent)
    local line = colorscheme
    if transparent then
        line = line .. " --transparent"
    end
    vim.fn.writefile({ line }, colorscheme_file)
    ApplyColors(colorscheme, transparent)
end

vim.api.nvim_create_user_command("SetTheme", function(opts)
    local colorscheme
    local transparent = false

    for _, arg in ipairs(opts.fargs) do
        if arg == "--transparent" then
            transparent = true
        else
            colorscheme = arg
        end
    end

    if not colorscheme then
        vim.notify("Please specify a color scheme name.", vim.log.levels.ERROR)
        return
    end

    SaveColors(colorscheme, transparent)
end, {
    nargs = "*",
    complete = function(_, line, _)
        local args = vim.split(line, "%s+")
        if #args == 2 or (#args == 3 and not vim.startswith(args[#args], "--")) then
            return vim.fn.getcompletion(args[#args], "color")
        else
            return { "--transparent" }
        end
    end
})
