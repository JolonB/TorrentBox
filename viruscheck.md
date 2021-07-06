# Virus Checking

To check for viruses in the files you download, we are going to use VirusTotal.
VirusTotal has a command line tool available which is very easy to set up.

To begin, [create a VirusTotal account](https://virustotal.com/gui/join-us).  
Log in to your account a find your personal API key and make a note of it.

Before we can install VirusTotal, we need to install Golang v1.12 (or higher?).
To do this, simply run:

```shell
wget https://golang.org/dl/go1.12.linux-armv6l.tar.gz -O go.tar.gz
sudo tar -C /usr/local/ -xzf go.tar.gz
GOPATH=$HOME/go
printf "\n# Golang install\nexport GOPATH=$GOPATH\nexport PATH=/usr/local/go/bin:$PATH:$GOPATH/bin\n" >> ~/.bashrc
```

Next, we need to install VirusTotal on the command line (vt-cli).
The full instructions can be found on [the GitHub page](https://github.com/VirusTotal/vt-cli), but the instructions are repeated below anyway:


```shell
git clone https://github.com/VirusTotal/vt-cli
cd vt-cli
make install
```

Try running `vt`.
If this command doesn't work, check that it is present at ~/go/bin/vt and that `$PATH` has been correctly set to include ~/go/bin at the end.

If that works, you can optionally set up autocompletion with:

```shell
vt completion bash > /etc/bash_completion.d/vt
# If the above command doesn't work (due to permissions), you can try the following:
vt completion bash | sudo tee /etc/bash_completion.d/vt > /dev/null
```

Now you can initialise VirusTotal by running:

```shell
 vt init
```

Paste your API key when it asks for it.

## ClamScan

We can also run a virus check on files offline (as VirusTotal is only useful for files <200 MB).
To do this, we use `clamscan`.

<!-- Or maybe we don't because it seems to freeze the Pi -->
