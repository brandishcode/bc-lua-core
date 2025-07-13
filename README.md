# bc-lua-core

brandishcode's lua core library for lua plugin/script development

# modules

## bcappender

Lua appender/logging module.

### How to use

```lua
local log = require 'bcappender'
log.setup({ name = 'my_plugin' })
```

By default this will create a logger with `fatal` level of logging.

Appender options:

- name - the name of the plugin or script to be logged (normally the project name)
- is_file_log - to enable file logging
- level - logging level; `info`, `debug`, `warn`, `error` and `fatal`.

#### Example of file logging

```lua
local log = require 'bcappender'
log.setup({ name = 'my_plugin', is_file_log = true })
```

This will create file logging at `$HOME/.local/share/\<plugin/script name>/20250701_193025-my_plugin.log`
