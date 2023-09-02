return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.cmd 'let g:gruvbox_material_background = \'hard\''
      vim.cmd.colorscheme 'gruvbox-material'
      vim.cmd "let g:lightline = {'colorscheme' : 'gruvbox-material'}"
      local highlights = {
        -- Normal = { guibg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
        -- EndOfBuffer = { bg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
        -- NormalNC = { bg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
        -- CursorColumn = { bg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
        -- CursorLine = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
        -- CursorLineNr = { cterm = {}, ctermbg = "NONE", ctermfg = "NONE" },
        -- LineNr = {},
        -- SignColumn = {},
        -- StatusLine = {},
        -- NeoTreeNormal = { bg = "NONE", ctermbg = "NONE" },
        -- NeoTreeNormalNC = { bg = "NONE", ctermbg = "NONE" },
        -- NeoTreeEndOfBuffer = { bg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
        -- WinBar = { bg = "NONE", ctermbg = "NONE" },
        -- WinBarNC = { bg = "NONE", ctermbg = "NONE" },
        -- NormalFloat = { bg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
        -- FloatBorder = { bg = "NONE", ctermbg = "NONE", ctermfg = "NONE" },
      }
      for group, styles in pairs(highlights) do
        local style_str = ''
        for key, value in pairs(styles) do
          if type(value) == "table" then
            for _, attr in ipairs(value) do
              style_str = style_str .. ' ' .. key .. '=' .. attr
            end
          elseif value ~= "NONE" then
            style_str = style_str .. ' ' .. key .. '=' .. value
          elseif (key == "guifg" or key == "guibg" or key == "gui") then
            style_str = style_str .. ' ' .. key .. '=NONE'
          end
        end
        vim.api.nvim_command('silent highlight ' .. group .. style_str)
      end
    end,
  },
}
