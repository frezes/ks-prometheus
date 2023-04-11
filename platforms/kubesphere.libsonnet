local whizardTelemetryMixin = import '../components/whizard-telemetry.libsonnet';

(import 'kube-prometheus/platforms/kubeadm.libsonnet')+
(import 'kube-prometheus/addons/all-namespaces.libsonnet') +
(import 'kube-prometheus/addons/networkpolicies-disabled.libsonnet') +
//(import 'kube-prometheus/addons/static-etcd.libsonnet') +
(import '../addons/ksm-patch.libsonnet') +
(import '../addons/node-exporter-patch.libsonnet') +
{
    whizardTelemetry: whizardTelemetryMixin(
    {
      namespace: $.values.common.namespace,
      mixin+: { ruleLabels: $.values.common.ruleLabels },
    }
  )
}