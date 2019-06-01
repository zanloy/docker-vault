#!/bin/bash

read -p "[?] Are you sure you want to remove all Vault's data (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo '[*] Removing files...'
        echo '[+] Removing: ./data/consul/*'
        rm -rf ./data/consul/*
        echo '[+] Removing: ./data/vault/*'
        rm -rf ./data/vault/*
        echo '[+] Removing: ./data/keys.txt'
        rm -f ./data/keys.txt
    ;;
    * )
        echo "[*] Aborting..."
    ;;
esac
