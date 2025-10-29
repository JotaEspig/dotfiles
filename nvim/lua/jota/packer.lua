local vim = vim

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    print(install_path)
    if fn.empty(fn.glob(install_path)) > 0 then
        print("hello")
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- colorizer
    use {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        -- or                            , branch = "0.1.x",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    -- Fugitive
    use "tpope/vim-fugitive"

    -- Mason
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- AutoSurround
    use "dapt4/vim-autoSurround"

    -- Codeium
    use 'Exafunction/codeium.vim'
    -- Github Copilot
    use 'github/copilot.vim'
    use "CopilotC-Nvim/CopilotChat.nvim"

    -- LSP
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- LSP Support
            { "neovim/nvim-lspconfig" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        }
    }

    -- Vimtex
    use "lervag/vimtex"

    -- Markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- 2048
    use {
        "NStefan002/2048.nvim",
        config = function()
            require("2048").setup()
        end,
    }

    -- BlackJack
    use {
        'alanfortlink/blackjack.nvim',
        requires = {'nvim-lua/plenary.nvim'},
    }

    -- Cellular Automation
    use 'eandrju/cellular-automaton.nvim'

    -- Brainrot
    use '3rd/image.nvim'
    use({
      'sahaj-b/brainrot.nvim',
      opts = {
        -- defaults:
        disable_phonk = false,    -- skip phonk/overlay on "no errors"
        phonk_time = 2.5,         -- seconds the phonk/image overlay stays
        min_error_duration = 0.5, -- minimum seconds errors must exist before phonk triggers (0 = instant)
        block_input = true,       -- block input during phonk/overlay
        dim_level = 60,           -- phonk overlay darkness 0..100
        sound_enabled = true,     -- enable sounds
        image_enabled = true,     -- enable images (needs image.nvim)
        boom_volume = 50,         -- volume for vine boom sound (0..100)
        phonk_volume = 50,        -- volume for phonk sound (0..100)
        boom_sound = nil,         -- custom boom sound path (e.g., "~/sounds/boom.ogg")
        phonk_dir = nil,          -- custom phonk folder path (e.g., "~/sounds/phonks")
        image_dir = nil,          -- custom image folder path (e.g., "~/memes/images")
        lsp_wide = false,         -- track errors workspace-wide (get ALL lsp errors)
      },
      config = function(_, opts)
        require("brainrot").setup(opts)
      end,
    })

    -- Devicons
    use "nvim-tree/nvim-web-devicons"

    -- Tabline
    use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
    use 'romgrk/barbar.nvim'

    -- Status Line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Colorschemes
    use {
        -- gruvbox
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
            overrides = {
                ["@string"] = { fg = "#5fb950" }
            }
        })
        end
    }
    use "folke/tokyonight.nvim"
    use "shaunsingh/nord.nvim"
    use "olimorris/onedarkpro.nvim"
    use "Mofiqul/vscode.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use "rebelot/kanagawa.nvim"
    use "scottmckendry/cyberdream.nvim"
    use "nyoom-engineering/oxocarbon.nvim"
    use {
        'daltonmenezes/aura-theme',
        rtp = 'packages/neovim',
    }

    -- Transparent background (it's causing some error)
    -- use "xiyaowong/transparent.nvim"

    if packer_bootstrap then
        require("packer").sync()
    end
end)
