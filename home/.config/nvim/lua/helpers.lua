function set_vim_options(options)
  for i, option in ipairs(options) do
    command = table.concat({
      'set ',
      option['key'],
      (option['value'] and '=' .. option['value'] or '' ),
    })

    vim.api.nvim_command(command)
  end
end

function map_key_bindings(bindings)
  for i, binding in ipairs(bindings) do
    local mode

    if binding['mode'] == nil then 
      mode = 'n'
    else 
      mode = binding['mode']
    end

    vim.api.nvim_set_keymap(mode, binding['key'], binding['command'], { noremap = true })
  end
end
