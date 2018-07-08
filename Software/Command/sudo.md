                  .bashrc
    COMMAND        $HOME   $USER  Env.  $PATH
 1. sudo -i        (root)   root  root  [1]
 2. sudo -s        (USER)   root  USER  /home/${USER}/bin:[1]
 3. sudo /bin/bash (USER)   root  USER  /home/${USER}/bin:[1]
 4. sudo su        (root)   root  USER  [1]:/usr/games:/usr/local/games
 5. sudo su -      (root)   root  root  [1]
