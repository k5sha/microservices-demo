<img width="1710" height="1037" alt="image" src="https://github.com/user-attachments/assets/df16be4e-dc94-45eb-af5f-a424cb0f1104" />
<h1 align="center">Online Boutique by ExitCodeOne</h1>

<p align="center">
  <img src="https://github.com/k5sha/microservices-demo/actions/workflows/cd-main.yml/badge.svg" alt="Global CI/CD Pipeline">
</p>

<p align="center">
  <strong>Production-ready мікросервісна архітектура в AWS EKS з повною автоматизацією CI/CD</strong>
</p>

---

## 🏗 Архітектура системи

Проєкт базується на хмарній інфраструктурі AWS, розгорнутій за допомогою Terraform. Архітектура реалізована з урахуванням високої доступності (High Availability) та автоматизації GitOps.

<img width="6539" height="3453" alt="image" src="https://github.com/user-attachments/assets/e248b8b4-4c13-4b2e-a04f-c51644d2648f" />

🔗 **[Відкрити схему в Excalidraw](https://excalidraw.com/#json=5fnDh-32ql4_Xd6SIOvYB,Qn4GoZNAvCFx-Q77v1zsrQ)**

### Деталі реалізації:
* **EKS Control Plane:** Використовує API Server, Scheduler та Cloud Controller для керування кластером.
* **Networking:** VPC розділена на дві зони доступності (AZ A/B). 
    * **Public Subnets:** Містять NAT Gateways для виходу приватних нод в інтернет та **ALB (Application Load Balancer)** для входу зовнішнього трафіку.
    * **Private Subnets:** Робочі ноди (Worker Nodes) з компонентами **Kubelet**, **Kube-Proxy** та **ENI** для мережевої ізоляції.
* **Ingress Flow:** Route 53 → ALB → Target Group → Pods.
* **CI/CD Logic:** Розділення потоків на інфраструктурний (Terraform) та прикладний (Skaffold + Kustomize).


---

## 🚀 Запуск та CI/CD

Проєкт використовує **Skaffold** для керування життєвим циклом додатків та **GitHub Actions** для повної автоматизації.

### Доступні профілі розгортання:

| Профіль | Опис | Команда (локально) |
| :--- | :--- | :--- |
| `local` | Розробка на Minikube/Docker Desktop (без push в ECR) | `skaffold dev -p local` |
| `staging` | Автоматичний деплой при пуші в гілку `staging` | `skaffold run -p staging` |
| `production` | Деплой стабільних версій при пуші в `main` | `skaffold run -p production` |

### Pipeline Workflows:

1.  **Terraform CI/CD:** Автоматично валідує, планує та застосовує зміни інфраструктури. Використовує окремі S3 Backends для `staging` та `production`.
2.  **Global CI/CD (Skaffold):**
    * **Build:** Збирає Docker-образи, тегує їх номером запуску (`run_number`) та пушить в Amazon ECR.
    * **Deploy:** Оновлює `kubeconfig`, підставляє актуальні теги та деплоїть маніфести в потрібний Namespace.
    * **Health Check:** Очікує на успішний Rollout фронтенду перед завершенням.
3.  **Infrastructure Destruction (DANGER):** Спеціальний Workflow для повного видалення ресурсів. Спочатку примусово очищує Kubernetes-ресурси (Ingress, LB), щоб уникнути "завислих" ресурсів в AWS, а потім виконує `terraform destroy`.

---

## 📸 Скріншоти проєкту

### 🟢 Стан деплою в AWS


<img width="1710" height="986" alt="image" src="https://github.com/user-attachments/assets/15c01036-6c75-45f8-899a-d1a43c6147c9" />

<img width="1710" height="986" alt="image" src="https://github.com/user-attachments/assets/81af7e4b-7f36-4cf7-aae4-eebab241999e" />

<img width="1710" height="987" alt="image" src="https://github.com/user-attachments/assets/77ae00d6-e94b-4ff9-b45d-92fb07e001b2" />


### 🛠 GitHub Actions Pipelines

<img width="1710" height="992" alt="Screenshot 2026-02-28 at 10 25 48" src="https://github.com/user-attachments/assets/3b4f49ca-693a-4236-896f-b5ffa8d2408f" />

<img width="1710" height="997" alt="image" src="https://github.com/user-attachments/assets/28b91b97-7bb2-4c4f-9c72-ec374b1c88e4" />

<img width="1710" height="1004" alt="image" src="https://github.com/user-attachments/assets/82da9638-cdb9-4cd4-bf61-3d75bc2721e3" />

<img width="1710" height="996" alt="image" src="https://github.com/user-attachments/assets/79879403-30c3-4ff7-a329-46b2669d21d9" />

<img width="1710" height="994" alt="image" src="https://github.com/user-attachments/assets/11f82c0e-8644-48b3-bd80-dabbcbd4183d" />

### 📊 Моніторинг та Дашборди



### 🛒 Працюючий застосунок

<img width="1710" height="1037" alt="image" src="https://github.com/user-attachments/assets/e5732a07-eef6-4d3b-8263-61d2155b0d6f" />

<img width="1710" height="1034" alt="image" src="https://github.com/user-attachments/assets/2e4ebf22-3654-45ff-bcce-6a846236c681" />

<img width="1710" height="1035" alt="image" src="https://github.com/user-attachments/assets/52884cc7-d8df-4839-a435-6ea3b08e81f8" />

<img width="1710" height="1037" alt="image" src="https://github.com/user-attachments/assets/bcac73be-a564-4b03-9b96-7d3016db0090" />

---

## 🛠 Технологічний стек
* **IaC:** Terraform
* **Orchestration:** Kubernetes (EKS)
* **Package Manager:** Kustomization
* **Development Tool:** Skaffold
* **CI/CD:** GitHub Actions
* **Cloud:** AWS (VPC, EKS, ECR, ALB, Route 53)

---
<p align="center">Made with ❤️ by ExitCodeOne</p>

