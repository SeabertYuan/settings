#!/bin/sh

case $1 in
    fs)
        sshfs syuan07@remote.students.cs.ubc.ca:/home/s/syuan07 ssh_mnt
        ;;

    c)
        ssh syuan07@remote.students.cs.ubc.ca
        ;;
esac
