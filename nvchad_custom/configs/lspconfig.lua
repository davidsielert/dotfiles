-- require("plugins.configs.lspconfig").defaults()

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "ansiblels",
  "html",
  "cssls",
  "gopls",
  "tsserver",
  "clangd",
  "rust_analyzer",
  "yamlls",
  "jsonls",
  "dockerls",
  "lua_ls",
  "svelte",
  "bashls",
  "helm_ls",
}

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

local custom_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(bufnr, true)
  end
end
require("mason-lspconfig").setup {
  ensure_installed = servers,
}

require("mason-lspconfig").setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = custom_on_attach,
      capabilities = capabilities,
    }
  end,
  ["gopls"] = function()
    lspconfig["gopls"].setup {
      on_attach = custom_on_attach,
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gosum", "goimpl" },
      settings = {
        gopls = {
          buildFlags = { "-tags=wireinject" },
          usePlaceholders = true,
          completeUnimported = true,
          vulncheck = "Imports",
          analyses = {
            shadow = true,
            unusedparams = true,
            unusewrites = true,
            fieldalignment = true,
            nilness = true,
            useany = true,
          },
          staticcheck = true,
          codelenses = {
            references = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            regenerate_cgo = true,
            generate = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          gofumpt = true,
        },
      },
    }
  end,

  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup {
      on_attach = custom_on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "use", "vim" },
          },
          hint = {
            enable = true,
            setType = true,
          },
          telemetry = {
            enable = false,
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }
  end,
  ["yamlls"] = function()
    lspconfig["yamlls"].setup {
      on_attach = custom_on_attach,
      capabilities = capabilities,
      settings = {
        yaml = {
          filetypes = { "yaml", "yaml.docker-compose", "yaml.ansible" },
          schemas = {
            ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.6-standalone/all.json"] = "~/dev/k8s/*.yml",
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows",
            ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/playbook.json"] = "~/dev/ansible/playbook/*.yml",
          },
        },
      },
    }
  end,
}

-- lspconfig.pyright.setup { blabla}
vim.diagnostic.config {
  virtual_lines = true,
  virtual_text = false,
  --virtual_text = {
  -- source = "always",
  -- prefix = "■",
  -- },
  -- virtual_text = false,
  float = {
    source = "always",
    border = "rounded",
  },
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
}
