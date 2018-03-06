node {
    def app

    stage("Fazendo checkout do código") {
        checkout scm
    }

    stage("Rodando testes") {
        // def prId = currentPullRequest()
        // exemplo autocontido para rodar o pronto + credo
        // na prática você pode querer cachear as dependências
        docker.image('elixir:1.5').inside('-u root') {
            sh "apt-get update && apt-get install ruby ruby-dev cmake -y"
            sh "gem install rake pronto pronto-credo --no-ri --no-rdoc"
            sh "mix local.hex --force"
            sh "mix do deps.get, deps.compile, compile"
            // sh "mix test"
            // passo que chama o credo
            // se existir algum pull request associado ao
            // branch sendo testado
            // if (prId > 0) {
                // sh(script: "git stash && git checkout master && git checkout -f ${GITHUB_BRANCH_HEAD_SHA} && git stash pop", returnStatus: true)
                sh "PRONTO_GITHUB_ACCESS_TOKEN=${githubToken} PRONTO_PULL_REQUEST_ID=${GITHUB_PR_NUMBER} pronto run -f github_status github_pr"
            // }
        }
    }
}


Integer currentPullRequest() {
    def json     = []
    def response = httpRequest([
        acceptType: 'APPLICATION_JSON',
        contentType: 'APPLICATION_JSON',
        httpMode: 'GET',
        customHeaders: [[name: 'Authorization', value: "token ${githubToken}"]],
        url: "https://api.github.com/repos/quero-edu/elixir-pronto-credo-example/pulls?state=open&head=${GITHUB_BRANCH_NAME}&per_page=1"
    ])

    try {
        json = readJSON(text: response.content)
    }
    catch(Exception e) {
        json = []
    }

    if (json.size() > 0) {
        return json[0]['number'];
    } else {
        return 0
    }
}
