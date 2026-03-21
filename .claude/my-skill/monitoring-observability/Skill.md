---
name: monitoring-observability
description: Metrics, distributed tracing, structured logs, and alerting for system health. Use when operating production backends and debugging incidents.
user-invocable: false
---

# Monitoring & Observability

Three pillars: **metrics**, **logs**, **traces** — correlated by request ID.

---

## Metrics

* **RED** for services: Rate, Errors, Duration (latency histograms).
* **USE** for resources: Utilization, Saturation, Errors.
* Export **Prometheus** format or vendor equivalents; **SLIs** drive **SLOs** and alerts.

---

## Logs

* **Structured JSON** with `level`, `msg`, `requestId`, `traceId`.
* Centralize in **ELK, Loki, CloudWatch**; retain per compliance.

---

## Tracing

* **OpenTelemetry** — propagate context (`traceparent`) across HTTP and message consumers.
* Sample in prod (e.g. 1–10%) if volume high; always trace errors.

---

## Alerting

* Alert on **SLO burn** and **symptoms** (error rate, latency), not only CPU.
* **Runbooks** linked from alerts.

---

## Dashboards

* Golden signals per service; dependency health (DB, queue depth, cache).

---

## Anti-Patterns

* Logs only without metrics — hard to see trends.
* Paging on single failed request — noisy alerts.

---

## Summary

Instrument **RED/USE**, ship **structured logs** with **correlation**, add **OpenTelemetry**, and alert on **SLOs** with actionable **runbooks**.
