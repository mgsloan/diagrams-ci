#!/bin/bash
REPOS=(

  # support libraries
  'monoid-extras'
  'diagrams-solve'
  'dual-tree'
  'active'

  # core libraries
  'diagrams'
  'diagrams-core'
  'diagrams-lib'
  'diagrams-contrib'

  # extras
  'SVGFonts'
  'palette'
  'diagrams-input'
  'diagrams-graphviz'
  'diagrams-builder'

  # backends
  'statestack'
  'diagrams-cairo'
  'diagrams-gtk'
  'diagrams-html5'
  'diagrams-pgf'
  'diagrams-postscript'
  'diagrams-povray'
  'diagrams-rasterific'
  'diagrams-svg'

  # documentation, tests, & admin
  'diagrams-doc'
  'diagrams-haddock'
  'docutils'
  'diagrams-backend-tests'
  'package-ops'

  # miscellaneous
  'force-layout'
  )

rm -rf build-tmp  # remove build-tmp in case it is still there from before
mkdir build-tmp
cd build-tmp
ln -s ../stack.yaml .

for repo in "${REPOS[@]}"; do
  git clone https://github.com/diagrams/$repo
done

stack setup
stack build gtk2hs-buildtools
stack exec -- stack build
