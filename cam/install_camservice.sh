 #!/bin/bash

cp cam.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable cam
systemctl start  cam
systemctl status cam
