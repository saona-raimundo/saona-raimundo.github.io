---

layout: post
title:  "Suspicious SSH connection"
date:   2025-06-03 00:00:00 +0000
front: 	false
categories: 

---

From time to time, I was getting an `sftp` connection in my Linux machine.
It appeared in the file explorer, and when navigating into it the folder was empty.
At the end, it was simply an experimental feature of GSConnect (KDE Connect) that was turned on by default in my OS (bluefin).

At first, I thought that someone had access to my file system and I could not enter theirs. I thought some script was messing with my computer.
This is the summarized story of how I solved it.

## Audit a file

Say you want to audit everything that modifies a given file at `<PaTH_TO_FILE>`. Then, run this

> sudo auditctl -a always,exit   -F arch=b64   -F path=<PATH_TO_FILE>   -F perm=w   -k <KEY_OF_RULE>

where `<KEY_OF_RULE>` is simply a name to refer to this rule.

To watch everything that has been detected, run

> sudo ausearch -k <KEY_OF_RULE> -i

The rule will run while the pc is on. If you restart the pc, you must restart the rule.
To delete a rule, run

> sudo auditctl -D

## Audit a command

Very similar, run

> sudo auditctl -a always,exit -F arch=b64 -F exe=<PATH_TO_EXEC> -S execve -k <KEY>

And view the logs with

> sudo ausearch -k <KEY> -i

If you do not know where an executable is, you can run

> which <EXEC>

## My story

I watched the file `known_hosts` in the `.ssh` folder.
This led my to watch the `ssh` command.
Finally, AI suggested this could be triggered by GSConnect, which was indeed the case.
The port it was using was similar to

	[10.0.0.176]:1739 ecdsa-sha2-nistp256