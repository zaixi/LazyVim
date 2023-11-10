-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

local plugin_conf = require("plugins.config.other")

return {
  --- 功能增强 {{{

  {
    "folke/which-key.nvim",
    config = plugin_conf.whichkey,
    opts = {
      default = {},
    },
  },

  --- }}}
}
