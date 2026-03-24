return {
  -- Python Code Runner
  {
    'CRAG666/code_runner.nvim',
    ft = { 'python' },
    keys = {
      { '<leader>rr', ':RunCode<CR>', desc = 'Run Python file', ft = 'python' },
      { '<leader>rf', ':RunFile<CR>', desc = 'Run file', ft = 'python' },
      { '<leader>rp', ':RunProject<CR>', desc = 'Run project', ft = 'python' },
      { '<leader>rc', ':RunClose<CR>', desc = 'Close runner', ft = 'python' },
      { '<leader>ri', function()
          require('toggleterm.terminal').Terminal:new({
            cmd = 'python -i ' .. vim.fn.expand('%'),
            direction = 'horizontal',
            close_on_exit = false,
          }):toggle()
        end, desc = 'Run Python interactive', ft = 'python' },
    },
    opts = {
      filetype = {
        python = {
          'cd $dir &&',
          'python $fileName'
        }
      },
      project = {
        ['pyproject.toml'] = {
          'cd $dir &&',
          'python -m pip install -e . &&',
          'python -m pytest'
        },
        ['setup.py'] = {
          'cd $dir &&',
          'python setup.py install &&',
          'python -m pytest'
        },
        ['requirements.txt'] = {
          'cd $dir &&',
          'pip install -r requirements.txt &&',
          'python -m pytest'
        }
      }
    },
    config = function(_, opts)
      require('code_runner').setup(opts)
    end
  },

  -- Python DAP (Debug Adapter Protocol)
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    keys = {
      { '<leader>dpr', function() require('dap-python').test_runner = 'pytest' end, desc = 'Set pytest runner' },
      { '<leader>dpm', function() require('dap-python').test_method() end, desc = 'Debug test method' },
      { '<leader>dpc', function() require('dap-python').test_class() end, desc = 'Debug test class' },
      { '<leader>dps', function() require('dap-python').debug_selection() end, desc = 'Debug selection', mode = 'v' },
    },
    config = function()
      -- Try to find python debugpy installation
      local mason_path = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
      local system_python = vim.fn.exepath('python')
      local python_path = vim.fn.filereadable(mason_path) == 1 and mason_path or system_python
      
      require('dap-python').setup(python_path)
      
      -- Configure DAP for Python
      local dap = require('dap')
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = function()
            -- Try to detect virtual environment
            local venv_python = os.getenv('VIRTUAL_ENV')
            if venv_python then
              return venv_python .. '/bin/python'
            end
            return python_path
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file with arguments',
          program = '${file}',
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, ' ')
          end,
          pythonPath = function()
            local venv_python = os.getenv('VIRTUAL_ENV')
            if venv_python then
              return venv_python .. '/bin/python'
            end
            return python_path
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch Django',
          program = '${workspaceFolder}/manage.py',
          args = { 'runserver' },
          pythonPath = function()
            local venv_python = os.getenv('VIRTUAL_ENV')
            if venv_python then
              return venv_python .. '/bin/python'
            end
            return python_path
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch Flask',
          module = 'flask',
          args = { 'run' },
          env = { FLASK_DEBUG = '1' },
          pythonPath = function()
            local venv_python = os.getenv('VIRTUAL_ENV')
            if venv_python then
              return venv_python .. '/bin/python'
            end
            return python_path
          end,
        }
      }
    end
  },

  -- Python REPL integration (simplified)
  {
    'kassio/neoterm',
    ft = 'python',
    keys = {
      { '<leader>rs', ':TREPLSendLine<CR>', desc = 'Send line to REPL' },
      { '<leader>rs', ':TREPLSendSelection<CR>', desc = 'Send selection to REPL', mode = 'v' },
      { '<leader>rf', ':TREPLSendFile<CR>', desc = 'Send file to REPL' },
      { '<leader>ro', ':Topen<CR>', desc = 'Open terminal REPL' },
      { '<leader>rq', ':Tclose<CR>', desc = 'Close REPL' },
      { '<leader>rR', function()
          vim.cmd('Tclose')
          vim.cmd('T ipython')
        end, desc = 'Restart Python REPL' },
    },
    config = function()
      vim.g.neoterm_default_mod = 'rightbelow vertical'
      vim.g.neoterm_size = 80
      vim.g.neoterm_autoscroll = 1
      vim.g.neoterm_repl_python = 'ipython'
      
      -- Auto-start Python REPL for Python files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function()
          vim.keymap.set('n', '<leader>rp', ':T ipython<CR>', { buffer = true, desc = 'Start Python REPL' })
        end
      })
    end
  },

  -- Python testing with pytest
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
    },
    ft = 'python',
    keys = {
      { '<leader>tt', function() require('neotest').run.run() end, desc = 'Run nearest test' },
      { '<leader>tT', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run all tests in file' },
      { '<leader>td', function() require('neotest').run.run({strategy = 'dap'}) end, desc = 'Debug nearest test' },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
      { '<leader>to', function() require('neotest').output.open({ enter = true }) end, desc = 'Open test output' },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
      { '<leader>tS', function() require('neotest').run.stop() end, desc = 'Stop test' },
    },
    opts = {
      adapters = {
        ['neotest-python'] = {
          dap = { justMyCode = false },
          args = { '--log-level', 'DEBUG' },
          runner = 'pytest',
          python = function()
            local venv_python = os.getenv('VIRTUAL_ENV')
            if venv_python then
              return venv_python .. '/bin/python'
            end
            return vim.fn.exepath('python')
          end,
        },
      },
      quickfix = {
        open = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
      output = {
        enabled = true,
        open_on_run = 'short',
      },
      summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = 'a',
          clear_marked = 'M',
          clear_target = 'T',
          debug = 'd',
          debug_marked = 'D',
          expand = { '<CR>', '<2-LeftMouse>' },
          expand_all = 'e',
          jumpto = 'i',
          mark = 'm',
          next_failed = 'J',
          output = 'o',
          prev_failed = 'K',
          run = 'r',
          run_marked = 'R',
          short = 'O',
          stop = 'u',
          target = 't',
          watch = 'w',
        },
      },
    },
    config = function(_, opts)
      require('neotest').setup(opts)
    end
  },

  -- Python virtual environment management
  {
    'linux-cultist/venv-selector.nvim',
    ft = 'python',
    dependencies = { 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select virtual environment' },
      { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = 'Select cached venv' },
    },
    opts = {
      name = 'venv',
      auto_refresh = false,
      search_venv_managers = true,
      search_workspace = true,
      search = true,
      dap_enabled = true,
      parents = 2,
      notify_user_on_activate = true,
    },
    config = function(_, opts)
      require('venv-selector').setup(opts)
    end
  },

  -- Python docstring generation
  {
    'danymat/neogen',
    ft = 'python',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    keys = {
      { '<leader>nf', function() require('neogen').generate({ type = 'func' }) end, desc = 'Generate function docstring' },
      { '<leader>nc', function() require('neogen').generate({ type = 'class' }) end, desc = 'Generate class docstring' },
      { '<leader>nt', function() require('neogen').generate({ type = 'type' }) end, desc = 'Generate type docstring' },
      { '<leader>nF', function() require('neogen').generate({ type = 'file' }) end, desc = 'Generate file docstring' },
    },
    opts = {
      enabled = true,
      input_after_comment = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'google_docstrings',
          }
        }
      }
    },
    config = function(_, opts)
      require('neogen').setup(opts)
    end
  },

  -- Python import organization
  {
    'stsewd/isort.nvim',
    ft = 'python',
    build = ':UpdateRemotePlugins',
    keys = {
      { '<leader>is', '<cmd>Isort<CR>', desc = 'Sort imports' },
      { '<leader>iS', '<cmd>Isort!<CR>', desc = 'Sort imports (force)' },
    },
    config = function()
      vim.g.isort_command = 'isort'
    end
  },
}