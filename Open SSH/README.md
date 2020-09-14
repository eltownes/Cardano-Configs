
# OpenSSH Quick Ref (Windows --> Ubuntu)

##### _Get password access working then transition to key only access._

### Resources

* [OpenSSH on Ubuntu](https://help.ubuntu.com/community/SSH)  

### Ubuntu - install & config
* ` sudo apt-get install openssh-server `  
* backup file before making changes:
``` 
sudo cp /etc/ssh/sshd_config $HOME/backup/ssh
```  
* ` ssh -v localhost ` : test for a local connection  
* tighten security a bit:  
    * sshd_config: ` AllowUsers bob `, no empty passwords  
* consider a non-standard port (default is 22 / user ports: 1024-49151)  
* restart service
```
service ssh restart
```

### Windows - PowerShell password login
* login
```
ssh bob@1.1.1.2 [-p 1025]
```  
<br>

## Transition to SSH key only access

### Windows - generate keys
* run PowerShell as Administrator  
* choose file location and passphrase (ssh login password)
```
ssh-keygen -b 4096
```
* navigate to file location and verify SSH key pair:  
    * id_rsa  
    * id_rsa.pub  
* copy public key to Ubuntu via scp  
  if adding more keys, modify below command  
    * first backup 'authorized_keys' and then just send the key  
    * then concatenate new key: ` cat id_rsa.pub >> authorized_keys `  
    
```
scp [-P 1025] id_rsa.pub jim@1.1.1.1:~/.ssh/authorized_keys
```
* modify settings in 'sshd_config' to disallow password and enable pubkey
authentication


<br><br>

