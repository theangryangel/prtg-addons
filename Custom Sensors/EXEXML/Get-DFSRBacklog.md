# Get-DFSRBacklog.ps1 - Script to allow PRTG Network Monitor to report the status of DFS replication backlogs.

## Background

Distributed File System (DFS) is a feature of Windows Server allowing file shares to be replicated across servers for purposes of load balancing, high availability, branch office synchronisation etc. Monitoring replication backlog queues is important for checking the health of the replication group or for troubleshooting problems.

Script is a modified version of the one available on Microsoft Technet. See http://gallery.technet.microsoft.com/scriptcenter/dac62790-219d-4325-a57b-e79c2aa6b58e/ for further information and discussion. Script modified to produce the XML output required by a PRTG custom sensor. 

## Compatibility

DFS Server - Windows 2003 R2 or later
PRTG - PRTG Network Monitor 9 and above running on Windows 2003R2 / Vista or later

## Usage

	* Save this script to the folder Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML

	* Set up a new Custom Sensor - EXE/Script Advanced

	* Select Get-DFSRBacklog.ps1 in EXE/Script dropdown

	* In Parameters add -computer [DFS SERVER NAME]

	* Timeout - This script can take a considerable time to run if you have long replication queues. You may will have to increase the timeout to a value appropriate for your environment. A timeout of 600 has been found in testing to be sufficient for total backlogs in excess of 1 million on average hardware.

	* Scanning interval - judging by the time this script can take to run, it may be quite intensive on your DFS server. You shuold judge and make a decission on an appropriate scanning interval for your enviroment.


By default this script will return inbound and outbound queues for all replication groups. Optionally you can use additional parameters -RGName and RFName to restrict to one replication group or replicated folder.

Troubleshooting

Script can be run from a power shell window on the PRTG server to test and should produce well formed XML as in the example below.

PS C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML> .\Get-DFSRBacklog.ps1 -computer fs2
<prtg>
<result>
<channel>RG1 In</channel>
<value>24</value>
</result>
<result>
<channel>RG1 Out</channel>
<value>634</value>
</result>
<result>
<channel>RG2 In</channel>
<value>0</value>
</result>
<result>
<channel>RG2 Out</channel>
<value>2</value>
</result>
.
.
.
</prtg>

## Acknowledgements
Script adapted for PRTG by Tim Boothby - timboothby@hotmail.com
Originally from [http://code.google.com/p/prtg-addons/](http://code.google.com/p/prtg-addons/)
