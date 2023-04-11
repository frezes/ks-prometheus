{
  _config+:: {
    kubeStateMetricsSelector: error 'must provide selector for kube-state-metrics',
    kubeJobTimeoutDuration: error 'must provide value for kubeJobTimeoutDuration',
    namespaceSelector: null,
    prefixedNamespaceSelector: if self.namespaceSelector != null then self.namespaceSelector + ',' else '',
  },

  prometheusAlerts+:: {
    groups+: [
      {
        name: 'kubernetes-apps',
        rules: [
          {
            expr: |||
              max_over_time(kube_pod_container_status_waiting_reason{reason="CrashLoopBackOff", %(prefixedNamespaceSelector)s%(kubeStateMetricsSelector)s}[5m]) >= 1
            ||| % $._config,
            labels: {
              severity: 'warning',
            },
            annotations: {
              description: 'Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) is in waiting state (reason: "CrashLoopBackOff").',
              summary: 'Pod is crash looping.',
            },
            'for': '15m',
            alert: 'KubePodCrashLooping',
          },
        ],
      },
    ],
  },
}
