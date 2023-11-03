;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (gnu services xorg)
             (chuccle-channel environment chuccle-de)
)

(use-service-modules cups desktop networking ssh xorg)
(use-package-modules emacs suckless xdisorg)

(operating-system
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "GUIX")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "Charlie")
                  (comment "Charlie")
                  (group "users")
                  (home-directory "/home/Charlie")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))



  (packages (append (list
                     emacs
		                 chuccle-st
		                 chuccle-dwm
                     chuccle-dmenu
                     sx
                     slstatus
                     (specification->package "nss-certs"))
                   %base-packages))

  (services
   (cons*
            ;; Define the lightdm-service-type
            (service xorg-server-service-type
              (xorg-configuration
	             (keyboard-layout keyboard-layout)))
	    
	    (modify-services %desktop-services
              (delete gdm-service-type))))
	  

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout keyboard-layout)))
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "ea6fd892-e445-4b0a-a803-01b36b06a13a"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "ext4")
                         (dependencies mapped-devices)) %base-file-systems)))
