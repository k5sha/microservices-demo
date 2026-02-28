# EKS Observability: CloudWatch Dashboards & Alarms

## 1) Dashboards

### 1.1 App Reliability (Production / Staging)

Швидко підтвердити, чи працює сервіс належним чином з точки зору користувача.

**Widgets:**
- **Uptime (gauge)** — загальна кількість запитів на ALB `HealthyHostCount / UnHealthyHostCount` (`AWS/ApplicationELB`)
- **RequestCount** — загальна кількість запитів на ALB
- **5XX errors** — `HTTPCode_Target_5XX_Count` (target-side 5xx)
- **Latency p95** — `TargetResponseTime (p95)`
- **ASG Capacity** — `Desired / InService / Total` (context: навантаження вузла)

<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/App-Reliability-Production.jpg" />
<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/App-Reliability-Staging.jpg" />

---

### 1.2 App Scalability (Production / Staging)

Перевірити поведінку масштабування та виявити вузькі місця.

**Widgets:**
- **Request Count (gauge / timeseries)** — вхідний трафік
- **ALB Saturation** — `SurgeQueueLength` + `SpilloverCount`
- **CPU utilization per pod (bar)** — Порівняння продуктивності процесора за кожним сервісом
- **Memory utilization per pod (stacked bar)** — Порівняння оперативної пам'яті за послугами
- **Scaled / readiness (bar)** — сигнал готовності/масштабування

<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/App-Scalability-Production.jpg" />
<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/App-Scalability-Staging.jpg" />

---

### 1.3 Infra Health (Production / Staging)

Стан платформи (EKS/nodes/control plane).

**Widgets:**
- **Node CPU (EC2 avg, 5m)** — `AWS/EC2 CPUUtilization` by ASG
- **Node Memory (cluster avg, 5m)** — `ContainerInsights node_memory_utilization` через `SEARCH + AVG`
- **Pod restarts (timeseries)** — `pod_number_of_container_restarts`
- **EKS control plane (timeseries)** — `apiserver_request_total_5XX` + `apiserver_request_duration_seconds_*_P99`

<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/Infra-Health-Production.jpg" />
<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/Infra-Health-Staging.jpg" />

---

## 2) Alarms

Створено **6 alarms** (Prod + Staging).

### 2.1 Resource pressure / scalability
- **Pod CPU High STAG** — `pod_cpu_utilization > 80` протягом **5 minutes**
- **Pod CPU High PROD** — `pod_cpu_utilization > 80` протягом **5 minutes**

### 2.2 Stability / reliability
- **Pod Restarts STAG** — `pod_number_of_container_restarts > 2` в **5 minutes**
- **Pod Restarts PROD** — `pod_number_of_container_restarts > 2` в **5 minutes**

### 2.3 Control plane reliability
- **EKS API 5XX STAG** — `apiserver_request_total_5XX` поріг (5 min)
- **EKS API 5XX PROD** — `apiserver_request_total_5XX` поріг (5 min)

> **Note:** `apiserver_request_total_5XX` це **EKS control plane 5xx**, а не додаток 5xx.
<img width="6539" height="3453" alt="image" src="https://github.com/k5sha/microservices-demo/blob/chore/add-dashboard/docs/img/Alarms.jpg" />
---

