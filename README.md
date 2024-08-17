# **Desafio Técnico de DevOps**

Este repositório contém a solução para o Desafio Técnico de DevOps, que visa criar e gerenciar um ambiente na AWS utilizando Terraform, EKS, RDS, e integrar a automação de deploy com GitHub Actions.

## **Índice**

- [Visão Geral](#vis%C3%A3o-geral)
- [Arquitetura](#arquitetura)
- [Requisitos](#requisitos)
- [Configuração do Ambiente](#configura%C3%A7%C3%A3o-do-ambiente)
- [Deploy da Aplicação WordPress](#deploy-da-aplica%C3%A7%C3%A3o-wordpress)
- [Configuração do CI/CD](#configura%C3%A7%C3%A3o-do-cicd)
- [Monitoramento e Escalabilidade](#monitoramento-e-escalabilidade)
- [Limpeza do Ambiente](#limpeza-do-ambiente)
- [Considerações Finais](#considera%C3%A7%C3%B5es-finais)

## **Visão Geral**

Este projeto provisiona um ambiente na AWS utilizando Terraform para gerenciar a infraestrutura, Kubernetes (EKS) para orquestração de contêineres, e integrações com GitHub Actions para automatizar o deploy de uma aplicação WordPress. O projeto aborda os principais aspectos de infraestrutura como código (IaC), segurança, escalabilidade, e CI/CD.

## **Arquitetura**

A solução implementa a seguinte arquitetura:

- **VPC**: Criação de uma Virtual Private Cloud com subnets públicas e privadas, além de tabelas de roteamento associadas.
- **EKS**: Cluster Kubernetes gerenciado para orquestração de contêineres.
- **RDS**: Banco de dados relacional gerenciado (MySQL) utilizando o Amazon RDS.
- **Secrets Manager**: Gestão segura de credenciais e segredos para a aplicação.
- **EC2**: Instâncias de suporte para tarefas auxiliares, como provisionamento de scripts.
- **CI/CD**: Pipeline de integração e entrega contínua utilizando GitHub Actions.

## **Requisitos**

- **Terraform**: v1.9.2
- **kubectl**: Configurado para acessar o cluster EKS.
- **AWS CLI**: Configurado com credenciais apropriadas.
- **GitHub Actions**: Configurado no repositório para CI/CD.

## **Configuração do Ambiente**

### 1. **Provisionamento de Infraestrutura**

Clone o repositório e execute os seguintes comandos para provisionar a infraestrutura:

```bash
git clone <url-do-repositorio>
cd terraform
terraform init
terraform apply -auto-approve
```

Este comando provisiona todos os componentes necessários, incluindo a VPC, subnets, EKS, RDS, Secrets Manager, e outros recursos.

### 2. **Deploy do WordPress via Terraform**

O deploy do WordPress no EKS é gerenciado pelo próprio Terraform, garantindo que a infraestrutura e a aplicação sejam provisionadas de maneira consistente.

O Terraform aplica diretamente no EKS para criar o Deployment e o Service do WordPress.

## **Configuração do CI/CD**

O pipeline CI/CD utiliza GitHub Actions para automatizar o deploy da aplicação no EKS. A seguir está a estrutura básica do pipeline.

### **Estrutura do Pipeline**

Este pipeline realiza as seguintes ações como parte do processo de CI/CD:

1. **Terraform Init:** Inicializa o Terraform no diretório de trabalho.
2. **Terraform Validate:** Valida a configuração do Terraform para garantir que está correta.
3. **Terraform Plan:** Gera um plano de execução que mostra quais mudanças serão feitas na infraestrutura.
4. **Terraform Apply:** Aplica as mudanças na infraestrutura, mas somente na branch `main`.

O pipeline é acionado por push ou pull request nos branches `main` e `dev`, e aplica as mudanças automaticamente apenas na branch `main`.

### **Configuração do Workflow no GitHub Actions**

O arquivo de configuração YAML para o pipeline no GitHub Actions é o seguinte:

```yaml
name: CI/CD Terraform Pipeline

on:
  push:
    branches:
      - main
      - dev
  pull_request:
    branches:
      - main
      - dev

jobs:
  terraform:
    name: Terraform CI/CD
    runs-on: ubuntu-20.04

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Terraform Init
        uses: robertdebock/terraform-action@1.1.4
        with:
          action: init
          directory: ./

      - name: Terraform Validate
        uses: robertdebock/terraform-action@1.1.4
        with:
          action: validate
          directory: ./

      - name: Terraform Plan
        uses: robertdebock/terraform-action@1.1.4
        with:
          action: plan
          directory: ./

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        uses: robertdebock/terraform-action@1.1.4
        with:
          action: apply
          directory: ./
        env:
          TF_CLI_ARGS: "-input=false -auto-approve"
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

```

### **Gerenciamento de Segredos**

Os segredos necessários, como as chaves de acesso da AWS, são armazenados de forma segura no GitHub Actions e referenciados como variáveis de ambiente durante o processo de aplicação (`apply`).

## **Considerações Finais**

Este projeto demonstra a criação e o gerenciamento de um ambiente simples na AWS, utilizando as melhores práticas de DevOps, como infraestrutura como código (IaC), automação de deploy, segurança de segredos, e escalabilidade. A integração com o GitHub Actions para CI/CD garante um fluxo contínuo e eficiente de integração e entrega da aplicação.
