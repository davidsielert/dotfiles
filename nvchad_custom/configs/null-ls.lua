local null_ls = require "null-ls"

local b = null_ls.builtins
local dg = null_ls.builtins.diagnostics
local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "yaml" } }, -- so prettier works only on these filetypes

  dg.ansiblelint,
  
  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  b.formatting.rustfmt,

  b.formatting.gofmt,

  -- diagnostics
  dg.shellcheck,
  dg.luacheck.with({
    extra_args = {'--globals','vim','--std','luajit'}
  })


}

null_ls.setup {
  debug = true,
  sources = sources,
}
