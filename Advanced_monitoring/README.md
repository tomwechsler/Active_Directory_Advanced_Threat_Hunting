# Set up advanced monitoring - at no extra cost!
In order for information to be examined quickly and efficiently, I believe it is essential to store the information centrally. This is where Security Onion comes in (The tool is free of charge!).

But before information can be examined, advanced logging (in this example, with domain controllers) must be set up. The following article from the Microsoft documentation is a great starting point.

**Configure Windows Event collection**  
https://learn.microsoft.com/en-us/defender-for-identity/configure-windows-event-collection

Now it's time to install and configure Security Onion. On the website of Security Onion Solutions there is a really great documentation for installation and configuration. The hardware requirements are addressed and everything needed to get an instance up and running.

> Note: Here you can find the information about the installation and configuration: [Security Onion Documentation](https://docs.securityonion.net/en/2.3/)

After the installation, it is now time to set up the agent (Winlogbeat) on all systems (that are to be monitored).

<img src="/Advanced_monitoring/SO-Winlogbeat.JPG" alt="Download Winlogbeat Agent">

When you have downloaded the agent and the installation has been completed, you will be asked at the end if you want to open the directory to the configuration files. Confirm this so that the directory is opened. This directory contains sample configuration files for the agent. I have provided you with an example here. These file are written in YAML format.

[Winlogbeat Configuration File](/Advanced_monitoring/winlogbeat.yml)

If you have copied this file into the directory, you can now run a check and see if everything is ok. YAML is very space sensitive, a check is worthwhile in any case.

<img src="/Advanced_monitoring/SO-Winlogbeat_Config_Check.JPG" alt="Check the Configuration File">

An "OK" confirmation must be issued otherwise the service will not start.

<img src="/Advanced_monitoring/SO-Winlogbeat_Config_OK.JPG" alt="Config OK">

If everything is in order, the service must now be started.

<img src="/Advanced_monitoring/SO-Winlogbeat_Service.JPG" alt="Start the service">

Now it's time to install Sysmon. You can get the tool directly from the Sysinternals website:

**Live Sysinternals**  
https://live.sysinternals.com/

I have downloaded the file Sysmon64.exe. Sysmon is very detailed in its default configuration. But you can define which information is important for you. I will gladly provide you with an example configuration file. 

[Sysmon Configuration File](/Advanced_monitoring/sysmon-config.xml)

Afterwards the installation is done as follows:  
- sysmon64.exe -i sysmon-config.xml

When you access the file for the first time, you still have to accept the license terms.

> Note: You can automate the installation of the Winlogbeat agent and Sysmon very well with a group policy object.

If you have made all preparations you can now call the URL to your Security Onion (as defined by you during the installation) and check if the information has arrived.

<img src="/Advanced_monitoring/SO-Dashboard.JPG" alt="Dashobard">

<img src="/Advanced_monitoring/SO-Dashboard-Elastic.JPG" alt="Elastic Dashobard">

---
## *HAPPY HUNTING!*
---