## Getting Started

(obs: a instalação foi feita no wsl2)

- Instalar as dependências
- Abrir o docker

```bash
npm install 
npm run build
```

## 1- Instalar o Kind

[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64

chmod +x ./kind

sudo mv ./kind /usr/local/bin/

kind --version

## 2- Criar o cluster com o kind

- Create - kind create cluster --config k8s/kind-config.yaml --name cluster-front
- Use cluste - kubectl cluster-info --context kind-cluster-front


## 3- Configurar o istio

- Baixa o istioctl - curl -L https://istio.io/downloadIstio | sh -
- Entre na pasta - cd istio-1.19.0
- Exponha o path nas variaveis de ambiente ou use os arquivos .bashrc ou .bash_profile - export PATH=$PWD/bin:$PATH
- Instale o istio no cluster - istioctl install --set profile=default
- Ative o Sidecar injection - kubectl label namespace default istio-injection=enabled
- Verifique se os CRDs (Custom Resource Definitions) - kubectl get crd | grep istio

## 4- Docker

- Build and push da imagem do docker
- Alterar a versão ou a imagem dentro dos arquivos deployments

## 5- Rodar o kubectl apply em todos os arquivos do diretório K8s

- kubectl apply -f k8s/arquivo.yaml
- kubectl get pods para verificar se os pods estão rodando e estão com o Sidecar (Coluna READY 2/2)

## 6 Arquivo server.js

Basicamente esse arquivo é um servidor express que possui a responsabilidade de definir uma rota custumizada para servir os arquivos estáticos de uma versão específica.

Para rodar uma versão 1.0.0 ou 2.0.0 é necessario alterar os arquivos postbuild.sh, server.js e o next.config.js.
Caso queria rodar uma versão diferente dessas é preciso alterar também nos arquivos de deployments.