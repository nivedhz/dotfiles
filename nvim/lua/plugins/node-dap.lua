return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Adds the visual UI
      "rcarriga/nvim-dap-ui",
      -- Required dependency for dap-ui
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate Session",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle Debugger UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 1. Setup the UI
      dapui.setup()

      -- Automatically open/close the UI when debugging starts/stops
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- 2. Define the Adapter
      -- This points to the adapter you just installed via Mason
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- vim.fn.stdpath("data") resolves to ~/.local/share/nvim on Ubuntu
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- 3. Configure the Language
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
