pipeline {
  agent any
  stages {
    stage('Executing general high-level tests') {
      agent any
      steps {
        sh 'pwd'
        Matlab(matlabRootFolder: '/Applications/Matlab_R2019b.app') {
          echo 'echo $MATLAB_ROOT'
        }

        RunMatlabCommand(matlabCommand: 'run_all_examples')
      }
    }

  }
}