# Sopa [![Build Status](https://app.codeship.com/projects/4059db10-449f-0137-4a06-2ebb4adb651b/status?branch=master)](https://app.codeship.com/projects/4059db10-449f-0137-4a06-2ebb4adb651b/)
Local Web Application and Android App to improve the 3rd sector businesses. 


## Introduction
The project was born to deal with the requirement of automatically manage orders and requests from plenty of customers to the corresponding host or establishment.

The project is basically focused on customers, orders, employees, products and thereby bills, business data, food dishes, beverages and similar.

Sopa becomes the second main software project developed by ImagineIng organization, which basically consists of a Web Application deployed locally and followed by an Android App, deployed locally as well. Locally does not means that it cannot be implemented via Internet, it is just the first vision.

The first potential Partner is a proprietary holiday resort placed in Guanacaste (which name is not mentioned yet due to restrictions and ongoing contractual procedures).

## Getting Started

For demostration, the app can be accessed with: [heroku](https://heliconias-sopa.herokuapp.com)

Please follow the instructions in the [manual](./S_O_P_A.pdf)

### Prerequisites

There are two kind of packages, those necessary to run the application and those to debug and troubleshoot issues from the developer perspective.

#### Minimal packages required
1. The following packages can be installed by executing the command: `sudo apt-get install *package_name* `. For example: `sudo apt-get install npm`:

  * `npm`
  * `git`
  * `nodejs`
  * `mysql-server`
  * `mysql-common`
  * `mysql-client`
  * `sendmail`
  * `sharutils`
  * `ssmtp`

    1.1 *Summary*: ```sudo apt-get install npm git nodejs-legacy mysql-server mysql-common mysql-client sendmail sharutils ssmtp  -y```
If npm is not installed after nodejs installation, please try to install nodejs with the following command,
```curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -```
```sudo apt-get install nodejs```

2. Install the printer Packages:
  ```
sudo apt-get install libcups2-dev libcupsimage2-dev git build-essential
```
```
sudo adduser $USER lp
```
#### Debugging Packages (*ONLY* for developers)
1. Install the following packages with `sudo apt-get install *package_name*`:
  * `openssh_client`
  * `openssh_server`
  * `tcpdump`
  * `htop`
  * `links2`
  * `putty`
  * `screen`
  * `xfce4`
  * `xfce4-goodies`
  * `tightvncserver`
  * `vim`

### Installing

A step by step series of examples that tell you have to get a development env running

1. Create 2 new folders called `local` and `local/mesero`.

```
mkdir local;
mkdir local/mesero;
```

2. Enter to local and execute the following command to clone the git repository:

```
cd local;
git clone https://github.com/JeanCarlosChavarriaHughes/sopa.git
```

3. Enter to the new folder created by git.
```
cd sopa
```

4. Install all NPM and Bower dependencies by running the following commands:
  * ```npm install ```
  * ``` sudo npm install --global pm2```
  * ``` sudo npm install --global bower```
  * ```bower install ```

5. Enter to the folder `mesero` by executing the command `cd; cd local/mesero`.

6. Execute the following command to clone again the repository *(this will be used to mesero version)*.

```
git clone https://github.com/JeanCarlosChavarriaHughes/sopa.git
```

7. Enter to the new folder created by git.
```
cd sopa
```

8. Move to the *mesero* branch with:
```
git checkout mesero
```
The console output should be something like:
*Switched to a new branch 'mesero'*

9. Install all NPM and Bower dependencies by running the following commands:
  * ```npm install ```
  * ```bower install ```

10. Set a persistent configuration for the printer. More details follow [Writing udev rules, by Daniel Drake](http://www.reactivated.net/writing_udev_rules.html#example-printer)
  * Use the following command in order to see the device information. It must use only the _device_ information and maximun one _parent_ information in the _sysfs_ tree:   ```sudo udevadm info -a -p $(udevadm info -q path -n /dev/usb/lp0)```
  * Then create the _rule_ file in the folder: _/etc/udev/rules/_. For example: ```sudo touch /etc/udev/rules/10-local.rules```
  * Insert the *RULE* line in the file and save it: ```KERNEL=="lp0", SUBSYSTEM=="usbmisc", SUBSYSTEMS=="usb", DRIVERS=="usb", ATTRS{idVendor}=="0483", ATTRS{manufacturer}=="Printer-58", SYMLINK+="sopa_printer0"```
  * Finally test and execute the rules: ```sudo udevadm trigger``` and ```sudo udevadm control --reload```

Note: **Please note that the repository can be only cloned by one of the Sopa developers. The process cannot be executed by anyone due to credential restrictions. Contact imagineing team**
Note: If you receive the permission denied error: EACCES error, like the one mentioned [https://stackoverflow.com/questions/50543004/pm2-app-gets-permission-denied-when-printing](here). Please add permission to write ohters to the /usb/lp0. If sopa_printer0 points to /dev/usb/lp0, then make sure both the file and the link have 777 (it can be less but 777 worked for me).

## Deploy the application

There are two ways to use the application. Testing with `nodejs` or Production with `pm2`.

### Production
The following deployment will need a process manager. In this case `pm2` was elected. To use the application in production environment, please have used the process manager `pm2`. For deploying in production it is strictly recommended to use a process manager. In this case we have chosen pm2. [https://github.com/Unitech/pm2](pm2)

1. Start Local. Go to Local folder.

```
cd; cd local/sopa;
```
2. Start pm2 process manager
```
sudo pm2 start server.js --name local
```

3. Start the Mesero Process. Go to mesero folder
```
cd; cd local/mesero/sopa;
````

4. Start pm2 process manager.
```
sudo pm2 start npm --name mesero -- start
```

5.  To monitor the web server please read about [pm2](http://pm2.keymetrics.io/docs/usage/quick-start/#usage):
  * Dashboard of the server. ``` pm2 dashboard```
  * Exit from Dashboard. Press `q`.
  * Log of `local`: ``` pm2 log local```
  * Exit from logs. Press ``` ctrl + c```.
  * Log of `mesero`: ``` pm2 log mesero```

6. To get automatically-configured startup script for the machine execute the command: 
```
sudo pm2 startup
```

7. To save all configuration above.
```
sudo pm2 save
```

### Testing (*ONLY*  For developers)
Before running the application, please use a certain `screen`. Screen will allow you to execute the application via ssh terminal and if the sessions ends, the application will continue working in the backgroud.

1. Start the screen process:
`screen`

2. Make sure there is no more node apps running (Omit the step if the installation is fom scratch):
`ps aux | grep -i node`

3. Run the following commands:

* To use the remote Data Base, please pass the remote flag to node. The script section in `package.json` file has been updated for start process.
`node server.js remote`
The node server.js is now listening for port 8181. The server will let you know which IP Address and port should be accessed in the browser, *i.e:*
```
node server.js remote;
Listening ... http://192.168.1.112:8181
```
* To the Raspberry Pi Server for ImagineIng. The command could be;
`node server.js remote> stdout.txt 2> stderr.txt &`

4. deattach screen with  `$ctrl + a + d`

5. return to screen with `$screen -r`
[source](http://stackoverflow.com/questions/12701259/how-to-make-a-node-js-application-run-permanently)

---
 Secciones Pendientes

## Create the users for nodejs
Execute the following commands one by one and press `Ctrl + C` after each one.

```
node server.js create --username mesero1 --masterPassword 123456 --password pass1
```
```
node server.js create --username mesero2 --masterPassword 123456 --password pass2
```
```
node server.js create --username mesero3 --masterPassword 123456 --password pass3
```
```
node server.js create --username mesero4 --masterPassword 123456 --password pass4
```
```
node server.js create --username mesero5 --masterPassword 123456 --password pass5
```
```
node server.js create --username mesero6 --masterPassword 123456 --password pass6
```
```
node server.js create --username mesero7 --masterPassword 123456 --password pass7
```
```
node server.js create --username mesero8 --masterPassword 123456 --password pass8
```
```
node server.js create --username mesero9 --masterPassword 123456 --password pass9
```
```
node server.js create --username mesero10 --masterPassword 123456 --password pass10
```
```
node server.js create --username cajero11 --masterPassword 123456 --password pass11
```
```
node server.js create --username cajero12 --masterPassword 123456 --password pass12
```
```
node server.js create --username cajero13 --masterPassword 123456 --password pass13
```
```
node server.js create --username cajero14 --masterPassword 123456 --password pass14
```
```
node server.js create --username admin1 --masterPassword 123456 --password admin1
```
```
node server.js create --username user1 --masterPassword 123456 --password pass1
```

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Built With

The compiler version used: _version_

## Contributing

Before any contribution either from ImagineIng or outside the organizacion, either in software contribution or infrastructure modification or any kind or related modification to the Sopa project, please stick to the terms and conditions stated in the License document: https://www.gnu.org/licenses/agpl-3.0.txt

Please contact [email](jchavarria@gmail.com)

## Versioning

### Version 1.0
