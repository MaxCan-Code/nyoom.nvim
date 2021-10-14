-- A function that verifies if the plugin passed as a parameter is installed,
-- if it isn't it will be installed
---@param plugin string #the plugin, must follow the format `username/repository`
local function bootstrap(plugin)
  local ddir = vim.fn.stdpath("data")
  local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])
  local pactstrap_path = ddir .. "/site/pack/pactstrap"
  local plugin_path = pactstrap_path .. "/opt/" .. plugin_name
  if vim.loop.fs_stat(ddir .. "/site/pack/pact/start/" .. plugin_name) == nil then
    vim.notify("Could not find " .. plugin_name .. ", cloning new copy to " .. pactstrap_path, vim.log.levels.WARN)
    vim.fn.system({
      "git",
      "clone",
      "--filter",
      "blob:none",
      "https://github.com/" .. plugin,
      plugin_path,
    })
    vim.cmd("packadd " .. plugin_name)
    -- require("pact.bootstrap")(pactstrap_path)
  end
end

-- global variable to set the user's fennel compiler
local fennel_compiler = "hotpot"

-- nessecary plugins
bootstrap("rktjmp/pact.nvim")

-- We only want impatient if the compiler is aniseed/tangerine
-- I only test hotpot, you're on your own for the other two

-- Hotpot has its own caching feature
if fennel_compiler == "hotpot" then
  bootstrap("rktjmp/hotpot.nvim")
  require([[hotpot]]).setup()
  require([[init]])
elseif fennel_compiler == "aniseed" then
  bootstrap("lewis6991/impatient.nvim")
  bootstrap("olical/aniseed")
  require([[impatient]])
  vim.g["aniseed#env"] = true
elseif fennel_compiler == "tangerine" then
  bootstrap("lewis6991/impatient.nvim")
  bootstrap("udayvir-singh/tangerine.nvim")
  require([[impatient]])
  require([[tangerine]]).setup({
    compiler = {
      hooks = {},
    },
  })
  require([[init]])
else
  error([[Unknown compiler]])
end
