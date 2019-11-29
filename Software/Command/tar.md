Extract
=====
```sh
tar zxvf  FileName.tar.gz
tar jxvf  FileName.tar.bz
tar jxvf  FileName.tar.bz2
tar Jxvf  FileName.tar.xz
tar Zxvf  FileName.tar.Z
tar zxvf  FileName.tgz
tar zxvf  FileName.tar.tgz
gunzip -k FileName.gz
gzip -dk  FileName.gz
```

Extract to folder
=====
```sh
mkdir $HOME/Desktop/Extract
tar zxvf FileName.tar.gz -C $HOME/Desktop/Extract
```

Pack
=====
```sh
cd $HOME/folder
sudo tar czvf ../pack.tar.gz . # Pack
```

Use xz
=====
* Compress
* $ xz file.txt
* Decompress
* $ xz -d file.txt.xz
