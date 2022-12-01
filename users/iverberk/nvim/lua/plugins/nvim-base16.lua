local cs = require('base16-colorscheme')

cs.setup("tomorrow-night-eighties", {
    telescope = false
})

local hi = cs.highlight

hi.MatchParen  = { guifg = '#cccccc', guibg = '#2d2d2d', gui = 'bold', guisp = nil }
hi.VertSplit = { guifg='#373b41' }
hi.IndentBlanklineChar = { guifg='#444444', gui='nocombine' }
