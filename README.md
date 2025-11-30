# 📚 Book Platform — Kubernetes Infrastructure (K8s)

Este repositório contém toda a infraestrutura Kubernetes da **Book Platform**, incluindo:
- Banco de dados **PostgreSQL**  
- Banco de dados **MongoDB**  
- Mensageria com **RabbitMQ** + serviço auxiliar **app-dlq**  
- API principal: **api-book-service**  
- Monitoramento: **Prometheus + Grafana**  
- Ingress Controller: **NGINX Ingress**  
- Cluster local com **Kind**

---

## 📁 Estrutura do Diretório

```text
k8s/
├── kind/
│   └── cluster.yaml
├── ingress/
│   └── ingress.yaml
├── monitoring/
│   ├── prometheus/
│   └── grafana/
├── postgres/
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── pvc.yaml
│   └── deployment.yaml
├── mongodb/
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── pvc.yaml
│   └── deployment.yaml
├── rabbitmq/
│   ├── configmap.yaml
│   ├── secret.yaml
│   ├── deployment.yaml
├── app-dlq/
│   ├── deployment.yaml
│   └── service.yaml
└── api-book-service/
    ├── deployment.yaml
    ├── service.yaml
```

---

## 🎯 Objetivo do Projeto

A stack Kubernetes fornece um ambiente completo para desenvolvimento local, com:

- Persistência (Postgres + MongoDB)
- Filas e processamento de mensagens (RabbitMQ + app-dlq)
- API central da plataforma
- Ingress NGINX com roteamento HTTP
- Monitoramento completo com métricas reais

---

## 🚀 Requisitos

- Docker  
- Kind  
- kubectl  
- (Opcional) Lens ou k9s  

---

## 🧱 Criando o Cluster Kind

```bash
kind create cluster --config ./k8s/kind/cluster.yaml
```

---

## 📦 Aplicando toda a infraestrutura

```bash
kubectl apply -f k8s/
```

Ou modularmente:

### PostgreSQL
```bash
kubectl apply -f k8s/postgres/
```

### MongoDB
```bash
kubectl apply -f k8s/mongodb/
```

### RabbitMQ + DLQ Processor
```bash
kubectl apply -f k8s/rabbitmq/
kubectl apply -f k8s/app-dlq/
```

### Monitoring
```bash
kubectl apply -f k8s/monitoring/prometheus/
kubectl apply -f k8s/monitoring/grafana/
```

### NGINX Ingress
```bash
kubectl apply -f k8s/ingress/
```

### API Book Service
```bash
kubectl apply -f k8s/api-book-service/
```

---


## 🌐 Acesso via Ingress

Após aplicar o ingress:

### API Book Service
```
http://local.book
```

### Grafana
```
http://grafana.local
```

RabbitMQ e MongoDB não expõem rotas HTTP via ingress por padrão.

---

## 📡 Acesso via Port-Forward (alternativa)

### Grafana
```bash
kubectl port-forward svc/grafana 3000:3000
```

### Prometheus
```bash
kubectl port-forward svc/prometheus 9090:9090
```

### RabbitMQ
```bash
kubectl port-forward svc/rabbitmq 15672:15672
```

### MongoDB
```bash
kubectl port-forward svc/mongodb 27017:27017
```

### API Book Service
```bash
kubectl port-forward svc/api-book-service 8080:8080
```

---

## 📈 Métricas incluídas

### PostgreSQL
- conexões
- latência
- I/O
- queries/s

### MongoDB (metrics exporter)
- operações/s
- tamanho das coleções
- conexões ativas

### RabbitMQ
- filas pendentes
- mensagens/s
- canais e conexões
- DLQ monitorada pelo **app-dlq**

### api-book-service
- latência HTTP
- status code
- métricas internas

### app-dlq
- mensagens consumidas
- reprocessamentos
- falhas

---

## 📌 Boas Práticas Aplicadas

✔ NGINX Ingress com rotas organizadas  
✔ Banco relacional + NoSQL  
✔ DLQ isolada para garantir resiliência  
✔ HPA configurado  
✔ Monitoramento full-stack  
✔ Estrutura modular e expansível  

---

## 🧪 Limpando o cluster

```bash
kind delete cluster
```