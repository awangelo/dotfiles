```
sudo systemctl enable NetworkManager.service power-profiles-daemon.service fstrim.timer
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```
