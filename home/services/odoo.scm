(define-module (home services odoo)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)
  #:export (odoo-filebrowser-service odoo-jellyfin-service))

(define odoo-filebrowser-service
  (shepherd-service
   (documentation "Run File Browser.")
   (provision '(odoo-filebrowser))
   (start #~(make-forkexec-constructor
             '("podman" "run" "--replace" "--name" "file_browser" "--userns=keep-id" "--user" "1001:998" "-e" "GID=998" "-e" "UID=1001" "-v" "/home/sibl/containers_data/file_browser/data:/srv" "-v" "/shared:/srv/odoo" "-v" "/home/sibl/containers_data/file_browser/database:/database" "-v" "/home/sibl/containers_data/file_browser/config:/config" "-p" "8080:8080" "filebrowser/filebrowser")
             #:log-file (string-append (getenv "HOME")
                                       "/log/file-browser.log")))
   (stop #~(make-kill-destructor))))

(define odoo-jellyfin-service
  (shepherd-service
   (documentation "Run File Browser.")
   (provision '(odoo-jellyfin))
   (start #~(make-forkexec-constructor
             '("podman" "run" "--replace" "--name" "jellyfin" "-v" "jellyfin-config:/config" "-v" "jellyfin-cache:/cache" "--mount" "type=bind,source=/home/sibl/Public,target=/media" "--restart=unless-stopped" "-p" "8888:8096" "--device=/dev/dri:/dev/dri" "jellyfin/jellyfin")
             #:log-file (string-append (getenv "HOME")
                                       "/log/jellyfin.log")))
   (stop #~(make-kill-destructor))))
