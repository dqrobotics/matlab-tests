pipeline {
  agent any
  stages {
    stage('Executing general high-level tests') {
      steps {
        RunMatlabCommand(matlabCommand: 'run_all_example')
      }
    }

  }
}