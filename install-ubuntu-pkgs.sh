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
