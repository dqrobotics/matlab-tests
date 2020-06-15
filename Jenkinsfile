pipeline {
  agent any
  stages {
    stage('Executing general high-level tests') {
      agent any
      steps {
        Matlab(matlabRootFolder: '/Applications/Matlab_R2019b.app/') {
          RunMatlabCommand(matlabCommand: 'run_all_examples')
        }

        sh 'pwd'
      }
    }

  }
}