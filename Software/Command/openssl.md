Methods
=====
* aes-128-cbc ← this is okay
* aes-128-ecb
* aes-192-cbc
* aes-192-ecb
* aes-256-cbc ← this is recommended
* aes-256-ecb

Encryption
=====
* $ openssl aes-256-cbc -in attack-plan.txt -out message.enc
* Then openssl will ask password to encrypt

Decryption
=====
* $ openssl aes-256-cbc -d -in message.enc -out plain-text.txt
* Then openssl will ask password to decrypt