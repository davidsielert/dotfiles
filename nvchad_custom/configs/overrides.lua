local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "cmake",
    "css",
    "dockerfile",
    "diff",
    "go",
    "lua",
    "hcl",
    "html",
--    "hypr",
    "ini",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "meson",
    "nasm",
    "regex",
    "svelte",
    "terraform",
    "typescript",
    "tsx",
    "rust",
    "toml",
    "vim",
    "yaml",
  },

  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
  }},
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    "cpptools",
    "codelldb",

    -- rust
    "rust_analyzer"
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.colorizer = {
  filetypes = {
    "*",
    cmp_docs = { always_update = true },
    cmp_menu = { always_update = true },
  },
  user_default_options = {
    names = false,
    RRGGBBAA = true,
    rgb_fn = true,
    tailwind = true,
    RGB = true,
    RRGGBB = true,
    AARRGGBB = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    sass = { enable = true, parsers = { "css" } },
    mode = "background", -- Available methods are false / true / "normal" / "lsp" / "both"
    virtualtext = "■",
    always_update = true,
  },
}

return M
