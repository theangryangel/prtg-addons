# Send-IRCCatNotification.ps1 - Script to send an IRC notification from PRTG

## Usage

	* Save this script to the folder Program Files (x86)\PRTG Network Monitor\Custom Sensors\Notications

	* Create or alter an existing notification, and enable execute program

	* Select the powershell script
	
	* Set the parameters to what you need
	  i.e. -IRCCatHost "server_with_ircbot" -IRCCatPort "irc_cat_bot_port" -IRCCatChannel "irc_channel" -Message '[%sitename] %device %name %status %down (%message)'

	* Your IRC bot must listen on UDP port specified, and accept and understand
	  messages in the format { "method": "say", "params": ["#channel", "message here" ]}
