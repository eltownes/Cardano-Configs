
# OpenSSH Quick Ref (Windows --> Ubuntu)
<br>

##### _Get password access working then transition to key only access._
<br>

### Resources

o [OpenSSH on Ubuntu](https://help.ubuntu.com/community/SSH)  
<br>

### Ubuntu - install & config
o ` sudo apt-get install openssh-server `  
o backup file before making changes:  
``` 
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```  
o ` ssh -v localhost ` : test for a local connection - verbose  
o tighten security a bit:  
    \ \ \ \  o sshd_config: ` AllowUsers bob `  
o consider a non-standard port (default is 22)  
o restart
```
service ssh restart
```  
<br>

### Windows - test password login
o login
```
ssh bob@1.1.1.2
```  
<br><br>

## Transition to SSH key only access

### Windows - generate keys
o run PowerShell as Administrator  
o choose 'location' and passphrase  
```
ssh-keygen -b 4096
```
o navigate to 'location' and verify SSH key pair:  
    \ \ \ \ o id_rsa  
    \ \ \ \ o id_rsa.pub
<br>



<br><br>

