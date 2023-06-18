# Set up advanced monitoring - at no extra cost!
In order for information to be examined quickly and efficiently, I believe it is essential to store the information centrally. This is where Security Onion comes in (The tool is free of charge!).

But before information can be examined, advanced logging (in this example, with domain controllers) must be set up. The following article from the Microsoft documentation is a great starting point.

**Configure Windows Event collection**  
https://learn.microsoft.com/en-us/defender-for-identity/configure-windows-event-collection

Now it's time to install and configure Security Onion. On the website of Security Onion Solutions there is a really great documentation for installation and configuration. The hardware requirements are addressed and everything needed to get an instance up and running.

> Note: Here you can find the information about the installation and configuration: [Security Onion Documentation](https://docs.securityonion.net/en/2.3/)

After the installation, it is now time to set up the agent (Winlogbeat) on all systems (that are to be monitored).

[[https://github.com/tomwechsler/Active_Directory_Advanced_Threat_Hunting/blob/main/Advanced_monitoring/SO-Winlogbeat.JPG]]


If you get stuck, look in the Solution directory.

---
## *GREAT WORK!*
---