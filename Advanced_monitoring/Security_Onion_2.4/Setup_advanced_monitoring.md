# Set up advanced monitoring with the Security Onion - at no extra cost!
In order for information to be examined quickly and efficiently, I believe it is essential to store the information centrally. This is where Security Onion comes in (The tool is free of charge!).

But before information can be examined, advanced logging (in this example, with domain controllers) must be set up. The following article from the Microsoft documentation is a great starting point.

**Configure Windows Event collection**  
https://learn.microsoft.com/en-us/defender-for-identity/configure-windows-event-collection

Now it's time to install and configure Security Onion. On the website of Security Onion Solutions there is a really great documentation for installation and configuration. The hardware requirements are addressed and everything needed to get an instance up and running.

> Note: Here you can find the information about the installation and configuration: [Security Onion Documentation](https://docs.securityonion.net/en/2.4/)

**Use the new Security Onion 2.4**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_4.png" alt="Use the new Security Onion 2.4">

**Uninstall old agents if necessary**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_2.png" alt="Uninstall old agents">

**Check the service - should be removed after uninstall**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_3.png" alt="Check the service">

**The status of the Security Onion**  

After the installation of the Security Onion, it is now time to set up the agent (Elastic Agent) on all systems (that are to be monitored). First, check the status of the Security Onion.

**At the console**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_1.png" alt="Check the status">

**With the browser**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_5.png" alt="Check the status">

**The firewall settings**  

But before we start with the installation of the agent. We first need to adjust the Security Onion firewall settings so that the agent can communicate with the Security Onion.

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_6.png" alt="Firewall Settings">

**Download the agent**

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_7.png" alt="Download the agent">

**Install the agent (elevated rights)**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_8.png" alt="Install the agent">

**Accept warning and install the agent**

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_9.png" alt="Accept warning and install the agent">

**The installation starts**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_10.png" alt="The installation starts">

**The installation is complete**

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_11.png" alt="The installation is complete">

**Check the service**

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_11a.png" alt="Check the service">

## Now it's time to install Sysmon. You can get the tool directly from the Sysinternals website:  

**Live Sysinternals**  
https://live.sysinternals.com/

I have downloaded the file Sysmon64.exe. Sysmon is very detailed in its default configuration. But you can define which information is important for you. I will gladly provide you with an example configuration file. 

[Sysmon Configuration File](/Advanced_monitoring/Security_Onion_2.3/sysmon-config.xml)

> Note: This configuration file is from @SwiftOnSecurity (many thanks here!) https://github.com/SwiftOnSecurity

Afterwards the installation is done as follows:  

```
sysmon64.exe -i sysmon-config.xml
```

When you access the file for the first time, you still have to accept the license terms.

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_14.png" alt="Accept the license terms">

> Note: You can automate the installation of the Elastic Agent and Sysmon very well with a group policy object.

If you have made all preparations you can now call the URL to your Security Onion (as defined by you during the installation) and check if the information has arrived.

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_12.png" alt="Dashobard">

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_13.png" alt="Fleet Agents">

**This is an example of the information that is collected**  

<img src="/Advanced_monitoring/Security_Onion_2.4/Images/so_15.png" alt="Information">

---
## *HAPPY MONITORING!*
---