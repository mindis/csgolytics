CSGOLytics
==========

CSGOLytics imports the Valve SRCDS/CS:GO (Counter Strike Global Offense) server logfile and writes all game events as structured data (JSON) into a backend database ([EventQL](https://eventql.io/)).

![Screenshot](https://raw.githubusercontent.com/paulasmuth/csgolytics/master/screenshot.png)

Usage
-----

CSGOLytics requires a running [EventQL](https://eventql.io/) database. You can start the CSGOLytics app with this command:

    $ ./csgolytics \
          --listen_udp 0.0.0.0:3764 \
          --listen_http 0.0.0.0:3765 \
          --eventql_addr localhost:9175 \
          --eventql_database csgolytics

To use CSGOLytics, you have to enable detailed logging in your dedicated server. You can either execute these lines via rcon or put them into your `autoexec.cfg` file.

    > rcon log on
    > rcon mp_logdetail 3

#### Sending log data via logtail

The preferred way of sending the CS:GO logfiles to csgolytics is by using the included `csgolytics_logtail` script. To start the logtail script, execute this command (replace x.x.x.x with the address on which csgolytics is listening for http connections):

    $ scripts/csgolytics_logtail --logdir /path/to/csgo/server/csgo/logs --target http://x.x.x.x:3765
    
#### Sending log data via UDP

Alternatively, you can use the built-in remote logging support to receive the log data via udp. However this is less reliable. Execute this line via rcon or put it into the `autoexec.cfg` file (replace x.x.x.x with the address on which csgolytics ist listening for udp packets)

    > rcon logaddress_add x.x.x.x:3764
    
When using UDP logging, you have to specify a source address to server_id mapping. To do so ... [FIXME}


Game Events (JSON)
------------------

#### Frag Event (csgo_frags)

    {  
       "event":"frag",
       "time":"2016-12-18T11:51:19Z",
       "attacker_name":"le_fnord",
       "attacker_steamid":"STEAM_1:0:123456789",
       "attacker_team":"CT",
       "attacker_coords_x":-285,
       "attacker_coords_y":343,
       "attacker_coords_z":1,
       "victim_name":"Allen",
       "victim_steamid":"BOT",
       "victim_team":"T",
       "victim_coords_x":-282,
       "victim_coords_y":424,
       "victim_coords_z":125,
       "weapon":"ak47",
       "headshot":false,
       "penetrated":false,
       "server_id":"aim"
    }


License
-------

Copyright (c) 2016 Paul Asmuth

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
