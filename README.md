# matlab-tests
Repository for developers. It mainly contains standard tests to assess that the current version of DQ Robotics is working correctly.

# GithubActions
## Configuring a self-hosted machine for MATLAB

1. Install Ubuntu 20.04
2. Run
```sh
sudo apt update
sudo apt upgrade -y
sudo apt install git
```
3. Install MATLAB
- `Matlab`
- `Optimization Toolbox`
5. Export your MATLAB to your PATH
```sh
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```
5. Configure your GithubActions runner using the github interface. 
6. Add the tag `MATLAB` to your runner.
7. Rejoice.
