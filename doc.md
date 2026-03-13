1. What is the difference between the kernel and the shell? In your own words, what does each one do?
- use shell to enter commands and the kernel to execute commands.

2. You type ls -la and see a file with permissions -rw-r--r--. Who can write to this file? Who can only read it?
- the owner can write it. every body can read it

3. What does ~ represent in Linux? What about /? What is the difference?
- the ~, means the home, its the user directory. / means the root. and root is the base directory of the system. 

4. You run tail -f /var/log/nginx/error.log. What does this do, and why would a DevOps engineer use it?
- to check the last 5 lines of log of nginx. to check the nginx server error

5. Explain the difference between rm file.txt and rm -rf folder/. Why is rm -rf dangerous?
- rm file.txt only remove the file and rm -rf, force remove recursively 

6. What is sudo? Why do we use it instead of just always logging in as root?
- root user. to run commands as root user

7. A friend says "I installed Python on my Ubuntu server with apt install python3". What two commands should they have run BEFORE installing, and why?
- ahoami and  apt update

8. Look at this permission number: chmod 644 file.txt. What permissions does the owner have? What about the group? What about others?
owner can read wirte, group can read, others can read

9. What is a shebang (#!/bin/bash) and what happens if you forget it in a shell script?
- to tell its a bash script, if no provided the script does not run commands inside

10. What command would you use to: find all files named config.yml on the entire system? Write the exact command.
- find / -name "config.yml" 