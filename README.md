# Lexidoo Guix Config

## Home

To reconfigure the home directory of `$USER` (sibl):  
`guix home -L ~/guix-config reconfigure ~/guix-config/home/lexidoo-home.scm`

> the home service currently have the username `sibl` hardcoded.

## System

To reconfigure the system:  
`sudo guix system reconfigure -L ~/guix-config reconfigure ~/guix-config/systems/lexidoo.scm`
