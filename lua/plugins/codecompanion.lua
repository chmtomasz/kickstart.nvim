return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',

    'hrsh7th/nvim-cmp',              -- Optional: for enhanced completion
    'nvim-telescope/telescope.nvim', -- Optional: for enhanced actions
  },
  config = function()
    require('codecompanion').setup({
      strategies = {
        chat = {
          adapter = 'copilot',
        },
        inline = {
          adapter = 'copilot',
        },
        agent = {
          adapter = 'copilot',
        },
      },
      adapters = {
        http = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'gpt-4o',
                },
              },
            })
          end,
        },
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
        chat = {
          window = {
            layout = 'vertical', -- float|vertical|horizontal|buffer
            width = 0.45,
            height = 0.8,
            relative = 'editor',
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = '0',
              linebreak = true,
              list = false,
              signcolumn = 'no',
              spell = false,
              wrap = true,
            },
          },
        },
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true,           -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
      opts = {
        log_level = 'ERROR',        -- TRACE|DEBUG|ERROR|INFO
        send_code = true,           -- Send code context to LLM? Disable to prevent leaking code outside your environment
        use_default_actions = true, -- Use the default actions in the action palette?
        use_default_prompts = true, -- Use the default prompts from the plugin?
      },
      tools = {
        cmd_runner = {
          opts = {
            requires_approval = true, -- Require approval before running commands
          },
        },
        create_file = {
          opts = {
            requires_approval = true, -- Require approval before creating files
          },
        },
        insert_edit_into_file = {
          opts = {
            requires_approval = {
              buffer = false, -- Don't require approval for buffer edits
              file = true,    -- Require approval for file edits
            },
          },
        },
        read_file = {}, -- Read files (no special config needed)
        file_search = {
          opts = {
            max_results = 500,
          },
        },
        grep_search = {
          opts = {
            max_files = 100,
            respect_gitignore = true,
          },
        },
        get_changed_files = {
          opts = {
            max_lines = 1000,
          },
        },
        list_code_usages = {}, -- LSP-based code usage finder
      },
      prompt_library = {
        ['Custom Prompt'] = {
          strategy = 'chat',
          description = 'A custom prompt',
          opts = {
            mapping = '<Leader>cc',
            modes = { 'n', 'v' },
            slash_cmd = 'custom',
            auto_submit = true,
          },
          prompts = {
            {
              role = 'user',
              content = function()
                return 'Custom prompt content here'
              end,
            },
          },
        },
      },
    })
  end,
  -- No keymaps; use :CodeCompanion, :CodeCompanionChat and :CodeCompanionActions manually.
  cmd = {
    'CodeCompanion',
    'CodeCompanionChat',
    'CodeCompanionActions',
  },
  event = 'VeryLazy',
}
