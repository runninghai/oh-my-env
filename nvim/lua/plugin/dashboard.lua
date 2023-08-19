require('dashboard').setup({
   theme = 'hyper',
   config = {
     footer = {
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                                                                                          ",
         "                                                                                              自分に同情するな。自分に同情するのは下劣な人間がやることだ。"
     },
     header = {
        '          ▀████▀▄▄              ▄█ ',
        '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
        '    ▄        █          ▀▀▀▀▄  ▄▀  ',
        '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
        '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
        '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
        '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
        '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
        '   █   █  █      ▄▄           ▄▀   ',
     },

     week_header = {
      enable = true,
     },
     shortcut = {
       { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
       {
         icon = ' ',
         icon_hl = '@variable',
         desc = 'Files',
         group = 'Label',
         action = 'Telescope find_files',
         key = 'f',
       },
     },
   },
 })
