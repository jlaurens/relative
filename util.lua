#!/usr/bin/env texlua

local function execute_cmd(cmd) {
  local pfile = assert(io.popen(cmd, 'r'))
  local stdout = pfile:read('*a')
  pfile:close()
  return stdout
}

local function insert_unik(list, item)
  for _, v in pairs(list) do
    if v == item then
      item = nil
      break
    end
  end
  if item then
    table.insert(list, item)
  end
end

local function file_remove (filename)
  local extensions = {
    'aux',
    'glo',
    'synctex',
    'synctex.gz',
    'fls',
    'hd',
    'idx',
    'ilg',
    'ind',
    'log',
    'out',
    'pdf',
    'fdb_latexmk'
  }
  for _, ext in pairs(extensions) do
    os.remove (filename .. '.' .. ext)
  end
end

local function clean_test ()
  local pfile = assert(io.popen(("find testfiles -mindepth 1 -maxdepth 1 -type f -print0"), 'r'))
  local list = pfile:read('*a')
  pfile:close()
  local files = {}
  for filename in string.gmatch(list, '%Z+') do
    local m = string.match(filename, ".-[^\\/]-%.?([^%.\\/]+)(%.[^%.\\/]*)$")
    if m then
      insert_unik(files, m)
    end
  end
  for _, filename in pairs(files) do
    file_remove('testfiles/' .. filename)
  end
end

local function clean_test_input ()
  local list = execute_cmd("find testfiles/input/ -type f -print0")
  local files = {}
  for filename in string.gmatch(list, '[^%z]+') do
    local m = string.match(filename, ".-[^\\/]-%.?([^%.\\/]+)(%.[^%.\\/]*)$")
    if m then
      insert_unik(files, m)
    end
  end
  for _, f in pairs(files) do
    file_remove('testfiles/input/' .. f)
  end
end

local function clean_source()
  remove('relative')
  remove('relative-doc')
  remove('relative-code')
end

local function test_save (what)
  local function build(basename)
    local cmd = string.format("l3build save '%s'", basename)
    print('Execute `' .. cmd .. '`...')
    return execute_cmd(cmd)
  end
  local list
  if what == 'all' then
    list = execute_cmd("find testfiles -type f -name '*.lvt' -print0")
  elseif what then
    list = what
  else
    print('Problem ', arg[3])
    os.exit()
  end
  stdout = {}
  for filename in string.gmatch(list, '[^%z]+') do
    local m = string.match(filename, ".-[^\\/]-%.?([^%.\\/]*)(%.lvt)$")
    if m then
      print(filename, m)
      stdout[m] = build(m)
    else
      m = string.match(filename, ".-[^\\/]-%.?([^%.\\/]*)$")
      print(filename, m[1])
      if m then
        stdout[m] = build(m)
      end
    end
  end
  for k, v in pairs(stdout) do
    print(k, v)
  end
end

local function test_tlg (what, how)
  local list
  if what == 'all' then
    list = execute_cmd("find testfiles -name '*.tlg' -type f -exec grep '%s' '{}' \\; -print0")
  elseif what then
    list = execute_cmd("find testfiles -name '%s.tlg' -type f -exec grep '%s' '{}' \\; -print0")
  else
    print('Problem ', arg[3])
    os.exit()
  end
  for line in string.gmatch(list, '[^%z]+') do
    print(line)
  end
end

local function build_doc (what)
  local cmd = string.format([[pdflatex %s
  makeindex -s gind.ist %s
  pdflatex %s
  makeindex -s gind.ist %s
  pdflatex %s
  ]], what, what, what, what, what)
  execute_cmd(cmd)
end

local pwd = os.getenv('PWD')
if arg[1] == 'clean' then
  if arg[2] == 'source' or arg[2] == 'all' or not arg[2] then
    clean_source()
    os.exit()
  end
  if arg[2] == 'test' or arg[2] == 'all' or not arg[2] then
    clean_test()
    clean_test_input()
    os.exit()
  end
elseif arg[1] == 'test' then
  if arg[2] == 'save' then
    test_save(arg[3])
  elseif arg[2] == 'tlg' then
    test_tlg(arg[3], '^! ')
    test_tlg(arg[3], '^.*XPCT:.*FAILED.*PASSED.*out.*of')
  end
elseif arg[1] == 'build' then
  if arg[2] == 'doc' then
    build_doc('relative-doc')
  elseif arg[2] == 'code' then
    build_code('relative-code')
  elseif arg[2] == 'all' or not arg[2] then
    execute_cmd('l3build doc')
  else
    build_code('relative.dtx')
  end
end
print('DONE')