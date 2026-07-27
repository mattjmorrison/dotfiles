# Home Lab Plan

## Hardware / Nodes

- **iMac** (32GB RAM, 1TB disk, NixOS) — k3s control plane + worker node
- **Raspberry Pis** (various: 16GB, 8GB, 2GB, and original low-memory model) — worker nodes; NixOS viability on lower-memory models TBD
- **Mini PC** (~32GB RAM, SteamOS/Arch, used by daughter for Minecraft/Roblox) — potential additional worker node when idle
- One Pi is wired via serial port to a media device — that app must run specifically on that Pi; use node labels + node affinity/selectors to pin it while allowing other workloads on spare capacity

## Orchestration

- **k3s** (lightweight Kubernetes) — chosen over full k8s or Docker Compose given multiple physical machines
- Control plane on iMac; Pis and mini PC join as agent nodes
- k3s auto-discovers node resources and schedules workloads across the pool
- Node failures: workloads reschedule automatically to healthy nodes
- Control plane failure is a single point of failure — accepted tradeoff for a home lab

## Planned Applications

- Pihole (ad-blocking DNS)
- Minecraft server
- Media controller (serial-port app, pinned to specific Pi)
- Home Assistant
- A Python-based application

## Deployment Model

- Each application owns its own repo with its own manifests/resource definitions
- **ArgoCD** watches multiple app repos and syncs to the k3s cluster (GitOps) — no manual `kubectl apply` once set up
- ArgoCD runs as a workload inside the k3s cluster

## CI/CD

- Avoid GitHub Actions cost — prefer self-hosted CI inside the k3s cluster
- Candidates: GitLab Runner, Tekton (Kubernetes-native), Woodpecker, Gitea CI
- Pipeline: build Docker image → push to internal registry → update manifest tag → ArgoCD detects and deploys

## Container Registry

- Private Docker registry inside the cluster (Harbor or a simple registry container) — not Docker Hub

## Source Control

- GitHub with a private personal GitHub org (free for private repos)
- NixOS baseline config repo (bootstraps machines + installs k3s) kept separate from per-app repos

## Monitoring & Alerting

- **Prometheus** — scrapes metrics from apps and infrastructure (pull-based)
- **Alertmanager** — alerting rules and notifications from Prometheus data
- **Grafana** — dashboards and visualization, queries Prometheus as data source
- Pihole metrics via a Pihole Prometheus exporter (pre-built Grafana dashboards available)
- All three run as workloads inside the k3s cluster

## Open Questions

- Whether NixOS is practical on lower-memory Raspberry Pi models
- Final CI tool choice (GitLab Runner vs. Tekton vs. others)
- Ingress controller setup for routing internal DNS names to in-cluster services
