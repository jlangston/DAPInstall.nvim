local M = {}

local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "firefox/"

M.details = {
	dependencies = { "npm", "git" },
}

M.dap_info = {
	name_adapter = "firefox",
	name_configuration = {
		"javascriptreact",
		"typescriptreact",
		"typescript",
	},
}

M.config = {
	adapters = {
		type = "executable",
		command = "node",
		args = { dbg_path .. "vscode-firefox-debug/dist/adapter.bundle.js" },
	},
	configurations = {
		{
			type = "firefox",
			-- request = "attach",
      request = 'launch',
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			-- protocol = "inspector",
      url = 'http://localhost:8080',
			-- port = 9222,
			webRoot = "${workspaceFolder}",
      reAttach = true,
      firefoxExecutable = '/usr/bin/firefox'
		},
	},
}

M.installer = {
	before = "",
	install = [[
		git clone https://github.com/firefox-devtools/vscode-firefox-debug && cd vscode-firefox-debug
		npm install
		npm run build
	]],
	uninstall = [[
		cd vscode-firefox-debug && npm uninstall .
		cd ../..
		rm -rf firefox
	]],
}

return M

