#!/usr/bin/env texlua

module = "relative"

typesetfiles  = {"*.tex"}

checksuppfiles = {"*.tex"}

typesetsuppfiles = { 'pkginfo.sty' }

excludefiles = {
  'BUILD.md',
  'relative-code.tex',
  'relative-doc.tex'
}

cleanfiles = {
  '*.aux',
  '*.glo',
  '*.synctex',
  '*.synctex(busy)',
  '*.gz',
  '*.fls',
  '*.hd',
  '*.idx',
  '*.ilg',
  '*.ind',
  '*.log',
  '*.out',
  '*.pdf',
  '*.fdb_latexmk'
}

checkconfigs = {
  "build",
  "build2"
}
