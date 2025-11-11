return {
  -- Code Runner for C++
  {
    'CRAG666/code_runner.nvim',
    cmd = { 'RunCode', 'RunFile', 'RunProject', 'RunClose' },
    keys = {
      { '<leader>rr', ':RunCode toggleterm<CR>', desc = 'Run current file' },
      { '<leader>rf', ':RunFile toggleterm<CR>', desc = 'Run file' },
      { '<leader>rp', ':RunProject<CR>', desc = 'Run project' },
      { '<leader>rc', ':RunClose<CR>', desc = 'Close runner' },
    },
    opts = {
      filetype = {
        cpp = {
          'cd $dir &&',
          'g++ -std=c++17 -O2 -Wall -Wextra $fileName -o $fileNameWithoutExt &&',
          '$dir/$fileNameWithoutExt'
        },
        c = {
          'cd $dir &&',
          'gcc -std=c11 -O2 -Wall -Wextra $fileName -o $fileNameWithoutExt &&',
          '$dir/$fileNameWithoutExt'
        }
      },
      project = {
        ['CMakeLists.txt'] = {
          'cd $dir &&',
          'mkdir -p build &&',
          'cd build &&',
          'cmake .. &&',
          'make &&',
          './$(find . -type f -executable | head -1)'
        },
        ['Makefile'] = {
          'cd $dir &&',
          'make &&',
          './$(find . -type f -executable | head -1)'
        }
      }
    },
    config = function(_, opts)
      require('code_runner').setup(opts)
    end
  },

  -- CMake integration
  {
    'Civitasv/cmake-tools.nvim',
    ft = { 'c', 'cpp', 'cmake' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>cg', ':CMakeGenerate<CR>', desc = 'CMake Generate' },
      { '<leader>cb', ':CMakeBuild<CR>', desc = 'CMake Build' },
      { '<leader>cr', ':CMakeRun<CR>', desc = 'CMake Run' },
      { '<leader>cd', ':CMakeDebug<CR>', desc = 'CMake Debug' },
      { '<leader>cc', ':CMakeClean<CR>', desc = 'CMake Clean' },
      { '<leader>cs', ':CMakeSelectBuildType<CR>', desc = 'CMake Select Build Type' },
      { '<leader>ct', ':CMakeSelectBuildTarget<CR>', desc = 'CMake Select Target' },
    },
    opts = {
      cmake_command = 'cmake',
      cmake_build_directory = 'build',
      cmake_build_directory_prefix = '',
      cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' },
      cmake_build_options = {},
      cmake_console_size = 10,
      cmake_show_console = 'always',
      cmake_dap_configuration = {
        name = 'cpp',
        type = 'codelldb',
        request = 'launch'
      },
      cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 }
      }
    },
    config = function(_, opts)
      require('cmake-tools').setup(opts)
    end
  },

  -- Enhanced C++ syntax and features
  {
    'p00f/clangd_extensions.nvim',
    ft = { 'c', 'cpp' },
    keys = {
      { '<leader>lh', ':ClangdSwitchSourceHeader<CR>', desc = 'Switch Header/Source' },
      { '<leader>lt', ':ClangdTypeHierarchy<CR>', desc = 'Type Hierarchy' },
      { '<leader>ls', ':ClangdSymbolInfo<CR>', desc = 'Symbol Info' },
      { '<leader>lm', ':ClangdMemoryUsage<CR>', desc = 'Memory Usage' },
    },
    opts = {
      inlay_hints = {
        inline = vim.fn.has('nvim-0.10') == 1,
        only_current_line = false,
        only_current_line_autocmd = 'CursorHold',
        show_parameter_hints = true,
        parameter_hints_prefix = '<- ',
        other_hints_prefix = '=> ',
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = 'Comment'
      },
      ast = {
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = ''
        },
        kind_icons = {
          Compound = '',
          Recovery = '',
          TranslationUnit = '',
          PackExpansion = '',
          TemplateTypeParm = '',
          TemplateTemplateParm = '',
          TemplateParamObject = ''
        }
      }
    },
    config = function(_, opts)
      require('clangd_extensions').setup(opts)
    end
  },

  -- Competitive Programming helper
  {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    ft = { 'cpp', 'c' },
    keys = {
      { '<leader>pr', ':CompetiTest run<CR>', desc = 'Run tests' },
      { '<leader>pa', ':CompetiTest add_testcase<CR>', desc = 'Add testcase' },
      { '<leader>pe', ':CompetiTest edit_testcase<CR>', desc = 'Edit testcase' },
      { '<leader>pd', ':CompetiTest delete_testcase<CR>', desc = 'Delete testcase' },
      { '<leader>pt', ':CompetiTest receive testcases<CR>', desc = 'Receive testcases' },
      { '<leader>pp', ':CompetiTest receive problem<CR>', desc = 'Receive problem' },
      { '<leader>pc', ':CompetiTest receive contest<CR>', desc = 'Receive contest' },
    },
    opts = {
      local_config_file_name = '.competitest.lua',
      floating_border = 'rounded',
      floating_border_highlight = 'FloatBorder',
      picker_ui = {
        width = 0.2,
        height = 0.3,
        mappings = {
          focus_next = { 'j', '<down>', '<Tab>' },
          focus_prev = { 'k', '<up>', '<S-Tab>' },
          close = { '<esc>', '<C-c>', 'q', 'Q' },
          submit = { '<cr>' }
        }
      },
      editor_ui = {
        popup_width = 0.4,
        popup_height = 0.6,
        show_nu = true,
        show_rnu = false,
        normal_mode_mappings = {
          switch_window = { '<C-h>', '<C-l>', '<C-i>' },
          save_and_close = '<C-s>',
          cancel = { 'q', 'Q' }
        },
        insert_mode_mappings = {
          switch_window = { '<C-h>', '<C-l>', '<C-i>' },
          save_and_close = '<C-s>',
          cancel = '<C-q>'
        }
      },
      runner_ui = {
        interface = 'popup',
        selector_show_nu = false,
        selector_show_rnu = false,
        show_nu = true,
        show_rnu = false,
        mappings = {
          run_again = 'R',
          run_all_again = '<C-r>',
          kill = 'K',
          kill_all = '<C-k>',
          view_input = { 'i', 'I' },
          view_output = { 'a', 'A' },
          view_stdout = { 'o', 'O' },
          view_stderr = { 'e', 'E' },
          toggle_diff = { 'd', 'D' },
          close = { 'q', 'Q' }
        },
        viewer = {
          width = 0.5,
          height = 0.5,
          show_nu = true,
          show_rnu = false,
          close_mappings = { 'q', 'Q' }
        }
      },
      popup_ui = {
        total_width = 0.8,
        total_height = 0.8,
        layout = {
          { 4, 'tc' },
          { 5, { { 1, 'so' }, { 1, 'si' } } },
          { 5, { { 1, 'eo' }, { 1, 'se' } } }
        }
      },
      split_ui = {
        position = 'right',
        relative_to_editor = true,
        total_width = 0.3,
        vertical_layout = {
          { 1, 'tc' },
          { 1, { { 1, 'so' }, { 1, 'si' } } },
          { 1, { { 1, 'eo' }, { 1, 'se' } } }
        },
        total_height = 0.4,
        horizontal_layout = {
          { 2, 'tc' },
          { 3, { { 1, 'so' }, { 1, 'si' } } },
          { 3, { { 1, 'eo' }, { 1, 'se' } } }
        }
      },
      save_current_file = true,
      save_all_files = false,
      compile_directory = '.',
      compile_command = {
        c = { exec = 'gcc', args = { '-Wall', '$(FNAME)', '-o', '$(FNOEXT)' } },
        cpp = { exec = 'g++', args = { '-Wall', '-std=c++17', '$(FNAME)', '-o', '$(FNOEXT)' } },
        rust = { exec = 'rustc', args = { '$(FNAME)' } },
        java = { exec = 'javac', args = { '$(FNAME)' } }
      },
      running_directory = '.',
      run_command = {
        c = { exec = './$(FNOEXT)' },
        cpp = { exec = './$(FNOEXT)' },
        rust = { exec = './$(FNOEXT)' },
        java = { exec = 'java', args = { '$(FNOEXT)' } }
      },
      multiple_testing = -1,
      maximum_time = 5000,
      output_compare_method = 'squish',
      view_output_diff = false,
      testcases_directory = '.',
      testcases_use_single_file = false,
      testcases_auto_detect_storage = true,
      testcases_single_file_format = '$(FNOEXT).testcases',
      testcases_input_file_format = '$(FNOEXT)_input$(TCNUM).txt',
      testcases_output_file_format = '$(FNOEXT)_output$(TCNUM).txt',
      companion_port = 27121,
      receive_print_message = true,
      template_file = false,
      evaluate_template_modifiers = false,
      date_format = '%c',
      received_files_extension = 'cpp',
      received_problems_path = '$(CWD)/$(PROBLEM).$(FEXT)'
    },
    config = function(_, opts)
      require('competitest').setup(opts)
    end
  }
}