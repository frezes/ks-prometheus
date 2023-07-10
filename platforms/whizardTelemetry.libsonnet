local whizardTelemetryMixin = import '../components/whizard-telemetry.libsonnet';
local kubesphereMixin =  import '../components/kubesphere.libsonnet';
local thanosRulerMixin = import '../components/thanos-ruler.libsonnet';

(import 'kube-prometheus/platforms/kubeadm.libsonnet')+
(import 'kube-prometheus/addons/all-namespaces.libsonnet') +
(import 'kube-prometheus/addons/networkpolicies-disabled.libsonnet') +
(import '../addons/ksm-patch.libsonnet') +
(import '../addons/node-exporter-patch.libsonnet') +
{
  
  values+:: {
    common+: {
      versions+:: (import '../versions.json'),
      images+:: {
        thanos: 'thanosio/thanos:v' + $.values.common.versions.thanos,
      },
    },
  },
  
  whizardTelemetry: whizardTelemetryMixin(
    {
      namespace: $.values.common.namespace,
      mixin+: { ruleLabels: $.values.common.ruleLabels },
    }
  )+{
  kubesphere: kubesphereMixin(
    {
      namespace: $.values.common.namespace,
      mixin+: { ruleLabels: $.values.common.ruleLabels },
    }
  ),
  thanosRuler: thanosRulerMixin(
    {
      namespace: $.values.common.namespace,
      version: $.values.common.versions.thanos,
      image: $.values.common.images.thanos,
      name: 'k8s',
      mixin+: { ruleLabels: $.values.common.ruleLabels },
    }
  ),
  }
}