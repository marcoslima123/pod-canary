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

## 4 - Instalar o Helm (opcional)

- curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
- chmod 700 get_helm.sh
- ./get_helm.sh
- helm install deploy-canary ./chart --set staticVersion=stable (Na raiz do projeto)

## 5 - Caso prefira usar o kube, copie os arquivos do diretório chart/templates e cole no diretório k8s
- Obs: substituir os valores das variáveis ( .Values.canaryVersionStaticFiles e .Values.stableVersionStaticFiles) no arquivos de deployments.
- Valores: canary e stable

- kubectl apply -f k8s/arquivo.yaml
- kubectl get pods para verificar se os pods estão rodando e estão com o Sidecar (Coluna READY 2/2)


## 6 - É possível validar o funcionamento através do Kiali

- kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/kiali.yaml
- kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/addons/prometheus.yaml
- kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/addons/jaeger.yaml
- kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/addons/grafana.yaml
- istioctl dashboard kiali

deployment-canary-749c9cc868-scbvv