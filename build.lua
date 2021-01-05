#!/usr/bin/env texlua

module = "relative"

typesetfiles  = {"*.tex"}

checksuppfiles = {"*.tex"}

typesetsuppfiles = { 'pkginfo.sty' }

cleanfiles = {
  '*.aux',
  '*.glo',
  '*.synctex',
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
