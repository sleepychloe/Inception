# Inception
Mandatory part

Success 100/100

## Installation

```bash
  git clone https://github.com/sleepychloe/Inception.git
  cd Inception
  make
```

if docker is not installed,
install it via

```bash
  sudo apt install -y docker.io && sudo apt-get install -y docker-compose
  sudo usermod -aG docker [username]
  sudo reboot
```


## Usage

```bash
  make
  make list
  make logs
  make stop
  make restart
  make fclean
```

## Dumb-init

- a simple process supervisor and init system
   designed to run as PID 1 inside minimal container enveronments such as Docker.
- in case of running a simle process or service without normal init systems
	 often leads to incorrect handing of proccesses and signal,
	 and can have problems such as container that can't be normally stopped,
	 or leaking containers that should have been destroyed.
- dumb-init acts as PID 1 and immediately spawns your command
	 as a child process, taking care to properly handle
	 and forward signals as they are recived.

I commented it out since I am not sure if programs running in the background are allowed.
