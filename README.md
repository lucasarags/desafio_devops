# Documentação de Implantação: Aplicação Dockerizada Monitorada na AWS com Terraform

## 1. Introdução
A aplicação implementada é um Hello World simples, contêinerizada com Docker e implantada na AWS. Ela foi projetada para demonstrar a integração de diversas tecnologias modernas para construção e implantação de infraestruturas escaláveis e resilientes. O processo de provisionamento de toda a infraestrutura foi automatizado utilizando Terraform, o que permite a criação, gestão e modificação da infraestrutura como código.

### Tecnologias Utilizadas
- **AWS**: Infraestrutura na nuvem.
- **Terraform**: Ferramenta para provisionamento de infraestrutura como código.
- **Docker**: Contêinerização da aplicação.
- **CloudWatch**: Monitoramento da aplicação e infraestrutura.
- **SNS (Simple Notification Service)**: Sistema de notificação de alertas.
- **Application Load Balancer (ALB)**: Balanceamento de carga.
- **Auto Scaling Group (ASG)**: Escalabilidade automática das instâncias EC2.

## 2. Tecnologias e Arquitetura Implementada

![Arquitetura da Aplicação](assets/images/arquitetura.png)

### 2.1 Rede (VPC e Subnets)
A infraestrutura de rede foi organizada dentro de uma **VPC (Virtual Private Cloud)**, utilizando as seguintes configurações:
- **VPC (rte-wk6-vnet)** com CIDR `172.16.0.0/16`.
- **Subnets públicas** distribuídas entre as zonas de disponibilidade (AZs) `us-east-1a` e `us-east-1b`.
- **Internet Gateway** associado à VPC para permitir a comunicação com a internet.

### 2.2 Segurança
A segurança da aplicação é garantida com dois grupos de segurança principais:
- **rte-wk6-alb-security-group**: Controla o tráfego de entrada para o Load Balancer.
- **rte-wk6-asg-security-group**: Define regras de tráfego para as instâncias da aplicação.

### 2.3 Balanceamento de Carga
**Application Load Balancer (ALB)**: Recebe as requisições HTTP na porta 80 e distribui o tráfego para as instâncias EC2.
- **Target Group**: Monitora a saúde das instâncias EC2 e garante que o tráfego seja direcionado apenas para instâncias saudáveis.

### 2.4 Escalabilidade Automática
**Auto Scaling Group (ASG)**: Ajusta automaticamente o número de instâncias EC2 conforme a demanda. A configuração atual define um número desejado de 3 instâncias, com mínimo de 2 e máximo de 5 instâncias.
- **Launch Template**: Define a configuração das instâncias EC2, incluindo o tipo da instância (`t2.micro`) e a AMI (`ami-006dcf34c09e50022`).

### 2.5 Monitoramento e Alertas
- **CloudWatch Dashboard**: Fornece métricas em tempo real sobre o tráfego do Load Balancer, utilização de CPU e tempo de resposta das instâncias EC2.
- **Alarmes do CloudWatch**: Monitora a saúde das instâncias e notifica via SNS caso algum alarme seja disparado.

## 3. Fluxo do Usuário até a Aplicação
1. O usuário acessa a aplicação via navegador (requisição HTTP na porta 80).
2. O **Load Balancer (ALB)** recebe o tráfego e encaminha para uma instância EC2 ativa no **Target Group**.
3. A instância EC2 processa a requisição e retorna a resposta ao ALB.
4. O ALB encaminha a resposta de volta para o cliente.
5. Se a demanda aumentar, o **Auto Scaling Group** cria novas instâncias EC2 automaticamente para garantir que a aplicação continue funcionando sem interrupções.

## 4. Detalhes Técnicos sobre o Código

### 4.1 Auto Scaling Group (ASG)
O **Auto Scaling Group (ASG)** garante que o número de instâncias EC2 seja ajustado dinamicamente conforme a carga da aplicação. A configuração do ASG é detalhada da seguinte forma:
- **desired_capacity**: Número de instâncias desejado (3 instâncias).
- **max_size**: Número máximo de instâncias (5 instâncias).
- **min_size**: Número mínimo de instâncias (2 instâncias).
- **target_group_arns**: Associa as instâncias EC2 ao Target Group do ALB.
- **launch_template**: Define o modelo de lançamento das instâncias, incluindo a AMI e tipo da instância.

### 4.2 Launch Template
O **Launch Template** define a configuração necessária para iniciar as instâncias EC2. As configurações incluem:
- **image_id**: AMI utilizada para criar as instâncias EC2 (`ami-006dcf34c09e50022`).
- **instance_type**: Tipo de instância (`t2.micro`).
- **user_data**: Script executado automaticamente ao iniciar a instância, que instala o Docker, configura o ambiente e executa a aplicação no Docker.

### 4.3 Health Checks
O **Target Group** associado ao ALB realiza verificações periódicas de saúde das instâncias EC2:
- A instância é considerada saudável se a URL de saúde (`/health`) retornar um status HTTP 200.
- Se uma instância falhar no Health Check, o tráfego é redirecionado para outra instância saudável.

## 5. Fluxo de Provisionamento e Execução

### 5.1 Criação das Instâncias EC2
1. O **Auto Scaling Group** inicia a criação de instâncias conforme o **Launch Template**.
2. O **Launch Template** utiliza o **user_data**, que executa um script bash para configurar o Docker e iniciar a aplicação dentro de um contêiner Docker.

### 5.2 Escalabilidade e Monitoramento
1. Se a carga aumentar, o **Auto Scaling Group** escala automaticamente para criar novas instâncias.
2. O **CloudWatch** monitora a utilização de recursos e envia alertas via SNS caso os limites configurados sejam atingidos.

## 6. Conclusão
A infraestrutura foi implementada de maneira modular e escalável, garantindo alta disponibilidade e capacidade de responder a picos de demanda. Utilizando **Terraform** para provisionamento, **Docker** para contêinerização e **AWS** para gestão de infraestrutura, a aplicação é capaz de operar de maneira eficiente e ser facilmente escalada conforme necessário.

A monitorização contínua através de **CloudWatch** e os **Health Checks** implementados no ALB garantem que as instâncias da aplicação estejam sempre disponíveis e funcionando corretamente, com alertas configurados para notificar sobre qualquer falha na infraestrutura.
