describe('bcprocess', function()
  describe('execute', function()
    it('echo Hello World!', function()
      local process = require 'process'
      local result = {}
      process({
        cmd = 'echo',
        args = { 'Hello World!' },
        listeners = {
          on_stdout = function(_, data)
            table.insert(result, data)
          end,
        },
      })
      assert.are.equal('Hello World!\n', table.concat(result))
    end)
  end)
end)
