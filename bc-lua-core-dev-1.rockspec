rockspec_format = "3.0"
package = "bc-lua-core"
version = "dev-1"
source = {
   url = "git://github.com/brandishcode/bc-lua-core.git"
}
description = {
   homepage = "https://github.com/brandishcode/bc-lua-core.git",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      ["bcappender"] = "lua/appender.lua",
      ["bcprocess"] = "lua/process.lua"
   }
}
dependencies = {
  "lualogging >= 1.8.2",
  "ansicolors >= 1.0.2-3",
  "luv >= 1.51.0-1",
}
test = {
  type = "busted"
}
