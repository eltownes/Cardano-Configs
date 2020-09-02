
# OpenSSH Quick Ref (Windows / Ubuntu)
<br>

##### _Get password access working then transition to key only access._
<br>

### Sources

* [OpenSSH on Ubuntu](https://help.ubuntu.com/community/SSH)  
<br>

### Ubuntu
* ` sudo apt-get install openssh-server `  
* ` sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup ` : backup file before making changes
* ` ssh -v localhost ` : test for a local connection - verbose  
* Tighten security a bit:  
\ sshd_config: ` AllowUsers bob `
* Consider a non-standard port (default is 22)
* ` service ssh restart `
<br>

### Windows
* login: ` ssh bob@1.1.1.2 `  
<br><br>

### Transition to SSH key only access

### Windows
* Run PowerShell as Administrator  
* ` ssh-keygen -b 4096 ` : choose 'location' and passphrase  
* Navigate to 'location' and verify SSH key pair:  
\ - id_rsa  
\ - id_rsa.pub
<br>



<br><br>

