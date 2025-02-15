require("options")
require("keymaps")
if vim.fn.has("gui_running") == 0 then
  require("plugin")
end
