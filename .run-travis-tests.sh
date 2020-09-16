#!/bin/bash
export OPAMYES=true

dd if=/dev/zero of=/tmp/zfs.img bs=100M count=10
sudo losetup -P /dev/loop0 /tmp/zfs.img
sudo zpool create zfs /dev/loop0

dd if=/dev/zero of=/tmp/btrfs.img bs=100M count=10
sudo losetup -P /dev/loop1 /tmp/btrfs.img
sudo mkfs.btrfs -f /dev/loop1
sudo mkdir /btrfs
sudo mount -t btrfs /dev/loop1 /btrfs

[ -d ~/.opam/4.11.1 ] || opam init --compiler=4.11.1
opam install --deps-only -t .
#make

#dune exec -- obuilder build -f test/test1.spec test/test1 --store=btrfs:/btrfs
