-- brandishcode lua core logging/appender
---@author brandishcode
---@license MIT

---@alias Level
---| 'debug'
---| 'info'
---| 'error'
---| 'warn'
---| 'fatal'

---@class AppenderOpts
---@field name string module name
---@field level? Level
---@field is_file_log? boolean
---@version 1.0.0

---@class Appender
---@field debug fun(...)
---@field error fun(...)
---@field info fun(...)
---@field warn fun(...)
---@field fatal fun(...)

---@class OutputAppender
---@field info fun(...)

---@class AppenderModule
---@field setup fun(opts: AppenderOpts)
---@field get_log fun(): Appender
---@field get_output_log fun(): OutputAppender
---@version 1.0.0

local ansicolors = require 'ansicolors'
local log = require 'logging'

require 'logging.console'
require 'logging.file'

---@type Appender
local __appender
---@type OutputAppender
local __output_appender

---@param opts AppenderOpts
local function setup(opts)
  local level = log.FATAL
  if opts.level == 'debug' then
    level = log.DEBUG
  elseif opts.level == 'info' then
    level = log.INFO
  elseif opts.level == 'error' then
    level = log.ERROR
  elseif opts.level == 'warn' then
    level = log.WARN
  else
    level = log.FATAL
  end
  local timestampPattern = '%y-%m-%d %H:%M:%S.%3q'
  local appender
  if opts.is_file_log then
    local log_dir = string.format('%s/.local/share/name', os.getenv('HOME'))
    os.execute(string.format('mkdir -p %s', log_dir))
    assert(log_dir, 'logging directory for file should be created')

    appender = log.file {
      filename = string.format('%s/%s-%s.log', log_dir, os.date('%Y%m%d_%H%M%S'), opts.name),
      logPattern = '%date %level %message\n',
      logLevel = log.DEBUG,
      timestampPattern = timestampPattern,
    }
  else
    appender = log.console {
      logLevel = level,
      destination = 'stderr',
      timestampPattern = timestampPattern,
      logPatterns = {
        [log.DEBUG] = ansicolors('%date %{magenta}%level %{reset}%message\n'),
        [log.ERROR] = ansicolors('%date %{red}%level %{reset}%message\n'),
        [log.WARN] = ansicolors('%date %{yellow}%level %{reset}%message\n'),
        [log.INFO] = ansicolors('%date %{green}%level %{reset}%message\n'),
        [log.FATAL] = ansicolors('%{red}Error%{reset}: %message\n'),
      },
    }
  end
  __appender = appender
  __output_appender = log.console {
    logLevel = log.INFO,
    destination = 'stdout',
    logPatterns = {
      [log.INFO] = ansicolors('%{reset}%message'),
    },
  }
end

---@type AppenderModule
return {
  get_log = function()
    assert(
      __appender,
      "call setup first: require 'appender'.setup(); should be called before every modules that uses the appender module"
    )
    return __appender
  end,
  setup = setup,
  get_output_log = function()
    assert(
      __appender,
      "call setup first: require 'appender'.setup(); should be called before every modules that uses the appender module"
    )
    return __output_appender
  end,
}
