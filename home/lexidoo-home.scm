(define-module (home lexidoo-home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services xdg)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (home fish)
  #:use-module (home packages)
  #:use-module (home services odoo)
  #:use-module (ice-9 string-fun))

(home-environment
 (packages home-packages)
 (services
  (cons*
   home-fish-config
   (service home-shepherd-service-type
            (home-shepherd-configuration
             (services 
              (list odoo-filebrowser-service odoo-jellyfin-service))))
   %base-home-services)))
