
# OpenSSH Quick Ref (Windows --> Ubuntu)

##### _Get password access working then transition to key only access._

### Resources

* [OpenSSH on Ubuntu](https://help.ubuntu.com/community/SSH)  

### Ubuntu - install & config
* install
```
sudo apt-get install openssh-server
```   
* backup file before making changes:
``` 
sudo cp /etc/ssh/sshd_config $HOME/backup/ssh
```  
* test for a local connection : ` ssh -v localhost `  
* tighten security a bit:  
   * sshd_config:  
      * ` AllowUsers [id] `  
      * ` PermitEmptyPasswords no`  
      * ` Port [#] ` user ports: 1024-49151  
* restart service : ` service ssh restart `

### Windows - PowerShell password login
* login
```
ssh [user]@1.1.1.1 -p [port #]
```  
<br>

## Transition to SSH key only access

### Windows
* run PowerShell as Administrator  
* choose file location and passphrase (ssh login password)
```
ssh-keygen -b 4096
```
* navigate to file location and verify SSH key pair:  
    * id_rsa  
    * id_rsa.pub  
* copy public key to Ubuntu via scp  
  if adding more keys, modify below command:  
    * first backup 'authorized_keys' and then just send the key  
    * then concatenate new key: ` cat id_rsa.pub >> authorized_keys `  
    
```
scp -P [port #] id_rsa.pub [user]@1.1.1.1:~/.ssh/authorized_keys
```
* modify settings in 'sshd_config' to disallow password and enable pubkey
authentication
  * ` PubkeyAuthentication yes `  
  * ` PasswordAuthentication no `  

### Windows <---> Ubuntu
* Copy file to local pc  
```
scp -P [port #] [user]@1.1.1.1:~/backup/[file] C:\dlt 
```
* Copy directory to local pc  
```
scp -r -P [port #] [user]e@1.1.1.1:~/backup/[folder] C:\dlt
```


<br><br>

