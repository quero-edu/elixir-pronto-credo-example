node {
    def app

    // exemplo autocontido para rodar o pronto + credo
    // em produção é melhor dividir o pipeline em várias etapas
    // em uma etapa de instalação a instalação das dependências
    // não precisam ser cacheadas.
    stage("Rodando testes") {
        docker.image('elixir:1.5').inside('-u root') {
            sh "apt-get update && apt-get install ruby ruby-dev cmake -y"
            sh "gem install pronto pronto-credo --no-ri --no-rdoc"
            sh "mix local.hex --force"
            sh "mix do deps.get, deps.compile, compile"
            sh "mix test"
            // passo que chama o credo
            sh "PRONTO_GITHUB_ACCESS_TOKEN=${githubToken} PRONTO_PULL_REQUEST_ID=${GITHUB_PR_NUMBER} pronto run -f github_status github_pr -c origin/master"
        }
    }
}
