describe('setup', function()
  describe('get_log', function()
    it('fails when setup is not called first', function()
      assert.has.errors(
        function()
          require 'appender'.get_log()
        end,
        "call setup first: require 'appender'.setup(); should be called before every modules that uses the appender module"
      )
    end)
    it('success when setup was called first', function()
      assert.has_no.errors(function()
        require 'appender'.setup({ name = 'appender_spec' })
        require 'appender'.get_log()
        require 'appender'.get_output_log()
      end)
    end)
  end)
end)
