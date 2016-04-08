#!/usr/bin/local/lua

--[[
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
]]--

-- example command: ncat -vlkp [listening_port] --lua-exec [full_path_to_this_file]

BANNER = "220 PCMan's FTP Server 2.0 Ready.\r" -- Fake banner message mimicking a real ftp service
cmd_list = {pwd=true,list=true,mkd=true,port=true,quit=true,dele=true,syst=true,stat=true,size=true,stor=true} -- Command recognized by server (Server will complain login is needed before command is used)
print(BANNER)
while( true ) -- starts 1 on 1 communication
do
userinput = io.read() -- gets user input
	local t = {}; i = 1
	for token in string.gmatch(userinput, "[^%s]+") do -- 't' is a table of each word in user's input
		t[i] = token
		i = i + 1
	end
	if t[1] == nil then
		t[1] = ''
	end
	if (t[1]:lower() == 'user') then -- check if login unauthorized command or unknown command
		print('331 User name okay, need password.\r')
	elseif (t[1]:lower() == 'pass') then
		print('530 Not logged in.\r')
	elseif (cmd_list[t[1]:lower()]) then
		print('530 Not logged in.\r')
	else
		print('500 Syntax error, command unrecognized.\r')
		print(t[1]:lower())
	end
end
