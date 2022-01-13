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
4. Add your MATLAB binary to your PATH. (e.g. ~/MATLAB/R2021a/bin) 
```sh
echo "export PATH=$PATH:YOUR_MATLAB_PATH" >> ~/.bashrc
source ~/.bashrc
```
5. Configure your GithubActions runner using the [github interface](https://github.com/organizations/dqrobotics/settings/actions/runners). 
6. Add the label `MATLAB` to your runner using the [github interface](https://github.com/organizations/dqrobotics/settings/actions/runners). 
>(Quoted from [Github Docs](https://docs.github.com/en/actions/hosting-your-own-runners/using-labels-with-self-hosted-runners))
>1. Navigate to the main page of the organization or repository where your self-hosted runner group is registered.
>2. Click :gear: Settings.
>3. In the left sidebar, click Actions.
>4. Click Runners.
>5. In the list of runners, click the runner you'd like to configure.
>6. In the "Labels" section, click :gear:
>7. In the "Find or create a label" field, type `MATLAB` and click Create new label. The custom label is created and assigned to the self-hosted runner. 
7. Rejoice.
