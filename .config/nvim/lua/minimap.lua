local map = require('mini.map')
map.setup(
{
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.gitsigns(),
    map.gen_integration.diagnostic(),
  },
  symbols = {
    -- Encode symbols. See `:h MiniMap.config` for specification and
    -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
    -- Default: solid blocks with 3x2 resolution.
    encode = map.gen_encode_symbols.dot('4x2'),
    scroll_line = '🮚',
    scroll_view = '╎',
  },
  window = {
    -- Whether window is focusable in normal way (with `wincmd` or mouse)
    focusable = false,
    -- Side to stick ('left' or 'right')
    side = 'right',
    -- Whether to show count of multiple integration highlights
    show_integration_count = true,
    -- Total width
    width = 10,
    -- Value of 'winblend' option
    winblend = 25,
  },
}
)
