#!/bin/bash
UBUNTU_PKGS=(

  'pkg-config'
  'glib-2.0-dev'
  'libcairo2-dev'
  'libpango1.0-dev'
  'libgtk2.0-dev'
  'python-docutils'
  )

apt-get install -y "${UBUNTU_PKGS[@]}"

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

## Check out everything
for repo in "${REPOS[@]}"; do
  git clone https://github.com/diagrams/$repo
done

## Build diagrams
stack setup
stack build gtk2hs-buildtools
if [[ $OSTYPE == darwin* ]]; then
    stack exec -- stack build --flag gtk:have-quartz-gtk
else
    stack exec -- stack build
fi

## Build the website
cd diagrams-doc
stack runghc Shake.hs clean
stack ghc -- --make Shake -threaded
stack exec -- ./Shake +RTS -N7 -RTS build
