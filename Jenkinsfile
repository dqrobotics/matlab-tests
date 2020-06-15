pipeline {
  agent any
  stages {
    stage('Executing general high-level tests') {
      agent any
      steps {
        sh '/Applications/Matlab_R2019b.app/bin/matlab -nodisplay -nosplash -nodesktop -r "run(\'/Users/adorno/work/software/dqrobotics/matlab-tests/run_all_examples\')"'
      }
    }

  }
}