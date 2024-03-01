require('hardline').setup {
  bufferline = true,
  bufferline_settings = {
    exclude_terminal = false,
    show_index = false,
  },
  theme = 'default',
  sections = {
    {class = 'mode', item = require('hardline.parts.mode').get_item},
    {class = 'high', item = require('hardline.parts.treesitter-context').get_item },
    {class = 'high', item = require('hardline.parts.git').get_item, hide = 50},
    {class = 'med', item = require('hardline.parts.filename').get_item, hide = 50},
    '%<',
    {class = 'med', item = '%='},
    {class = 'error', item = require('hardline.parts.lsp').get_error},
    {class = 'warning', item = require('hardline.parts.whitespace').get_item},
    {class = 'mode', item = require('hardline.parts.line').get_item},
    {class = 'low', item = require('hardline.parts.filetype').get_item, hide = 6},
  },
}
