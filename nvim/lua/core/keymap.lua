local keyset = vim.keymap.set

keyset('n', '<Leader>rr', ':source $MYVIMRC<CR>')

keyset('n', '<Leader>wq', ':wq<CR>')
keyset('n', '<Leader>w', ':w<CR>')
keyset('n', '<Leader>q', ':q<CR>')
keyset('n', '<Leader>qq', ':q!<CR>')

keyset('n', '<Space>jp', 'o<Esc>p')
keyset('n', '<Space>kp', 'O<Esc>p')

keyset('n', '<Up>', '<nop>')
keyset('n', '<Down>', '<nop>')
keyset('n', '<Left>', '<nop>')
keyset('n', '<Right>', '<nop>')
keyset('i', '<Up>', '<nop>')
keyset('i', '<Down>', '<nop>')
keyset('i', '<Left>', '<nop>')
keyset('i', '<Right>', '<nop>')

-- TODO. use a module function rather then a globle function
function openFileByDate()
  -- 获取当前日期
  local currentDate = os.date('%Y/%m/%d')

  -- 构建文件路径
  local filePath = os.getenv("LOGPATH").. '/log/' .. currentDate .. '/README.md'

  -- 打开文件
  vim.cmd('edit ' .. filePath)
end
-- daily log
keyset('n', '<Space>lt', ':vs $LOGPATH/task/task.json<CR>')
keyset('n', '<Space>ld', ':lua openFileByDate()<CR>')

