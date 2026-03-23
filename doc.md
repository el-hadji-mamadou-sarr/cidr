# Day 1

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

# Day 2

1. What is the difference between a public IP and a private IP? Give a real-world DevOps example of when you'd use each.
public ip that can be accessed from world and private ip is only accessed inside the cluster or the local network.
In a kubernetes cluster, each pod has a private ip because we don't want to expose the pod directy to the world and that come the load balancer like cloudflare
that have a public ip to route trafic to the pod.

2. What does 192.168.1.0/24 mean? How many usable host addresses does this network have?
its a private ip addresse with a cidr 24 so it has 254 hosts in the network

3. Explain DNS in your own words, as if explaining to someone who has never heard of it. What problem does it solve?
a dns is a like a dictionnary to map a domain to a public ip adresse. Because the domain is more human readable and easy to access and machines only understand ip addreses.

4. What is the difference between an A record and a CNAME record? Give an example of when you'd use each.
A record translate a domain to an ipv4 adresse. A CNAME translates an alias to a domain.
A record for a dns server to resolve a domain to a ipv4 adresse. CNAME for exemple in a microservice, when you want call another service, we can use the alias of the service
and kubernetes will resolve it to the service domain.

5. A user reports they get a 502 Bad Gateway on your app. As a DevOps engineer, what does this tell you? What would you check first?
The trafic does not know where to go. so i will check the pods if there up/down.

6. What is the difference between TCP and UDP? Why does DNS use UDP instead of TCP?
so TCP is reliable, the bytes arrives at the good order, if packet is lost, it will be resent and it uses the 3 way handshake to establish conexion.
UDP is unreliable, its faster than TCP, no conexion to establish. the data sent by the server for dns lookup, is tiny. so if the packet is lost, the server will reask. so no need for TCP overhead.

7. You run ss -tulpn on your server and see port 3306 is open and listening on 0.0.0.0. Why is this a security problem? How would you fix it?
so 3306 is the mysql server running. so it means that it will accept connexions on all hosts(public and private) its a security breach beause, every hosts on the outside world can connect to  the mysql server running on the machine. to fix it, we can listen on localhost: 127.0.0.1 or defined hosts.

8. Explain the difference between port 80 and port 443. Why should production apps never use port 80 alone?
port 80 is for HTTP and port 443 is for HTTPS. HTTPS use encryption on transit using SSL. in prod HTTPS is the norme because, we don't want the man in the middle attack to know the data we are transmitting between our server and the client

9. What is an SSH key pair? Which key goes on the server and which stays on your computer? What happens if you lose your private key?
so its the private and the piublic key, the private stay on the local machine and the public stay on the server. if we loose the private a new private key should be generated

10. You want to allow only the IP 10.0.0.5 to connect to your PostgreSQL database on port 5432, and block everyone else. Write the exact ufw commands to do this
ufw allow from 10.0.0.5 to any port 5432

# Day 3

1. What is the difference between a Docker image and a Docker container? Use an analogy to explain.
the docker image is the recipe to run the app. and the docker container is the dish. so we use the recipe to make the dish.

2. Explain Docker's layer caching. Why should you copy requirements.txt and run pip install BEFORE copying the rest of your code?
the layer caching means that each line of the docker file is cached to reuse if the files does not change. 
because the requirements.txt does not change a lot and it takes a lot of time to install packages thats why we install first the requirements before copying the rest of the file.

3. What does this command do, explain every part:
docker run -d -p 3000:8080 -e NODE_ENV=production --name api myapp:2.1
create a container in the background on the port 3000 on the host mapped to 8000 inside the container with a environment var NODE_ENV=production. the container name is api with the image name myapp with tag 2.1

4. What is the difference between CMD and ENTRYPOINT in a Dockerfile?
cmd is the command to start the container and the entry does the same but less easy to write commands

5. A container running your database gets deleted. The data is gone. How do you prevent this? What exact Docker feature do you use?
use the volume to persist the postgres data.

6. In a Docker Compose file, the web service connects to the database using hostname: db. Why does this work? What would you use instead if Docker Compose wasn't involved?
it work because they are on the same network.
if docker compose was not involved, we need to create a network and when starting the container provide the same network

7. What is the difference between docker stop and docker kill? When would you use each?
docker stop=> gracefull stop running containers, docker kill=>force stop running container 

8. You run docker build -t myapp . and notice it's rebuilding ALL layers every time, even ones that haven't changed. What is likely wrong and how do you fix it?
copy first the requirements or the package.json ect and install the packages first and then copy the rest of the files.

9. Why should containers not run as root? What is the risk?
so if the app is compromised, the attaker cannot run root commands thats why we create a user in the docker file to run commands.

10. What is a multi-stage build? Give a real example of why you'd use one.
Multi stage build is to build the image using different base images its to keep the final build tiny.