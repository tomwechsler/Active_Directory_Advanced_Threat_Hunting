#Check the the winlogbeat config file
C:\Program Files\Elastic\Beats\8.7.1>winlogbeat.cmd test config -c "C:\ProgramData\Elastic\Beats\winlogbeat\winlogbeat.yml" -e

#Install sysmon (Change to the directory where you downloaded Sysmon)
Sysmon64.exe -i sysmon-config.xml

