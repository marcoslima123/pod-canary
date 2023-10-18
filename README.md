## Getting Started

(obs: a instalação foi feita no wsl2)

- Instalar as dependências
- Abrir o docker

```bash
npm install 
npm run build
```

## 1 - Instalar o k3d

- wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
- k3d version

## 2- Criar o cluster com o k3d

- k3d cluster create -p "8000:30000@loadbalancer" --agents 2


## 3 - Configurar o istio

- Baixa o istioctl - curl -L https://istio.io/downloadIstio | sh -
- Entre na pasta - cd istio-1.19.0
- Exponha o path nas variaveis de ambiente ou use os arquivos .bashrc ou .bash_profile - export PATH=$PWD/bin:$PATH
- Instale o istio no cluster - istioctl install --set profile=default
- Ative o Sidecar injection - kubectl label namespace default istio-injection=enabled
- Verifique se os CRDs (Custom Resource Definitions) - kubectl get crd | grep istio

## 4 - Docker

- Build and push da imagem do docker
  - docker build --build-arg NEXT_PUBLIC_STATIC_VERSION=(stable ou canary) -t (usuario docker/imagem com a versão) .

- Alterar a versão ou a imagem dentro dos arquivos deployments

## 5 - Instalar o Helm (opcional)

- curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
- chmod 700 get_helm.sh
- ./get_helm.sh
- helm install deploy-canary ./chart --set staticVersion=stable (Na raiz do projeto)

## 6 - Caso prefira usar o kube, copie os arquivos do diretório chart/templates e cole no diretório k8s
- Obs: substituir os valores das variáveis ( .Values.canaryVersionStaticFiles e .Values.stableVersionStaticFiles) no arquivos de deployments.
- Valores: canary e stable

- kubectl apply -f k8s/arquivo.yaml
- kubectl get pods para verificar se os pods estão rodando e estão com o Sidecar (Coluna READY 2/2)

## 7 - Arquivo server.js

Basicamente esse arquivo é um servidor express que possui a responsabilidade de definir uma rota custumizada para servir os arquivos estáticos de uma versão específica.

Para rodar uma versão 1.0.0 ou 2.0.0 é necessario alterar os arquivos postbuild.sh, server.js e o next.config.js.
Caso queria rodar uma versão diferente dessas é preciso alterar também nos arquivos de deployments.

## 8 - É possível validar o funcionamento através do Kiali

- kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/kiali.yaml
- istioctl dashboard kiali